module StudentIndexer
	extend ActiveSupport::Concern

	included do
		include Elasticsearch::Model
		#include Elasticsearch::Model::Callbacks
		
		settings index: { number_of_shards: 1} do
			mappings dynamic: 'false' do
				indexes :name, analyzer: 'english', index_options: 'offsets'
				indexes :email, analyzer: 'english', index_options: 'offsets'
			end
		end

		def as_indexed_json(options={})
			as_json(root: false, only: [:name, :email ])
		end

		def self.serach(query)
			__elasticsearch__.search(query)
		end
	end
end
  