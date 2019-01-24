Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD03C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9628F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfAXGR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:17:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28686 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725287AbfAXGR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:17:26 -0500
X-UUID: 11b2ad6eddbd46aa961f22506c559675-20190124
X-UUID: 11b2ad6eddbd46aa961f22506c559675-20190124
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1433468263; Thu, 24 Jan 2019 14:17:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 14:17:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 14:17:19 +0800
Message-ID: <1548310639.4220.3.camel@mtksdaap41>
Subject: Re: [PATCH V2,4/8] drm/mediatek: fix the rate and divder of hdmi
 phy for MT2701
From:   CK Hu <ck.hu@mediatek.com>
To:     Wangyan Wang <wangyan.wang@mediatek.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <jitao.shi@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <srv_heupstream@mediatek.com>
Date:   Thu, 24 Jan 2019 14:17:19 +0800
In-Reply-To: <20190118125928.3279-5-wangyan.wang@mediatek.com>
References: <20190118125928.3279-1-wangyan.wang@mediatek.com>
         <20190118125928.3279-5-wangyan.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 20:59 +0800, Wangyan Wang wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>

Describe something here.

> 
> Fixes: 0fc721b2968e ("drm/mediatek: add hdmi driver for MT2701 and MT7623")
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>

Any one who pass a patch should sign off it.

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> index 43bc058d5528..88dd9e812ca0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -114,8 +114,8 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  	if (rate <= 64000000)
>  		pos_div = 3;
> -	else if (rate <= 12800000)
> -		pos_div = 1;
> +	else if (rate <= 128000000)
> +		pos_div = 2;
>  	else
>  		pos_div = 1;
>  


