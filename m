Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C660C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BD020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP/P+kRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BD020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeICWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:02:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51167 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeICWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:01:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1930993wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cYHF3DuU1Mgm5+iUOEtA+Jn8lKOkDL2loPcAl5A+4tQ=;
        b=uP/P+kRPdtfp8PcKkjvQDGy/QZcPVmd8/Rg098QWKhjZLKlzZu6qBiX2l8g//Mynzq
         Twe/jF10Oy66lgQcrlUOWJVu9muFXnBUQLwndcmVfTforz5B+5K6v3C1VzaJsluEimcD
         doGsFwFxFcGoQJ5ewR9nr1IbUl7MjhSYMWDCpzM9ua+sRecSS/ASFaZ3sIZQ1+IyvVxl
         X0KGmIiphf3aMtIiFIiaT2DEK/EmgGlMLc3xVXpZ77J9oJoMkVnPteELfcAPxfnIMdwH
         NViE1cyHyfvdILgCcWq6syk1d66FGGV1WGfDq2Fv3BIyobOu7trnhOfHxdrOMSTUCKWc
         6X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYHF3DuU1Mgm5+iUOEtA+Jn8lKOkDL2loPcAl5A+4tQ=;
        b=N2qVNYDJna0cdHmBpfOhfo9gMmZhlbkFtzOaNOVQInqS4LqDN1ASzT5EPBE1rNQMre
         THYry87pbCUQnqVuyEPHVejpaOYE4iyHaR9k7JAONjMdbON6aapbWrEZshTfbOZhoK4l
         R4m2SgH3VD86Dmndf9oQuxiE6HncBv61Jsbonpef5hrIXN+m9rV+jc41Jq/INCnfj2BP
         TcpO9BzXb4k+PO8G8bLrvXU39SjBV3crJL9//3WFuV60sbAgQ1HEBTbQtWspFQ1Lt1XE
         TC60gJKE2ZJ2wCbtW0PTp4O77ZqE6IORT62e869V9hwqMMDu3382IHInboL9pQGx+Gu4
         VG0Q==
X-Gm-Message-State: APzg51AVcSDUL3CIGxmzux/MUv66VBCz65DhidHDulzt0XqJ5Qj5ToeF
        yKJUQVS+JBdX2jdcinWHIQ8=
X-Google-Smtp-Source: ANB0VdbjkGsfwsm5EjcVBQEvRw4IrEAXxVhqWgYM0fEMiSVkVxxI61PDMQ28HoDpb5iJw0VR64P+KQ==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr293545wma.41.1535996446328;
        Mon, 03 Sep 2018 10:40:46 -0700 (PDT)
Received: from [192.168.43.97] (cst-prg-22-193.cust.vodafone.cz. [46.135.22.193])
        by smtp.gmail.com with ESMTPSA id j75-v6sm12944181wmj.8.2018.09.03.10.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 10:40:45 -0700 (PDT)
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
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
Date:   Mon, 3 Sep 2018 19:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180827102644.7323-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
[...]

> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +static inline u64
> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
> +			  u64 dividend, u32 *remainder)
> +{
> +	*remainder = (u32)dividend & erase->size_mask;

Is the cast really needed ? btw I think there might be a macro doing
just this, div_by_ or something in include/ .

> +	return dividend >> erase->size_shift;
> +}
> +
> +static const struct spi_nor_erase_type *
> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
> +			     const struct spi_nor_erase_region *region,
> +			     u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_type *erase;
> +	u32 rem;
> +	int i;
> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +	/*
> +	 * Erase types are ordered by size, with the biggest erase type at
> +	 * index 0.
> +	 */
> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
> +		/* Does the erase region support the tested erase type? */
> +		if (!(erase_mask & BIT(i)))
> +			continue;
> +
> +		erase = &map->erase_type[i];
> +
> +		/* Don't erase more than what the user has asked for. */
> +		if (erase->size > len)
> +			continue;
> +
> +		/* Alignment is not mandatory for overlaid regions */
> +		if (region->offset & SNOR_OVERLAID_REGION)
> +			return erase;
> +
> +		spi_nor_div_by_erase_size(erase, addr, &rem);
> +		if (rem)
> +			continue;
> +		else
> +			return erase;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct spi_nor_erase_region *
> +spi_nor_region_next(struct spi_nor_erase_region *region)
> +{
> +	if (spi_nor_region_is_last(region))
> +		return NULL;
> +	return ++region;

region++ ...

[...]

> +static int spi_nor_cmp_erase_type(const void *a, const void *b)
> +{
> +	const struct spi_nor_erase_type *erase1 = a;
> +	const struct spi_nor_erase_type *erase2 = b;
> +
> +	return erase1->size - erase2->size;

What does this function do again ?

> +}
> +
> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
> +{
> +	struct spi_nor_erase_region *region = map->regions;
> +	struct spi_nor_erase_type *erase_type = map->erase_type;
> +	int i;
> +	u8 region_erase_mask, ordered_erase_mask;
> +
> +	/*
> +	 * Sort each region's Erase Types in ascending order with the smallest
> +	 * Erase Type size starting at BIT(0).
> +	 */
> +	while (region) {
> +		region_erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +		/*
> +		 * The region's erase mask indicates which erase types are
> +		 * supported from the erase types defined in the map.
> +		 */
> +		ordered_erase_mask = 0;
> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
> +			if (erase_type[i].size &&
> +			    region_erase_mask & BIT(erase_type[i].idx))
> +				ordered_erase_mask |= BIT(i);
> +
> +		/* Overwrite erase mask. */
> +		region->offset = (region->offset & ~SNOR_ERASE_TYPE_MASK) |
> +				 ordered_erase_mask;
> +
> +		region = spi_nor_region_next(region);
> +	}
> +}
> +
> +static inline void

Drop the inline

> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
> +			       u8 erase_mask, u64 flash_size)
> +{
> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
> +							     0);
> +	map->uniform_region.size = flash_size;
> +	map->regions = &map->uniform_region;
> +	map->uniform_erase_type = erase_mask;
> +}
> +

[...]

> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
> +
> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)

Get rid of the inlines, really.

> +{
> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
> +}
> +
> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
> +{
> +	return !!nor->erase_map.uniform_erase_type;
> +}
> +
>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>  					  struct device_node *np)
>  {
> 

General question, what happens if the multi-block erase fails mid-way ,
is that handled or reported somehow to the user ?

-- 
Best regards,
Marek Vasut
