Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86552C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CEC223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jq/Uxu3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CEC223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeKNVVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:21:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51750 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKNVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:21:42 -0500
Received: by mail-it1-f196.google.com with SMTP id f84-v6so2010990ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 03:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKgs0JqXb8sv6bIrcsuIIocfK3TGT0xahSp84ZAnsNs=;
        b=jq/Uxu3PGYcEby2vwoBQuY3UV8Rppl4BwPdBUQNjDHKo/cg2IDEvHQd0h43PEZJZdr
         dsA71KOZScY5I+0ZLYEffMMzeQioQzsIJHA/cogf9bEWgdEMc/cgXZwQ+toOpNH+nlSX
         5Te8iC8mtBOxuyXoDgk82sadq1ns5bf+3ZyFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKgs0JqXb8sv6bIrcsuIIocfK3TGT0xahSp84ZAnsNs=;
        b=YTPV5jWzfhevWizhWDM/6QhPNft+rjumsKltBaPwtvmvrIXoPk4dnFsChKkxJ2m2aW
         zsp8zjZBcKz3j6fhULctCEhoBI7Xs5poF2h5Rq9vQwWEtvHWtX146AKvropsRa5eclCu
         v5uXEsAwwNiu8ERp25ai+OOStjPPtDO2+kaddt6b47xQBdmQSf/UJote/3kFye/F3x4X
         xjHtlJf7rBc43EKEZIqW5TjsiWPi6PWAaB6xHhz06D2+mQWRFu5bbE5EQdUmau3El3bs
         jeca+MIvrzXtFYG2JKXVITgYFeys4z+1oKJNlXgKUWCT65eABuhJE+ClNFaqPsuS/Dw5
         7FHw==
X-Gm-Message-State: AGRZ1gLTqAMcOwMm0QsWzCIvb/3JnhqtPysDtcjlS/v2r5Sh6P4KcxuU
        ErrQnXFGbc8/XLutBq5WKoBpclyLgraml85cB7lRJA==
X-Google-Smtp-Source: AJdET5fh0njZr6k1CGFidzy2nTou641I70nXqoFmpbDd5YUZgkkQI5mvqWFXe8XZeEknnEf0wYlHQ0H1q6/A/e5585k=
X-Received: by 2002:a05:660c:ac1:: with SMTP id k1mr1583937itl.173.1542194331584;
 Wed, 14 Nov 2018 03:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-26-jagan@amarulasolutions.com> <20181113122204.337db8b1@donnerap.cambridge.arm.com>
 <CAMty3ZBQXcnU=490KREa=F-qctMtRep9-rrhrPd1UZStnV=hqw@mail.gmail.com>
 <CAGb2v669dkf2qaUDaosJEKSRKpPRVKWszb6BLL2NrAjWwp3t2Q@mail.gmail.com> <CAGb2v64YOV48UwHc8-=jDt2Bp_4mNb3iuyEzj0d+GOQE_oT-Xg@mail.gmail.com>
In-Reply-To: <CAGb2v64YOV48UwHc8-=jDt2Bp_4mNb3iuyEzj0d+GOQE_oT-Xg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 14 Nov 2018 16:48:39 +0530
Message-ID: <CAMty3ZAa97_zHTyxfbV+8d7fUMaEuvB_Kg-SYLY42kMEoiJLyA@mail.gmail.com>
Subject: Re: [PATCH v4 25/26] [DO NOT MERGE] arm64: dts: allwinner:
 bananapi-m64: Bananapi S070WV20-CT16 DSI panel
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 2:52 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Nov 14, 2018 at 2:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Wed, Nov 14, 2018 at 2:31 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Tue, Nov 13, 2018 at 5:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
> > > >
> > > > On Tue, 13 Nov 2018 16:46:32 +0530
> > > > Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > > > > BPI-M64 board.
> > > > >
> > > > > DSI panel connected via board DSI port with,
> > > > > - DC1SW as AVDD supply
> > > >
> > > > Are you sure of that? I don't see anything in the schematic to support
> > > > this. The only power lines that go to the DSI connector are DCDC1 and
> > > > PS. DC1SW is only connected to PortD on the SoC and to the Ethernet PHY.
> > > > Is there anything I miss?
> > >
> > > Thanks for the comment, yes dc1sw is connected in ephy. I have reused
> > > dc1, BSP is attached lcd_power1 to axp81x_dc1sw [1]. I just looking
> > > for someone to comment, may be we can skip this regulator attachment.
> >
> > That seems sketchy. The schematics show the connector has feeds from both
> > the unregulated output IPSOUT (PS) and DCDC1. For designs with RGB LCD
> > panels, we only see the PS feed. Since the LCD panel can be used in either
> > RGB or MIPI DSI mode, I highly suspect the DCDC1 supply feeds the bridge
> > IC.
> >
> > As for DC1SW, this is likely referenced because it provides power to the
> > GPIO lines that are used to control the LCD panel. If you don't provide
> > power, you can't pull them up.
> >
> > While many of us dislike FEX and the new FEX-derived device tree, they
> > do provide some information, such as regulator usage. Note that each
> > regulator output has multiple names, which likely denote specific
> > usages.
> >
> > I've asked BPI for schematics on the bridge board. Hopefully we'll
> > have something in more detail. In the meantime, I suggest leaving
> > this panel out of your next submission, and focus on getting the bulk
> > of the dsi driver and dts changes in first.
>
> I got the schematics, but unfortunately I can't share them publicly.
>
> It looks like VCC-MIPI on the connector is not connected to anything.
> All power is provided from IPSOUT, first through a current limiter IC
> turned on and off by LCD_PWR_EN, and then through some voltage regulators
> to provide the voltages for various parts of the panel, including LCD,
> capacitive touch, and the MIPI-DSI bridge. There's even an onboard EEPROM,
> though I'm not sure what that's for.

So there is no concern supply regulators on panel side, only VCC-DSI.

>
> > >
> > > >
> > > > > - DCDC1 as DVDD supply
> > > >
> > > > That seems right, but doesn't match with what you write below.
> > >
> > > Commit need to fix s/DCDC1/DLDO1
> > >
> > > >
> > > > > - PD6 gpio for reset pin
>
> This toggles reset for both the panel itself and for the MIPI-DSI bridge.
>
> > > > > - PD5 gpio for backlight enable pin
>
> This enables the backlight's regulator.
>
> > > > > - PD7 gpio for backlight vdd supply
>
> This enables power to the whole panel module.
>
> Then you also have the two GPIOs for the capacitive touch controller.
> And also the I2C bus for the controller, and the EEPROM.

Thanks, for the details. I have verified w/ vcc-dsi-supply attached to
dldo1 and the panel with reset w/o any supply regulators.
