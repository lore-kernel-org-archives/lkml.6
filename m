Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeEOQLD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:11:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43455 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbeEOQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:10:59 -0400
X-Google-Smtp-Source: AB8JxZrzHJSQpyz9reekS3+JoZ5kYIQ/05WBFRbn/3Thidwv/yZ7eNidnRIh+wZQFsqzmu+zGO7tMQ==
Subject: Re: [PATCH v2 1/5] media: cec-notifier: Get notifier by device and
 connector name
To: Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526395342-15481-1-git-send-email-narmstrong@baylibre.com>
 <1526395342-15481-2-git-send-email-narmstrong@baylibre.com>
 <309fa9b4-0c0b-25af-31a3-84fe5fc00743@xs4all.nl>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <19cebe7d-5217-de5e-c668-ea2926e5ea0f@baylibre.com>
Date: Tue, 15 May 2018 18:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <309fa9b4-0c0b-25af-31a3-84fe5fc00743@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2018 17:22, Hans Verkuil wrote:
> On 05/15/2018 04:42 PM, Neil Armstrong wrote:
>> In non device-tree world, we can need to get the notifier by the driver
>> name directly and eventually defer probe if not yet created.
>>
>> This patch adds a variant of the get function by using the device name
>> instead and will not create a notifier if not yet created.
>>
>> But the i915 driver exposes at least 2 HDMI connectors, this patch also
>> adds the possibility to add a connector name tied to the notifier device
>> to form a tuple and associate different CEC controllers for each HDMI
>> connectors.
> 
> The patch looks good, but I'm curious about this paragraph above.
> 
> Was this tested with devices with more than one HDMI output? Or only on
> laptops with a single physical HDMI output? If there are two or more
> outputs then I guess it is the HW designer that decides with output gets
> CEC support?

The driver exposes 2 HDMI connectors (I suspect one is connected to the USB-C alt mode mux along the DP port),
and only one connected has the CEC line connected to the Embedded Controller.

Neil

> 
> Regards,
> 
> 	Hans
> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/media/cec/cec-notifier.c | 11 ++++++++---
>>  include/media/cec-notifier.h     | 27 ++++++++++++++++++++++++---
>>  2 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
>> index 16dffa0..dd2078b 100644
>> --- a/drivers/media/cec/cec-notifier.c
>> +++ b/drivers/media/cec/cec-notifier.c
>> @@ -21,6 +21,7 @@ struct cec_notifier {
>>  	struct list_head head;
>>  	struct kref kref;
>>  	struct device *dev;
>> +	const char *conn;
>>  	struct cec_adapter *cec_adap;
>>  	void (*callback)(struct cec_adapter *adap, u16 pa);
>>  
>> @@ -30,13 +31,14 @@ struct cec_notifier {
>>  static LIST_HEAD(cec_notifiers);
>>  static DEFINE_MUTEX(cec_notifiers_lock);
>>  
>> -struct cec_notifier *cec_notifier_get(struct device *dev)
>> +struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)
>>  {
>>  	struct cec_notifier *n;
>>  
>>  	mutex_lock(&cec_notifiers_lock);
>>  	list_for_each_entry(n, &cec_notifiers, head) {
>> -		if (n->dev == dev) {
>> +		if (n->dev == dev &&
>> +		    (!conn || !strcmp(n->conn, conn))) {
>>  			kref_get(&n->kref);
>>  			mutex_unlock(&cec_notifiers_lock);
>>  			return n;
>> @@ -46,6 +48,8 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
>>  	if (!n)
>>  		goto unlock;
>>  	n->dev = dev;
>> +	if (conn)
>> +		n->conn = kstrdup(conn, GFP_KERNEL);
>>  	n->phys_addr = CEC_PHYS_ADDR_INVALID;
>>  	mutex_init(&n->lock);
>>  	kref_init(&n->kref);
>> @@ -54,7 +58,7 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
>>  	mutex_unlock(&cec_notifiers_lock);
>>  	return n;
>>  }
>> -EXPORT_SYMBOL_GPL(cec_notifier_get);
>> +EXPORT_SYMBOL_GPL(cec_notifier_get_conn);
>>  
>>  static void cec_notifier_release(struct kref *kref)
>>  {
>> @@ -62,6 +66,7 @@ static void cec_notifier_release(struct kref *kref)
>>  		container_of(kref, struct cec_notifier, kref);
>>  
>>  	list_del(&n->head);
>> +	kfree(n->conn);
>>  	kfree(n);
>>  }
>>  
>> diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
>> index cf0add7..814eeef 100644
>> --- a/include/media/cec-notifier.h
>> +++ b/include/media/cec-notifier.h
>> @@ -20,8 +20,10 @@ struct cec_notifier;
>>  #if IS_REACHABLE(CONFIG_CEC_CORE) && IS_ENABLED(CONFIG_CEC_NOTIFIER)
>>  
>>  /**
>> - * cec_notifier_get - find or create a new cec_notifier for the given device.
>> + * cec_notifier_get_conn - find or create a new cec_notifier for the given
>> + * device and connector tuple.
>>   * @dev: device that sends the events.
>> + * @conn: the connector name from which the event occurs
>>   *
>>   * If a notifier for device @dev already exists, then increase the refcount
>>   * and return that notifier.
>> @@ -31,7 +33,8 @@ struct cec_notifier;
>>   *
>>   * Return NULL if the memory could not be allocated.
>>   */
>> -struct cec_notifier *cec_notifier_get(struct device *dev);
>> +struct cec_notifier *cec_notifier_get_conn(struct device *dev,
>> +					   const char *conn);
>>  
>>  /**
>>   * cec_notifier_put - decrease refcount and delete when the refcount reaches 0.
>> @@ -85,7 +88,8 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
>>  			       struct cec_notifier *notifier);
>>  
>>  #else
>> -static inline struct cec_notifier *cec_notifier_get(struct device *dev)
>> +static inline struct cec_notifier *cec_notifier_get_conn(struct device *dev,
>> +							 const char *conn)
>>  {
>>  	/* A non-NULL pointer is expected on success */
>>  	return (struct cec_notifier *)0xdeadfeed;
>> @@ -121,6 +125,23 @@ static inline void cec_register_cec_notifier(struct cec_adapter *adap,
>>  #endif
>>  
>>  /**
>> + * cec_notifier_get - find or create a new cec_notifier for the given device.
>> + * @dev: device that sends the events.
>> + *
>> + * If a notifier for device @dev already exists, then increase the refcount
>> + * and return that notifier.
>> + *
>> + * If it doesn't exist, then allocate a new notifier struct and return a
>> + * pointer to that new struct.
>> + *
>> + * Return NULL if the memory could not be allocated.
>> + */
>> +static inline struct cec_notifier *cec_notifier_get(struct device *dev)
>> +{
>> +	return cec_notifier_get_conn(dev, NULL);
>> +}
>> +
>> +/**
>>   * cec_notifier_phys_addr_invalidate() - set the physical address to INVALID
>>   *
>>   * @n: the CEC notifier
>>
> 
