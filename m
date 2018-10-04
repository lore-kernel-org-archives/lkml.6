Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C321470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JSesh6sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257C321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJDRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:30:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58136 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:30:41 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94AbfUW096049;
        Thu, 4 Oct 2018 05:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538649461;
        bh=wGDizo2WCCvowyxifJwFRkkq+4m/A4sOv5V9RgRd0qY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JSesh6sF/RrLWm0bPZXyCtnWUvs7BGEJnG5glqVC03C7wklhFWkT5f9ep0BP/Aiue
         obMGxBuo2LmxbY3KfeT2CfDhn28XKvPSTZNVe2CUCMdDWzLQiTVXWo1OP8LKRXC1tE
         romf/eb3D7A5VJ7wy11xf7IltoUEfniD9rvFvDeI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94AbfSi032045;
        Thu, 4 Oct 2018 05:37:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 05:37:41 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 05:37:40 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94AbafD022602;
        Thu, 4 Oct 2018 05:37:38 -0500
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-2-vigneshr@ti.com>
 <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <ad1e560a-9dc8-c99c-acf4-de8be00b934e@ti.com>
Date:   Thu, 4 Oct 2018 16:08:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 04 October 2018 12:21 PM, Yogesh Narayan Gaur wrote:
> Hi Vignesh,
> 
>> -----Original Message-----
>> From: Vignesh R [mailto:vigneshr@ti.com]
>> Sent: Wednesday, October 3, 2018 10:26 PM
>> To: Boris Brezillon <boris.brezillon@bootlin.com>; Marek Vasut
>> <marek.vasut@gmail.com>; Rob Herring <robh+dt@kernel.org>
>> Cc: Brian Norris <computersforpeace@gmail.com>; Yogesh Narayan Gaur
>> <yogeshnarayan.gaur@nxp.com>; Linux ARM Mailing List <linux-arm-
>> kernel@lists.infradead.org>; linux-mtd@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Vignesh R
>> <vigneshr@ti.com>
>> Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
>>
>> Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines. It supports
>> read/write over 8 IO lines simulatenously. Add support for Octal read mode for
>> Micron mt35xu512aba.
>> Unfortunately, this flash is only complaint to SFDP JESD216B and does not seem
>> to support newer JESD216C standard that provides auto detection of Octal
>> mode capabilities and opcodes. Therefore, this capability is manually added
>> using new SPI_NOR_OCTAL_READ flag.
>>
> 
> Thanks for sending the patch-set of adding octal support.
> If possible, can you share the MT35x datasheet?
> 

I dont have datasheet, this patch is based on prior patches from here:
http://patchwork.ozlabs.org/patch/740942/

> I also have the patch ready in which I have added support for Read (1-1-8 and 1-8-8) protocol and Write (1-1-8 and 1-8-8).
> Also have added support of Octal in driver/spi/spi.c framework.
> 
> IMO, we would collaborate our patches.

That would be great, thanks!

Regards
Vignesh

> --
> Regards
> Yogesh Gaur
> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 11 ++++++++++-
>>  include/linux/mtd/spi-nor.h   |  2 ++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c index
>> aff5e6ff0b2c..4926e805a8cb 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -90,6 +90,7 @@ struct flash_info {
>>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip
>> erase */
>>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>>  #define USE_CLSR		BIT(14)	/* use CLSR command */
>> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>>
>>  	int	(*quad_enable)(struct spi_nor *nor);
>>  };
>> @@ -209,6 +210,7 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
>>  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
>>  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
>>  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
>> +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
>>
>>  		{ SPINOR_OP_READ_1_1_1_DTR,
>> 	SPINOR_OP_READ_1_1_1_DTR_4B },
>>  		{ SPINOR_OP_READ_1_2_2_DTR,
>> 	SPINOR_OP_READ_1_2_2_DTR_4B },
>> @@ -1406,7 +1408,7 @@ static const struct flash_info spi_nor_ids[] = {
>>  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K |
>> USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>>
>>  	/* Micron */
>> -	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K |
>> USE_FSR | SPI_NOR_4B_OPCODES) },
>> +	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K |
>> USE_FSR
>> +| SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>>
>>  	/* PMC */
>>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
>> @@ -3199,6 +3201,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
>>  					  SNOR_PROTO_1_1_4);
>>  	}
>>
>> +	if (info->flags & SPI_NOR_OCTAL_READ) {
>> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
>> +		spi_nor_set_read_settings(&params-
>>> reads[SNOR_CMD_READ_1_1_8],
>> +					  0, 8, SPINOR_OP_READ_1_1_8,
>> +					  SNOR_PROTO_1_1_8);
>> +	}
>> +
>>  	/* Page Program settings. */
>>  	params->hwcaps.mask |= SNOR_HWCAPS_PP;
>>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h index
>> 8b1acf68b7ac..ae9861ed7e0f 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -50,6 +50,7 @@
>>  #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O
>> SPI) */
>>  #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad
>> Output SPI) */
>>  #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O
>> SPI) */
>> +#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal
>> Output SPI) */
>>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>>  #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
>>  #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
>> @@ -73,6 +74,7 @@
>>  #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O
>> SPI) */
>>  #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad
>> Output SPI) */
>>  #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O
>> SPI) */
>> +#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal
>> Output SPI) */
>>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256
>> bytes) */
>>  #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
>>  #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
>> --
>> 2.19.0
> 

-- 
Regards
Vignesh
