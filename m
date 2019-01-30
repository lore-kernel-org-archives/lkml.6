Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BA420855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548855546;
	bh=ANOq4Ks1VkJXQZwpn5WfSy/7ddeh4wvUO4vsJLizLVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1AUmpOBu9E4aeTY2VZlvF9B0n5OIX7XFQEaL1HIdwqGwHwLHnorRBDDYE3higW9Y0
	 jFnYjqrh4N5lim4Hep57QMxAnySIc6s1Wz6bMSIHQ9aqZBNZCprXdQ2vPkI+KDRZuF
	 pGxAvD/eG3lHlzrzqRHRS9H4STqMdRhqwAMaJ30o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfA3NjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731245AbfA3NjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:39:00 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC5820855;
        Wed, 30 Jan 2019 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548855539;
        bh=ANOq4Ks1VkJXQZwpn5WfSy/7ddeh4wvUO4vsJLizLVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pmThoYpmP6fsqamk8NCXT8ISBKJajscJGIo9LSBi3RdnY2kPTtX0CRQ6pQdwiomyt
         9XDhvMDSxFot/sLpbrpghRzNr4Qo/8hKfpKkxnvsJ/Y6FaxgCQOmLCoDUL8+gPLs7i
         w2PMUBrDC5lxZw7OeymL9CDDvgGeNoxQZdNB1lEk=
Date:   Wed, 30 Jan 2019 14:38:49 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] mtd: nand: Make flags for bad block marker
 position more granular
Message-ID: <20190130143849.73501e65@bbrezillon>
In-Reply-To: <20190130130111.32724-3-frieder.schrempf@kontron.de>
References: <20190130130111.32724-1-frieder.schrempf@kontron.de>
        <20190130130111.32724-3-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 13:01:47 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> To be able to check and set bad block markers in the first and
> second page of a block independently of each other, we create
> separate flags for both cases.
> 
> Previously NAND_BBM_SECONDPAGE meant, that both, the first and the
> second page were used. With this patch NAND_BBM_FIRSTPAGE stands for
> using the first page and NAND_BBM_SECONDPAGE for using the second
> page.
> 
> This patch is only for preparation of subsequent changes and does
> not implement the logic to actually handle both flags separately.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/mtd/nand/raw/nand_amd.c      | 2 +-
>  drivers/mtd/nand/raw/nand_base.c     | 6 ++++--
>  drivers/mtd/nand/raw/nand_bbt.c      | 3 ++-
>  drivers/mtd/nand/raw/nand_esmt.c     | 2 +-
>  drivers/mtd/nand/raw/nand_hynix.c    | 2 +-
>  drivers/mtd/nand/raw/nand_macronix.c | 2 +-
>  drivers/mtd/nand/raw/nand_micron.c   | 2 +-
>  drivers/mtd/nand/raw/nand_samsung.c  | 2 +-
>  drivers/mtd/nand/raw/nand_toshiba.c  | 2 +-
>  drivers/mtd/nand/raw/sh_flctl.c      | 2 +-
>  include/linux/mtd/rawnand.h          | 1 +
>  11 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_amd.c b/drivers/mtd/nand/raw/nand_amd.c
> index 6e248bdcc797..6202cbf7ee8d 100644
> --- a/drivers/mtd/nand/raw/nand_amd.c
> +++ b/drivers/mtd/nand/raw/nand_amd.c
> @@ -40,7 +40,7 @@ static void amd_nand_decode_id(struct nand_chip *chip)
>  static int amd_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c6199cc68d2f..9ef7b86cdc42 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -302,7 +302,8 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
>  		ofs += mtd->erasesize - mtd->writesize;
>  
>  	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> -	page_end = page + ((chip->options & NAND_BBM_SECONDPAGE) ? 2 : 1);
> +	page_end = page + (((chip->options & NAND_BBM_FIRSTPAGE) &&
> +			    (chip->options & NAND_BBM_SECONDPAGE)) ? 2 : 1);
>  
>  	for (; page < page_end; page++) {
>  		res = chip->ecc.read_oob(chip, page);
> @@ -550,7 +551,8 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
>  
>  		i++;
>  		ofs += mtd->writesize;
> -	} while ((chip->options & NAND_BBM_SECONDPAGE) && i < 2);
> +	} while ((chip->options & NAND_BBM_FIRSTPAGE) &&
> +		 (chip->options & NAND_BBM_SECONDPAGE) && i < 2);
>  
>  	return ret;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index 862eaa3a0552..c095c04d566d 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -466,7 +466,8 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  
>  	pr_info("Scanning device for bad blocks\n");
>  
> -	if (this->options & NAND_BBM_SECONDPAGE)
> +	if ((this->options & NAND_BBM_FIRSTPAGE) &&
> +	    (this->options & NAND_BBM_SECONDPAGE))
>  		numpages = 2;
>  	else
>  		numpages = 1;
> diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
> index 80d2d3a1b5f2..99a8092969a7 100644
> --- a/drivers/mtd/nand/raw/nand_esmt.c
> +++ b/drivers/mtd/nand/raw/nand_esmt.c
> @@ -36,7 +36,7 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
>  static int esmt_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
> index 2789bf3857c9..e685d70c1618 100644
> --- a/drivers/mtd/nand/raw/nand_hynix.c
> +++ b/drivers/mtd/nand/raw/nand_hynix.c
> @@ -674,7 +674,7 @@ static int hynix_nand_init(struct nand_chip *chip)
>  	if (!nand_is_slc(chip))
>  		chip->options |= NAND_BBM_LASTPAGE;
>  	else
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	hynix = kzalloc(sizeof(*hynix), GFP_KERNEL);
>  	if (!hynix)
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 6db7ced4b96b..e287e71347c5 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -62,7 +62,7 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  static int macronix_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	macronix_nand_fix_broken_get_timings(chip);
>  
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index ea6b6e80d6f8..ca80e09783c7 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -448,7 +448,7 @@ static int micron_nand_init(struct nand_chip *chip)
>  		goto err_free_manuf_data;
>  
>  	if (mtd->writesize == 2048)
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	ondie = micron_supports_on_die_ecc(chip);
>  
> diff --git a/drivers/mtd/nand/raw/nand_samsung.c b/drivers/mtd/nand/raw/nand_samsung.c
> index 3be737139210..ace50522dd19 100644
> --- a/drivers/mtd/nand/raw/nand_samsung.c
> +++ b/drivers/mtd/nand/raw/nand_samsung.c
> @@ -123,7 +123,7 @@ static int samsung_nand_init(struct nand_chip *chip)
>  	if (!nand_is_slc(chip))
>  		chip->options |= NAND_BBM_LASTPAGE;
>  	else
> -		chip->options |= NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
> index 222a66bf0aa6..0031e6727193 100644
> --- a/drivers/mtd/nand/raw/nand_toshiba.c
> +++ b/drivers/mtd/nand/raw/nand_toshiba.c
> @@ -147,7 +147,7 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
>  static int toshiba_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->options |=  NAND_BBM_SECONDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	/* Check that chip is BENAND and ECC mode is on-die */
>  	if (nand_is_slc(chip) && chip->ecc.mode == NAND_ECC_ON_DIE &&
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
> index 2017b00fadd8..971d9afd55e5 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -1176,7 +1176,7 @@ static int flctl_probe(struct platform_device *pdev)
>  	if (pdata->flcmncr_val & SEL_16BIT)
>  		nand->options |= NAND_BUSWIDTH_16;
>  
> -	nand->options |= NAND_BBM_SECONDPAGE;
> +	nand->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_resume(&pdev->dev);
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index da785d92e26e..23ad4ad790af 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -176,6 +176,7 @@ enum nand_ecc_algo {
>   * Position within the block: Each of these pages needs to be checked for a
>   * bad block marking pattern.
>   */
> +#define NAND_BBM_FIRSTPAGE		0x01000000
>  #define NAND_BBM_SECONDPAGE		0x02000000
>  #define NAND_BBM_LASTPAGE		0x04000000
>  

