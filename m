Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2229FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02842086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02842086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJLNir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:38:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeJLNir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:38:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 87A6A207B4; Fri, 12 Oct 2018 08:07:53 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E8F920726;
        Fri, 12 Oct 2018 08:07:53 +0200 (CEST)
Date:   Fri, 12 Oct 2018 08:07:53 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Message-ID: <20181012080753.2a59b75c@bbrezillon>
In-Reply-To: <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 02:23:08 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Some MICRON related macros in spi-nor domain were ST.
> Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> 
> Added entry of MFR Id for Micron flashes, 0x002C.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> Changes for v3:
> - None
> Changes for v2:
> - None
> 
>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
>  include/linux/mtd/cfi.h       | 1 +
>  include/linux/mtd/spi-nor.h   | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 9407ca5..b8b494f 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
>  	u8 cmd;
>  
>  	switch (JEDEC_MFR(info)) {
> +	case SNOR_MFR_ST:
>  	case SNOR_MFR_MICRON:
>  		/* Some Micron need WREN command; all will accept it */
>  		need_wren = true;
> @@ -1388,7 +1389,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
>  
> -	/* Micron */
> +	/* Micron <--> ST Micro */
>  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
>  	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
> @@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			params->quad_enable = macronix_quad_enable;
>  			break;
>  
> +		case SNOR_MFR_ST:
>  		case SNOR_MFR_MICRON:
>  			break;
>  
> @@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
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

Are you sure ST and Micron NORs work the same way WRT locking, 4-byte
addressing mode and Quad enable?

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
> index 7f0c730..8b1acf6 100644
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

