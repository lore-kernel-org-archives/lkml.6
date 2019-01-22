Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4A2C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389AF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAVGlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:41:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47259 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727070AbfAVGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:41:39 -0500
X-UUID: ad60eacbd7694476a514c725c879d81b-20190122
X-UUID: ad60eacbd7694476a514c725c879d81b-20190122
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 154833029; Tue, 22 Jan 2019 14:41:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 14:41:11 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 14:41:10 +0800
Message-ID: <1548139270.1697.1.camel@mszsdaap41>
Subject: Re: [PATCH 9/9] drm/mediatek: add dpi dual edge support
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>
CC:     Chunhui Dai =?UTF-8?Q?=28=E6=88=B4=E6=98=A5=E6=99=96=29?= 
        <Chunhui.Dai@mediatek.com>,
        --to=Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <Sean.Wang@mediatek.com>,
        "Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?=" 
        <Ryder.Lee@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>,
        JamesJJ Liao =?UTF-8?Q?=28=E5=BB=96=E5=BB=BA=E6=99=BA=29?= 
        <jamesjj.liao@mediatek.com>
Date:   Tue, 22 Jan 2019 14:41:10 +0800
In-Reply-To: <6021c8950c3146bb941ed1355391106d@mtkmbs01n1.mediatek.inc>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
         <1546585439-30455-10-git-send-email-chunhui.dai@mediatek.com>
         <6021c8950c3146bb941ed1355391106d@mtkmbs01n1.mediatek.inc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

Ok, I'll send it again in an independent patch.

Best Regards
Jitao

On Wed, 2019-01-16 at 14:52 +0800, CK Hu (胡俊光) wrote:
> Hi, Chunhui:
> 
> > -----Original Message-----
> > From: chunhui dai [mailto:chunhui.dai@mediatek.com]
> > Sent: Friday, January 04, 2019 3:04 PM
> > To: --to=Michael Turquette; Stephen Boyd; CK Hu (胡俊光)
> > Cc: Matthias Brugger; Philipp Zabel; David Airlie; Chunhui Dai (戴春晖); Sean
> > Wang; Ryder Lee (李庚諺); Colin Ian King; linux-clk@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-mediatek@lists.infradead.org; dri-devel@lists.freedesktop.org;
> > srv_heupstream; Bibby Hsieh (謝濟遠); JamesJJ Liao (廖建智); Jitao Shi (石记
> > 涛)
> > Subject: [PATCH 9/9] drm/mediatek: add dpi dual edge support
> > 
> > DPI sample on rising and falling edge. It can reduce half data io.
> 
> This patch looks like a patch for MT8183. For MT8173 and MT2701, dual_edge is false.
> For now, we have not support MT8183 yet.
> So you could just set dual_edge to false and remove MT8183 part in this patch.
> You could send the MT8183 part in an independent patch, not in a series of MT2701.
> 
> Regards,
> CK
> 
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 30
> > ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index 4a2f4a6..acb4f47 100644
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
> > @@ -353,6 +354,15 @@ static void mtk_dpi_config_disable_edge(struct
> > mtk_dpi *dpi)
> >  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);  }
> > 
> > +static void mtk_dpi_config_dual_edge(struct mtk_dpi *dpi) {
> > +	if (dpi->conf->dual_edge) {
> > +		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN |
> > +				DDR_4PHASE, DDR_EN | DDR_4PHASE);
> > +		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> > +	}
> > +}
> > +
> >  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
> >  					enum mtk_dpi_out_color_format format)  { @@
> > -509,6 +519,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	mtk_dpi_config_color_format(dpi, dpi->color_format);
> >  	mtk_dpi_config_2n_h_fre(dpi);
> >  	mtk_dpi_config_disable_edge(dpi);
> > +	mtk_dpi_config_dual_edge(dpi);
> >  	mtk_dpi_sw_reset(dpi, false);
> > 
> >  	return 0;
> > @@ -669,6 +680,16 @@ static unsigned int mt2701_calculate_factor(int
> > clock)
> >  		return 1;
> >  }
> > 
> > +static unsigned int mt8183_calculate_factor(int clock) {
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
> > @@ -680,6 +701,12 @@ static unsigned int mt2701_calculate_factor(int
> > clock)
> >  	.edge_sel_en = true,
> >  };
> > 
> > +static const struct mtk_dpi_conf mt8183_conf = {
> > +	.cal_factor = mt8183_calculate_factor,
> > +	.reg_h_fre_con = 0xe0,
> > +	.dual_edge = true,
> > +};
> > +
> >  static int mtk_dpi_probe(struct platform_device *pdev)  {
> >  	struct device *dev = &pdev->dev;
> > @@ -775,6 +802,9 @@ static int mtk_dpi_remove(struct platform_device
> > *pdev)
> >  	{ .compatible = "mediatek,mt8173-dpi",
> >  	  .data = &mt8173_conf,
> >  	},
> > +	{ .compatible = "mediatek,mt8183-dpi",
> > +	  .data = &mt8183_conf,
> > +	},
> >  	{ },
> >  };
> > 
> > --
> > 1.9.1
> 


