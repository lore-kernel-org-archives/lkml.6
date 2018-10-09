Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D721C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D242085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D242085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJILQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:16:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:34772 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJILQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:16:27 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534834800"; 
   d="scan'208";a="22113949"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Oct 2018 21:01:33 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Mon, 8 Oct 2018 21:01:32 -0700
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON
 flash
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <marek.vasut@gmail.com>, <frieder.schrempf@exceet.de>,
        <cyrille.pitchen@wedev4u.fr>, <computersforpeace@gmail.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <6f692aa5-99af-2da8-95db-8ac71197c9a7@microchip.com>
Date:   Tue, 9 Oct 2018 07:01:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/19/2018 07:50 AM, Yogesh Gaur wrote:
> Some MICRON related macros in spi-nor domain were ST.
> Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> 
> Added entry of MFR Id for Micron flashes, 0x002C.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
>  include/linux/mtd/cfi.h       | 1 +
>  include/linux/mtd/spi-nor.h   | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index f028277..33a55bc 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -271,6 +271,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
>  	u8 cmd;
>  
>  	switch (JEDEC_MFR(info)) {
> +	case SNOR_MFR_ST:
>  	case SNOR_MFR_MICRON:
>  		/* Some Micron need WREN command; all will accept it */
>  		need_wren = true;
> @@ -1096,7 +1097,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
>  
> -	/* Micron */
> +	/* Micron <--> ST Micro */
>  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
>  	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
> @@ -2502,6 +2503,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			params->quad_enable = macronix_quad_enable;
>  			break;
>  
> +		case SNOR_MFR_ST:
>  		case SNOR_MFR_MICRON:
>  			break;
>  
> @@ -2876,8 +2878,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	mtd->_resume = spi_nor_resume;
>  
>  	/* NOR protection support for STmicro/Micron chips and similar */
> -	if (JEDEC_MFR(info) == SNOR_MFR_MICRON ||
> -			info->flags & SPI_NOR_HAS_LOCK) {
> +	if (JEDEC_MFR(info) == SNOR_MFR_ST ||
> +	    JEDEC_MFR(info) == SNOR_MFR_MICRON ||
> +	    info->flags & SPI_NOR_HAS_LOCK) {
>  		nor->flash_lock = stm_lock;
>  		nor->flash_unlock = stm_unlock;
>  		nor->flash_is_locked = stm_is_locked;
> diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
> index 9b57a9b..cbf7716 100644
> --- a/include/linux/mtd/cfi.h
> +++ b/include/linux/mtd/cfi.h
> @@ -377,6 +377,7 @@ struct cfi_fixup {
>  #define CFI_MFR_SHARP		0x00B0
>  #define CFI_MFR_SST		0x00BF
>  #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
> +#define CFI_MFR_MICRON		0x002C /* Micron */
>  #define CFI_MFR_TOSHIBA		0x0098
>  #define CFI_MFR_WINBOND		0x00DA
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index c922e97..f43bfc5 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -23,7 +23,8 @@
>  #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
>  #define SNOR_MFR_GIGADEVICE	0xc8
>  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
> -#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
> +#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
> +#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
>  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
>  #define SNOR_MFR_SPANSION	CFI_MFR_AMD
>  #define SNOR_MFR_SST		CFI_MFR_SST
> 
