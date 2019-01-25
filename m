Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4576C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA972146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAYMgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:36:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49232 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAYMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:36:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 19116209BF; Fri, 25 Jan 2019 13:36:42 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id C4019207AD;
        Fri, 25 Jan 2019 13:36:31 +0100 (CET)
Date:   Fri, 25 Jan 2019 13:36:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: Annotate implicit fall through in
 nand_scan_tail
Message-ID: <20190125133631.48a32268@xps13>
In-Reply-To: <20190116195004.2499-2-malat@debian.org>
References: <20190116195004.2499-1-malat@debian.org>
        <20190116195004.2499-2-malat@debian.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Mathieu Malaterre <malat@debian.org> wrote on Wed, 16 Jan 2019 20:50:04
+0100:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1).
> 
> This commit removes the following warnings:
> 
>   drivers/mtd/nand/raw/nand_base.c:5556:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/mtd/nand/raw/nand_base.c:5575:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/mtd/nand/raw/nand_base.c:5613:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index cca4b24d2ffa..da344c276088 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5555,6 +5555,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  		}
>  		if (!ecc->read_page)
>  			ecc->read_page = nand_read_page_hwecc_oob_first;
> +		/* fall through */
>  
>  	case NAND_ECC_HW:
>  		/* Use standard hwecc read page function? */
> @@ -5574,6 +5575,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  			ecc->read_subpage = nand_read_subpage;
>  		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
>  			ecc->write_subpage = nand_write_subpage_hwecc;
> +		/* fall through */
>  
>  	case NAND_ECC_HW_SYNDROME:
>  		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
> @@ -5611,6 +5613,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>  			ecc->size, mtd->writesize);
>  		ecc->mode = NAND_ECC_SOFT;
>  		ecc->algo = NAND_ECC_HAMMING;
> +		/* fall through */
>  
>  	case NAND_ECC_SOFT:
>  		ret = nand_set_ecc_soft_ops(chip);

Applied to nand/next with the subject prefix being "mtd: rawnand:"


Thanks,
Miquèl
