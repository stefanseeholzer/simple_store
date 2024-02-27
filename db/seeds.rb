# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "csv"

# product = Product.create
# puts product.errors.full_messages

# 676.times do
#     product = Product.create(
#         title: Faker::Commerce.product_name,
#         price: Faker::Commerce.price(range: 0..10.0, as_string: true),
#         stock_quantity: Faker::Number.between(from: 0, to: 100)
#     )
# end

# puts "Created #{Product.count} products"

Product.destroy_all
Category.destroy_all

csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |product|
    title = product['name']
    description = product['description']
    price = product['price']
    stock_quantity = product['stock quantity']
    category_name = product['category']

    category = Category.find_or_create_by(name: category_name)

    product = Product.create(
        title: title,
        description: description,
        price: price,
        stock_quantity: stock_quantity,
        category: category,
    )
    puts product.errors.full_messages
end

puts "Created #{Product.count} products"
puts "Created #{Category.count} Categories"