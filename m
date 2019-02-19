Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFBC217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfBSEoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:44:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6809 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbfBSEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:44:11 -0500
X-UUID: fc6aca95214c4feba9e6222c19c1e397-20190219
X-UUID: fc6aca95214c4feba9e6222c19c1e397-20190219
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1518967249; Tue, 19 Feb 2019 12:43:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 12:43:58 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 12:43:57 +0800
Message-ID: <1550551437.9232.4.camel@mtksdaap41>
Subject: Re: [v2 1/1] drm/mediatek: add mt8183 dpi support
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
Date:   Tue, 19 Feb 2019 12:43:57 +0800
In-Reply-To: <20190219030645.68321-1-jitao.shi@mediatek.com>
References: <20190219030645.68321-1-jitao.shi@mediatek.com>
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

On Tue, 2019-02-19 at 11:06 +0800, Jitao Shi wrote:
> MT8183 samples on rising and falling edge. It can reduce half data
> io.
> MT8173 also has those registers. But the hw function is removed.
> So MT8173 doesn't support DPI dual edge sample and can't use the
> same setting to mt8183.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 62a9d47df948..610c23334047 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -117,6 +117,7 @@ struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
> +	bool dual_edge;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -353,6 +354,13 @@ static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
>  }
>  
> +static void mtk_dpi_enable_dual_edge(struct mtk_dpi *dpi)
> +{
> +	mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> +		     DDR_EN | DDR_4PHASE);
> +	mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, EDGE_SEL, EDGE_SEL);
> +}

I would like to move dual edge function to an independent patch. Maybe
some other SoC need dual edge function but it's not mt8183 so it could
cherry-pick the dual edge part only.

> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format format)
>  {
> @@ -509,6 +517,8 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	mtk_dpi_config_color_format(dpi, dpi->color_format);
>  	mtk_dpi_config_2n_h_fre(dpi);
>  	mtk_dpi_config_disable_edge(dpi);
> +	if (dpi->conf->dual_edge)
> +		mtk_dpi_enable_dual_edge(dpi);
>  	mtk_dpi_sw_reset(dpi, false);
>  
>  	return 0;
> @@ -671,6 +681,16 @@ static unsigned int mt2701_calculate_factor(int clock)
>  		return 2;
>  }
>  
> +static unsigned int mt8183_calculate_factor(int clock)
> +{
> +	if (clock <= 27000)
> +		return 8;
> +	else if (clock <= 167000)
> +		return 4;
> +	else
> +		return 2;
> +}
> +
>  static const struct mtk_dpi_conf mt8173_conf = {
>  	.cal_factor = mt8173_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
> @@ -682,6 +702,12 @@ static const struct mtk_dpi_conf mt2701_conf = {
>  	.edge_sel_en = true,
>  };
>  
> +static const struct mtk_dpi_conf mt8183_conf = {
> +	.cal_factor = mt8183_calculate_factor,
> +	.reg_h_fre_con = 0xe0,
> +	.dual_edge = true,
> +};
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -777,6 +803,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
>  	{ .compatible = "mediatek,mt8173-dpi",
>  	  .data = &mt8173_conf,
>  	},
> +	{ .compatible = "mediatek,mt8183-dpi",

I could not find "mediatek,mt8183-dpi" in binding document, please add
it.

Regards,
CK

> +	  .data = &mt8183_conf,
> +	},
>  	{ },
>  };
>  


