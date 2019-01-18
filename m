Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D43C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469D82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547800200;
	bh=GgTgbns2eBfbuAhJFW8BVh1if6T7NrQ/79Ib8cLi7Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SW9YiP8Fg6SC2VkiNuJVeQ2L/bOIYIb5e6APx/0GjOMO1zNAhuuVIY1fa5h9MHaYa
	 5n8rf/9lq/M8pw+7tEE38orasvpNCVH0UJl+jtag7QtzEm7is7+wqEDWOb+YlveC/k
	 UhYCVHbT7AzPMqrRk5jJfgNZfuVP7T7PIHRPMjBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfARI37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARI36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:29:58 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2377D20823;
        Fri, 18 Jan 2019 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547800197;
        bh=GgTgbns2eBfbuAhJFW8BVh1if6T7NrQ/79Ib8cLi7Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GN01m9ZNdfnMopO3lxIGSmJv7xE2mcBPox0kH63eosGeQFT+u56fB6vk0Uwfivyam
         MF8RoX2BORZW2M7lX3TM1ycmc+5tznUBB6RCoKlzix7UuaLE8gcGMTNnH9+tMIxIpB
         BhaVyuJemC3BK++4JKW+f7cP4DAJbxISUCro3wAI=
Date:   Fri, 18 Jan 2019 09:29:45 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 5/8] mtd: rawnand: jz4780: Add ooblayout for the JZ4725B
Message-ID: <20190118092945.4ca0fef2@bbrezillon>
In-Reply-To: <20190118010634.27399-5-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118010634.27399-5-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:06:31 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> The boot ROM of the JZ4725B SoC expects a specific OOB layout on the
> NAND, so it makes sense to use this OOB layout unconditionally on this
> SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/mtd/nand/raw/jz4780_nand.c | 40 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
> index cf24bf12884f..073b3da5c3f7 100644
> --- a/drivers/mtd/nand/raw/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/jz4780_nand.c
> @@ -34,6 +34,7 @@ struct jz_soc_info {
>  	unsigned long data_offset;
>  	unsigned long addr_offset;
>  	unsigned long cmd_offset;
> +	const struct mtd_ooblayout_ops *oob_layout;
>  };
>  
>  struct jz4780_nand_cs {
> @@ -208,7 +209,7 @@ static int jz4780_nand_attach_chip(struct nand_chip *chip)
>  		return -EINVAL;
>  	}
>  
> -	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +	mtd_set_ooblayout(mtd, nfc->soc_info->oob_layout);
>  
>  	return 0;
>  }
> @@ -398,16 +399,53 @@ static int jz4780_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int jz4725b_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				 struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	if (section || !ecc->total)
> +		return -ERANGE;
> +
> +	oobregion->length = ecc->total;
> +	oobregion->offset = 3;
> +
> +	return 0;
> +}
> +
> +static int jz4725b_ooblayout_free(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length = mtd->oobsize - ecc->total - 3;
> +	oobregion->offset = 3 + ecc->total;
> +
> +	return 0;
> +}
> +
> +const struct mtd_ooblayout_ops jz4725b_ooblayout_ops = {
> +	.ecc = jz4725b_ooblayout_ecc,
> +	.free = jz4725b_ooblayout_free,
> +};
> +
>  static const struct jz_soc_info jz4725b_soc_info = {
>  	.data_offset = 0x00000000,
>  	.cmd_offset  = 0x00008000,
>  	.addr_offset = 0x00010000,
> +	.oob_layout  = &jz4725b_ooblayout_ops,
>  };
>  
>  static const struct jz_soc_info jz4780_soc_info = {
>  	.data_offset = 0x00000000,
>  	.cmd_offset  = 0x00400000,
>  	.addr_offset = 0x00800000,
> +	.oob_layout  = &nand_ooblayout_lp_ops,
>  };
>  
>  static const struct of_device_id jz4780_nand_dt_match[] = {

