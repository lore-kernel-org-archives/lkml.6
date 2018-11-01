Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08B0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A373120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I0vgKRZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A373120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKASEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:04:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54002 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:04:53 -0400
Received: by mail-it1-f194.google.com with SMTP id y73-v6so1126537itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNKDkr0hHYXro3jJilUf//rFJsuGlSepowZXP6ERJx4=;
        b=I0vgKRZWFvEqzL3kOm5t3DjXb2PwC5Cs/AYJAtgajgK5bckWyF/u/n/BgKFv/8LH4T
         gn4YXAKnmkjjDA//d9rwpk+NrdIqd7n+5I+q2inn7R7/bHhL80mmBxdzymHZ1d3TSwV1
         MKl/4ufRDH4eSPp1gWD2dyUtV47O5FmQ/mSC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNKDkr0hHYXro3jJilUf//rFJsuGlSepowZXP6ERJx4=;
        b=VE90jj72FF7ZoYaIVthyemCs7cVyuB7e1ZC8hOMPv5XcDo8yXgBk0kxqASbTFOr/AV
         YzyOiZokpW3oXNe/0tR1aSE98AbvNFYvdUxfhtFYVkuuKgZ1GHQq0CSKdI8o3WUZtM7C
         lwQK4DRxRvgyU34hVLGCPZWuL7JFqzgbM6CeSCSlQRxLeDgzWCAAMIhFbp/wY50iUBpX
         2n4Mk9mXAT46RfC2Xq5kSi+A5bER/L2PxGagxZdt8wK5Gx+JRDw6Wl5DVn0aEEb35Hci
         XeP0MaOGOSivyAuVf/Zh1S2EZ2BngW6/50275oU4nhhoOoDdXlXubUoFNo3ugXZCGarU
         DT4A==
X-Gm-Message-State: AGRZ1gLBNDwCgCYDtAv6SfE6szJP2GWdn28RqhtpnONNlq5MXtGcemfh
        TDXM/FzmdpmtzXky7LcZMTMRb1F3A6lfsNiANI+QyA==
X-Google-Smtp-Source: AJdET5dQWuJoSqH2pUw5ImvKKiKt6BeibXXfOZLmC5LrWc7JlS0NtZb4m1vTep766SvVWwOxH47CuKb9WQSNzdwJqsk=
X-Received: by 2002:a02:e43:: with SMTP id 64-v6mr5464819jae.58.1541062966111;
 Thu, 01 Nov 2018 02:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com> <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
 <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com> <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com>
In-Reply-To: <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 14:32:34 +0530
Message-ID: <CAMty3ZBJiDrr0hqgzMMQ76R7=+agsHyjYQGTrebH=_q5Ax2xXA@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 1, 2018 at 3:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > From: Jagan Teki <jagan@openedev.com>
> > > >
> > > > RTC controller is similar to A31, so use the same compatible
> > > > for H6 and update interrupt numbers as per manual.
> > >
> > > No. Unfortunately they are not that compatible. The A31 does not have
> > > the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> > > of the internal RC oscillator varies between SoCs. I'm working on a
> > > series of patches to correct this. Stay tuned.
> >
> > 4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
> > see external clock working with WIFI for A31 compatible.
>
> That bit turns on the external crystal, i.e. X32KIN and X32KOUT pins.

This is what I confused, the same signal pins available there in A64
schematics but no bit to enable external OSC in LOSC_CTRL_REG.

But the X32KFOUT pin which is 0x60 , BIT(0) is enabled in A64, H6 w/o
this LOSC_CTRL_REG which I don't know exactly or may be feed it by
default not sure.

>
> I'm talking about the X32KFOUT pin, which feeds the WiFi module the
> LPO clock in typical Allwinner designs. That is controlled by register
> 0x60, and is not present on the A31. That is the clock you say is
> working. You have the two confused.
>
> The clock tree looks like this:
>
> IOSC -----------------------------\
>                                    SUN6I_LOSC_CTRL_EXT_OSC mux ---->
> LOSC --> (to CCU)
> 32k crystal --> EXT_LOSC_EN gate -/                              \
>                                                                   \
>                                                                   /
>       (to WiFi) <-- X32KFOUT pin <-- LOSC_OUT_GATING_EN gate <---/

Yes, I understand this. But for A33, A64 there is no EXT_LOSC_EN which
is directly feed to WIFI from LOSC as per manual but from schematic
signals X32KI and X32KO were present.

>
> The bottom part does not exist in the A31. Meanwhile we've been claiming that
> all later RTC modules that actually have that part are compatible with the A31.
> Also the IOSC part has different clock rates for different chips.
>
> Do you see the problem?

From external crystal point of view, between A33, A64 vs H6 I only see
the difference in EXT_LOSC_EN external oscillator enable bit only
available in H6 manual.

Regarding, rtc-sun6i. we can manage the external clock stuff via
"clock-output-names" with rtc->ext_losc and mentioning external
oscillator outputs on DTSI. since A31, don't have external clock to
wifi then we can skip those properties.

What do you think?
