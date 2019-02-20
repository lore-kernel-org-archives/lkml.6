Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C782146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfBTGc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:32:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727704AbfBTGc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:32:26 -0500
X-UUID: d97d0e4bf5f649b5a992e0c266cee96e-20190220
X-UUID: d97d0e4bf5f649b5a992e0c266cee96e-20190220
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1288556849; Wed, 20 Feb 2019 14:32:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS33DR.mediatek.inc (172.27.6.106) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 14:32:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 14:32:16 +0800
Message-ID: <1550644336.14153.8.camel@mtksdaap41>
Subject: Re: [PATCH v1 1/2] drm/mediatek: separate mipi_tx to different file
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Ajay Kumar" <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Russell King" <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <stonea168@163.com>
Date:   Wed, 20 Feb 2019 14:32:16 +0800
In-Reply-To: <20190219091404.89370-2-jitao.shi@mediatek.com>
References: <20190219091404.89370-1-jitao.shi@mediatek.com>
         <20190219091404.89370-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

On Tue, 2019-02-19 at 17:14 +0800, Jitao Shi wrote:
> Different IC has different mipi_tx setting of dsi.
> This patch separates the mipi_tx hardware relate part for mt8173.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile             |   1 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 350 ++----------------
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  51 +++
>  drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 290 +++++++++++++++
>  4 files changed, 377 insertions(+), 315 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> 

[snip]
>  
> +static void mtk_mipi_tx_clk_get_ops(struct mtk_mipi_tx *mipi_tx,
> +				    const struct clk_ops **ops)
> +{
> +	if (mipi_tx && mipi_tx->driver_data &&
> +	    mipi_tx->driver_data->mipi_tx_clk_ops)
> +		*ops = mipi_tx->driver_data->mipi_tx_clk_ops;
> +	else
> +		dev_err(mipi_tx->dev, "Failed to get clk ops of phy\n");

Any where call mtk_mipi_tx_clk_get_ops() would make sure mipi_tx is not
NULL, so you need not to check mipi_tx. And the checking of driver_data
and mipi_tx_clk_ops looks unnecessary because any one who implement this
driver would never let this happen. So this function just need do the
assignment and therefore this assignment could just do in probe().

Regards,
CK

> +}
> +
>  static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mipi_tx *mipi_tx;
>  	struct resource *mem;
> -	struct clk *ref_clk;
>  	const char *ref_clk_name;
>  	struct clk_init_data clk_init = {
> -		.ops = &mtk_mipi_tx_pll_ops,
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
>  		.flags = CLK_SET_RATE_GATE,
> @@ -408,6 +132,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mipi_tx->driver_data = of_device_get_match_data(dev);
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(mipi_tx->regs)) {
> @@ -416,13 +141,14 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ref_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ref_clk)) {
> -		ret = PTR_ERR(ref_clk);
> +	mipi_tx->ref_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(mipi_tx->ref_clk)) {
> +		ret = PTR_ERR(mipi_tx->ref_clk);
>  		dev_err(dev, "Failed to get reference clock: %d\n", ret);
>  		return ret;
>  	}
> -	ref_clk_name = __clk_get_name(ref_clk);
> +
> +	ref_clk_name = __clk_get_name(mipi_tx->ref_clk);
>  
>  	ret = of_property_read_string(dev->of_node, "clock-output-names",
>  				      &clk_init.name);
> @@ -431,6 +157,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	mtk_mipi_tx_clk_get_ops(mipi_tx, &clk_init.ops);
> +
>  	mipi_tx->pll_hw.init = &clk_init;
>  	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
>  	if (IS_ERR(mipi_tx->pll)) {
> @@ -465,20 +193,12 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct mtk_mipitx_data mt2701_mipitx_data = {
> -	.mppll_preserve = (3 << 8)
> -};
> -
> -static const struct mtk_mipitx_data mt8173_mipitx_data = {
> -	.mppll_preserve = (0 << 8)
> -};
> -
>  static const struct of_device_id mtk_mipi_tx_match[] = {
>  	{ .compatible = "mediatek,mt2701-mipi-tx",
>  	  .data = &mt2701_mipitx_data },
>  	{ .compatible = "mediatek,mt8173-mipi-tx",
>  	  .data = &mt8173_mipitx_data },
> -	{},
> +	{ },
>  };
>  



