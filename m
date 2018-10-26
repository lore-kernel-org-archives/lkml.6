Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4013C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8456F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhKUJYHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8456F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJ0BHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeJ0BHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:07:32 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18BB520870;
        Fri, 26 Oct 2018 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540571389;
        bh=8x0AOKbXfnBl4is7vZ/h0omAyDdFWkEPt4F+WGzPt0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhKUJYHFfM06vd7D3xi7wyhJpa/NT/Ck6vFv5owUXxEyUeZZw+9JQNe8WVXbPh9lG
         Yfl15JKhDcof69oCdAnB7JV3EP7sK/3hEqw0w2W2AN2hyHiGSypoD/G5uRitLd8ZgG
         0hs/7vzxCrBH9zuPH7fJbpEafdFvTgRZcBBFIkHY=
Received: by mail-qt1-f182.google.com with SMTP id z2-v6so1914009qts.1;
        Fri, 26 Oct 2018 09:29:49 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJjXfUneD8RYT5fkMJKOO910z0de5rKQmPgPsZQvbZk0u9NlIFM
        nyVohOyeQt5MxOF/UV9eccx9q1wkIC458bFZjQ==
X-Google-Smtp-Source: AJdET5cFlWUE625/CSiKz0xw8XHwq5nI7ue8kakmCCixmCf6D4fqorjcL/CumqbCnWqkQFU/fQd2n+yv2C4LF1FXc4I=
X-Received: by 2002:ac8:5414:: with SMTP id b20-v6mr3932000qtq.144.1540571388241;
 Fri, 26 Oct 2018 09:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181016164218.3736-1-l.stach@pengutronix.de> <20181025143504.GA9673@bogus>
 <1540570298.2245.13.camel@pengutronix.de>
In-Reply-To: <1540570298.2245.13.camel@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Oct 2018 11:29:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+f+TyeuStN4NLrq1E_xMS8_QqUW1jfami0+NnUChRKLA@mail.gmail.com>
Message-ID: <CAL_Jsq+f+TyeuStN4NLrq1E_xMS8_QqUW1jfami0+NnUChRKLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: irq: add binding for Freescale IRQSTEER multiplexer
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:11 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Rob,
>
> Am Donnerstag, den 25.10.2018, 09:35 -0500 schrieb Rob Herring:
> > On Tue, Oct 16, 2018 at 06:42:17PM +0200, Lucas Stach wrote:
> > > This adds the DT binding for the Freescale IRQSTEER interrupt
> > > multiplexer found in the i.MX8 familiy SoCs.
> > >
> > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  .../interrupt-controller/fsl,irqsteer.txt     | 39 +++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > > new file mode 100644
> > > index 000000000000..ed2b18165591
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > > @@ -0,0 +1,39 @@
> > > +Freescale IRQSTEER Interrupt multiplexer
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: should be:
> > > > > +       - "fsl,imx8m-irqsteer"
> > > > > +       - "fsl,imx-irqsteer"
> > > +- reg: Physical base address and size of registers.
> > > +- interrupts: Should contain the parent interrupt line used to multiplex the
> > > +  input interrupts.
> > > +- clocks: Should contain one clock for entry in clock-names
> > > +  see Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +- clock-names:
> > > +   - "ipg": main logic clock
> > > +- interrupt-controller: Identifies the node as an interrupt controller.
> > > +- #interrupt-cells: Specifies the number of cells needed to encode an
> > > +  interrupt source. The value must be 2.
> > > +
> > > +Optional properties:
> > > +- fsl,channel: Number of channels managed by this controller. Each channel
> > > +  contains up to 32 interrupt sources. If absent defaults to 1.
> >
> > What's a channel? Why isn't this implied by the compatible?
>
> The documentation calls the mux outputs a channel. Basically the
> irqsteer IP block can mux up to 512 input interrupts onto up to 8
> output interrupt lines (just noticed that the 32 in the description is
> wrong and should be 64).

Then shouldn't you have up to 8 int specifiers in 'interrupts' property?

> So the channel count defines the number of input IRQs in steps of 64
> and the output IRQs in steps of 1. The register layout/offsets don't
> change with different number of channels, as those are always laid out
> as if the controller supported the maximum count of 8 channels. It's
> just the actual implemented number of registers that change.

So do you actually need to know how many channels? We don't typically
put into DT what interrupt lines are actually connected. We assume the
interrupt connections in DT are correct.

Also, if 'interrupts' listed all the muxed output connections, then
you could get the same information from there.

Rob
