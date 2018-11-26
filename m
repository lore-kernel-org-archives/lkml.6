Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38192082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38192082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeK0KoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:44:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33150 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbeK0KoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:44:20 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRQc4-0003H9-HH; Tue, 27 Nov 2018 00:48:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Add DT for nanopc-t4
Date:   Tue, 27 Nov 2018 00:48:23 +0100
Message-ID: <26178858.xdqtN7Rtck@phil>
In-Reply-To: <20181126145107.38222-1-tomeu.vizoso@collabora.com>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com> <20181126145107.38222-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomeu,

Am Montag, 26. November 2018, 15:47:49 CET schrieb Tomeu Vizoso:
> This adds a device tree for the NanoPC-T4 SBC, which is based on the
> Rockchip RK3399 SoC and marketed by FriendlyELEC.
> 
> Known working:
> 
> - Serial
> - Ethernet
> - HDMI
> - USB 2.0
> 
> All of the interesting stuff is in a .dtsi because there are at least
> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

looks pretty good overall, just some more small-scale things
below.

> ---
> 
> v2: - Rename compatible from friendlyelec to friendlyarm, to match
>       existing bindings
>     - Remove superfluous node spi1
> 
> v3: - Rewrite regulator tree to match the schematics (Heiko)
>     - Sort top-level nodes alphabetically (Heiko)
>     - Used defines for GPIO numbers (Heiko)
>     - Enabled rga (Heiko)
>     - Removed cdn_dp node (Heiko)
>     - Removed dependencies to fusb0 as extcon (Heiko)
>     - Removed superfluous properties (Heiko)


> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 49042c477870..4cbd2c461052 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb

These are definitly sorted in the Makefile, so this should move between
rk3399-gru-scarlet-kd.dtb and rk3399-puma-haikou.dtb :-)


> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> new file mode 100644
> index 000000000000..f102ff2317c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * RK3399-based FriendlyElec boards device tree source
> + *
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	vdd_5v: vdd_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v0_core: vcc5v0_core {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_core";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3_sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_core>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0_sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc5v0_usb1: vcc5v0_usb1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb1";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb2: vcc5v0_usb2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb2";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* switched by pmic_sleep */
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcc3v0_sd: vcc3v0_sd {

dt-spec mandates node names with "-", so this should become
	vcc3v0_sd: vcc3v0-sd {

Same for most regulators above.

> +	rk808: pmic@1b {
> +		compatible = "rockchip,rk808";
> +		reg = <0x1b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";

rename rk808-clkout1 to xin32k so that it hooks correctly into
the rk3399 clock controller, as that signals is providing the 32kHz clock
for the system. (see $debug/clk/clk_summary and rk3399-cru dt binding)


> +&pinctrl {
> +

unnecessary empty line

> +	pmic {


> +&rga {
> +	status = "okay";
> +};

rga is not dependant on pinout, so is always enabled in rk3399.dtsi
So this node can go away.

> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	supports-emmc;

remnant from the vendor-kernel?
Should also go away.

> +	non-removable;
> +	keep-power-in-suspend;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +

> +&usbdrd3_0 {
> +	status = "okay";
> +	extcon = <&fusb0>;

I still don't think that extcon gets defined at all and is also
not specified in any dwc3 binding, so should probably go away.


Heiko


