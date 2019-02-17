Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B434521929
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfBQOsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:48:38 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:1594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725795AbfBQOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:48:38 -0500
X-UUID: d4b019f306a64d96bd859c92f8e845ed-20190217
X-UUID: d4b019f306a64d96bd859c92f8e845ed-20190217
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1431380648; Sun, 17 Feb 2019 22:48:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 17 Feb
 2019 22:48:14 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 22:48:13 +0800
Message-ID: <1550414892.5194.17.camel@mszsdaap41>
Subject: Re: [PATCH 3/3] drm/mediatek: add mt8183 dsi driver support
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
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
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        cawa cheng <cawa.cheng@mediatek.com>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <bibby.hsieh@mediatek.com>, CK HU <ck.hu@mediatek.com>,
        <stonea168@163.com>
Date:   Sun, 17 Feb 2019 22:48:12 +0800
In-Reply-To: <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
         <20190214044243.129920-3-jitao.shi@mediatek.com>
         <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 13:54 +0800, Nicolas Boichat wrote:
> On Thu, Feb 14, 2019 at 12:43 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
> >
> > MT8183 dsi has two changes with mt8173.
> > 1. Add the register double buffer control, but we no need it, So make
> >    it default off.
> 
> Can you describe a little bit more what this is about? That's shadow
> registers, right?
> 

Yes, it is shadow registers.

Jitao

> > 2. Add picture size control.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 80db02a25cb0..20cb53f05d42 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -78,6 +78,7 @@
> >  #define DSI_VBP_NL             0x24
> >  #define DSI_VFP_NL             0x28
> >  #define DSI_VACT_NL            0x2C
> > +#define DSI_SIZE_CON           0x38
> >  #define DSI_HSA_WC             0x50
> >  #define DSI_HBP_WC             0x54
> >  #define DSI_HFP_WC             0x58
> > @@ -131,7 +132,10 @@
> >  #define VM_CMD_EN                      BIT(0)
> >  #define TS_VFP_EN                      BIT(5)
> >
> > -#define DSI_CMDQ0              0x180
> 
> As I said earlier, move this to 2/3.
> 

Thank for you review.
I'll move it to 2/3 next version.

Best Regards
Jitao

> > +#define DSI_SHADOW_DEBUG       0x190U
> > +#define FORCE_COMMIT           BIT(0)
> > +#define BYPASS_SHADOW          BIT(1)
> > +
> >  #define CONFIG                         (0xff << 0)
> >  #define SHORT_PACKET                   0
> >  #define LONG_PACKET                    2
> > @@ -158,6 +162,7 @@ struct phy;
> >
> >  struct mtk_dsi_driver_data {
> >         const u32 reg_cmdq_off;
> > +       bool has_size_ctl;
> >  };
> >
> >  struct mtk_dsi {
> > @@ -426,6 +431,9 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> >         writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
> >         writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> >
> > +       if (dsi->driver_data->has_size_ctl)
> > +               writel(vm->vactive << 16 | vm->hactive, dsi->regs + DSI_SIZE_CON);
> > +
> >         horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
> >
> >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> > @@ -595,6 +603,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >         }
> >
> >         mtk_dsi_enable(dsi);
> > +
> > +       /* DSI no need this double buffer, disable it when writing register */
> 
> "DSI does not need double buffering, disable it when writing register"
> 

I'll fix it next version.


> > +       writel(FORCE_COMMIT | BYPASS_SHADOW, dsi->regs + DSI_SHADOW_DEBUG);
> 
> So you do this on all MT* variants, is that ok?
> 
> >         mtk_dsi_reset_engine(dsi);
> >         mtk_dsi_phy_timconfig(dsi);
> >
> > @@ -1090,11 +1101,18 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> >         .reg_cmdq_off = 0x180,
> >  };
> >
> > +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x200,
> > +       .has_size_ctl = true,
> > +};
> > +
> >  static const struct of_device_id mtk_dsi_of_match[] = {
> >         { .compatible = "mediatek,mt2701-dsi",
> >           .data = &mt2701_dsi_driver_data },
> >         { .compatible = "mediatek,mt8173-dsi",
> >           .data = &mt8173_dsi_driver_data },
> > +       { .compatible = "mediatek,mt8183-dsi",
> > +         .data = &mt8183_dsi_driver_data },
> >         { },
> >  };
> >
> > --
> > 2.20.1
> >


