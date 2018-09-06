Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8168A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8168A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbeIGBTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:19:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41410 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbeIGBTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:19:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 826962072F; Thu,  6 Sep 2018 22:42:38 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 51491207AD;
        Thu,  6 Sep 2018 22:42:15 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:42:13 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: nand: reorder nand manufacturer ids
Message-ID: <20180906224213.7b162cbb@bbrezillon>
In-Reply-To: <20180906084922.14845-1-marcel@ziswiler.com>
References: <20180906084922.14845-1-marcel@ziswiler.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Sep 2018 10:49:21 +0200
Marcel Ziswiler <marcel@ziswiler.com> wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Reorder NAND manufacturer ids for clarity.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/mtd/nand/raw/nand_ids.c | 20 ++++++++++----------
>  include/linux/mtd/rawnand.h     |  8 ++++----
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
> index 5423c3bb388e..0851cd86bf19 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -169,21 +169,21 @@ struct nand_flash_dev nand_flash_ids[] = {
>  
>  /* Manufacturer IDs */
>  static const struct nand_manufacturer nand_manufacturers[] = {
> -	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
> +	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
> +	{NAND_MFR_ATO, "ATO"},
> +	{NAND_MFR_EON, "Eon"},
>  	{NAND_MFR_ESMT, "ESMT"},
> -	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
>  	{NAND_MFR_FUJITSU, "Fujitsu"},
> -	{NAND_MFR_NATIONAL, "National"},
> -	{NAND_MFR_RENESAS, "Renesas"},
> -	{NAND_MFR_STMICRO, "ST Micro"},
>  	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
> -	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
> -	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
> +	{NAND_MFR_INTEL, "Intel"},
>  	{NAND_MFR_MACRONIX, "Macronix", &macronix_nand_manuf_ops},
> -	{NAND_MFR_EON, "Eon"},
> +	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
> +	{NAND_MFR_NATIONAL, "National"},
> +	{NAND_MFR_RENESAS, "Renesas"},
> +	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
>  	{NAND_MFR_SANDISK, "SanDisk"},
> -	{NAND_MFR_INTEL, "Intel"},
> -	{NAND_MFR_ATO, "ATO"},
> +	{NAND_MFR_STMICRO, "ST Micro"},
> +	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
>  	{NAND_MFR_WINBOND, "Winbond"},
>  };
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index efb2345359bb..ca134851d211 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1541,12 +1541,12 @@ nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
>  
>  extern struct nand_flash_dev nand_flash_ids[];
>  
> -extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
> -extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
> -extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
> -extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
>  extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
> +extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
>  extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
> +extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
> +extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
> +extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;

I'm okay with this kind of alphabetic reordering, but why not
reordering the macro definitions too?
