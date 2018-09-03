Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD08C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC752077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLBQP2I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC752077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeICWCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:02:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38946 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeICWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:02:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id o37-v6so1404396wrf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tdsurv1DugfElh5x13JycDlZAw6FSo15qK8ErGQhW3w=;
        b=oLBQP2I6kUsIQzppRGkylITmm5VmVELxfbnROqPWfgQHVahlp8OcA0HsKLPN0nPd0g
         jamHLx76EXqLd6oegjZyvR2LxTCHzywf/9Id9WKNOOODlNPfBGiTcvjzchQjOApQ3NYu
         TGPXu+Se59SKPw7j7WinCBwLcgTZy4tbpxKInD6PV980d2HR1BI5Sa9d9UdFEnxn283q
         5vYDMvFCEYuENngzViTz5hvtmIQjzNSvAHwf9OcI7pqolhJcOyPKa4VeUo6RaEy4PmdC
         HZqHxLrLzPMdtrSpnQilxmLoQi/7S4UZJv5t/t/k1ZcDZaypJLy2zNOr7gcIhuRcj8hO
         H3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tdsurv1DugfElh5x13JycDlZAw6FSo15qK8ErGQhW3w=;
        b=Apm4EGUxOp8ixN3sPsH49jyJulHwFmppXxoJguIo48mIEatG8R0LGN6F2uw2mDB0vS
         jFiod9DRZTm3hoN+emrdogqpgBj5/XqtIwow+2wXnTEJL7LBpHx/A2IklmElGG+VZQ+8
         XljFbBXqHeyTxTG9RoW197crDi6573kTA5P4ly7IyaoD0lWRERB+jcgjuCW35kHBuWPN
         9fWMqSJc/eObyBE937KSBxMJ4mOmSfQ7kWigsgtE5rgnmI2vjCDzOmiDV9tCgh39g9x3
         kKI4VUSsGV0VEd7uG+UaBQt+zu3DLLscTjqs2QN3xRO+07oYl33Z6108lULBleqIsNE6
         zD6Q==
X-Gm-Message-State: APzg51Ao2XUwv/vE6QuIV2c7Z4yHeTvmHCu9Mj/U9APvkP4hx3dcvZdd
        tFkQ4EdWypzwLtHIadgUWqg=
X-Google-Smtp-Source: ANB0Vdb+uSmR4DFIZPGT4zbRvxVm4nzbJAUndnAaulatiZ/nUTwO/UofrzZlGyOXLJrQiPSNOMH2vA==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr19127067wrn.43.1535996449304;
        Mon, 03 Sep 2018 10:40:49 -0700 (PDT)
Received: from [192.168.43.97] (cst-prg-22-193.cust.vodafone.cz. [46.135.22.193])
        by smtp.gmail.com with ESMTPSA id m8-v6sm28559759wrf.93.2018.09.03.10.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 10:40:48 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 2/3] mtd: spi-nor: parse SFDP Sector Map
 Parameter Table
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        cyrille.pitchen@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, Cristian.Birsan@microchip.com
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-3-tudor.ambarus@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1bfbb5f7-39ee-08cb-8f7b-5c3f441f66a2@gmail.com>
Date:   Mon, 3 Sep 2018 19:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180827102644.7323-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
[...]
> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
> +{
> +	const u32 *ret = NULL;
> +	u32 i, addr;
> +	int err;
> +	u8 addr_width, read_opcode, read_dummy;
> +	u8 read_data_mask, data_byte, map_id;
> +
> +	addr_width = nor->addr_width;
> +	read_dummy = nor->read_dummy;
> +	read_opcode = nor->read_opcode;
> +
> +	map_id = 0;
> +	i = 0;
> +	/* Determine if there are any optional Detection Command Descriptors */
> +	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
> +		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> +		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
> +		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> +		addr = smpt[i + 1];
> +
> +		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> +		if (err)
> +			goto out;
> +
> +		/*
> +		 * Build an index value that is used to select the Sector Map
> +		 * Configuration that is currently in use.
> +		 */
> +		map_id = map_id << 1 | (!(data_byte & read_data_mask) ? 0 : 1);

You can drop the ternary operator part completely ^

> +		i = i + 2;
> +	}
> +
> +	/* Find the matching configuration map */
> +	while (SMPT_MAP_ID(smpt[i]) != map_id) {
> +		if (smpt[i] & SMPT_DESC_END)
> +			goto out;
> +		/* increment the table index to the next map */
> +		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
> +	}
> +
> +	ret = smpt + i;
> +	/* fall through */
> +out:
> +	nor->addr_width = addr_width;
> +	nor->read_dummy = read_dummy;
> +	nor->read_opcode = read_opcode;
> +	return ret;
> +}
> +
> +static void
> +spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
> +			     const struct spi_nor_erase_type *erase,
> +			     const u8 erase_type)
> +{
> +	int i;
> +
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		if (!(erase_type & BIT(i)))
> +			continue;
> +		if (region->size & erase[i].size_mask) {
> +			spi_nor_region_mark_overlay(region);
> +			return;
> +		}
> +	}
> +}
> +
> +static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
> +					      const u32 *smpt)
> +{
> +	struct spi_nor_erase_map *map = &nor->erase_map;
> +	const struct spi_nor_erase_type *erase = map->erase_type;
> +	struct spi_nor_erase_region *region;
> +	u64 offset;
> +	u32 region_count;
> +	int i, j;
> +	u8 erase_type;
> +
> +	region_count = SMPT_MAP_REGION_COUNT(*smpt);
> +	region = devm_kcalloc(nor->dev, region_count, sizeof(*region),
> +			      GFP_KERNEL);

Is this memory always correctly free'd ?

-- 
Best regards,
Marek Vasut
