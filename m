Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7614BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA5C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA5C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeIJT07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:26:59 -0400
Received: from mailoutvs3.siol.net ([185.57.226.194]:36257 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbeIJT07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:26:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id BA91C5217AD;
        Mon, 10 Sep 2018 16:32:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3mx7fEEuHcwc; Mon, 10 Sep 2018 16:32:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 2BF12521DFE;
        Mon, 10 Sep 2018 16:32:34 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id 4FB855217AD;
        Mon, 10 Sep 2018 16:32:31 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback compatible from R40 DT
Date:   Mon, 10 Sep 2018 16:32:30 +0200
Message-ID: <1926288.mXGsSvSKgU@jernej-laptop>
In-Reply-To: <20180910142354.5ldexkvnan6ohz4x@flea>
References: <20180907072234.48282-1-icenowy@aosc.io> <20180907072234.48282-6-icenowy@aosc.io> <20180910142354.5ldexkvnan6ohz4x@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime Ripard 
napisal(a):
> On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > The R40 HDMI PHY seems to be different to the A64 one, the A64 one
> > has no input mux, but the R40 one has.
> > 
> > Drop the A64 fallback compatible from the HDMI PHY node in R40 DT.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > 
> >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > b/arch/arm/boot/dts/sun8i-r40.dtsi index ffd9f00f74a4..5f547c161baf
> > 100644
> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > @@ -800,8 +800,7 @@
> > 
> >  		};
> >  		
> >  		hdmi_phy: hdmi-phy@1ef0000 {
> > 
> > -			compatible = "allwinner,sun8i-r40-hdmi-phy",
> > -				     "allwinner,sun50i-a64-hdmi-phy";
> > +			compatible = "allwinner,sun8i-r40-hdmi-phy";
> 
> If you could use the A64 phy before, you can still use it now.

Not exactly. Given that we don't know how to switch between HDMI PHY clock 
parents on A64 (if it is actually connected at all, there is no information 
about that in manual and AW didn't answered our questions, despite asking them 
through different channels), A64 compatible will be associated with quirk, 
which will tell that only one clock parent is usable.

However, R40 HDMI PHY has definetly two clock parents, as it was tested by me 
and Icenowy and we know how to switch between them without issues. 
Technically, we could have A64 compatible there, but that would mean only 
single PHY parent is considered instead of two.

Best regards,
Jernej



