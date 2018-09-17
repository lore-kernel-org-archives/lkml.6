Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15FB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15FB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeIRE0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:26:54 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56098 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbeIRE0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:26:54 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 688BD5599E;
        Mon, 17 Sep 2018 22:57:23 +0000 (UTC)
Message-ID: <f968f15fec21ba5b0415b1792536af3e5aba6e57.camel@aosc.io>
Subject: Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY fallback
 compatible from R40 DT
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej =?gb2312?Q?=810=947krabec?= <jernej.skrabec@siol.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Tue, 18 Sep 2018 06:57:16 +0800
In-Reply-To: <20180917145452.ewfuqkrxjjosbawd@flea>
References: <20180907072234.48282-1-icenowy@aosc.io>
         <20180907072234.48282-6-icenowy@aosc.io>
         <20180910142354.5ldexkvnan6ohz4x@flea> <1926288.mXGsSvSKgU@jernej-laptop>
         <20180917145452.ewfuqkrxjjosbawd@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-09-17一的 16:54 +0200，Maxime Ripard写道：
> On Mon, Sep 10, 2018 at 04:32:30PM +0200, Jernej Škrabec wrote:
> > Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime
> > Ripard 
> > napisal(a):
> > > On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > > > The R40 HDMI PHY seems to be different to the A64 one, the A64
> > > > one
> > > > has no input mux, but the R40 one has.
> > > > 
> > > > Drop the A64 fallback compatible from the HDMI PHY node in R40
> > > > DT.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > b/arch/arm/boot/dts/sun8i-r40.dtsi index
> > > > ffd9f00f74a4..5f547c161baf
> > > > 100644
> > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > @@ -800,8 +800,7 @@
> > > > 
> > > >  		};
> > > >  		
> > > >  		hdmi_phy: hdmi-phy@1ef0000 {
> > > > 
> > > > -			compatible = "allwinner,sun8i-r40-hdmi-
> > > > phy",
> > > > -				     "allwinner,sun50i-a64-
> > > > hdmi-phy";
> > > > +			compatible = "allwinner,sun8i-r40-hdmi-
> > > > phy";
> > > 
> > > If you could use the A64 phy before, you can still use it now.
> > 
> > Not exactly. Given that we don't know how to switch between HDMI
> > PHY clock 
> > parents on A64 (if it is actually connected at all, there is no
> > information 
> > about that in manual and AW didn't answered our questions, despite
> > asking them 
> > through different channels), A64 compatible will be associated with
> > quirk, 
> > which will tell that only one clock parent is usable.
> > 
> > However, R40 HDMI PHY has definetly two clock parents, as it was
> > tested by me 
> > and Icenowy and we know how to switch between them without issues. 
> > Technically, we could have A64 compatible there, but that would
> > mean only 
> > single PHY parent is considered instead of two.
> 
> The DT change above would mean that you can't operate the R40 phy in
> the same way than the A64's. From what you're telling me now, this
> isn't exactly what is going on: you can operate the R40 phy just like
> the A64: with a single PLL instead of two. You operate in a degraded
> and non-optimal mode, but it still works.

The status of R40 HDMI PHY input mux is not determined when use A64
driver, which makes it not working when the bootloader initializes it
to use the second PLL (the A64 driver will assume the parent is the
first PLL).

> 
> And it's exactly what the DT is already saying.
> 
> Maxime
> 

