Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id a8PmHv4/GlvKUwAAmS7hNA
	; Fri, 08 Jun 2018 08:38:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EFA56608BA; Fri,  8 Jun 2018 08:38:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CFA4E6074D;
	Fri,  8 Jun 2018 08:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFA4E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeFHIi0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:38:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37990 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751224AbeFHIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:38:24 -0400
X-UUID: 63f7504d412b42e8a2092012ce15f86b-20180608
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 139879176; Fri, 08 Jun 2018 16:38:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 8 Jun 2018 16:38:18 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 8 Jun 2018 16:38:18 +0800
Message-ID: <1528447098.11190.26.camel@mtksdccf07>
Subject: Re: [PATCH v4 9/9] drm/mediatek: Add support for mediatek SOC MT2712
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Fri, 8 Jun 2018 16:38:18 +0800
In-Reply-To: <1527494014.24367.14.camel@mtksdaap41>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
         <1527489507-24453-10-git-send-email-stu.hsieh@mediatek.com>
         <1527494014.24367.14.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:


On Mon, 2018-05-28 at 15:53 +0800, CK Hu wrote:
> Hi, Stu:
> 
> Two inline comment.
> 
> On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> > This patch add support for the Mediatek MT2712 DISP subsystem.
> > There are two OVL engine and three disp output in MT2712.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 39 ++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 +++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 8bfc0debd2c2..3b22b48a6022 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -61,6 +61,24 @@
> >  #define MT8173_MUTEX_MOD_DISP_PWM1		24
> >  #define MT8173_MUTEX_MOD_DISP_OD		25
> >  
> > +#define MT2712_MUTEX_MOD_DISP_PWM2		10
> > +#define MT2712_MUTEX_MOD_DISP_OVL0		11
> > +#define MT2712_MUTEX_MOD_DISP_OVL1		12
> > +#define MT2712_MUTEX_MOD_DISP_RDMA0		13
> > +#define MT2712_MUTEX_MOD_DISP_RDMA1		14
> > +#define MT2712_MUTEX_MOD_DISP_RDMA2		15
> > +#define MT2712_MUTEX_MOD_DISP_WDMA0		16
> > +#define MT2712_MUTEX_MOD_DISP_WDMA1		17
> > +#define MT2712_MUTEX_MOD_DISP_COLOR0		18
> > +#define MT2712_MUTEX_MOD_DISP_COLOR1		19
> > +#define MT2712_MUTEX_MOD_DISP_AAL0		20
> > +#define MT2712_MUTEX_MOD_DISP_UFOE		22
> > +#define MT2712_MUTEX_MOD_DISP_PWM0		23
> > +#define MT2712_MUTEX_MOD_DISP_PWM1		24
> > +#define MT2712_MUTEX_MOD_DISP_OD0		25
> > +#define MT2712_MUTEX_MOD2_DISP_AAL1		33
> > +#define MT2712_MUTEX_MOD2_DISP_OD1		34
> > +
> >  #define MT2701_MUTEX_MOD_DISP_OVL		3
> >  #define MT2701_MUTEX_MOD_DISP_WDMA		6
> >  #define MT2701_MUTEX_MOD_DISP_COLOR		7
> > @@ -110,6 +128,26 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
> >  };
> >  
> > +static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> > +	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
> > +	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
> > +	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
> > +	[DDP_COMPONENT_COLOR1] = MT2712_MUTEX_MOD_DISP_COLOR1,
> > +	[DDP_COMPONENT_OD0] = MT2712_MUTEX_MOD_DISP_OD0,
> > +	[DDP_COMPONENT_OD1] = MT2712_MUTEX_MOD2_DISP_OD1,
> > +	[DDP_COMPONENT_OVL0] = MT2712_MUTEX_MOD_DISP_OVL0,
> > +	[DDP_COMPONENT_OVL1] = MT2712_MUTEX_MOD_DISP_OVL1,
> > +	[DDP_COMPONENT_PWM0] = MT2712_MUTEX_MOD_DISP_PWM0,
> > +	[DDP_COMPONENT_PWM1] = MT2712_MUTEX_MOD_DISP_PWM1,
> > +	[DDP_COMPONENT_PWM2] = MT2712_MUTEX_MOD_DISP_PWM2,
> > +	[DDP_COMPONENT_RDMA0] = MT2712_MUTEX_MOD_DISP_RDMA0,
> > +	[DDP_COMPONENT_RDMA1] = MT2712_MUTEX_MOD_DISP_RDMA1,
> > +	[DDP_COMPONENT_RDMA2] = MT2712_MUTEX_MOD_DISP_RDMA2,
> > +	[DDP_COMPONENT_UFOE] = MT2712_MUTEX_MOD_DISP_UFOE,
> > +	[DDP_COMPONENT_WDMA0] = MT2712_MUTEX_MOD_DISP_WDMA0,
> > +	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
> > +};
> > +
> >  static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
> >  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
> > @@ -430,6 +468,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
> >  
> >  static const struct of_device_id ddp_driver_dt_match[] = {
> >  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
> > +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
> >  	{},
> >  };
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 3d279a299383..3a866e1d6af4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -146,6 +146,32 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
> >  	DDP_COMPONENT_DPI0,
> >  };
> >  
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
> > +	DDP_COMPONENT_OVL0,
> > +	DDP_COMPONENT_COLOR0,
> > +	DDP_COMPONENT_AAL0,
> > +	DDP_COMPONENT_OD0,
> > +	DDP_COMPONENT_RDMA0,
> > +	DDP_COMPONENT_DPI0,
> > +	DDP_COMPONENT_PWM0,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
> > +	DDP_COMPONENT_OVL1,
> > +	DDP_COMPONENT_COLOR1,
> > +	DDP_COMPONENT_AAL1,
> > +	DDP_COMPONENT_OD1,
> > +	DDP_COMPONENT_RDMA1,
> > +	DDP_COMPONENT_DPI1,
> 
> Where do you define DDP_COMPONENT_DPI1?
> 
> > +	DDP_COMPONENT_PWM1,
> > +};
> > +
> > +static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
> > +	DDP_COMPONENT_RDMA2,
> > +	DDP_COMPONENT_DSI2,
> 
> Where do you define DDP_COMPONENT_DSI2?
> 

I would add another patch for these component in next version patch
series.And add some connection patch from RDMAx to
DPI0/DPI1/DSI1/DSI2/DSI3.

Regards,
Stu

> Regards,
> CK
> 
> > +	DDP_COMPONENT_PWM2,
> > +};
> > +
> >  static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
> >  	DDP_COMPONENT_OVL0,
> >  	DDP_COMPONENT_COLOR0,
> > @@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> >  	.shadow_register = true,
> >  };
> >  
> > +static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
> > +	.main_path = mt2712_mtk_ddp_main,
> > +	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
> > +	.ext_path = mt2712_mtk_ddp_ext,
> > +	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
> > +	.third_path = mt2712_mtk_ddp_third,
> > +	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
> > +};
> > +
> >  static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
> >  	.main_path = mt8173_mtk_ddp_main,
> >  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
> > @@ -379,6 +414,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
> >  	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
> >  	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
> >  	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> > +	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> >  	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
> >  	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
> >  	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
> > @@ -557,6 +593,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
> >  static const struct of_device_id mtk_drm_of_ids[] = {
> >  	{ .compatible = "mediatek,mt2701-mmsys",
> >  	  .data = &mt2701_mmsys_driver_data},
> > +	{ .compatible = "mediatek,mt2712-mmsys",
> > +	  .data = &mt2712_mmsys_driver_data},
> >  	{ .compatible = "mediatek,mt8173-mmsys",
> >  	  .data = &mt8173_mmsys_driver_data},
> >  	{ }
> 
> 
