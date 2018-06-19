Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D51C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5802075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5802075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeFSLRS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:17:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38610 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965152AbeFSLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:17:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4067E60A04A1;
        Tue, 19 Jun 2018 13:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hchpT9gtaHO5; Tue, 19 Jun 2018 13:17:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEDD260A04C6;
        Tue, 19 Jun 2018 13:17:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WPBg853E0kxj; Tue, 19 Jun 2018 13:17:14 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 9062260A04A1;
        Tue, 19 Jun 2018 13:17:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kbuild@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 2/3] mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
Date:   Tue, 19 Jun 2018 13:17:14 +0200
Message-ID: <4803088.H75MTUDLH6@blindfold>
In-Reply-To: <1529025532-22087-3-git-send-email-yamada.masahiro@socionext.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com> <1529025532-22087-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Juni 2018, 03:18:51 CEST schrieb Masahiro Yamada:
> The probe function references &pdev->dev many times.  Add 'dev' as
> a shorthand.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mtd/nand/raw/denali_dt.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
> index ce6239d..afaae37 100644
> --- a/drivers/mtd/nand/raw/denali_dt.c
> +++ b/drivers/mtd/nand/raw/denali_dt.c
> @@ -81,38 +81,39 @@ MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
>  
>  static int denali_dt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	struct denali_dt *dt;
>  	const struct denali_dt_data *data;
>  	struct denali_nand_info *denali;
>  	int ret;
>  
> -	dt = devm_kzalloc(&pdev->dev, sizeof(*dt), GFP_KERNEL);
> +	dt = devm_kzalloc(dev, sizeof(*dt), GFP_KERNEL);
>  	if (!dt)
>  		return -ENOMEM;
>  	denali = &dt->denali;
>  
> -	data = of_device_get_match_data(&pdev->dev);
> +	data = of_device_get_match_data(dev);
>  	if (data) {
>  		denali->revision = data->revision;
>  		denali->caps = data->caps;
>  		denali->ecc_caps = data->ecc_caps;
>  	}
>  
> -	denali->dev = &pdev->dev;
> +	denali->dev = dev;
>  	denali->irq = platform_get_irq(pdev, 0);
>  	if (denali->irq < 0) {
> -		dev_err(&pdev->dev, "no irq defined\n");
> +		dev_err(dev, "no irq defined\n");
>  		return denali->irq;
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
> -	denali->reg = devm_ioremap_resource(&pdev->dev, res);
> +	denali->reg = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(denali->reg))
>  		return PTR_ERR(denali->reg);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
> -	denali->host = devm_ioremap_resource(&pdev->dev, res);
> +	denali->host = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(denali->host))
>  		return PTR_ERR(denali->host);
>  
> @@ -120,19 +121,19 @@ static int denali_dt_probe(struct platform_device *pdev)
>  	 * A single anonymous clock is supported for the backward compatibility.
>  	 * New platforms should support all the named clocks.
>  	 */
> -	dt->clk = devm_clk_get(&pdev->dev, "nand");
> +	dt->clk = devm_clk_get(dev, "nand");
>  	if (IS_ERR(dt->clk))
> -		dt->clk = devm_clk_get(&pdev->dev, NULL);
> +		dt->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(dt->clk)) {
> -		dev_err(&pdev->dev, "no clk available\n");
> +		dev_err(dev, "no clk available\n");
>  		return PTR_ERR(dt->clk);
>  	}
>  
> -	dt->clk_x = devm_clk_get(&pdev->dev, "nand_x");
> +	dt->clk_x = devm_clk_get(dev, "nand_x");
>  	if (IS_ERR(dt->clk_x))
>  		dt->clk_x = NULL;
>  
> -	dt->clk_ecc = devm_clk_get(&pdev->dev, "ecc");
> +	dt->clk_ecc = devm_clk_get(dev, "ecc");
>  	if (IS_ERR(dt->clk_ecc))
>  		dt->clk_ecc = NULL;
>  
> @@ -155,7 +156,7 @@ static int denali_dt_probe(struct platform_device *pdev)
>  		 * Hardcode the clock rates for the backward compatibility.
>  		 * This works for both SOCFPGA and UniPhier.
>  		 */
> -		dev_notice(&pdev->dev,
> +		dev_notice(dev,
>  			   "necessary clock is missing. default clock rates are used.\n");
>  		denali->clk_x_rate = 200000000;
>  	}
> 

Tested-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
