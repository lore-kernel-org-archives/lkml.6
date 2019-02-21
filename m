Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D1FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B992086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfBUCe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:34:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbfBUCe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:34:28 -0500
X-UUID: af8846f3f5a7484e91719e6f27a82d5b-20190221
X-UUID: af8846f3f5a7484e91719e6f27a82d5b-20190221
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 33549891; Thu, 21 Feb 2019 10:34:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 10:34:13 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 10:34:11 +0800
Message-ID: <1550716451.23876.5.camel@mszsdaap41>
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
From:   mtk14994 <wangyan.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     CK Hu <ck.hu@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <srv_heupstream@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 21 Feb 2019 10:34:11 +0800
In-Reply-To: <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
         <20190220025357.7354-6-wangyan.wang@mediatek.com>
         <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 6B35865B27218DA5E0ACF1A9CEF1EFCB5B08DDBD136AEA6993247B1A9DBD11432000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,
> +       unsigned char mux_flags;
> 
> Why isn't it an unsigned long? Isn't this supposed to match the
> frameworks version of the clk flags?

---->   it is unsigned char mux_flags ,becasuse struct clk_mux {

....
....
u8 flags;
....
}

it is matched when use " mux->flags = mc->mux_flags;"

Best Regards
Wangyan



On Wed, 2019-02-20 at 11:37 -0800, Stephen Boyd wrote:
> Quoting wangyan wang (2019-02-19 18:53:54)
> > From: chunhui dai <chunhui.dai@mediatek.com>
> > 
> > Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.
> 
> s/falgs/flags/
> 
> > Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mtk.c |  2 +-
> >  drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> > index 9c0ae4278a94..2ed996404804 100644
> > --- a/drivers/clk/mediatek/clk-mtk.c
> > +++ b/drivers/clk/mediatek/clk-mtk.c
> > @@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
> >                 mux->mask = BIT(mc->mux_width) - 1;
> >                 mux->shift = mc->mux_shift;
> >                 mux->lock = lock;
> > -
> > +               mux->flags = mc->mux_flags;
> >                 mux_hw = &mux->hw;
> >                 mux_ops = &clk_mux_ops;
> >  
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> > index f83c2bbb677e..4b88d196d52f 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -81,15 +81,13 @@ struct mtk_composite {
> >         signed char divider_shift;
> >         signed char divider_width;
> >  
> > +       unsigned char mux_flags;
> 
> Why isn't it an unsigned long? Isn't this supposed to match the
> frameworks version of the clk flags?
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


