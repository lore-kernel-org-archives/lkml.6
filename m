Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C363C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153B320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRMacOTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153B320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIJPvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:51:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36369 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeIJPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:51:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so12366550wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zgMndwtdWIkF8A9i5m7hZH6Ly8XDgIw2l4ibOT1dhM8=;
        b=HRMacOTAdGTJULzKa/4r9X3q8afvdvzi7h8e91wpJ4LN/YYfDg/Fsi/RAmNWMCCz4m
         jJkBQTps1ztqDKkSORYEJTVFKsxt5AEjQk+EGJPGErM+SNDUUri2XPURXHq2Q4OOK7Lk
         L17xAwiSKU956qHeGVutrpeduoPf2EbKAKaIqlxtmXeUKL2+hY2cgSQUf6CTMQIjFtBQ
         LJ+crgd2Qv1NVvCARFk87HinYNJxhyJpXvjx5VBZLTLqW1MPUof8FAPHHnwgkDVGlocD
         UHsFaC8ftg8+RS64LmE4yqxmwhQFdBm2NYDBfZq2h0FKKEwVY+w2/HxFFn9n0v9UKzL1
         M/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zgMndwtdWIkF8A9i5m7hZH6Ly8XDgIw2l4ibOT1dhM8=;
        b=ajzeGlJWR8giDkXBovfoeLp8Mnu4FcLd1w+LRjVGxmgy1gUMM0/PDRDbGh27LtAdE7
         fwSacutdGZG++ilQUjT3ace32FyI+3IxpUM2T3g9zPzdtzkl1xK8Yc+QQ1UYu2oXP001
         Q0qftKyqpE/BQ2sjbCfCiUsJMaQzgRBMyIOOeP4BtLFhBTmSJ9JcA0Nc9knbxDHKCJU8
         hneQV3XKTtzsL26AZ7riODkTQD0Gp7kSZleaSW+QbTdHjNsW/k9LiMwNo7rywxYHMaZZ
         XvZ5XaLj/0ihucf3ap38SkiirY0L8kQgIQxClFORETgtsRgfqZ+3aXqnr0cnmX9QHe5N
         9u7w==
X-Gm-Message-State: APzg51Aqo6mgbY+naB/pBheqJali1O6NGbsbG5PNfYxwiEphKlqELrH2
        0vVT4Q20ASLY1huKf2T+ZRg=
X-Google-Smtp-Source: ANB0VdY8mQtS8MYWFExBGEjiffSuvHUPk6+85naRLeL3y05RK2dWDsGujXD6ZVUjlisVzOfJCZXMXg==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr9742988wrx.215.1536577085844;
        Mon, 10 Sep 2018 03:58:05 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id j11-v6sm16587999wrr.37.2018.09.10.03.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 03:58:04 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 1/3] mtd: spi-nor: add support to non-uniform
 SFDP SPI NOR flash memories
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     cyrille.pitchen@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, Cristian.Birsan@microchip.com
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-2-tudor.ambarus@microchip.com>
 <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
 <7b7f9f85-075a-eb3c-1c27-24c67dbc027f@microchip.com>
 <f9b3c046-011c-e5cd-d822-78a7200a6159@gmail.com>
 <37b1c463-b764-e52d-00e9-ec9d46dd2c36@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <878d25a1-3a9b-598d-332d-c928312415fd@gmail.com>
Date:   Mon, 10 Sep 2018 12:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <37b1c463-b764-e52d-00e9-ec9d46dd2c36@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 12:18 PM, Tudor Ambarus wrote:
> Marek,

Hi,

> On 09/07/2018 11:31 PM, Marek Vasut wrote:
>> On 09/07/2018 10:51 AM, Tudor Ambarus wrote:
>>> Thanks Marek,
>>>
>>> On 09/03/2018 08:37 PM, Marek Vasut wrote:
>>>> On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
>>>> [...]
>>>>
>>>>> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
>>>>> +static inline u64
>>>>> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
>>>>> +			  u64 dividend, u32 *remainder)
>>>>> +{
>>>>> +	*remainder = (u32)dividend & erase->size_mask;
>>>>
>>>> Is the cast really needed ? btw I think there might be a macro doing
>>>> just this, div_by_ or something in include/ .
>>>
>>> The cast is not needed, the AND sets to zero all but the low-order 32bits of
>>> divided and then we have the implicit cast.
>>>
>>> Are you referring to do_div()? I expect the bitwise operations to be faster.
>>> Bitwise operations are preferred in include/linux/mtd/mtd.h too:
>>
>> I thought there was some macro to do this bitwise modulo operation
>> already , so you don't have to implement it here. I don't mean do_div, no.
>>
>>> static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
>>> {
>>>         if (mtd->erasesize_shift)
>>>                 return sz >> mtd->erasesize_shift;
>>>         do_div(sz, mtd->erasesize);
>>>         return sz;
>>> }
>>>
>>>>
>>>>> +	return dividend >> erase->size_shift;
>>>>> +}
>>>>> +
>>>>> +static const struct spi_nor_erase_type *
>>>>> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
>>>>> +			     const struct spi_nor_erase_region *region,
>>>>> +			     u64 addr, u32 len)
>>>>> +{
>>>>> +	const struct spi_nor_erase_type *erase;
>>>>> +	u32 rem;
>>>>> +	int i;
>>>>> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>>>>> +
>>>>> +	/*
>>>>> +	 * Erase types are ordered by size, with the biggest erase type at
>>>>> +	 * index 0.
>>>>> +	 */
>>>>> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
>>>>> +		/* Does the erase region support the tested erase type? */
>>>>> +		if (!(erase_mask & BIT(i)))
>>>>> +			continue;
>>>>> +
>>>>> +		erase = &map->erase_type[i];
>>>>> +
>>>>> +		/* Don't erase more than what the user has asked for. */
>>>>> +		if (erase->size > len)
>>>>> +			continue;
>>>>> +
>>>>> +		/* Alignment is not mandatory for overlaid regions */
>>>>> +		if (region->offset & SNOR_OVERLAID_REGION)
>>>>> +			return erase;
>>>>> +
>>>>> +		spi_nor_div_by_erase_size(erase, addr, &rem);
>>>>> +		if (rem)
>>>>> +			continue;
>>>>> +		else
>>>>> +			return erase;
>>>>> +	}
>>>>> +
>>>>> +	return NULL;
>>>>> +}
>>>>> +
>>>>> +static struct spi_nor_erase_region *
>>>>> +spi_nor_region_next(struct spi_nor_erase_region *region)
>>>>> +{
>>>>> +	if (spi_nor_region_is_last(region))
>>>>> +		return NULL;
>>>>> +	return ++region;
>>>>
>>>> region++ ...
>>>
>>> It's an array of regions, consecutive in address space, in which walking is done
>>> incrementally. If the received region is not the last, I want to return the next
>>> region, so ++region is correct.
>>
>> return i++ is the same as return ++i;
>>
>>>> [...]
>>>>
>>>>> +static int spi_nor_cmp_erase_type(const void *a, const void *b)
>>>>> +{
>>>>> +	const struct spi_nor_erase_type *erase1 = a;
>>>>> +	const struct spi_nor_erase_type *erase2 = b;
>>>>> +
>>>>> +	return erase1->size - erase2->size;
>>>>
>>>> What does this function do again ?
>>>
>>> It's a compare function, I compare by size the map's Erase Types. I pass a
>>> pointer to this function in the sort() call. I sort in ascending order, by size,
>>> all the map's Erase Types when parsing bfpt. I'm doing the sort at init to speed
>>> up the finding of the best erase command at run-time.
>>>
>>> A better name for this function is spi_nor_map_cmp_erase_type(), we compare the
>>> map's Erase Types by size.
>>
>> More like a description would be most welcome, in the actual code. And I
> 
> I will describe all functions, together with arguments and return value.

Thanks !

>> really dislike how you fiddle around with void pointers, can't that be
>> fixed?
> 
> The void pointers are imposed by the sort() declaration, I'm not sure how we can
> avoid them. See include/linux/sort.h:
> void sort(void *base, size_t num, size_t size,
>           int (*cmp)(const void *, const void *),
>           void (*swap)(void *, void *, int));

Ah OK, thanks for clarifying.

>>>>> +
>>>>> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>>>>> +{
>>>>> +	struct spi_nor_erase_region *region = map->regions;
>>>>> +	struct spi_nor_erase_type *erase_type = map->erase_type;
>>>>> +	int i;
>>>>> +	u8 region_erase_mask, ordered_erase_mask;
>>>>> +
>>>>> +	/*
>>>>> +	 * Sort each region's Erase Types in ascending order with the smallest
>>>>> +	 * Erase Type size starting at BIT(0).
>>>>> +	 */
>>>>> +	while (region) {
>>>>> +		region_erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>>>>> +
>>>>> +		/*
>>>>> +		 * The region's erase mask indicates which erase types are
>>>>> +		 * supported from the erase types defined in the map.
>>>>> +		 */
>>>>> +		ordered_erase_mask = 0;
>>>>> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
>>>>> +			if (erase_type[i].size &&
>>>>> +			    region_erase_mask & BIT(erase_type[i].idx))
>>>>> +				ordered_erase_mask |= BIT(i);
>>>>> +
>>>>> +		/* Overwrite erase mask. */
>>>>> +		region->offset = (region->offset & ~SNOR_ERASE_TYPE_MASK) |
>>>>> +				 ordered_erase_mask;
>>>>> +
>>>>> +		region = spi_nor_region_next(region);
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> +static inline void
>>>>
>>>> Drop the inline
>>>
>>> Ok.
>>>
>>>>
>>>>> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
>>>>> +			       u8 erase_mask, u64 flash_size)
>>>>> +{
>>>>> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
>>>>> +							     0);
>>>>> +	map->uniform_region.size = flash_size;
>>>>> +	map->regions = &map->uniform_region;
>>>>> +	map->uniform_erase_type = erase_mask;
>>>>> +}
>>>>> +
>>>>
>>>> [...]
>>>>
>>>>> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
>>>>> +
>>>>> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
>>>>
>>>> Get rid of the inlines, really.
>>>
>>> Agreed.
>>>
>>>>
>>>>> +{
>>>>> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
>>>>> +}
>>>>> +
>>>>> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
>>>>> +{
>>>>> +	return !!nor->erase_map.uniform_erase_type;
>>>>> +}
>>>>> +
>>>>>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>>>>>  					  struct device_node *np)
>>>>>  {
>>>>>
>>>>
>>>> General question, what happens if the multi-block erase fails mid-way ,
>>>> is that handled or reported somehow to the user ?
>>>
>>> I already implemented your suggestion. I build a list of erase commands to be
>>> executed once I validate that the erase can be performed.
>>
>> You can send them, but what happens if it fails mid-way ? Is the user
>> somehow notified that part of his flash is empty and part is not ?
> 
> The user will see just the error code, it is not notified which part of the
> flash is erased and which not, just like in the uniform erase case. I'm not sure
> what would be the advantage of reporting a partial erase. If the erase fails
> mid-way then it's not reliable, no?

Yes, that's right.

> Since your suggestion also applies for the uniform erase case, would you agree
> to let it apart and treat it in a different patch after the non-uniform erase
> gets approved?

That's fine, just document this behavior please.

-- 
Best regards,
Marek Vasut
