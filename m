Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1150E2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfAQIet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:34:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39664 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726986AbfAQIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:34:49 -0500
X-UUID: 1e120a4f7c444726ad323d805ab44dd3-20190117
X-UUID: 1e120a4f7c444726ad323d805ab44dd3-20190117
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunhui.dai@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 174804564; Thu, 17 Jan 2019 16:34:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 16:34:36 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 16:34:35 +0800
Message-ID: <1547714075.4664.1.camel@mszsdaap41>
Subject: Re: [PATCH 4/9] drm/mediatek: fix the rate and divder of hdmi phy
 for MT2701
From:   Chunhui Dai <chunhui.dai@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     --to=Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        <wangyan.wang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <jamesjj.liao@mediatek.com>,
        <jitao.shi@mediatek.com>
Date:   Thu, 17 Jan 2019 16:34:35 +0800
In-Reply-To: <a3e37dde-2bab-be02-27ec-d15784bd560b@gmail.com>
References: <1546585439-30455-1-git-send-email-chunhui.dai@mediatek.com>
         <1546585439-30455-5-git-send-email-chunhui.dai@mediatek.com>
         <a3e37dde-2bab-be02-27ec-d15784bd560b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 17:54 +0100, Matthias Brugger wrote:
> 
> On 04/01/2019 08:03, chunhui dai wrote:
> > fix the rate and divder of hdmi phy for MT2701.
> 
> This is a bug? Then we would need a fixes tag.

yes, we would add the tag in V2.

> Otherwise you should explain in the commit, that you need to change the
> calculation due to previous commits.
> 
> Regards,
> Matthias
> 
> > 
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > index a28a32d..10b6235 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> > @@ -114,8 +114,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> >  
> >  	if (rate <= 64000000)
> >  		pos_div = 3;
> > -	else if (rate <= 12800000)
> > -		pos_div = 1;
> > +	else if (rate <= 128000000)
> > +		pos_div = 2;
> >  	else
> >  		pos_div = 1;
> >  
> > 


