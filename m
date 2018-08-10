Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F5C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9122447
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9122447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHJUjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:15 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:21623 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:15 -0400
Received: from [192.168.0.109] (183.194.173.14) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sat, 11 Aug
 2018 02:08:18 +0800
Subject: Re: [PATCH 2/2] arm64: dts: meson-g12a: add initial g12a s905d2 SoC
 DT support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@caione.org>,
        Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>
References: <1533802951-49919-1-git-send-email-jianxin.pan@amlogic.com>
 <1533802951-49919-3-git-send-email-jianxin.pan@amlogic.com>
 <f21f60423cbc43797e2465f1a734f715795c30b6.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <ae4a9444-9946-578f-0eed-8b235eaa6b4a@amlogic.com>
Date:   Sat, 11 Aug 2018 02:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f21f60423cbc43797e2465f1a734f715795c30b6.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.194.173.14]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2018 7:58 PM, Jerome Brunet wrote:
> On Thu, 2018-08-09 at 16:22 +0800, Jianxin Pan wrote:
>> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
>> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
>> Timer, UART. It's capable of booting up into the serial console.
>>
>> Signed-off-by: Jianxin <jianxin.pan@amlogic.com>
> 
> Could please fix your signoff here ? Your last name went missing
> 
OK, I will fix this mistake. Thank you for your review.

>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 174 ++++++++++++++++++++++++
>>  3 files changed, 197 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index a97c0e2..c31f29d6 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> new file mode 100644
>> index 0000000..d267a37
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-g12a.dtsi"
>> +
>> +/ {
>> +	compatible = "amlogic,u200", "amlogic,g12a";
>> +	model = "Amlogic Meson G12A U200 Development Board";
>> +
>> +	aliases {
>> +		serial0 = &uart_AO;
>> +	};
>> +};
>> +
>> +&uart_AO {
>> +	status = "okay";
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> new file mode 100644
>> index 0000000..64a0f2e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -0,0 +1,174 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
> 
> Could you please order the subnodes alphabetically ?
> 
> In general, we should try to order nodes by addresses when there is one and
> alphabetically when there is none. This is something we have to fix for the AXG
> as well.
> 
> 
OK, I will fix this in g12a first.>> +	compatible = "amlogic,g12a";
>> +
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
> 
> It's the only one (for now at least) so it's not really an alternate, isn't it ?
> 
Yes, the reserved memory for BL31 is a must. I will remove 'Alternate' in V2. 
>> +		secmon_reserved: secmon@5000000 {
>> +			reg = <0x0 0x05000000 0x0 0x300000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <0x2>;
>> +		#size-cells = <0x0>;
>> +
>> +		cpu0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		cpu1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x1>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		cpu2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x2>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		cpu3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x3>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2>;
>> +		};
>> +
>> +		l2: l2-cache0 {
>> +			compatible = "cache";
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10
>> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
>> +	};
>> +
>> +	xtal: xtal-clk {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <24000000>;
>> +		clock-output-names = "xtal";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> Could you please order the different bus by ascending addresses ?
> 
> 
OK, I will change it in v2. Thank you.
>> +
>> +		apb: apb@ffe00000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xffe00000 0x0 0x200000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
>> +		};
>> +
>> +		cbus: bus@ffd00000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xffd00000 0x0 0x25000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
>> +
>> +		};
>> +
>> +		gic: interrupt-controller@ffc01000 {
>> +			compatible = "arm,gic-400";
>> +			reg = <0x0 0xffc01000 0 0x1000>,
>> +			      <0x0 0xffc02000 0 0x2000>,
>> +			      <0x0 0xffc04000 0 0x2000>,
>> +			      <0x0 0xffc06000 0 0x2000>;
>> +			interrupt-controller;
>> +			interrupts = <GIC_PPI 9
>> +				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>> +			#interrupt-cells = <3>;
>> +			#address-cells = <0>;
>> +		};
>> +
>> +		hiubus: bus@ff63c000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xff63c000 0x0 0x1c00>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>> +
>> +		};
>> +
>> +		periphs: periphs@ff634000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xff634000 0x0 0x2000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
>> +		};
>> +
>> +		aobus: bus@ff800000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xff800000 0x0 0x100000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>> +
>> +			uart_AO: serial@3000 {
>> +				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>> +				reg = <0x0 0x3000 0x0 0x18>;
>> +				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
>> +				clocks = <&xtal>, <&xtal>, <&xtal>;
>> +				clock-names = "xtal", "pclk", "baud";
>> +				status = "disabled";
>> +			};
>> +
>> +			uart_AO_B: serial@4000 {
>> +				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>> +				reg = <0x0 0x4000 0x0 0x18>;
>> +				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
>> +				clocks = <&xtal>, <&xtal>, <&xtal>;
>> +				clock-names = "xtal", "pclk", "baud";
>> +				status = "disabled";
>> +			};
>> +
>> +		};
>> +	};
>> +};
> 
> 
> .
> 

