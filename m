Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFFFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BF720823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BF720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeKSUE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:04:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37000 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbeKSUE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:04:58 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gOg3w-0006mI-Hb; Mon, 19 Nov 2018 10:41:48 +0100
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
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
Date:   Mon, 19 Nov 2018 10:41:47 +0100
Message-ID: <11718017.ngvMPIPJQJ@diego>
In-Reply-To: <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
References: <20181116051719.23376-1-dbasehore@chromium.org> <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com> <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. November 2018, 19:23:59 CET schrieb Doug Anderson:
> Hi,
> 
> On Fri, Nov 16, 2018 at 9:39 AM dbasehore . <dbasehore@chromium.org> wrote:
> > On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> 
wrote:
> > > Hi,
> > > 
> > > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> 
wrote:
> > > > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > > > directly used, muxes will end up traversing the entire clk tree on
> > > > calls to determine_rate if it doesn't exist.
> > > > 
> > > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > > ---
> > > > 
> > > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > 
> > > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> > > 
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > > 99e7f65c1779..3d09472978f8 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > 
> > > Aww crud.  I was at the airport yesterday and so I didn't notice that
> > > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > > device tree file, not in the top level rk3399.  As you have written
> > 
> > > this it will break rk3399 boards that have an rk808 on them, AKA:
> > Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> > this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
> > it can function without it defined, it really shouldn't. We can just
> > assign the existing labels in the dts files you pointed out.
> 
> No, it should be in the board files.  Each board may produce the 32k
> clock through a different component.  On gru-based devices we produce
> the 32k clock through a silego part.

That would also be a great part of the commit message, like
"...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
or so when you move it over to rk3399-gru.dtsi .


> Technically you could say that we don't _truly_ need to model this
> clock and we could have just inserted a dummy/fixed 32k clock in the
> clk-rk3399.c file.  ...but we did model it so that means we should
> probably model it semi-properly.
>
> If a given board forgets to provide a 32k clock then that's a bug for
> them like it was for us.

Yep and as I said in my other mail, on these pmic generated clocks
the clock generation often even is configurable (rate, on/off), so it
should really be a real clock not some hack ;-) .


Heiko


