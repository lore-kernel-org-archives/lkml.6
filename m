Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D6BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5B20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIOnyhPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A5B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIHBTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:19:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38521 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHBTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:19:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so15723422wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MACy3LKoH2xj0FywbRX20UiyKiaKPzHsyooTslrC++0=;
        b=hIOnyhPJFtTt33YyRLmDtzCtkMcGefE5ELvoo2PUO1PmlFhDDrl5PfyQ8byiwgwy59
         HdrOM8PDb7hM1EGy/5LIhXMocSMsxKnHjj29mDQldNNw9SrJHbZh4vezTeH1Akm7updV
         ABReyt3DnjirT9n5c0wZL3uqSS//w4DCc8Hv+WToYxVdwmVvvwgcmsO7IY5nag2UnX2l
         HcNRPWklc4gTZ/m1kDMW5msborTqkCxlL9ckV+6dKk3SVu7pWO3fUTFV3PosiyzjbOrn
         T+bISDKsB5+75q8aOCEPJ9UhSekRtur430ihQlo5N4wh6WlVtCI3nOWVynoxbRMg3hfV
         J4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MACy3LKoH2xj0FywbRX20UiyKiaKPzHsyooTslrC++0=;
        b=hmxFv6YAhRT0Pp0JtoUor3fCqpU+BYv1xIBgRFe2fkS2k+4uSRfUz3irqDYvTsnutT
         1tNtXbOerSrbAsG15cQpdlBYOi15sLfGJwkBKylvx5RqLmplcRy5YITFxAdiicoIhhlV
         i2ojkotorvvNARoFVwNkHXA+uCsOmihTRKYz6726+GZK0J67vST4V83V/AjnByos8cjD
         vP7BhO+zyzEioP74Mb0ZGw9XOFwF5c5v/xDZFhqxpK39LSAGz1+7VqsWt6QnRrMeijEC
         4TQEBw5hEJILLyeUk3meUlTPKMICraLJQvvO6efuJqp1pKaJ6YsISj+RcbFsbcSHHj+q
         2R7g==
X-Gm-Message-State: APzg51Dw4wui8OQ80ZMN/TuzVZlCuhSWZK+MT1SUk15DqO7zZgUGighb
        czo4gcRriZIk9sVzq6wiY0XtWOue
X-Google-Smtp-Source: ANB0VdZ63y5/bJ/P92Cgi5PlwSopcPgA4HhGZ4NZEV6afPpI9qUP3jp/MPRSeYSeVRIu6g8eRpZZBg==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr6083739wmf.59.1536352600077;
        Fri, 07 Sep 2018 13:36:40 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id i4-v6sm9747636wrs.85.2018.09.07.13.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:36:39 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 1/3] mtd: spi-nor: add support to non-uniform
 SFDP SPI NOR flash memories
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        cyrille.pitchen@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, Cristian.Birsan@microchip.com
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-2-tudor.ambarus@microchip.com>
 <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
 <7b7f9f85-075a-eb3c-1c27-24c67dbc027f@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f9b3c046-011c-e5cd-d822-78a7200a6159@gmail.com>
Date:   Fri, 7 Sep 2018 22:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7b7f9f85-075a-eb3c-1c27-24c67dbc027f@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 10:51 AM, Tudor Ambarus wrote:
> Thanks Marek,
> 
> On 09/03/2018 08:37 PM, Marek Vasut wrote:
>> On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
>> [...]
>>
>>> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
>>> +static inline u64
>>> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
>>> +			  u64 dividend, u32 *remainder)
>>> +{
>>> +	*remainder = (u32)dividend & erase->size_mask;
>>
>> Is the cast really needed ? btw I think there might be a macro doing
>> just this, div_by_ or something in include/ .
> 
> The cast is not needed, the AND sets to zero all but the low-order 32bits of
> divided and then we have the implicit cast.
> 
> Are you referring to do_div()? I expect the bitwise operations to be faster.
> Bitwise operations are preferred in include/linux/mtd/mtd.h too:

I thought there was some macro to do this bitwise modulo operation
already , so you don't have to implement it here. I don't mean do_div, no.

> static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
> {
>         if (mtd->erasesize_shift)
>                 return sz >> mtd->erasesize_shift;
>         do_div(sz, mtd->erasesize);
>         return sz;
> }
> 
>>
>>> +	return dividend >> erase->size_shift;
>>> +}
>>> +
>>> +static const struct spi_nor_erase_type *
>>> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
>>> +			     const struct spi_nor_erase_region *region,
>>> +			     u64 addr, u32 len)
>>> +{
>>> +	const struct spi_nor_erase_type *erase;
>>> +	u32 rem;
>>> +	int i;
>>> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>>> +
>>> +	/*
>>> +	 * Erase types are ordered by size, with the biggest erase type at
>>> +	 * index 0.
>>> +	 */
>>> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
>>> +		/* Does the erase region support the tested erase type? */
>>> +		if (!(erase_mask & BIT(i)))
>>> +			continue;
>>> +
>>> +		erase = &map->erase_type[i];
>>> +
>>> +		/* Don't erase more than what the user has asked for. */
>>> +		if (erase->size > len)
>>> +			continue;
>>> +
>>> +		/* Alignment is not mandatory for overlaid regions */
>>> +		if (region->offset & SNOR_OVERLAID_REGION)
>>> +			return erase;
>>> +
>>> +		spi_nor_div_by_erase_size(erase, addr, &rem);
>>> +		if (rem)
>>> +			continue;
>>> +		else
>>> +			return erase;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static struct spi_nor_erase_region *
>>> +spi_nor_region_next(struct spi_nor_erase_region *region)
>>> +{
>>> +	if (spi_nor_region_is_last(region))
>>> +		return NULL;
>>> +	return ++region;
>>
>> region++ ...
> 
> It's an array of regions, consecutive in address space, in which walking is done
> incrementally. If the received region is not the last, I want to return the next
> region, so ++region is correct.

return i++ is the same as return ++i;

>> [...]
>>
>>> +static int spi_nor_cmp_erase_type(const void *a, const void *b)
>>> +{
>>> +	const struct spi_nor_erase_type *erase1 = a;
>>> +	const struct spi_nor_erase_type *erase2 = b;
>>> +
>>> +	return erase1->size - erase2->size;
>>
>> What does this function do again ?
> 
> It's a compare function, I compare by size the map's Erase Types. I pass a
> pointer to this function in the sort() call. I sort in ascending order, by size,
> all the map's Erase Types when parsing bfpt. I'm doing the sort at init to speed
> up the finding of the best erase command at run-time.
> 
> A better name for this function is spi_nor_map_cmp_erase_type(), we compare the
> map's Erase Types by size.

More like a description would be most welcome, in the actual code. And I
really dislike how you fiddle around with void pointers, can't that be
fixed?

>>> +}
>>> +
>>> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>>> +{
>>> +	struct spi_nor_erase_region *region = map->regions;
>>> +	struct spi_nor_erase_type *erase_type = map->erase_type;
>>> +	int i;
>>> +	u8 region_erase_mask, ordered_erase_mask;
>>> +
>>> +	/*
>>> +	 * Sort each region's Erase Types in ascending order with the smallest
>>> +	 * Erase Type size starting at BIT(0).
>>> +	 */
>>> +	while (region) {
>>> +		region_erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>>> +
>>> +		/*
>>> +		 * The region's erase mask indicates which erase types are
>>> +		 * supported from the erase types defined in the map.
>>> +		 */
>>> +		ordered_erase_mask = 0;
>>> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
>>> +			if (erase_type[i].size &&
>>> +			    region_erase_mask & BIT(erase_type[i].idx))
>>> +				ordered_erase_mask |= BIT(i);
>>> +
>>> +		/* Overwrite erase mask. */
>>> +		region->offset = (region->offset & ~SNOR_ERASE_TYPE_MASK) |
>>> +				 ordered_erase_mask;
>>> +
>>> +		region = spi_nor_region_next(region);
>>> +	}
>>> +}
>>> +
>>> +static inline void
>>
>> Drop the inline
> 
> Ok.
> 
>>
>>> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
>>> +			       u8 erase_mask, u64 flash_size)
>>> +{
>>> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
>>> +							     0);
>>> +	map->uniform_region.size = flash_size;
>>> +	map->regions = &map->uniform_region;
>>> +	map->uniform_erase_type = erase_mask;
>>> +}
>>> +
>>
>> [...]
>>
>>> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
>>> +
>>> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
>>
>> Get rid of the inlines, really.
> 
> Agreed.
> 
>>
>>> +{
>>> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
>>> +}
>>> +
>>> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
>>> +{
>>> +	return !!nor->erase_map.uniform_erase_type;
>>> +}
>>> +
>>>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>>>  					  struct device_node *np)
>>>  {
>>>
>>
>> General question, what happens if the multi-block erase fails mid-way ,
>> is that handled or reported somehow to the user ?
> 
> I already implemented your suggestion. I build a list of erase commands to be
> executed once I validate that the erase can be performed.

You can send them, but what happens if it fails mid-way ? Is the user
somehow notified that part of his flash is empty and part is not ?

-- 
Best regards,
Marek Vasut
