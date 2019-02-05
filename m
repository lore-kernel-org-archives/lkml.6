Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A35C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678CA20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfBEMz3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:55:29 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:54659 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBEMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:55:29 -0500
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5CA1240005;
        Tue,  5 Feb 2019 12:55:22 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:55:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190205135521.622f82c2@xps13>
In-Reply-To: <20190128181520.GA25887@embeddedor>
References: <20190128181520.GA25887@embeddedor>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 28 Jan
2019 12:15:20 -0600:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nand_base.c:5538:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nand_base.c:5557:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nand_base.c:5595:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nand_legacy.c:332:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nand_legacy.c:483:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nandsim.c:2254:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/omap_elm.c:512:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/omap_elm.c:517:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/omap_elm.c:466:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/omap_elm.c:471:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/mtd/nand/raw/nuc900_nand.c: In function ‘nuc900_nand_command_lp’:
> ./arch/x86/include/asm/io.h:91:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  #define __raw_writel __writel
> drivers/mtd/nand/raw/nuc900_nand.c:52:2: note: in expansion of macro ‘__raw_writel’
>   __raw_writel((val), (dev)->reg + REG_SMCMD)
>   ^~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:196:3: note: in expansion of macro ‘write_cmd_reg’
>    write_cmd_reg(nand, NAND_CMD_READSTART);
>    ^~~~~~~~~~~~~
> drivers/mtd/nand/raw/nuc900_nand.c:197:2: note: here
>   default:
>   ^~~~~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Add extra /* fall through */ comment in nandsim.c file.
> 
>  drivers/mtd/nand/onenand/onenand_base.c | 2 ++
>  drivers/mtd/nand/raw/diskonchip.c       | 1 +
>  drivers/mtd/nand/raw/nand_base.c        | 3 +++
>  drivers/mtd/nand/raw/nand_legacy.c      | 3 ++-
>  drivers/mtd/nand/raw/nandsim.c          | 6 ++++--
>  drivers/mtd/nand/raw/nuc900_nand.c      | 3 ++-
>  drivers/mtd/nand/raw/omap_elm.c         | 4 ++++
>  7 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 4ca4b194e7d7..e9b71ad24f50 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c

onenand changes should probably be in a separate patch prefixed

        mtd: onenand:

When you are unsure, please run

        git log --oneline --follow drivers/mtd/nand/onenand/

> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
>  			if ((this->version_id & 0xf) == 0xe)
>  				this->options |= ONENAND_HAS_NOP_1;
>  		}
> +		/* fall through */
>  
>  	case ONENAND_DEVICE_DENSITY_2Gb:
>  		/* 2Gb DDP does not have 2 plane */
>  		if (!ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;
>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> +		/* fall through */

This looks strange.

In ONENAND_DEVICE_DENSITY_2Gb:
ONENAND_HAS_UNLOCK_ALL is set unconditionally.

But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
if process is evaluated to true.

Same problem with ONENAND_HAS_2PLANE:
- it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
- it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()

Maybe this portion should be reworked because I am unsure if this is a
missing fall through or a bug.

>  
>  	case ONENAND_DEVICE_DENSITY_1Gb:
>  		/* A-Die has all block unlock */
> diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
> index 53f57e0f007e..ead54c90f2d1 100644
> --- a/drivers/mtd/nand/raw/diskonchip.c
> +++ b/drivers/mtd/nand/raw/diskonchip.c
> @@ -1477,6 +1477,7 @@ static int __init doc_probe(unsigned long physadr)
>  			break;
>  		case DOC_ChipID_DocMilPlus32:
>  			pr_err("DiskOnChip Millennium Plus 32MB is not supported, ignoring.\n");
> +			/* fall through */
>  		default:
>  			ret = -ENODEV;
>  			goto notfound;

This is fine.

> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 96cadead262e..e05ecf2e4269 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5537,6 +5537,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  		}
>  		if (!ecc->read_page)
>  			ecc->read_page = nand_read_page_hwecc_oob_first;
> +		/* fall through */
>  
>  	case NAND_ECC_HW:
>  		/* Use standard hwecc read page function? */
> @@ -5556,6 +5557,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  			ecc->read_subpage = nand_read_subpage;
>  		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
>  			ecc->write_subpage = nand_write_subpage_hwecc;
> +		/* fall through */
>  
>  	case NAND_ECC_HW_SYNDROME:
>  		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
> @@ -5593,6 +5595,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  			ecc->size, mtd->writesize);
>  		ecc->mode = NAND_ECC_SOFT;
>  		ecc->algo = NAND_ECC_HAMMING;
> +		/* fall through */
>  
>  	case NAND_ECC_SOFT:
>  		ret = nand_set_ecc_soft_ops(chip);

These three already are in nand/next.

> diff --git a/drivers/mtd/nand/raw/nand_legacy.c b/drivers/mtd/nand/raw/nand_legacy.c
> index 43575943f13b..f2526ec616a6 100644
> --- a/drivers/mtd/nand/raw/nand_legacy.c
> +++ b/drivers/mtd/nand/raw/nand_legacy.c
> @@ -331,6 +331,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
>  		 */
>  		if (column == -1 && page_addr == -1)
>  			return;
> +		/* fall through */
>  
>  	default:
>  		/*
> @@ -483,7 +484,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
>  		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
>  				      NAND_NCE | NAND_CTRL_CHANGE);
>  
> -		/* This applies to read commands */
> +		/* fall through - This applies to read commands */
>  	default:
>  		/*
>  		 * If we don't have access to the busy pin, we apply the given

Already fixed in nand/next too.

> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 933d1a629c51..edf5fd3d5f07 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2251,9 +2251,11 @@ static int __init ns_init_module(void)
>  
>  	switch (bbt) {
>  	case 2:
> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +		/* fall through */
>  	case 1:
> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		/* fall through */
>  	case 0:
>  		break;
>  	default:

This is fine.

> diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
> index 38b1994e7ed3..56fa84029482 100644
> --- a/drivers/mtd/nand/raw/nuc900_nand.c
> +++ b/drivers/mtd/nand/raw/nuc900_nand.c
> @@ -192,8 +192,9 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
>  		return;
>  
>  	case NAND_CMD_READ0:
> -
>  		write_cmd_reg(nand, NAND_CMD_READSTART);
> +		/* fall through */
> +
>  	default:
>  
>  		if (!chip->legacy.dev_ready) {

This is fine too.

> diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
> index a3f32f939cc1..94c6401ef32f 100644
> --- a/drivers/mtd/nand/raw/omap_elm.c
> +++ b/drivers/mtd/nand/raw/omap_elm.c
> @@ -465,11 +465,13 @@ static int elm_context_save(struct elm_info *info)
>  					ELM_SYNDROME_FRAGMENT_5 + offset);
>  			regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_4 + offset);
> +			/* fall through */
>  		case BCH8_ECC:
>  			regs->elm_syndrome_fragment_3[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_3 + offset);
>  			regs->elm_syndrome_fragment_2[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_2 + offset);
> +			/* fall through */
>  		case BCH4_ECC:
>  			regs->elm_syndrome_fragment_1[i] = elm_read_reg(info,
>  					ELM_SYNDROME_FRAGMENT_1 + offset);
> @@ -511,11 +513,13 @@ static int elm_context_restore(struct elm_info *info)
>  					regs->elm_syndrome_fragment_5[i]);
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
>  					regs->elm_syndrome_fragment_4[i]);
> +			/* fall through */
>  		case BCH8_ECC:
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_3 + offset,
>  					regs->elm_syndrome_fragment_3[i]);
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_2 + offset,
>  					regs->elm_syndrome_fragment_2[i]);
> +			/* fall through */
>  		case BCH4_ECC:
>  			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_1 + offset,
>  					regs->elm_syndrome_fragment_1[i]);

And this is ok as well.


Thanks,
Miquèl
