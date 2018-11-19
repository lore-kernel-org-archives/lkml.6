Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C59C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA5D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeKSQBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:01:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725908AbeKSQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:01:44 -0500
X-UUID: 242e818e35404c0699433c94c60f9866-20181119
X-UUID: 242e818e35404c0699433c94c60f9866-20181119
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 346382193; Mon, 19 Nov 2018 13:39:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Nov 2018 13:39:00 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 13:38:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Nov 2018 13:38:59 +0800
Message-ID: <1542605939.32082.12.camel@mtksdaap41>
Subject: Re: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
From:   CK Hu <ck.hu@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <matthias.bgg@gmail.com>,
        <sean.wang@mediatek.com>, <sean.wang@kernel.org>,
        <rdunlap@infradead.org>, <wens@csie.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Matthias Brugger <mbrugger@suse.com>
Date:   Mon, 19 Nov 2018 13:38:59 +0800
In-Reply-To: <20181116125449.23581-6-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
         <20181116125449.23581-6-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> It can happen that the mmsys clock drivers aren't probed before the
> platform driver gets invoked. The platform driver used to print a warning
> that the driver failed to get the clocks. Omit this error on
> the defered probe path.

This patch looks good to me, but you have not modified the sub driver in
HDMI path. We could let HDMI path print the warning and someone send
another patch later, or you modify for HDMI path in this patch.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 4 +++-
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 4 +++-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c  | 4 +++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c    | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_dsi.c        | 6 ++++--
>  5 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> index f609b62b8be6..1ea3178d4c18 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> @@ -126,7 +126,9 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>  				&mtk_disp_color_funcs);
>  	if (ret) {
> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to initialize component: %d\n",
> +					ret);

I would like one more blank line here.

>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 28d191192945..5ebbcaa4e70e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -293,7 +293,9 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>  				&mtk_disp_ovl_funcs);
>  	if (ret) {
> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to initialize component: %d\n",
> +					ret);

I would like to align to the right of '('.

Regards,
CK

>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index b0a5cffe345a..59a08ed5fea5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -295,7 +295,9 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
>  				&mtk_disp_rdma_funcs);
>  	if (ret) {
> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to initialize component: %d\n",
> +					ret);
>  		return ret;
>  	}
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index b06cd9d4b525..b76a2d071a97 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -566,7 +566,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>  
>  	ddp->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(ddp->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get clock\n");
>  		return PTR_ERR(ddp->clk);
>  	}
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 90109a0d6fff..cc6de75636c3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1103,14 +1103,16 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>  	if (IS_ERR(dsi->engine_clk)) {
>  		ret = PTR_ERR(dsi->engine_clk);
> -		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get engine clock: %d\n", ret);
>  		return ret;
>  	}
>  
>  	dsi->digital_clk = devm_clk_get(dev, "digital");
>  	if (IS_ERR(dsi->digital_clk)) {
>  		ret = PTR_ERR(dsi->digital_clk);
> -		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get digital clock: %d\n", ret);
>  		return ret;
>  	}
>  


