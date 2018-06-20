Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44975208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44975208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbeFTJEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:04:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46060 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754514AbeFTJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:03:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 44EC920DBE; Wed, 20 Jun 2018 09:47:05 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id F296F203D9;
        Wed, 20 Jun 2018 09:46:54 +0200 (CEST)
Date:   Wed, 20 Jun 2018 09:46:54 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 1/4] mtd: rawnand: marvell: Handle on-die ECC
Message-ID: <20180620094654.4280caeb@bbrezillon>
In-Reply-To: <20180620050544.31549-2-chris.packham@alliedtelesis.co.nz>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
        <20180620050544.31549-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Wed, 20 Jun 2018 17:05:41 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> From the controllers point of view this is the same as no or
> software only ECC.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

I'm nitpicking, but we usually put the R-b/A-b tags after the author
SoB.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - New
> Changes in v3:
> - Add review from Boris
> 
>  drivers/mtd/nand/raw/marvell_nand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index ebb1d141b900..ba6889bbe802 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -2157,6 +2157,7 @@ static int marvell_nand_ecc_init(struct mtd_info *mtd,
>  		break;
>  	case NAND_ECC_NONE:
>  	case NAND_ECC_SOFT:
> +	case NAND_ECC_ON_DIE:
>  		if (!nfc->caps->is_nfcv2 && mtd->writesize != SZ_512 &&
>  		    mtd->writesize != SZ_2K) {
>  			dev_err(nfc->dev, "NFCv1 cannot write %d bytes pages\n",

