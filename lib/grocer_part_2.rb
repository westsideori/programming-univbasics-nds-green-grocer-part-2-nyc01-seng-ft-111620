require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  couponed_cart = []
  consolidated_cart = cart
  consolidated_cart.each do |grocery_item|
    matching_coupon = find_item_by_name_in_collection(grocery_item[:item], coupons)
    if matching_coupon && matching_coupon[:num] <= grocery_item[:count]
      new_price = matching_coupon[:cost] / matching_coupon[:num]
      remaining_items = grocery_item[:count] % matching_coupon[:num]
      coupon_times = (grocery_item[:count] / matching_coupon[:num]).round
      grocery_item[:count] = remaining_items
      couponed_cart << grocery_item
      discounted_item = {}
      discounted_item[:item] = "#{grocery_item[:item]} W/COUPON"
      discounted_item[:price] = new_price
      discounted_item[:clearance] = grocery_item[:clearance]
      discounted_item[:count] = coupon_times * matching_coupon[:num]
      couponed_cart << discounted_item
    else
      couponed_cart << grocery_item
    end
  end
  couponed_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |grocery_item|
    if grocery_item[:clearance]
      grocery_item[:price] = (grocery_item[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(couponed_cart)
  total = 0
  clearance_cart.each do |grocery_item|
    subtotal = grocery_item[:price] * grocery_item[:count]
    total += subtotal
  end
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
