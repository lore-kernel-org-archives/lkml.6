Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082172087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082172087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeKQEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:37:27 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51128 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:37:27 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gNimY-0003DQ-7r; Fri, 16 Nov 2018 19:23:54 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        =?utf-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>,
        Chris Zhong <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        klaus.goger@theobroma-systems.com,
        Brian Norris <briannorris@chromium.org>,
        enric.balletbo@collabora.com, Mark Rutland <mark.rutland@arm.com>,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
Date:   Fri, 16 Nov 2018 19:23:53 +0100
Message-ID: <1698950.cgYuLubFel@diego>
In-Reply-To: <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
References: <20181116051719.23376-1-dbasehore@chromium.org> <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com> <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek,

Am Freitag, 16. November 2018, 18:39:09 CET schrieb dbasehore .:
> On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> > 
> > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> wrote:
> > > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > > directly used, muxes will end up traversing the entire clk tree on
> > > calls to determine_rate if it doesn't exist.
> > > 
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > > 
> > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > 
> > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > 99e7f65c1779..3d09472978f8 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > 
> > Aww crud.  I was at the airport yesterday and so I didn't notice that
> > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > device tree file, not in the top level rk3399.  As you have written
> 
> > this it will break rk3399 boards that have an rk808 on them, AKA:
> Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
> it can function without it defined, it really shouldn't. We can just
> assign the existing labels in the dts files you pointed out.

Right now this patch puts your clock into the rk3399.dtsi, which is the
wrong place. On most Rockchip systems, the xin32k clock is created
by the pmic (rk808 in a lot of cases) and the clock-tree gets amended
once the pmic has probed. See for example [0].

While I don't know where your xin32k really comes from (cros-ec maybe)
it is definitly a board-specific source for the clock and should thus
live in the rk3399-gru.dtsi.

And we really expect each board to actually make sure its xin32k is
properly defined as for example on the rk808 and act8846 pmics it could
also very well be turned off at boot and also does support multiple rates,
thus needing proper clock handling.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi#n159


