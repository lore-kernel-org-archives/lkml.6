Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1566FC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AE6208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AE6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeKTOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:37:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35911 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727880AbeKTOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:37:04 -0500
X-UUID: 4ca6aa6169574b08a57506ee4e294684-20181120
X-UUID: 4ca6aa6169574b08a57506ee4e294684-20181120
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 203659341; Tue, 20 Nov 2018 12:09:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 12:09:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 12:09:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 12:09:42 +0800
Message-ID: <1542686982.26483.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
From:   CK Hu <ck.hu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <matthias.bgg@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <sean.wang@mediatek.com>,
        <sean.wang@kernel.org>, <rdunlap@infradead.org>, <wens@csie.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Matthias Brugger <mbrugger@suse.com>
Date:   Tue, 20 Nov 2018 12:09:42 +0800
In-Reply-To: <1542686700.9073.15.camel@mtksdaap41>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
         <20181116125449.23581-6-matthias.bgg@kernel.org>
         <1542605939.32082.12.camel@mtksdaap41>
         <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
         <1542686700.9073.15.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2018-11-20 at 12:05 +0800, CK Hu wrote:
> Hi, Matthias:
> 
> On Mon, 2018-11-19 at 10:26 +0100, Matthias Brugger wrote:
> > 
> > On 19/11/2018 06:38, CK Hu wrote:
> > > Hi, Matthias:
> > > 
> > > On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
> > >> From: Matthias Brugger <mbrugger@suse.com>
> > >>
> > >> It can happen that the mmsys clock drivers aren't probed before the
> > >> platform driver gets invoked. The platform driver used to print a warning
> > >> that the driver failed to get the clocks. Omit this error on
> > >> the defered probe path.
> > > 
> > > This patch looks good to me, but you have not modified the sub driver in
> > > HDMI path. We could let HDMI path print the warning and someone send
> > > another patch later, or you modify for HDMI path in this patch.
> > 
> > Sure, I'll add this in v6. After inspecting the code, I think we will need to
> > also check for not initialized clocks in mtk_mdp_comp_init, as the driver for
> > now does not even check if the clocks are present. What do you think?
> 
> Yes, we do really need to consider mdp driver because mmsys clock
> include mdp clock. You remind me that mmsys control 4 major function:
> drm routing, drm clock, mdp routing, and mdp clock. Your design let the
> mmsys device as drm device (control drm routing) and create a sub device
> as clock device (control drm clock, mdp clock). If one day mdp device
> (may need control drm routing) need to control the register of mdp

Sorry for typo: 'mdp device (may need control mdp routing)'

Regards,
CK

> routing, would mdp device be a sub device? Or we need not to consider
> this because it need not to access mmsys register now?
> 
> Regards,
> CK
> 
> > 
> > I'll address the coding style issue you metioned below as well.
> > 
> > Regards,
> > Matthias
> > 
> > >>
> > >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > >> ---
> > >>  drivers/gpu/drm/mediatek/mtk_disp_color.c | 4 +++-
> > >>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 4 +++-
> > >>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c  | 4 +++-
> > >>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c    | 3 ++-
> > >>  drivers/gpu/drm/mediatek/mtk_dsi.c        | 6 ++++--
> > >>  5 files changed, 15 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> > >> index f609b62b8be6..1ea3178d4c18 100644
> > >> --- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
> > >> +++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
> > >> @@ -126,7 +126,9 @@ static int mtk_disp_color_probe(struct platform_device *pdev)
> > >>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
> > >>  				&mtk_disp_color_funcs);
> > >>  	if (ret) {
> > >> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> > >> +		if (ret != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to initialize component: %d\n",
> > >> +					ret);
> > > 
> > > I would like one more blank line here.
> > > 
> > >>  		return ret;
> > >>  	}
> > >>  
> > >> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > >> index 28d191192945..5ebbcaa4e70e 100644
> > >> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > >> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> > >> @@ -293,7 +293,9 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
> > >>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
> > >>  				&mtk_disp_ovl_funcs);
> > >>  	if (ret) {
> > >> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> > >> +		if (ret != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to initialize component: %d\n",
> > >> +					ret);
> > > 
> > > I would like to align to the right of '('.
> > > 
> > > Regards,
> > > CK
> > > 
> > >>  		return ret;
> > >>  	}
> > >>  
> > >> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > >> index b0a5cffe345a..59a08ed5fea5 100644
> > >> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > >> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > >> @@ -295,7 +295,9 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
> > >>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &priv->ddp_comp, comp_id,
> > >>  				&mtk_disp_rdma_funcs);
> > >>  	if (ret) {
> > >> -		dev_err(dev, "Failed to initialize component: %d\n", ret);
> > >> +		if (ret != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to initialize component: %d\n",
> > >> +					ret);
> > >>  		return ret;
> > >>  	}
> > >>  
> > >> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > >> index b06cd9d4b525..b76a2d071a97 100644
> > >> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > >> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > >> @@ -566,7 +566,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
> > >>  
> > >>  	ddp->clk = devm_clk_get(dev, NULL);
> > >>  	if (IS_ERR(ddp->clk)) {
> > >> -		dev_err(dev, "Failed to get clock\n");
> > >> +		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to get clock\n");
> > >>  		return PTR_ERR(ddp->clk);
> > >>  	}
> > >>  
> > >> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > >> index 90109a0d6fff..cc6de75636c3 100644
> > >> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > >> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > >> @@ -1103,14 +1103,16 @@ static int mtk_dsi_probe(struct platform_device *pdev)
> > >>  	dsi->engine_clk = devm_clk_get(dev, "engine");
> > >>  	if (IS_ERR(dsi->engine_clk)) {
> > >>  		ret = PTR_ERR(dsi->engine_clk);
> > >> -		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > >> +		if (ret != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > >>  		return ret;
> > >>  	}
> > >>  
> > >>  	dsi->digital_clk = devm_clk_get(dev, "digital");
> > >>  	if (IS_ERR(dsi->digital_clk)) {
> > >>  		ret = PTR_ERR(dsi->digital_clk);
> > >> -		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > >> +		if (ret != -EPROBE_DEFER)
> > >> +			dev_err(dev, "Failed to get digital clock: %d\n", ret);
> > >>  		return ret;
> > >>  	}
> > >>  
> > > 
> > > 
> 


