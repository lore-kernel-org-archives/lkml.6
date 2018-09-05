Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A9C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504302075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504302075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeIEOGS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:06:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45213 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeIEOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:06:17 -0400
Received: by mail-ua1-f65.google.com with SMTP id q7-v6so5235945uam.12;
        Wed, 05 Sep 2018 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8VfDPle9aCIkbIRANKVtqWfHO4m1OJv5UaR0C7L/dkU=;
        b=Hr0N1D2/8p5p7KONPk0LcENNgqCgHZ5bSZ+R9phU9PwhxxK2Nz1eUI7bAQ96gwHYcd
         1f7yqlv5KrlYyTPHWdXECS3M0v6K6BhIT1PEfXpLbwNCCkPL1x9PiSDm0aL35QWjiyn3
         ii/z5pELeO8GNzDAAgR97I4fBn3Arb0YZ0dwf7kdHwxLKuhnqD1Zzci7CC5c3rG3uK8c
         67gRlIvGcOHGSrNgYdyfx33QAtbm9fpwNdw6nyUK0OrrN98MYCap/ULKiC4LAz56xJTm
         AoFgxdE7ooa1B6JjjSKqPW639DGHvEupBNRFHoR0t8kpbRbkxXA0OMXsAyMxv7RkG31t
         R3tA==
X-Gm-Message-State: APzg51Ag3xcRvem1Srm7gRN2Bbijh7hzotV4UK6iyRjEL/jzId1N/sFE
        NFO6ZoCSGiekFEbyAEEffdb5SuvktBORTPb3UUY=
X-Google-Smtp-Source: ANB0VdYB3jjW5oIKZBfWMiakvbEizc3z1PoTyvs8+Csh/m65De+upI4QamrhpuTWi2zUWLcF+ZgCUA/LBiQn1f80C+A=
X-Received: by 2002:a67:3d5c:: with SMTP id k89-v6mr12476053vsa.34.1536140212074;
 Wed, 05 Sep 2018 02:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540> <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Sep 2018 11:36:40 +0200
Message-ID: <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Mon, Sep 3, 2018 at 1:03 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On 03 September 2018 11:34, jacopo mondi wrote:
> > On Thu, Aug 30, 2018 at 02:12:52PM +0100, Phil Edworthy wrote:
> > > This implements the pinctrl driver for the RZ/N1 family of devices, including
> > > the R9A06G032 (RZ/N1D) device.
> > >
> > > One area that is likely to be contentious is the use of 'virtual pins' for the
> > > MDIO pinmuxing. The driver uses two pins (170 and 171) that don't exist on
> > the
> > > device to configure the MDIO source within the RZ/N1 devices. On these
> > devices,
> > > there are two Ethernet MACs, a 5-Port Switch, numerous industrial
> > Ethernet
> > > peripherals, any of which can be the MDIO source. Configuring the MDIO
> > source
> > > could be done without the virtual pins, e.g. by extending the functions to
> > > cover all MDIO variants (a total of 32 additional functions), but this would
> > > allow users to misconfigure individual MDIO pins, rather than assign all
> > MDIO
> > > pins to a MDIO source. The choice of how to implement this will affect the
> > > DT bindings.
> > >
> > > This series was originally written by Michel Pollet whilst at Renesas, and I
> > > have taken over this work.
> > >
> > > One point from Michel's v1 series:
> > > "Note, I used renesas,rzn1-pinmux node to specify the pinmux constants,
> > > and I also don't use some of the properties documented in
> > > pinctrl-bindings.txt on purpose, as they are too limited for my use
> > > (I need to be able to set, clear, ignore or reset level, pull up/down
> > > and function as the pinmux might be set by another OS/core running
> > > concurently)."
> > >
> >
> > I start by saying that I don't know this HW pin controller well, so
> > I might be missing something, but as commented on the original series from
> > Micheal, I still don't see why you need a custom property here...
> >
> > My understanding, looking at this comment and the header provided by
> > patch [1/3] (include/dt-bindings/pinctrl/rzn1-pinctrl.h) is that
> > basically need to control pull-up/down and the output driver strength.
> >
> > Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt reports
> > a set of generic pin configuration properties to be applied to a pin
> > configuration (and multiplexing) pin controller child node that fully
> > express all (most?) of your needs.
> >
> > Eg. a pin configuration with pull up applied, using examples from your
> > cover letter should be expressed as
> >
> > Your example:
> >          &pinctrl {
> >                  pinsuart0: pinsuart0 {
> >                          renesas,rzn1-pinmux-ids = <
> >                                  RZN1_MUX(103, UART0_I)  /* UART0_TXD */
> >                                  RZN1_MUX_PUP(104, UART0_I)      /* UART0_RXD */
> >                          >;
> >                  };
> >          };
> >
> > Using standard pinctroller bindings pin configuration properties:
> >
> >          &pinctrl {
> >                  pinsuart0: uart0  {
> >                         pinsuart_tx0 {
> >                                 pinmux = <103, UART0_I>;  /* UART0_TXD */
> >                         };
> >
> >                         pinsuart_rx0 {
> >                                  pinmux = <104, UART0_I>; /* UART0_RXD */
> >                                  bias-pull-up;
> >                         };
> >                  };
> >          };
> >
> > Is there anything I am missing? Maybe from the interaction with
> > "another OS/core running concurrently" you mentioned? In this case if
> > you only have to perform pin configuration (because muxing is handled
> > already) things are even simpler, just use the pin configuration
> > bindings, without involving muxing at all:
> >
> >         &pinctrl {
> >                 pinsuart_conf: uart0 {
> >                         pins = <103, 104>;
> >                         bias-pull-up;
> >                  };
> >          };
>
> Sorry I didn’t address your point.
> The only reason we want to use new properties is so the driver can process
> dts files that have been generated from an existing PinMux App. That output
> is used by VxWorks as well as our out-of-tree Linux port. If that is not a
> good enough reason to add new properties, then I can't see any technical
> reason not to use the existing bindings.
> The use with another OS running on a different core should not be a barrier
> as it must not use the same pins as Linux.

Have the VxWorks DT bindings been submitted for review to the devicetree
mailing list?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
