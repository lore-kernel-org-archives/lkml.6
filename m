Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF292C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAA52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeJaH7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:59:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41409 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeJaH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:59:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id c32so12807601otb.8;
        Tue, 30 Oct 2018 16:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCxb3gJMZuEekxxxYEZGwHEfo9PDi9VJAB2r29n9eXE=;
        b=rVU2IGWcg0Ps1f6GkfI63Fl7jF9Q37Adx5Hf5/MfG2IFKApnqfzjGE9AeU8hnfDOE0
         XoR+RdKg+76x4fapQWS4o7gIuXfWJvPXFmdBcLGnVe3+YnWf0DUmmJtUFc8ji3FfMvbM
         UOthwinu8r9WDq+h70Sgsts2K3Gpcrglh3b6yJcWK2yV8+tZV2RYCcD/z8p1nXXFWj0a
         1cdOuhOnLc8L0iaOwUyYzPRXUk9houfyH4ZeiP/SbBKuWwR6HRwzgWGj9EXpE757uBa6
         YgCoYRXrpjM6a/B2ZLlt2+RVOnf6H5AdlmZUnX/iTqEcaRb6UdgsSxdsok65+bG8XV1D
         aOSg==
X-Gm-Message-State: AGRZ1gLfGYuvrTGcZ1EzAxFS88hrkQ1X7mdG4TkALY4VfQGBJSyHnA5e
        8w6gUcQXXNdbOZsGh+0She7GgOw=
X-Google-Smtp-Source: AJdET5d94Isd5ZLAvB10RXSJvdHovqV73kp9UHMzCkuFSpQKa25E0WjqWd4s67stKsO2plAYmwSqsQ==
X-Received: by 2002:a9d:682:: with SMTP id 2mr445989otx.356.1540940661686;
        Tue, 30 Oct 2018 16:04:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p130-v6sm7108722oig.1.2018.10.30.16.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:04:21 -0700 (PDT)
Date:   Tue, 30 Oct 2018 18:04:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Message-ID: <20181030230420.GA25133@bogus>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
 <20181030104438.27827-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030104438.27827-2-phil.edworthy@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:44:37AM +0000, Phil Edworthy wrote:
> Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
> multiplexer.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Use interrupt-map to allow the GPIO controller info to be specified
>    as part of the irq.
>  - Don't show status in binding examples.
>  - Don't show the soc/board split in binding doc.
> ---
>  .../interrupt-controller/renesas,rzn1-mux.txt | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
> new file mode 100644
> index 000000000000..0b4ba27c00ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
> @@ -0,0 +1,92 @@
> +* Renesas RZ/N1 GPIO Interrupt Multiplexer
> +
> +On Renesas RZ/N1 devices, there are several GPIO Controllers each with a number
> +of interrupt outputs. All of the interrupts from the GPIO Controllers are passed
> +to the GPIO Interrupt Multiplexer, which selects a sub-set of the interrupts to

s/sub-set/subset/

> +pass onto the system interrupt controller.
> +
> +A single node in the device tree is used to describe the GPIO IRQ Muxer.
> +
> +Required properties:
> +- compatible: SoC-specific compatible string "renesas,<soc-specific>-gpioirqmux"
> +  followed by "renesas,rzn1-gpioirqmux" as fallback. The SoC-specific compatible
> +  strings must be one of:
> +	"renesas,r9a06g032-gpioirqmux" for RZ/N1D
> +	"renesas,r9a06g033-gpioirqmux" for RZ/N1S
> +- interrupt-controller: Identifies the node as an interrupt controller.
> +- #interrupt-cells: should be <1>. The meaning of the cells is the input
> +   interrupt index, 0 to 95.
> +- reg: Base address and size of GPIO IRQ Muxer registers.
> +- interrupts: This is a list of interrupt specifiers. Each interrupt consists of
> +   three numbers that represent:
> +     - (a) the index of the GPIO Interrupt Multiplexer output interrupt (0..7)
> +     - (b) the index of the GPIO Controller input interrupt (0..2)
> +     - (c) the interrupt index of the GPIO Controller input interrupt (0..31).
> +- interrupt-parent: A phandle for a local node that specifies an interrupt-map.
> +   The interrupt-map node must specify #interrupt-cells = <3>, and an
> +   interrupt-map property. The interrupt-map is used to translate the interrupt
> +   specifier to the output interrupts. It is used in conjunction with an
> +   interrupt-map-mask property to mask (b) and (c) from the interrupt specifier
> +   so that essentially there is a direct map from (a) to the output interrupt.
> +   Therefore (b) and (c) can be used to determine the interrupt source and
> +   configure the hardware accordingly. For information on interrupts,
> +   see Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +	The following is an example for the RZ/N1D SoC.

This looks a bit strange...

> +
> +	gpioirqmux: gpioirqmux@51000480 {
> +		compatible = "renesas,r9a06g032-gpioirqmux",
> +				"renesas,rzn1-gpioirqmux";
> +		reg = <0x51000480 0x20>;
> +

> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupt-parent = <&gpioirqmux_map>;
> +		interrupts =
> +			<0 1 17>,	/* gpio1a 17 */
> +			<1 1 24>,	/* gpio1a 24 */
> +			<2 1 26>;	/* gpio1a 26 */

Remove all these and...

> +
> +		gpioirqmux_map: gpioirqmux-map {

Move everything in this node up a level.

> +			#interrupt-cells = <3>;

This should be 1.

Or perhaps 2 cells if you need the GPIO controller index (cell 2 above). 
But is that numbering really meaningful to the GPIO irq mux or does it 
just have Nx32 inputs? #interrupt-cells should be defined based on the 
GPIO irq mux, not what it is connected to. You could always have a 
single linear number space and mask out bits to get banks if you need 
to.

> +			#address-cells = <0>;
> +			interrupt-map-mask = <7 0 0>;

Then 1 cell here, but the mask should be 31.

> +			interrupt-map =
> +				<0 0 0 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,

Then this should be:

<17 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>

> +				<1 0 0 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,

<24 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>

If I understand what you are trying to do. :)

If the 0-7 numbering and mapping to the downstream numbering was 
important (i.e. the 1 combined with 1 and 24 in the interrupts 
property), then you can use the index of the interrupt-map entries for 
that.

> +				<2 0 0 &gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				<3 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				<4 0 0 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				<5 0 0 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				<6 0 0 &gic GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				<7 0 0 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;

These all seem to be unused?

> +		};
> +	};
> +
> +	gpio1: gpio@5000c000 {
> +		compatible = "snps,dw-apb-gpio";
> +		reg = <0x5000c000 0x80>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "bus";
> +		clocks = <&sysctrl R9A06G032_HCLK_GPIO1>;
> +
> +		gpio1a: gpio-controller@0 {
> +			compatible = "snps,dw-apb-gpio-port";
> +			bank-name = "gpio1a";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			snps,nr-gpios = <32>;
> +			reg = <0>;
> +
> +			interrupt-controller;
> +			interrupt-parent = <&gpioirqmux>;
> +			interrupts =   < 0  1  2  3  4  5  6  7
> +					 8  9 10 11 12 13 14 15
> +					16 17 18 19 20 21 22 23
> +					24 25 26 27 28 29 30 31 >;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> -- 
> 2.17.1
> 
