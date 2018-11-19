Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D22C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D46920823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eylkn7qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeKTIQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730748AbeKTIQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:16:31 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4E92089F;
        Mon, 19 Nov 2018 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542664251;
        bh=6bygkLwsb0YUNSJWyyRLhCDP3vqr+MJ5xKx61huKdiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eylkn7qER5mkalzUtTQrfBc5ZLixORqZPFokPTRhEyOFjTeoYMu5ywJhlU6BmFieK
         Ux6eg2YrLjRAbDuv5KPQEhzzTlxhLComhVKu7qVbhIGCIwlK6nN9sYDMKySFizoYif
         EXfWLmfcOq7PiUmGBRavXJb6DtSZQrSOzn4QGBw0=
Received: by mail-qk1-f182.google.com with SMTP id d135so51269431qkc.12;
        Mon, 19 Nov 2018 13:50:51 -0800 (PST)
X-Gm-Message-State: AGRZ1gJNaaG5Gk4XK7u7hJQOp5VNn116IR8mH0ugM0O/1yY5XZPOXskf
        aLITXyMKnvynaXVFNjLXif2xCTwXoIpJP3+98A==
X-Google-Smtp-Source: AJdET5fj5z04kKvA50PRP8BAwRN1w3ToyJIlxXg8kPsUrLixdodQyBysPUN2AjJogarl1fwJjPZ0RePm3AsAZelOz2Q=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr23142151qtf.26.1542664250368;
 Mon, 19 Nov 2018 13:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
 <20181113130910.22130-2-phil.edworthy@renesas.com> <20181117143253.GA27381@bogus>
 <TY1PR01MB176917D755CB102AB5FD6BEAF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB176917D755CB102AB5FD6BEAF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Nov 2018 15:50:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJca7mXS_9msTbCovnXpFxC0VY81COk98x-c1Ug5a=jQQ@mail.gmail.com>
Message-ID: <CAL_JsqJca7mXS_9msTbCovnXpFxC0VY81COk98x-c1Ug5a=jQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 3:39 AM Phil Edworthy <phil.edworthy@renesas.com> wrote:
>
> Hi Rob,
>
> On 17 November 2018 14:33 Rob Herring wrote:
> > On Tue, Nov 13, 2018 at 01:09:09PM +0000, Phil Edworthy wrote:
> > > Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
> > > multiplexer.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > ---
> > > v3:
> > >  - Use 'interrupt-map' DT property correctly.
> > > v2:
> > >  - Use interrupt-map to allow the GPIO controller info to be specified
> > >    as part of the irq.
> > >  - Don't show status in binding examples.
> > >  - Don't show the soc/board split in binding doc.
> > > ---
> > >  .../interrupt-controller/renesas,rzn1-mux.txt | 73
> > > +++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mu
> > > x.txt
> >
> > A few nits, otherwise:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> Thanks for the review!
>
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > > mux.txt
> > > b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > > mux.txt
> > > new file mode 100644
> > > index 000000000000..6515880e25cc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r
> > > +++ zn1-mux.txt
> > > @@ -0,0 +1,73 @@
> > > +* Renesas RZ/N1 GPIO Interrupt Multiplexer
> > > +
> > > +On Renesas RZ/N1 devices, there are several GPIO Controllers each
> > > +with a number of interrupt outputs. All of the interrupts from the
> > > +GPIO Controllers are passed to the GPIO Interrupt Multiplexer, which
> > > +selects a sub-set of the interrupts to pass onto the system interrupt
> > controller.
> > > +
> > > +A single node in the device tree is used to describe the GPIO IRQ Muxer.
> > > +
> > > +Required properties:
> > > +- compatible: SoC-specific compatible string "renesas,<soc-specific>-
> > gpioirqmux"
> > > +  followed by "renesas,rzn1-gpioirqmux" as fallback. The SoC-specific
> > > +compatible
> > > +  strings must be one of:
> > > +   "renesas,r9a06g032-gpioirqmux" for RZ/N1D
> > > +   "renesas,r9a06g033-gpioirqmux" for RZ/N1S
> > > +- reg: Base address and size of GPIO IRQ Muxer registers.
> > > +- interrupts: List of output interrupts.
> > > +- #interrupt-cells: Numder of cells in the input interrupt specifier, must be
> > 1.
> > > +- #address-cells: Must be 0.
> > > +- interrupt-map-mask: must be 127.
> > > +- interrupt-map: Standard property detailing the maps between input
> > > +irqs and the
> > > +  corresponding output irq. This consist of a list of:
> > > +   <input-irq-spec phandle-to-interrupt-controller output-irq-spec>
> > > +  The input-irq-spec is from 0 to 95, corresponding to the outputs of
> > > +the GPIO
> > > +  Controllers.
> > > +
> > > +Example:
> > > +
> > > +   The following is an example for the RZ/N1D SoC.
> > > +
> > > +   gpioirqmux: gpioirqmux@51000480 {
> >
> > interrupt-controller@...
> Sure
>
> > > +           compatible = "renesas,r9a06g032-gpioirqmux",
> > > +                           "renesas,rzn1-gpioirqmux";
> > > +           reg = <0x51000480 0x20>;
> > > +           interrupts =
> > > +                   <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > > +                   <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> >
> > This is a bit redundant as the same information is in interrupt-map, but I
> > guess you need it to get the irq resources.
> That's right.
>
> > > +
> > > +           #interrupt-cells = <1>;
> > > +           #address-cells = <0>;
> > > +           interrupt-map-mask = <127>;
> >
> > Use hex for masks.
> Ok.
>
> > > +           interrupt-map =
> > > +                   /* gpio2a 24, pin 146: ETH Port 1 IRQ */
> > > +                   <88 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > > +                   /* gpio2a 26, pin 148: TouchSCRN_IRQ */
> > > +                   <90 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> > > +   };
> > > +
> > > +   gpio2: gpio@5000d000 {
> > > +           compatible = "snps,dw-apb-gpio";
> > > +           reg = <0x5000d000 0x80>;
> > > +           #address-cells = <1>;
> > > +           #size-cells = <0>;
> > > +           clock-names = "bus";
> > > +           clocks = <&sysctrl R9A06G032_HCLK_GPIO2>;
> > > +
> > > +           gpio2a: gpio-controller@0 {
> >
> > gpio@0
> Are you sure about this?

Yes, 'gpio' is what the DT spec says. It is the oddball though and I
always have to think about it.

> The bindings in Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> show an example where the sub-nodes for gpio banks are gpio-controller@.
> This is also in Documentation/devicetree/bindings/gpio/gpio.txt.

Indeed. Those should be fixed. I would be easily persuaded to just
change the spec, but 'gpio@' is much more widely used:

$ git grep gpio@ -- arch/ | wc
   1110    4378   67766
$ git grep gpio-controller@ -- arch/ | wc
     60     232    4270

Rob
