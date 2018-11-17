Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EAFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB442080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB442080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeKRAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:49:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42893 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKRAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 19:49:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so9371319oiw.9;
        Sat, 17 Nov 2018 06:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yilNz8PeP2cJ8bb6MXz1gT5hqALytK0Or/Y/TPXv+OA=;
        b=lyhYFgIQGjfKQLj9pQzodCnywBqJnfJIihjcuA8PNk2WKZ82t9kh+qO9fKeNmB84lL
         V0xcnwq1Cunt8+5+efKgMWxfzQsesGSoy2WxjEUsv9bGOvO8Q5oWBudHVF8Lw0YuRRbj
         CczQoeNjO30PzZPAI0e68uRxDZIIcycY3ty7Z0d5hNfwIHrGsU+0alIZHRSXYKLYMDQS
         9AfjpP0BZMgK3lR5iS2wiUv6/4+rwDXJiVMMJ/IZB3nhm9PpnWTxf8D5rqKyniOt3LWi
         Fj57I4bpQpMXwo7snxE/UztYiB5mONRs5aX3r+Fb4v+9R5NNhFptTCdX0KxczvGdQQk+
         TPJQ==
X-Gm-Message-State: AGRZ1gJXGHMSK/+N6GKK5fq33LjxaDtQaR+NwtFQhFhyGyLupGpWYhhv
        IIBlC9/bt74pBZLM8aEjdJmOOeY=
X-Google-Smtp-Source: AFSGD/V+mtEJzsgtqSMS6qp4An2POXW6BWR6xCMXaPWTN+OUgYyT5yZSefOFq+UVID3DVlaTZmxclA==
X-Received: by 2002:aca:4a56:: with SMTP id x83mr2802954oia.11.1542465176571;
        Sat, 17 Nov 2018 06:32:56 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id i34sm1613804otd.44.2018.11.17.06.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 06:32:55 -0800 (PST)
Date:   Sat, 17 Nov 2018 08:32:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings/interrupt-controller: rzn1: Add RZ/N1
 gpio irq mux binding
Message-ID: <20181117143253.GA27381@bogus>
References: <20181113130910.22130-1-phil.edworthy@renesas.com>
 <20181113130910.22130-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113130910.22130-2-phil.edworthy@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 01:09:09PM +0000, Phil Edworthy wrote:
> Add device binding documentation for the Renesas RZ/N1 GPIO interrupt
> multiplexer.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
>  - Use 'interrupt-map' DT property correctly.
> v2:
>  - Use interrupt-map to allow the GPIO controller info to be specified
>    as part of the irq.
>  - Don't show status in binding examples.
>  - Don't show the soc/board split in binding doc.
> ---
>  .../interrupt-controller/renesas,rzn1-mux.txt | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt

A few nits, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
> new file mode 100644
> index 000000000000..6515880e25cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
> @@ -0,0 +1,73 @@
> +* Renesas RZ/N1 GPIO Interrupt Multiplexer
> +
> +On Renesas RZ/N1 devices, there are several GPIO Controllers each with a number
> +of interrupt outputs. All of the interrupts from the GPIO Controllers are passed
> +to the GPIO Interrupt Multiplexer, which selects a sub-set of the interrupts to
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
> +- reg: Base address and size of GPIO IRQ Muxer registers.
> +- interrupts: List of output interrupts.
> +- #interrupt-cells: Numder of cells in the input interrupt specifier, must be 1.
> +- #address-cells: Must be 0.
> +- interrupt-map-mask: must be 127.
> +- interrupt-map: Standard property detailing the maps between input irqs and the
> +  corresponding output irq. This consist of a list of:
> +	<input-irq-spec phandle-to-interrupt-controller output-irq-spec>
> +  The input-irq-spec is from 0 to 95, corresponding to the outputs of the GPIO
> +  Controllers.
> +
> +Example:
> +
> +	The following is an example for the RZ/N1D SoC.
> +
> +	gpioirqmux: gpioirqmux@51000480 {

interrupt-controller@...

> +		compatible = "renesas,r9a06g032-gpioirqmux",
> +				"renesas,rzn1-gpioirqmux";
> +		reg = <0x51000480 0x20>;
> +		interrupts =
> +			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;

This is a bit redundant as the same information is in interrupt-map, but 
I guess you need it to get the irq resources.

> +
> +		#interrupt-cells = <1>;
> +		#address-cells = <0>;
> +		interrupt-map-mask = <127>;

Use hex for masks.

> +		interrupt-map =
> +			/* gpio2a 24, pin 146: ETH Port 1 IRQ */
> +			<88 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +			/* gpio2a 26, pin 148: TouchSCRN_IRQ */
> +			<90 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpio2: gpio@5000d000 {
> +		compatible = "snps,dw-apb-gpio";
> +		reg = <0x5000d000 0x80>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "bus";
> +		clocks = <&sysctrl R9A06G032_HCLK_GPIO2>;
> +
> +		gpio2a: gpio-controller@0 {

gpio@0

> +			compatible = "snps,dw-apb-gpio-port";
> +			bank-name = "gpio2a";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			snps,nr-gpios = <32>;
> +			reg = <0>;
> +
> +			interrupt-controller;
> +			interrupt-parent = <&gpioirqmux>;
> +			interrupts =  < 64 65 66 67 68 69 70 71
> +					72 73 74 75 76 77 78 79
> +					80 81 82 83 84 85 86 87
> +					88 89 90 91 92 93 94 95 >;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> -- 
> 2.17.1
> 
