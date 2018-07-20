Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50F204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B50F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbeGTQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:10:06 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43548 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbeGTQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:10:06 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so10224831ioa.10;
        Fri, 20 Jul 2018 08:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnOoq1z2VNAwi8n2pRjCdLmHnpnjgrFSnrS+PFiVlvI=;
        b=YCPL+YhC7CXfmc0TRHcu3WYbnn2KLpplSHI+8oAaPJwxFSxzb2/NPeuGEU/yrSnKiY
         QAG3kdyrOZJUbu/WTR+vnUw0HvFjqxvvDaM53dniakLKEDm+xuDqDcHmiWkLzOIocHS/
         IKC3DNaMafGbhxQR0X9wFbNggZewSP3rmFWmUQhMAMzhqy7smFxBs1zI30kcw2firXiS
         C38fTdmyBDNX7QmNrBunlgrv0KP+hkGJruAgTBeurNlH5N6e0Dcggru0fQwf7MOLxqcv
         L3ILW6NMyzboNyaO96B4eee+CUNji3yuDGwGCqm1FvkBxT+G4ndZDyV8JtQsOsuFF1rp
         3eyw==
X-Gm-Message-State: AOUpUlHKF73Oro5gf12+zzBQvpB8+U6aW3qrGsiODaRE8/wzfowNO5Ts
        D0RawjkBhGb4fOXZuglj/w==
X-Google-Smtp-Source: AAOMgpdNYljXF6p2y2CV4YVsVcRvR3SK/il6Fsiaf+ckj2WvtvC1e+Cbo5qPuZC3zu5I4pibId4Hag==
X-Received: by 2002:a6b:5306:: with SMTP id h6-v6mr1981415iob.2.1532100079028;
        Fri, 20 Jul 2018 08:21:19 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm1333438ita.38.2018.07.20.08.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:21:18 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:21:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: synaptics: add dtsi file for Synaptics
 AS370 SoC
Message-ID: <20180720152117.GB26487@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
 <20180713172626.5ca0e30f@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713172626.5ca0e30f@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 05:26:26PM +0800, Jisheng Zhang wrote:
> Add initial dtsi file to support Synaptics AS370 SoC with quad
> Cortex-A53 CPUs.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/arm64/boot/dts/synaptics/as370.dtsi | 177 +++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
> 
> diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
> new file mode 100644
> index 000000000000..20f3d658c566
> --- /dev/null
> +++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2018 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "syna,as370";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;

This normally goes in the board file. All boards will use this?

> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			device_type = "cpu";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +		};
> +
> +		l2: cache {
> +			compatible = "cache";

Why do you need this node? Doesn't define 

> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <75>;
> +				exit-latency-us = <155>;
> +				min-residency-us = <1000>;
> +			};
> +		};
> +	};
> +
> +	osc: osc {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc@f7000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0xf7000000 0x1000000>;
> +
> +		gic: interrupt-controller@901000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x901000 0x1000>,
> +			      <0x902000 0x2000>,
> +			      <0x904000 0x2000>,
> +			      <0x906000 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		apb@e80000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xe80000 0x10000>;
> +
> +			uart0: uart@0c00 {

serial@c00

> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x0c00 0x100>;
> +				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&osc>;
> +				reg-shift = <2>;
> +				status = "disabled";
> +			};
> +
> +			gpio0: gpio@1800 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x1800 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				porta: gpio-port@0 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
> +			gpio1: gpio@2000 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x2000 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				portb: gpio-port@1 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.18.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
