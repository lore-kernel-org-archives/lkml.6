Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AF218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLZJN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:13:28 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbeLZJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:13:28 -0500
X-UUID: 8be6071c9e6a40d5a276a25421a8e802-20181226
X-UUID: 8be6071c9e6a40d5a276a25421a8e802-20181226
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 550822703; Wed, 26 Dec 2018 17:13:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Dec 2018 17:13:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 17:13:19 +0800
Message-ID: <1545815599.20265.3.camel@mtksdaap41>
Subject: Re: [PATCH 09/18] drm/mediatek: add component DITHER
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 Dec 2018 17:13:19 +0800
In-Reply-To: <1545638931-24938-10-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-10-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> This patch add component DITHER
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 32 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 63f4b1e..a97e27b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -47,6 +47,12 @@
>  #define CCORR_RELAY_MODE			BIT(0)
>  #define DISP_CCORR_SIZE				0x0030
>  
> +#define DISP_DITHER_EN				0x0000
> +#define DITHER_EN				BIT(0)
> +#define DISP_DITHER_CFG                        0x0020
> +#define DITHER_RELAY_MODE			BIT(0)
> +#define DISP_DITHER_SIZE			0x0030
> +
>  #define DISP_GAMMA_EN				0x0000
>  #define DISP_GAMMA_CFG				0x0020
>  #define DISP_GAMMA_SIZE				0x0030
> @@ -155,6 +161,24 @@ static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
>  	writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
>  }
>  
> +static void mtk_dither_config(struct mtk_ddp_comp *comp, unsigned int w,
> +			      unsigned int h, unsigned int vrefresh,
> +			      unsigned int bpc)
> +{
> +	writel(h << 16 | w, comp->regs + DISP_DITHER_SIZE);
> +	writel(DITHER_RELAY_MODE, comp->regs + DISP_DITHER_CFG);
> +}
> +
> +static void mtk_dither_start(struct mtk_ddp_comp *comp)
> +{
> +	writel(DITHER_EN, comp->regs + DISP_DITHER_EN);
> +}
> +
> +static void mtk_dither_stop(struct mtk_ddp_comp *comp)
> +{
> +	writel_relaxed(0x0, comp->regs + DISP_DITHER_EN);
> +}
> +
>  static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
>  			     unsigned int h, unsigned int vrefresh,
>  			     unsigned int bpc)
> @@ -209,6 +233,12 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  	.stop = mtk_ccorr_stop,
>  };
>  
> +static const struct mtk_ddp_comp_funcs ddp_dither = {
> +	.config = mtk_dither_config,
> +	.start = mtk_dither_start,
> +	.stop = mtk_dither_stop,
> +};
> +
>  static const struct mtk_ddp_comp_funcs ddp_gamma = {
>  	.gamma_set = mtk_gamma_set,
>  	.config = mtk_gamma_config,
> @@ -233,6 +263,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
>  	[MTK_DISP_CCORR] = "ccorr",
>  	[MTK_DISP_AAL] = "aal",
>  	[MTK_DISP_GAMMA] = "gamma",
> +	[MTK_DISP_DITHER] = "dither",
>  	[MTK_DISP_UFOE] = "ufoe",
>  	[MTK_DSI] = "dsi",
>  	[MTK_DPI] = "dpi",
> @@ -255,6 +286,7 @@ struct mtk_ddp_comp_match {
>  	[DDP_COMPONENT_CCORR]	= { MTK_DISP_CCORR,	0, &ddp_ccorr },
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
> +	[DDP_COMPONENT_DITHER]	= { MTK_DISP_DITHER,	0, &ddp_dither },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
>  	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 6905647..b0064c52 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -29,6 +29,7 @@ enum mtk_ddp_comp_type {
>  	MTK_DISP_WDMA,
>  	MTK_DISP_COLOR,
>  	MTK_DISP_CCORR,
> +	MTK_DISP_DITHER,
>  	MTK_DISP_AAL,
>  	MTK_DISP_GAMMA,
>  	MTK_DISP_UFOE,
> @@ -48,6 +49,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_CCORR,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
> +	DDP_COMPONENT_DITHER,
>  	DDP_COMPONENT_DPI0,
>  	DDP_COMPONENT_DPI1,
>  	DDP_COMPONENT_DSI0,


