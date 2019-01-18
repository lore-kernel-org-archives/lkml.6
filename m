Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AD32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547799525;
	bh=bcoCVOEuGBTUydYBKwhs/F2p0ZrUgb38cu/2QlFES0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EZGEhOU7sAEusVvBmJn3ZM3Vu8mKd/mc/celYc19EhzR0PfMYWiCjLYbDVqUI4BeB
	 vwKHd6CoPSpGw0rI1qk+QTKOmL+nY777VAMFLnfEPl0wIZ6YsXDN7/eIJ0WCNwE4sc
	 6d0P0RzIeHqV9nom/RCc4Agzfs+5S+LlGr5ZVyW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfARISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbfARISn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:18:43 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC482087E;
        Fri, 18 Jan 2019 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547799522;
        bh=bcoCVOEuGBTUydYBKwhs/F2p0ZrUgb38cu/2QlFES0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KfyJPkxGio58EbpfwFy46OxtvhVFOP6QznZYowOD4rAz9wxW8X+4uanugRUkI/ESa
         J3NY1kHUl0GFFaFW1VWIUm5T7iviq27mRYD6py09CyrrzElWKCI3gNdeOpl5jcjkbk
         yTYFGUku56gEUHu+2iiapoK6PI3jKueJySmvdBTU=
Date:   Fri, 18 Jan 2019 09:18:32 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] memory: jz4780_nemc: Add support for the JZ4725B
Message-ID: <20190118091832.733b78f4@bbrezillon>
In-Reply-To: <20190117224550.18043-4-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
        <20190117224550.18043-4-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 19:45:50 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Add support for the JZ4725B SoC from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I don't know anything about the JZ4725B constraints but the code looks
good, so

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index ef3f20e46590..c472a22d6df5 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -44,9 +44,14 @@
>  #define NEMC_NFCSR_NFCEn(n)	BIT((((n) - 1) << 1) + 1)
>  #define NEMC_NFCSR_TNFEn(n)	BIT(16 + (n) - 1)
>  
> +struct jz_soc_info {
> +	u8 tas_tah_cycles_max;
> +};
> +
>  struct jz4780_nemc {
>  	spinlock_t lock;
>  	struct device *dev;
> +	const struct jz_soc_info *soc_info;
>  	void __iomem *base;
>  	struct clk *clk;
>  	uint32_t clk_period;
> @@ -202,7 +207,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  	if (of_property_read_u32(node, "ingenic,nemc-tAS", &val) == 0) {
>  		smcr &= ~NEMC_SMCR_TAS_MASK;
>  		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
> -		if (cycles > 15) {
> +		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
>  			dev_err(nemc->dev, "tAS %u is too high (%u cycles)\n",
>  				val, cycles);
>  			return false;
> @@ -214,7 +219,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  	if (of_property_read_u32(node, "ingenic,nemc-tAH", &val) == 0) {
>  		smcr &= ~NEMC_SMCR_TAH_MASK;
>  		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
> -		if (cycles > 15) {
> +		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
>  			dev_err(nemc->dev, "tAH %u is too high (%u cycles)\n",
>  				val, cycles);
>  			return false;
> @@ -278,6 +283,10 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
>  	if (!nemc)
>  		return -ENOMEM;
>  
> +	nemc->soc_info = device_get_match_data(dev);
> +	if (!nemc->soc_info)
> +		return -EINVAL;
> +
>  	spin_lock_init(&nemc->lock);
>  	nemc->dev = dev;
>  
> @@ -370,8 +379,17 @@ static int jz4780_nemc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct jz_soc_info jz4725b_soc_info = {
> +	.tas_tah_cycles_max = 7,
> +};
> +
> +static const struct jz_soc_info jz4780_soc_info = {
> +	.tas_tah_cycles_max = 15,
> +};
> +
>  static const struct of_device_id jz4780_nemc_dt_match[] = {
> -	{ .compatible = "ingenic,jz4780-nemc" },
> +	{ .compatible = "ingenic,jz4725b-nemc", .data = &jz4725b_soc_info, },
> +	{ .compatible = "ingenic,jz4780-nemc", .data = &jz4780_soc_info, },
>  	{},
>  };
>  

