Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29204C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41C6208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41C6208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935425AbeFMLsi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:48:38 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44091 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935106AbeFMLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:48:35 -0400
Received: by mail-vk0-f67.google.com with SMTP id x4-v6so1305840vkx.11;
        Wed, 13 Jun 2018 04:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmOEcF63umfCjk/Nyg5MdNPo458HLsHL1b1xB9cjWsA=;
        b=TJdgRZTWSOoUCqmLgTJ4l8xHYjgHDZtaPPyMMG4QNfwX7X1r7hc3lq0c6vtEBZ1ex+
         7qGkFUHK8zx9qRkDraY+AGAdj4xhXdRHaAHW3x3WT5sUdpkOXIEbs3iL3uVTBIGJAR2g
         cij6f7cgr08s5RaOOyG8pDYFjBe9yRtTR6g4qi8/IItvLrGvTULEx1VSP5Cialw8f/Yy
         Yh5oRrC7k+nYjAWaO9YFB+XwMEs1tUYn3UR5kRRSHmE4u/uSvfsR48xrHuMFr1CMsbsb
         0YTq/kneINpbjTDWkW4NHLIvunFVZ4Ela33BKZiKY3aaYPbc8GVEI4vdMMlvP+eDaPGV
         FYQg==
X-Gm-Message-State: APt69E2mnbOkR/0I3tzucpSkPozF+mhSnvODe7Hrp2rn/q0WnwwpEvwc
        /WqWQ1Md6nG/Zsf4sustMCLYsiWB/c14nmJxLyM=
X-Google-Smtp-Source: ADUXVKK0iPpJfHy7O7ioOR1H4SYcmmp7GcX1HA5wuBSDuxciGiXruA/DIAPEG91VzHKMJQc6W10OCt6R3gQp0poSz1Y=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr2727059vkd.3.1528890514647;
 Wed, 13 Jun 2018 04:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com>
 <OSBPR01MB2054D7F35A31A8331B906E05D27E0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAMuHMdUtdRB_L-WsphJYBd9m-3tth3KHGK1wWdr_UJF18S9Z5A@mail.gmail.com> <CAMMfpEwhpoBvO+JGPFYeNznns9W=+6iZoUec5Ffk-ppUH_9BFg@mail.gmail.com>
In-Reply-To: <CAMMfpEwhpoBvO+JGPFYeNznns9W=+6iZoUec5Ffk-ppUH_9BFg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Jun 2018 13:48:23 +0200
Message-ID: <CAMuHMdXfpafLbtZ_btcPmLO7j5B2Ue3OhFdfKdEYX=pFdGY0Sg@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To:     M P <buserror@gmail.com>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Wed, Jun 13, 2018 at 10:53 AM M P <buserror@gmail.com> wrote:
> On Wed, 13 Jun 2018 at 08:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Jun 13, 2018 at 8:38 AM Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:
> > > On 11 June 2018 11:01, Geert wrote:
> > > > On Tue, Jun 5, 2018 at 10:36 AM Michel Pollet
> > > > <michel.pollet@bp.renesas.com> wrote:
> > > > > The Renesas R9A06G032 SYSCTRL node description.
> > > > >
> > > > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-
> > > > sysctr
> > > > > +++ l.txt
> > > > > @@ -0,0 +1,32 @@
> > > > > +* Renesas R9A06G032 SYSCTRL
> > > > > +
> > > > > +Required Properties:
> > > > > +
> > > > > +  - compatible: Must be:
> > > > > +    - "renesas,r9a06g032-sysctrl"
> > > > > +  - reg: Base address and length of the SYSCTRL IO block.
> > > > > +  - #clock-cells: Must be 1
> > > >
> > > > (repeating myself) No clocks/clock-names for the external clock inputs?
> > > >
> > > > "RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
> > > > reference clock outputs for RMII/MII."
> > >
> > > Well, I'm trying to keep the binding as simple as possible, to dodge any
> > > further discussion. Adding these will be possible later, I don't need them
> > > for the moment anyway.
> >
> > Don't you? The external clock inputs are at the root of the clock tree, so I'd
> > say you need them. Bolting them on later may become complicated, especially
> > if you care about DTB backwards compatibility.
>
> Well the input is fixed frequency -- and there is a clock (gate)
> created for it in the driver
> (CLK_RGMII_REF) so you can turn it on/off if you like...
>
> The only configurable bit is a *nightmare* as the selection bit for
> whether it is coming
> from CLKOUT_D8 or from an external input is in a *completely different
> IP block*. I'd
> need another iomap() and all that stuff, and a custom driver for it.
>
> If I were to implement it, I'd have to add a custom driver for that
> clock, use the current
> gate as a parent, iomap the selection bit register etc -- basically.
> All of that for a use
> case of *none ever* as most people would probably tweak that bit in
> the bootloader
> anyway -- also, I'd have zero capability for testing it.
>
> As far as the output, they also have their own gates (already
> created). They are also fixed
> frequency and the only thing that matters to them is the pinmux
> settings. So (soon) with the
> pinmux driver, you can enable that clock properly without a special
> driver, just by adding
> that gate to your ethernet, and add the pinmux config for it.
>
> So what do I go with that?

IC.

Still, DT describes the hardware, not (the limitations of) the software
implementation.  So you can have the external clock inputs in the DT
bindings and in the DTS, but ignore complicated routing and source
selection in the driver.

> > > Did you have a chance to review the clock driver proper? I'm pondering
> > > sending a v9 since it's been a week (with very minor changes) -- but I
> > > don't want to interrupt if you were in the process of reviewing...
> >
> > I had a quick glance. Looks OK mostly, so it's definitely heading for the right
> > direction!
> > One remaining question: do you need CLK_OF_DECLARE()?
> > Is there any reason your clock driver cannot be a platform driver, which is
> > the recommended way?
>
> I copied it straight out of clk-rcar-gen2.c -- I don't 'need' anything more than
> instantiating my driver; does it make a difference? ie a one liner macro vs
> adding an extra struct, 2 functions to do the same thing?

clk-rcar-gen2.c is an old (early DT CCF) driver.
Please check out renesas-cpg-mssr.c for something newer.
Having a platform_driver means you're also having a struct device,
and can do power management, if needed.

> Just curious, sometime I lose track of that the goalpost is -- for
> years I understood
> that having OF was simpler and better all around?

"having OF" does not mean CLK_OF_DECLARE().
Those *_OF_DECLARE() macros impose a very strict initialization
order, which is not always suitable. Hence the trend to move to plain
platform drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
