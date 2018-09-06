Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4CAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AA620857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AA620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeIFGva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:51:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbeIFGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:51:30 -0400
X-UUID: e25b9dc5c12947b3acc04668474eca9a-20180906
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1764715506; Thu, 06 Sep 2018 10:18:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 10:18:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 10:18:23 +0800
Message-ID: <1536200303.4618.21.camel@mtksdaap41>
Subject: Re: [PATCH v2 06/13] drm/mediatek: add dpi driver for mt2701 and
 mt7623
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date:   Thu, 6 Sep 2018 10:18:23 +0800
In-Reply-To: <20180905083146.14727-7-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-7-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

One inline comment.

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> This patch adds dpi dirver suppot for both mt2701 and mt7623.
> And also support other (existing or future) chips that use
> the same binding and driver.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c     | 25 ++++++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index ed2c153c70a2..1af25765ab5f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -641,9 +641,7 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  	}
>  	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
>  
> -	/* Currently DPI0 is fixed to be driven by OVL1 */
> -	dpi->encoder.possible_crtcs = BIT(1);
> -
> +	dpi->encoder.possible_crtcs = BIT(0) | BIT(1);

This patch is for MT2701 and MT7623, but this modification would apply
to MT8173 and MT2712. Does MT8173 and MT2712 support this modification?
If the answer is no, apply this modification only for MT2701 and MT7623.
If the answer is yes, move this modification to an independent patch.

Regards,
CK

>  	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to attach bridge: %d\n", ret);
> @@ -691,12 +689,33 @@ static unsigned int mt8173_calculate_factor(int clock)
>  		return 3 << 1;
>  }
>  
> +static unsigned int mt2701_calculate_factor(int clock)
> +{
> +	if (clock <= 64000)
> +		return 16;
> +	else if (clock <= 128000)
> +		return 8;
> +	else if (clock <= 256000)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
>  };
>  
> +static const struct mtk_dpi_conf mt2701_conf = {
> +	.cal_factor = mt2701_calculate_factor,
> +	.reg_h_fre_con = 0xb0,
> +	.edge_sel_en = true,
> +};
> +
>  static const struct of_device_id mtk_dpi_of_ids[] = {
> +	{ .compatible = "mediatek,mt2701-dpi",
> +	  .data = &mt2701_conf,
> +	},
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = &mt8173_conf,
>  	},
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 39721119713b..d961112fa2f5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -424,6 +424,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>  	  .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dsi",
>  	  .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt2701-dpi",
> +	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt2701-disp-mutex",


