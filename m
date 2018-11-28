Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008620832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeK2Arw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:47:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44520 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbeK2Arw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:47:52 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gS0AC-0004rB-TO; Wed, 28 Nov 2018 14:46:00 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Tony Xie <tony.xie@rock-chips.com>,
        Chris <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        =?utf-8?B?6YOR6Iic5Lm+?= <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Brian Norris <briannorris@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
Date:   Wed, 28 Nov 2018 14:45:59 +0100
Message-ID: <6602824.AOVt5XvbUN@diego>
In-Reply-To: <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
References: <20181127232331.49628-1-dbasehore@chromium.org> <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2018, 01:42:36 CET schrieb Doug Anderson:
> Hi,
> 
> On Tue, Nov 27, 2018 at 3:23 PM Derek Basehore <dbasehore@chromium.org> 
wrote:
> > This adds the 32k clock to the RK3399 Gru board file. Even though it's
> > not directly used, muxes will end up traversing the entire clk tree on
> > calls to determine_rate if it doesn't exist. This is because the 32k
> > clk is listed as a possible parent on some clks. Since the clk doesn't
> > know about the 32k clk (it was never registered), it triggers a global
> > search for it. This can happen about 40 times per second, which isn't
> > great for power.
> 
> I seem to remember Heiko requesting something be added to the commit
> 
> message.  Ah yes, he said:
> > That would also be a great part of the commit message, like
> > "...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
> > or so when you move it over to rk3399-gru.dtsi .
> 
> Presumably Heiko could add that to the commit message when he applies
> the patch, so maybe wait to see if he wants you to respin it?
> 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi index
> > ca07f6032200..a07aa4c570c0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > @@ -14,6 +14,13 @@
> > 
> >                 stdout-path = "serial2:115200n8";
> >         
> >         };
> > 
> > +       ap_rtc_clk: ap-rtc-clk {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <32768>;
> > +               clock-output-names = "xin32k";
> > +               #clock-cells = <0>;
> > +       };
> > +
> > 
> >         /*
> >         
> >          * Power Tree
> 
> Really this should be below the power tree, AKA right above
> "gpio-keys".  Convention has typically been that only "special" nodes
> like "chosen" go all the way at the top here.  Then the power tree
> (parents first), then other nodes.
> 
> In the Chrome OS tree we had an "/* END REGULATORS */ comment to try
> to separate out the power tree from the rest of the nodes, but I guess
> Heiko didn't like that when this went upstream so now you just have to
> know the convention.  :-P
> 
> Possibly Heiko would re-sort this for you himself when applying the
> change if he agrees with my understanding of the conventions.

We hashed out the dt-conventions somewhat together during veyron
times, so I'd be surprised if we didn't agree on them :-D .

In any case, I've adapted the commit message to add the Silego part,
moved the clock to the correct position and applied the result with
your Reviewed-by for 4.21.


Heiko


