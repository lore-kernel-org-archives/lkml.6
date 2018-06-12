Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1DEE5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934910AbeFLWb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:31:59 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39800 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:31:57 -0400
Received: by mail-yw0-f193.google.com with SMTP id 81-v6so209969ywb.6;
        Tue, 12 Jun 2018 15:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opl2yBr8RSlbnuA0oUkYj94+HrNTbVh2yqIBDSdgf9Q=;
        b=DuxNrbNoEd6IPw3eWNEzgPswS2rfq3gvTLTYUTx9z4vcX3sqk7bchaD16hiNunwDEC
         c8sGcq+eeVTZlKFvk6i6KDPwdsZ6FHv/5qcVL5A1WviKs8D1eePYJTOHH4CyMJ0mdhHi
         dnlM/RnN81tc5pL0AYkUS53t/coAVJCI3ckqzHkiX5cmt5ipXCYm7MuY8bExDrZ6kEiQ
         mFmoZbEOMLAMRT3Ey4AQ8OZ8KNMsdcLN7BEvjqdQAY5bk/7Jixs9GNCG7zxXQsQ1Je1J
         imGW+KrBQ3bk9J3GjJenPNrvzmlUMFUMrfYXGBl30jMEy08PGjlbN6RAZKSrH4zqXU0C
         PIEg==
X-Gm-Message-State: APt69E06fdKl20LqifTjJxor/1UZH3hqnouUbArTg/+QKE2M+OjPBDg0
        DWJWBk01cBARBp1paxjhcA==
X-Google-Smtp-Source: ADUXVKLOSN0hg4U8sfnwwty/NL+XI4nXqWrf+hSTdWhv+wcRBiUdP2bAbH3ejZIFwtZcL0VAeVpm8g==
X-Received: by 2002:a81:7a81:: with SMTP id v123-v6mr1191546ywc.149.1528842716689;
        Tue, 12 Jun 2018 15:31:56 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h1-v6sm456765ywj.86.2018.06.12.15.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:31:56 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:31:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
Message-ID: <20180612223153.GB2197@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-4-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-4-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:30PM +0800, Songjun Wu wrote:
> From: Hua Ma <hua.ma@linux.intel.com>
> 
> Add initial support for Intel MIPS interAptiv SoCs made by Intel.
> This series will add support for the GRX500 family.
> 
> The series allows booting a minimal system using a initramfs.
> 
> Signed-off-by: Hua ma <hua.ma@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
>  arch/mips/Kbuild.platforms                         |   1 +
>  arch/mips/Kconfig                                  |  36 ++++
>  arch/mips/boot/dts/Makefile                        |   1 +
>  arch/mips/boot/dts/intel-mips/Makefile             |   3 +
>  arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  20 +++
>  arch/mips/boot/dts/intel-mips/xrx500.dtsi          | 196 +++++++++++++++++++++

Please split dts files to separate patch.


> diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
> new file mode 100644
> index 000000000000..40177f6cee1e
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +#include <dt-bindings/clock/intel,grx500-clk.h>
> +
> +#include "xrx500.dtsi"
> +
> +/ {
> +	model = "EASY350 ANYWAN (GRX350) Main model";

A board should have a board specific compatible, too. 

> +	chosen {
> +		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
> +		stdout-path = "serial0";
> +	};
> +
> +	memory@0 {

memory@20000000

> +		device_type = "memory";
> +		reg = <0x20000000 0x0e000000>;
> +	};
> +};
> diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
> new file mode 100644
> index 000000000000..04a068d6d96b
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "intel,xrx500";

This needs to be documented.

> +
> +	aliases {
> +		serial0 = &asc0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,interaptiv";
> +			clocks = <&cpuclk>;
> +			reg = <0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "mti,interaptiv";
> +			reg = <1>;
> +		};
> +	};
> +
> +	cpu_intc: interrupt-controller {
> +		compatible = "mti,cpu-interrupt-controller";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	gic: gic@12320000 {
> +		compatible = "mti,gic";
> +		reg = <0x12320000 0x20000>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		/*
> +		 * Declare the interrupt-parent even though the mti,gic
> +		 * binding doesn't require it, such that the kernel can
> +		 * figure out that cpu_intc is the root interrupt
> +		 * controller & should be probed first.
> +		 */
> +		interrupt-parent = <&cpu_intc>;
> +		mti,reserved-ipi-vectors = <56 8>;
> +	};
> +
> +	cgu0: cgu@16200000 {
> +		compatible = "syscon";
> +		reg = <0x16200000 0x100000>;
> +
> +		clock {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			osc0: osc0 {
> +				#clock-cells = <0>;
> +				compatible = "fixed-clock";
> +				clock-frequency = <40000000>;
> +				clock-output-names = "osc40M";
> +			};
> +
> +			pll0a: pll0a {
> +				#clock-cells = <0>;
> +				compatible = "fixed-factor-clock";
> +				clock-mult = <0x3C>;
> +				clock-div = <1>;
> +				clocks = <&osc0>;
> +				clock-output-names = "pll0a";
> +			};
> +
> +			pll0b: pll0b {
> +				#clock-cells = <0>;
> +				compatible = "fixed-factor-clock";
> +				clock-mult = <0x32>;
> +				clock-div = <1>;
> +				clocks = <&osc0>;
> +				clock-output-names = "pll0b";
> +			};
> +
> +			pll3: pll3 {
> +				#clock-cells = <0>;
> +				compatible = "fixed-factor-clock";
> +				clock-mult = <0x64>;
> +				clock-div = <1>;
> +				clocks = <&osc0>;
> +				clock-output-names = "lcpll3";
> +			};
> +
> +			pll0aclk: pll0aclk {
> +				#clock-cells = <1>;
> +				compatible = "intel,grx500-pll0a-clk";
> +				clocks = <&pll0a>;
> +				reg = <0x8>;
> +				clock-output-names = "cbm", "ngi",
> +				"ssx4", "cpu0";
> +			};
> +
> +			pll0bclk: pll0bclk {
> +				#clock-cells = <1>;
> +				compatible = "intel,grx500-pll0b-clk";
> +				clocks = <&pll0b>;
> +				reg = <0x38>;
> +				clock-output-names = "pae", "gswip", "ddr",
> +				"cpu1";
> +			};
> +
> +			ddrphyclk: ddrphyclk {
> +				#clock-cells = <0>;
> +				compatible = "fixed-factor-clock";
> +				clock-mult = <2>;
> +				clock-div = <1>;
> +				clocks = <&pll0bclk DDR_CLK>;
> +				clock-output-names = "ddrphy";
> +			};
> +
> +			pcieclk: pcieclk {
> +				#clock-cells = <0>;
> +				compatible = "intel,grx500-pcie-clk";
> +				clocks = <&pll3>;
> +				reg = <0x98>;
> +				clock-output-names = "pcie";
> +			};
> +
> +			cpuclk: cpuclk {
> +				#clock-cells = <0>;
> +				compatible = "intel,grx500-cpu-clk";
> +				clocks = <&pll0aclk CPU0_CLK>,
> +				<&pll0bclk CPU1_CLK>;
> +				reg = <0x8>;
> +				clock-output-names = "cpu";
> +			};
> +
> +			clkgate0: clkgate0 {
> +				#clock-cells = <1>;
> +				compatible = "intel,grx500-gate0-clk";
> +				reg = <0x114>;
> +				clock-output-names = "gate_xbar0", "gate_xbar1",
> +				"gate_xbar2", "gate_xbar3", "gate_xbar6",
> +				"gate_xbar7";
> +			};
> +
> +			clkgate1: clkgate1 {
> +				#clock-cells = <1>;
> +				compatible = "intel,grx500-gate1-clk";
> +				reg = <0x120>;
> +				clock-output-names = "gate_vcodec", "gate_dma0",
> +				"gate_usb0", "gate_spi1", "gate_spi0",
> +				"gate_cbm", "gate_ebu", "gate_sso",
> +				"gate_gptc0", "gate_gptc1", "gate_gptc2",
> +				"gate_urt", "gate_eip97", "gate_eip123",
> +				"gate_toe", "gate_mpe", "gate_tdm", "gate_pae",
> +				"gate_usb1", "gate_gswip";
> +			};
> +
> +			clkgate2: clkgate2 {
> +				#clock-cells = <1>;
> +				compatible = "intel,grx500-gate2-clk";
> +				reg = <0x130>;
> +				clock-output-names = "gate_pcie0", "gate_pcie1",
> +				"gate_pcie2";
> +			};
> +
> +			voiceclk: voiceclk {
> +				#clock-cells = <0>;
> +				compatible = "intel,grx500-voice-clk";
> +				clock-frequency = <8192000>;
> +				reg = <0xc4>;
> +				clock-output-names = "voice";
> +			};
> +
> +			i2cclk: i2cclk {
> +				#clock-cells = <0>;
> +				compatible = "intel,grx500-gate-dummy-clk";
> +				clock-output-names = "gate_i2c";
> +			};
> +		};
> +	};
> +
> +	asc0: serial@16600000 {
> +		compatible = "lantiq,asc";
> +		reg = <0x16600000 0x100000>;
> +
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
> +		clock-names = "freq", "asc";
> +	};
> +};
