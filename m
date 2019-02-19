Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA40C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA9F217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfBSBxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:53:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43565 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732932AbfBSBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:53:21 -0500
X-UUID: 09369e495cb34712b61f8f766755b2e0-20190219
X-UUID: 09369e495cb34712b61f8f766755b2e0-20190219
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1509288187; Tue, 19 Feb 2019 09:53:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 09:53:12 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 09:53:10 +0800
Message-ID: <1550541190.13121.2.camel@mszsdaap41>
Subject: Re: [PATCH] drm/mediatek: add mt8183 dpi support
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
Date:   Tue, 19 Feb 2019 09:53:10 +0800
In-Reply-To: <1550160809.6862.13.camel@mtksdaap41>
References: <20190211045059.11821-1-jitao.shi@mediatek.com>
         <1550160809.6862.13.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 00:13 +0800, CK Hu wrote:
> Hi, Jitao:
> 
> On Mon, 2019-02-11 at 12:50 +0800, Jitao Shi wrote:
> > MT8183 sample on rising and falling edge. It can reduce half data io.
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 62a9d47df948..610c23334047 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
> >  	unsigned int (*cal_factor)(int clock);
> >  	u32 reg_h_fre_con;
> >  	bool edge_sel_en;
> > +	bool dual_edge;
> >  };
> >  
> >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> > @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
> >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
> >  }
> >  
> > +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> > +{
> > +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> > +		     DDR_EN | DDR_4PHASE);
> > +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > +}
> 
> All these register exist in MT8173, if you do the same setting in
> MT8173, could it also sample on rising edge and falling edge?
> 
> Regards,
> CK

Hi CK,

MT8173 has those registers. But the hw function is removed.
So MT8173 doesn't support DPI dual edge sample.

Best Regards
Jitao

> 
> > +
> >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> >  					enum mtk_dpi_out_color_format format)
> >  {
> > @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> >  	mtk_dpi_config_2n_h_fre(dpi);
> >  	mtk_dpi_config_disable_edge(dpi);
> > +	if (dpi->conf->dual_edge)
> > +		mtk_dpi_enable_dual_edge(dpi);
> >  	mtk_dpi_sw_reset(dpi, false);
> >  
> >  	return 0;
> > @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
> >  		return 2;
> >  }
> >  
> > +static unsigned int mt8183_calculate_factor(int clock)
> > +{
> > +	if (clock <= 27000)
> > +		return 8;
> > +	else if (clock <= 167000)
> > +		return 4;
> > +	else
> > +		return 2;
> > +}
> > +
> >  static const struct mtk_dpi_conf mt8173_conf = {
> >  	.cal_factor = mt8173_calculate_factor,
> >  	.reg_h_fre_con = 0xe0,
> > @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
> >  	.edge_sel_en = true,
> >  };
> >  
> > +static const struct mtk_dpi_conf mt8183_conf = {
> > +	.cal_factor = mt8183_calculate_factor,
> > +	.reg_h_fre_con = 0xe0,
> > +	.dual_edge = true,
> > +};
> > +
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
> >  	{ .compatible = "mediatek,mt8173-dpi",
> >  	  .data = &mt8173_conf,
> >  	},
> > +	{ .compatible = "mediatek,mt8183-dpi",
> > +	  .data = &mt8183_conf,
> > +	},
> >  	{ },
> >  };
> >  
> 
> 


