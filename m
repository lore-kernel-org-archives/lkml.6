Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB99C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E9C2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550518377;
	bh=z4JP9lNSTz5HcBmX4WFF5gD2KBHAEGJjKY+Va69qEl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RBtXzoIJhym/1tKkN5YQdMJu2uKSR4+s6aQy5rkDbMSPsqrUxloOvfTBaJL1V/qiy
	 Q+mUe0NBh6RKqLATXtcomrIBLoeQt31zCIpkana7tTGrF0nCzkty/FapuYEfC6ye0M
	 OEWMOQf5xWb9ygQd3DjnC2y3B9bcBEdZpHIAKJ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfBRTcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:32:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41394 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfBRTcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:32:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id t7so13797266otk.8;
        Mon, 18 Feb 2019 11:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwK/t3EqiCQBADQ2CrSpZEUtlJF0kCvDoIFGC7QJMs4=;
        b=rZ3XVOVjAgoCeVN5VB3o+SD7OPtdSDYdk2FSi6DJVEudT+Fbygq5ZVrHBmnYA6St3P
         Lc7quLU8NBPIyNSt9s7sBLLUzT+X7Zjy0YaQw+ChsuTjFZKGrrxmmjKHNQOFL+QokSqn
         YaK+Wk3diqLdFH7GjL0Mqf1X984z29HlOMWQ7mjEAIdS2Z4RyAufZwKivBh92Yso8rQ6
         12qwmFywCU7cJwgAyjsZCcKw45fUCF9d906z05ysYKoU4xpH9j8yy8pvLNXvyDBEK50Z
         E/2Lkh0xZn5VYM7TLB7AdMe/YhFYSNDUfzGVY7kwUFWEcrARzgcqYmp/jElkZnbdK4oZ
         N8tg==
X-Gm-Message-State: AHQUAuZQhzcg36g+oR1/hyJ2/IWv+8mh3FlfEZaXRHLu6J/tnp+AfsQp
        HcedzXY87ywXTYiuaZuPhg==
X-Google-Smtp-Source: AHgI3IbmFrN1GPCux7cPUAlRZbe43Ar6DQ1GWo2D32tfx7TwNiSNcRS+UQa0k33YfETSIv1AoENZyw==
X-Received: by 2002:aca:5e82:: with SMTP id s124mr255622oib.7.1550518373515;
        Mon, 18 Feb 2019 11:32:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y5sm6206961oix.38.2019.02.18.11.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:32:52 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:32:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org,
        s-anna@ti.com, david@lechnology.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver
 for PRUSS interrupts
Message-ID: <20190218193252.GA6313@bogus>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-4-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549290167-876-4-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:22:36PM +0200, Roger Quadros wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../interrupt-controller/ti,pruss-intc-irq.txt     | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> new file mode 100644
> index 0000000..c70221c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
> @@ -0,0 +1,51 @@
> +PRU ICSS INTC on TI SoCs
> +========================
> +
> +Each PRUSS has a single interrupt controller instance that is common to both
> +the PRU cores. Each interrupt controller can detect 64 input events which are
> +then mapped to 10 possible output interrupts through two levels of mapping. The
> +input events can be triggered by either the PRUs and/or various other PRUSS
> +internal and external peripherals. The first 2 output interrupts are fed
> +exclusively to the internal PRU cores, with the remaining 8 connected to
> +external interrupt controllers including the MPU.
> +
> +Required Properties:
> +--------------------
> +- compatible           : should be one of,
> +                             "ti,am3356-pruss-intc" for AM335x family of SoCs
> +                             "ti,am4376-pruss-intc" for AM437x family of SoCs
> +                             "ti,am5728-pruss-intc" for AM57xx family of SoCs
> +                             "ti,k2g-pruss-intc" for 66AK2G family of SoCs
> +- reg                  : base address and size for the PRUSS INTC sub-module
> +- reg-names            : should contain the string "intc"

Not really useful with only 1 entry.

> +- interrupts     : all the interrupts generated towards the main host
> +                   processor in the SoC. The format depends on the
> +                   interrupt specifier for the particular SoC's MPU
> +                   parent interrupt controller
> +- interrupt-names: should use one of the following names for each interrupt,
> +                   the name should match the corresponding host interrupt
> +                   number,
> +                       "host2", "host3", "host4", "host5", "host6",
> +                       "host7", "host8" or "host9"
> +                   NOTE: AM437x and 66AK2G SoCs do not have "host7" interrupt
> +                         connected to MPU
> +- interrupt-controller : mark this node as an interrupt controller
> +- #interrupt-cells     : should be 1. Client users shall use the PRU System
> +                         event number (the interrupt source that the client
> +                         is interested in) as the value of the interrupts
> +                         property in their node
> +
> +Example:
> +--------
> +		pruss_intc: intc@20000 {

interrupt-controller@20000

> +			compatible = "ti,am3356-pruss-intc";
> +			reg = <0x20000 0x2000>;
> +			reg-names = "intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <20 21 22 23 24 25 26 27>;
> +			interrupt-names = "host2", "host3", "host4",
> +					  "host5", "host6", "host7",
> +					  "host8", "host9";
> +		};
> +
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
