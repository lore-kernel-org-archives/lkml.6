Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA59C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4721738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfBTDHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:07:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62707 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727997AbfBTDHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:07:46 -0500
X-UUID: 313be0bc043e4712b30bcbda297710cb-20190220
X-UUID: 313be0bc043e4712b30bcbda297710cb-20190220
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 621961555; Wed, 20 Feb 2019 11:07:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 11:07:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 11:07:32 +0800
Message-ID: <1550632052.26038.4.camel@mtkswgap22>
Subject: Re: [PATCH V5 0/8] make mt7623 clock of hdmi stable
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     wangyan wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Sean Wang" <sean.wang@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 20 Feb 2019 11:07:32 +0800
In-Reply-To: <20190220025357.7354-1-wangyan.wang@mediatek.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-20 at 10:53 +0800, wangyan wang wrote:
> From: Wangyan Wang <wangyan.wang@mediatek.com>
> 
> V4 adopt maintainer's suggestion.
> Here is the change list between V4 & V5
> 1. add Reviewed-by:CK Hu <ck.hu@mediatek.com>
> in " drm/mediatek: fix the rate ..." commit message.
> 
> 2. describe the reason why mt7623 clock of hdmi 
> is more stable than before.
> the tvdpll should be stable in hdmi normal setting
> to guarantee clock of hdmi stable, but the tvdpll 
> may be changed in original code ,the patch is to
> deal with the problem, you can find more descriptions
> in patch "drm/mediatek:using different flags of clk ...".
> 
> 
> chunhui dai (8):
>   drm/mediatek: recalculate hdmi phy clock of MT2701 by querying
>     hardware
>   drm/mediatek: move the setting of fixed divider
>   drm/mediatek: using different flags of clk for HDMI phy
>   drm/mediatek: fix the rate and divder of hdmi phy for MT2701
>   clk: mediatek: add MUX_GATE_FLAGS_2
>   clk: mediatek: using CLK_MUX_ROUND_CLOSEST for the clock of dpi1_sel
>   drm/mediatek: using new factor for tvdpll in MT2701
>   drm/mediatek: fix the rate of parent for hdmi phy in MT2701
> 
>  drivers/clk/mediatek/clk-mt2701.c              |  4 +-
>  drivers/clk/mediatek/clk-mtk.c                 |  2 +-
>  drivers/clk/mediatek/clk-mtk.h                 | 20 ++++++---
>  drivers/gpu/drm/mediatek/mtk_dpi.c             |  8 ++--
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 34 ++++------------
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  7 +---
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 56 +++++++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 23 +++++++++++
>  8 files changed, 102 insertions(+), 52 deletions(-)
> 

I could see the Debian Gnome desktop on my MT7623 R2.

Tested-by: Ryder Lee <ryder.lee@mediatek.com>


