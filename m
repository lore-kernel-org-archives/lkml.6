Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9CC21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 15:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfBQPRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 10:17:39 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:11421 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726638AbfBQPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 10:17:38 -0500
X-UUID: 40f7cf2251e34aa4b1b2bf424ef39e1f-20190217
X-UUID: 40f7cf2251e34aa4b1b2bf424ef39e1f-20190217
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 310595145; Sun, 17 Feb 2019 23:17:24 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 17 Feb
 2019 23:17:22 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 23:17:21 +0800
Message-ID: <1550416640.5194.33.camel@mszsdaap41>
Subject: Re: [PATCH 2/3] drm/mediatek: CMDQ reg address of mt8173 is
 different with mt2701
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
Date:   Sun, 17 Feb 2019 23:17:20 +0800
In-Reply-To: <CANMq1KAua2mEfT81Mos5JyxHwUfVmgi5Se3fTPy9QcXyh23Urg@mail.gmail.com>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
         <20190214044243.129920-2-jitao.shi@mediatek.com>
         <CANMq1KAua2mEfT81Mos5JyxHwUfVmgi5Se3fTPy9QcXyh23Urg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 13:48 +0800, Nicolas Boichat wrote:
> On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
> >
> > Config the different CMDQ reg address in driver data.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 39 ++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 93fa255b4aad..80db02a25cb0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -156,6 +156,10 @@
> >
> >  struct phy;
> >
> > +struct mtk_dsi_driver_data {
> > +       const u32 reg_cmdq_off;
> > +};
> > +
> >  struct mtk_dsi {
> >         struct mtk_ddp_comp ddp_comp;
> >         struct device *dev;
> > @@ -182,6 +186,7 @@ struct mtk_dsi {
> >         bool enabled;
> >         u32 irq_data;
> >         wait_queue_head_t irq_wait_queue;
> > +       struct mtk_dsi_driver_data *driver_data;
> >  };
> >
> >  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> > @@ -934,6 +939,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> >         const char *tx_buf = msg->tx_buf;
> >         u8 config, cmdq_size, cmdq_off, type = msg->type;
> >         u32 reg_val, cmdq_mask, i;
> > +       u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
> >
> >         if (MTK_DSI_HOST_IS_READ(type))
> >                 config = BTA;
> > @@ -953,9 +959,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
> >         }
> >
> >         for (i = 0; i < msg->tx_len; i++)
> > -               writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> > +               mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> > +                            (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> > +                            tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));
> 
> I found the writeb call _much_ clearer ... Either switch back to that,
> or create a new mtk_disk_mask_byte function maybe?

I'll fix it next version.

> 
> >
> > -       mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> > +       mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
> 
> You're removing DSI_CMDQ0 usage in this patch, so remove the #define
> in this patch too (instead of doing that in 3/3).

I'll fix it next version.
> 
> >         mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
> >  }
> >
> > @@ -1074,10 +1082,27 @@ static const struct component_ops mtk_dsi_component_ops = {
> >         .unbind = mtk_dsi_unbind,
> >  };
> >
> > +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x200,
> > +};
> > +
> > +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> > +       .reg_cmdq_off = 0x180,
> > +};
> > +
> > +static const struct of_device_id mtk_dsi_of_match[] = {
> > +       { .compatible = "mediatek,mt2701-dsi",
> > +         .data = &mt2701_dsi_driver_data },
> > +       { .compatible = "mediatek,mt8173-dsi",
> > +         .data = &mt8173_dsi_driver_data },
> > +       { },
> > +};
> > +
> >  static int mtk_dsi_probe(struct platform_device *pdev)
> >  {
> >         struct mtk_dsi *dsi;
> >         struct device *dev = &pdev->dev;
> > +       const struct of_device_id *of_id;
> >         struct resource *regs;
> >         int irq_num;
> >         int comp_id;
> > @@ -1101,6 +1126,10 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto err_unregister_host;
> >
> > +       of_id = of_match_device(mtk_dsi_of_match, &pdev->dev);
> > +       dsi->driver_data = (struct mtk_dsi_driver_data *)
> > +                           of_id->data;
> 
> This fits in 80 chars. Also, of_id->data is a void*, so no cast needed.

I'll fix it next version.

> 
> > +
> >         dsi->engine_clk = devm_clk_get(dev, "engine");
> >         if (IS_ERR(dsi->engine_clk)) {
> >                 ret = PTR_ERR(dsi->engine_clk);
> > @@ -1194,12 +1223,6 @@ static int mtk_dsi_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -static const struct of_device_id mtk_dsi_of_match[] = {
> > -       { .compatible = "mediatek,mt2701-dsi" },
> > -       { .compatible = "mediatek,mt8173-dsi" },
> > -       { },
> > -};
> 
> Any reason you moved this up?

of_match_device is called by mtk_dsi_probe.

Best regards
Jitao
> 
> > -
> >  struct platform_driver mtk_dsi_driver = {
> >         .probe = mtk_dsi_probe,
> >         .remove = mtk_dsi_remove,
> > --
> > 2.20.1
> >


