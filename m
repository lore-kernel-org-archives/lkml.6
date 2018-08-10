Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205821CCE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ulLbEmfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C205821CCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHJO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:28:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40029 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeHJO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:28:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so1624660wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MzyXpHqbFH3x1p7JI/B4cXbI0ZrmuolRNcoDV2ZL4E=;
        b=ulLbEmfcex2k8eWuKeZTkyCguC5t9rVgmIGQzk9qz5v8bYj9kw1lBbBi91sP45337A
         5w6ELPMri6Uldhl7p527Im9aDJ8lqSx4XfU2QrJUaMUlK6bL37fLtAvOkMFOWcuOeqgg
         JpsTpOmzQUH+nbuH64W3vcyMHlyC3ohxy96TPudjaf2D2fRpQ01NBtgXwusGIWhWnlZd
         aYDk9yLEW4cJrywnH1hhfdvcFNKvrH255nNFCUFKyWTbRAuAeLL8Xn8jOpuvgeikLwko
         cnw9TgbGKZQX8ukqPHCS5Y0wtGFDHbtQcDoUCFE9rhelHod5KbpGi/lCFTDIhwSjC1VS
         ZY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MzyXpHqbFH3x1p7JI/B4cXbI0ZrmuolRNcoDV2ZL4E=;
        b=Y2J5uynwW/IwKyeUwXqfL62r8DfMYebetCe1InlXOHVWgeureoypVuz8OfN2vzlwSv
         2UHcBAfYNgsmFjlJGWV8McsBAlJULpZTsv8HrFfVfTw1sM/tw+ovedSNXwrjwUzrTaBb
         SRndLLyTN9ht+d8wa8FzmM+pyEjuS0U/frkWcz53TqWHankOnnm+t4bqJaPpfUfFnaFC
         etn1PFL5U0I7Gu6n+CCt9VgviaRw65MUXhmgF6cIfQBLbSq5WcKAHvNr8Fm1Q4iCFyDv
         6dpom1Yd8Uk7JEC+0E0ZD4bqCWuod490UdvAzDGfQu4gsrEk5Oy3xxSa8enfr9b7K4RD
         Ld7Q==
X-Gm-Message-State: AOUpUlE2DbRq4Ion2t2xp/jHaJVxIF1Aqb/ACbJOxHVjs/22nTWi3eTO
        /VlwL/4soPM33BAl9V/E9SyGyQ==
X-Google-Smtp-Source: AA+uWPw+7tXH0ahwrUcmmYdv+TUE46BJrc3k76XJHHS+AMrRiBpy6t0N8HAPE5skz2T0vsthdJfS/A==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr1255553wmf.25.1533902327986;
        Fri, 10 Aug 2018 04:58:47 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t186-v6sm1851675wmf.14.2018.08.10.04.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 04:58:46 -0700 (PDT)
Message-ID: <f21f60423cbc43797e2465f1a734f715795c30b6.camel@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson-g12a: add initial g12a s905d2 SoC
 DT support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
        Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>
Date:   Fri, 10 Aug 2018 13:58:34 +0200
In-Reply-To: <1533802951-49919-3-git-send-email-jianxin.pan@amlogic.com>
References: <1533802951-49919-1-git-send-email-jianxin.pan@amlogic.com>
         <1533802951-49919-3-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 16:22 +0800, Jianxin Pan wrote:
> Try to add basic DT support for the Amlogic's Meson-G12A S905D2 SoC,
> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
> Timer, UART. It's capable of booting up into the serial console.
> 
> Signed-off-by: Jianxin <jianxin.pan@amlogic.com>

Could please fix your signoff here ? Your last name went missing

> ---
>  arch/arm64/boot/dts/amlogic/Makefile            |   1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts |  22 +++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi     | 174 ++++++++++++++++++++++++
>  3 files changed, 197 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index a97c0e2..c31f29d6 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> new file mode 100644
> index 0000000..d267a37
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12a.dtsi"
> +
> +/ {
> +	compatible = "amlogic,u200", "amlogic,g12a";
> +	model = "Amlogic Meson G12A U200 Development Board";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +	};
> +};
> +
> +&uart_AO {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> new file mode 100644
> index 0000000..64a0f2e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {

Could you please order the subnodes alphabetically ?

In general, we should try to order nodes by addresses when there is one and
alphabetically when there is none. This is something we have to fix for the AXG
as well.


> +	compatible = "amlogic,g12a";
> +
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */

It's the only one (for now at least) so it's not really an alternate, isn't it ?

> +		secmon_reserved: secmon@5000000 {
> +			reg = <0x0 0x05000000 0x0 0x300000>;
> +			no-map;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			reg = <0x0 0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xtal";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

Could you please order the different bus by ascending addresses ?


> +
> +		apb: apb@ffe00000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xffe00000 0x0 0x200000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
> +		};
> +
> +		cbus: bus@ffd00000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xffd00000 0x0 0x25000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
> +
> +		};
> +
> +		gic: interrupt-controller@ffc01000 {
> +			compatible = "arm,gic-400";
> +			reg = <0x0 0xffc01000 0 0x1000>,
> +			      <0x0 0xffc02000 0 0x2000>,
> +			      <0x0 0xffc04000 0 0x2000>,
> +			      <0x0 0xffc06000 0 0x2000>;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +		};
> +
> +		hiubus: bus@ff63c000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xff63c000 0x0 0x1c00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
> +
> +		};
> +
> +		periphs: periphs@ff634000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xff634000 0x0 0x2000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
> +		};
> +
> +		aobus: bus@ff800000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xff800000 0x0 0x100000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
> +
> +			uart_AO: serial@3000 {
> +				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
> +				reg = <0x0 0x3000 0x0 0x18>;
> +				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_AO_B: serial@4000 {
> +				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
> +				reg = <0x0 0x4000 0x0 0x18>;
> +				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&xtal>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +		};
> +	};
> +};


