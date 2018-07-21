Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB44ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121DE20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121DE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeGUSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:47:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeGUSre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:47:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 204F6206F3; Sat, 21 Jul 2018 19:54:00 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id B41752093C;
        Sat, 21 Jul 2018 19:53:15 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:53:14 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 23/35] mtd: rawnand: txx9ndfmc: rename nand
 controller internal structure
Message-ID: <20180721195314.527b12b8@bbrezillon>
In-Reply-To: <20180720151527.16038-24-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-24-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:15 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> As already done in the core, calling a struct nand_controller
> 'hw_control' is misleading. Use the same name as in nand_base.c:
> 'controller'.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/txx9ndfmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
> index 8f5bbbac4612..9019022774f7 100644
> --- a/drivers/mtd/nand/raw/txx9ndfmc.c
> +++ b/drivers/mtd/nand/raw/txx9ndfmc.c
> @@ -73,7 +73,7 @@ struct txx9ndfmc_drvdata {
>  	void __iomem *base;
>  	unsigned char hold;	/* in gbusclock */
>  	unsigned char spw;	/* in gbusclock */
> -	struct nand_controller hw_control;
> +	struct nand_controller controller;
>  };
>  
>  static struct platform_device *mtd_to_platdev(struct mtd_info *mtd)
> @@ -303,7 +303,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  	dev_info(&dev->dev, "CLK:%ldMHz HOLD:%d SPW:%d\n",
>  		 (gbusclk + 500000) / 1000000, hold, spw);
>  
> -	nand_controller_init(&drvdata->hw_control);
> +	nand_controller_init(&drvdata->controller);
>  
>  	platform_set_drvdata(dev, drvdata);
>  	txx9ndfmc_initialize(dev);
> @@ -337,7 +337,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		chip->ecc.bytes = 3;
>  		chip->ecc.strength = 1;
>  		chip->chip_delay = 100;
> -		chip->controller = &drvdata->hw_control;
> +		chip->controller = &drvdata->controller;
>  
>  		nand_set_controller_data(chip, txx9_priv);
>  		txx9_priv->dev = dev;

