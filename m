Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2959AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCE320825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l+5QGUR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCE320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeKJRQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:16:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35730 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbeKJRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:16:16 -0500
Received: by mail-io1-f67.google.com with SMTP id 79-v6so2927010iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 23:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjPWVgfXA2VNnFZcsEwQFthBj/hbHn8dIrVvMnZhsGo=;
        b=l+5QGUR4NyOW8xKcGgZtrjGC8EcErxUcnCN5N0ksCHg7ad4/jrtRXThKa3LCd42l3n
         1TB18YAw9fs8+R20zVDPWH9HyMyvyY8RH6x1zRHn/5bMMzQCe0WE0r3aBgqAB9hXrdkQ
         JVKzbdQz0+F+Hw2JH78NyDick9b4Wf8CnII8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjPWVgfXA2VNnFZcsEwQFthBj/hbHn8dIrVvMnZhsGo=;
        b=BJ6iimTu8mBqr7vj739VbLvoGuIHbGcxTG/ztn2jhHO420Ks6n5gsC8bLgNiy7+e5i
         EBK6asQL7gHdYGJal9DXZibZ2jtPoKPbaL5r3GEsaRUjIW8k9cxQqISeZ4eoXQVezs1h
         XxAmWK0mrUui+Z65co4NW2JYMizGYETDjvhSDpt95Hjv7hgOhqdnTK8z07f2zjHKt6JS
         UVtLQBZAiABzSTyPBb2yTbPgjA8PRbjv3KqhZeqyZ/3Mvx+RaFx+bDCZyCQcSVBQNA8p
         qbwydznC5Njl5dptjanS4jDdu0GTQ3HdfG9BZZQCxqqlcrS2zuUF4JdjaVvjVsKy0fMy
         N6og==
X-Gm-Message-State: AGRZ1gLPycqFHposUFG/pLCizC9a+oQY12WH8SUc8QkAEMPmbpoYQycJ
        V1nSQVyOQRR1bn6L/CMG/IS4NBQGG2MO+A/vrwmVQQ==
X-Google-Smtp-Source: AJdET5cJfT7wCaJqmw/LCOaKUuBMeHrAu2ZRU5RJ/T33PjDV3E7adLSJ6nsV8s195snTbNg4VJAA9xbNMPh26kcueTU=
X-Received: by 2002:a6b:918b:: with SMTP id t133-v6mr9648726iod.267.1541835133443;
 Fri, 09 Nov 2018 23:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com> <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
 <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com> <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
 <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
In-Reply-To: <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 10 Nov 2018 13:02:01 +0530
Message-ID: <CAMty3ZDTAiW=Lx2H4WvdsdJRYsVe1CpCJx7D0f7yANx7Lx25PA@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     a.hajda@samsung.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
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
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 2:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 06.11.2018 19:08, Jagan Teki wrote:
> > On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
> >>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>>> On 26.10.2018 16:43, Jagan Teki wrote:
> >>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> >>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
> >>>>>
> >>>>> So, this patch adds DSI specific binding details on existing
> >>>>> dt-bindings file.
> >>>>>
> >>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >>>>> ---
> >>>>> Changes for v3:
> >>>>> - Use existing binding doc and update dsi details
> >>>>> Changes for v2:
> >>>>> - none
> >>>>>
> >>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> >>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>> index 35bc0c839f49..b7855dc7c66f 100644
> >>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> >>>>> @@ -1,12 +1,39 @@
> >>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> >>>>>
> >>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> >>>>> +
> >>>>> +Depending on the variant, the PCB attached to the panel module either
> >>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> >>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> >>>>> +itself
> >>>> As I understand this is display board, which contains 'pure' RGB panel
> >>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> >>>> These are separate devices, just connected by vendor to simplify its
> >>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
> >>>> panel driver for S070WV20-CT16 - it looks more generic.
> >>>> Then you can describe both in dts and voila.
> >>>> Creating drivers for every combo of devices (panel + bridge), just
> >>>> because some vendor sells them together seems incorrect - we have
> >>>> devicetree for it.
> >>> Rob suggested this, and also the opposite: using the same
> >>> "bananapi,s070wv20-ct16"
> >>> compatible string for both types of connections, and have the driver deal with
> >>> detecting the bus type.
> >>>
> >>> The thing about the bridge chip is that there's no available datasheet that
> >>> describes all the parts of the init sequence, in fact none at all. I managed
> >>> to work out some bits, but the others remain a mystery and must be hard-coded
> >>> to match the panel. That would work against having a generic bridge driver.
> >>
> >> But it is common for many chips - 1st version of the driver is developed
> >> on one platform and it supports only one configuration, if next platform
> >> with the same cheap appears the driver is augmented if necessary.
> > At-least few of the commands from panel initialization code, the
> > respective opcode data values are based on panel timings and even
> > clock value is different in DSI. I think it look hard to try bridge
> > driver for these restrictions, do you have any suggestions?
>
>
> Where do you see an issue? Since panel is RGB it should have no
> initialization sequence (beside regulator/gpio power on/off), so the
> only thing to do is to figure out which regulators/gpios belongs to
> which component - with publicly available specs it should be doable.
>
> The whole initialization sequence is for the bridge, so you put it into
> bridge driver, for starters it can be hardcoded.

Yes, I understand we can move regulators/gpio setup separately and
though we hardcode the init sequence there is difference  in clock for
DSI(which I mentioned in previous mail). DSI panel can't work with
clock used by RGB panel-simple.

>
> Then you can:
>
> 1. Try to find other users of this ICN6211 chip and compare
> initialization sequences to guess purpose of registers.
>
> 2. Try to get specs of the chip (ask vendor, distributor, grep Internet).

As we mentioned (even Chen-Yu), we are unable to find the proper spec
for this panel, all we taken reference from AW BSP code.

>
> 3. Do nothing - if there will be other users of the bridge they will do
> this work.

Don't know how we can go with generic bridge driver irrespective of
these particular wrinkles, let me know if you have any suggestions.
