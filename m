Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0721820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FwhMRm2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0721820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeKICkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:40:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39896 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeKICkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:40:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10-v6so22038643wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FFj6EpmRM4r0RdFOW+/U4GFaTImNqse5DkY6+z+KS5M=;
        b=FwhMRm2AShGe6B+mwurftYHOJHFpzIv/4k0/EMgxF1SibZeX8/uO/dLEqFxoxaiZYk
         0C3luGyMOrMEzwrEwHDiYNOHiqSWrIOzqBFkxpcqO7fIL8KFnagFpJQqr6fGFU4mlEtG
         sHSjIU2wwTeqEfag8Be8Rbwj9ASXcsGODV30zkCqdGzJFchWNpDViwNzFwTNwqpsvB18
         K5YLwL77tUgA/HiynO5REYryetLFJfy/zUb4zPc8SzwC2pxoh1iV7N9ADnXA9JS6VvM4
         6vyoSAvdW3Eaxzom1bVJNWbF4hYZ6mZ8vsEjNy4NAgKLe4FHWkIxmB5cIvSrg7WPTYvQ
         DYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FFj6EpmRM4r0RdFOW+/U4GFaTImNqse5DkY6+z+KS5M=;
        b=UFN80UnZsdBAVd2UhQS40IuaqPtT3fTfARiX3eHVRv4HqsvJTQZOqPfI33w2fjzN1l
         GQJDbHPK+X3XYVHVCr+j3NEVyEo22Oh12OG8fQM56D+0kDHRI8Bdz4ht6dzaBREfeZoa
         IoVh8jqCuyoJEhDluqDBGSaSL0j156D/yhaxuE+mSspqOpHx9uMpS7y5Kmn0P9ClpO7R
         Bbide36qTDb/kPK79taAorDrvjfKprTbSJd0Lw83a7/Y3/+t3XD+i4vpAvBqwuaIKZUa
         T+pu+0vZ7eOVWDgWdf2nAgjX2mjGW/xnYW6Sw7HaOqio5rvkbxLvXB2c4jZlGqlmPj2x
         DsIQ==
X-Gm-Message-State: AGRZ1gIFRJn/qvc5JFpa1qdgyscj0sT3lBGQwgUJ640h6UVN3xgxQkcR
        4mGDEygLLL0huOy3YNa2RjW46Q==
X-Google-Smtp-Source: AJdET5c13Dm0OVEUGL9GRsGm9+CkD6/Gvjnch7hND0cKJm37sZbuRqvecoEqWts3GIzhD3R4kqa16A==
X-Received: by 2002:adf:800b:: with SMTP id 11-v6mr4763925wrk.106.1541696627638;
        Thu, 08 Nov 2018 09:03:47 -0800 (PST)
Received: from boomer.baylibre.com ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-v6sm4965738wrq.16.2018.11.08.09.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 09:03:46 -0800 (PST)
Message-ID: <f0439f033d6f23bd489b31ba7c81a8ad6878079d.camel@baylibre.com>
Subject: Re: [PATCH v2 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
From:   jbrunet@baylibre.com
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Thu, 08 Nov 2018 18:03:44 +0100
In-Reply-To: <1541696475-27454-4-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
         <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
         <1541696475-27454-4-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 21:01 +0400, Christian Hewitt wrote:
> The Smartlabs SML-5442TW is broadly similar to the P231 reference design
> but with the following differences:
> 
> - Yellow and Blue front-panel LEDs are available but disabled
> - Red/Green LED is used to signal off/on status
> - GPIOX_17 is set high to enable the QCA9377 wireless module
> - uart_AO can be accessed after opening the case; soldered pins exist
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>  .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 316
> +++++++++++++++++++++
>  2 files changed, 317 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-
> sml5442tw.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile
> b/arch/arm64/boot/dts/amlogic/Makefile
> index c31f29d6..37d7dbd 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-
> a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> new file mode 100644
> index 0000000..a081984
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016 Endless Computers, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + * Copyright (c) 2018 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d.dtsi"
> +
> +/ {
> +	compatible = "smartlabs,sml5442tw", "amlogic,s905d", "amlogic,meson-
> gxl";
> +	model = "Smartlabs SML-5442TW";
> +
> +	aliases {
> +		serial0 = &uart_AO;
> +		serial1 = &uart_A;
> +		ethernet0 = &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		yellow {
> +			label = "sml5442tw:yellow";
> +			gpios = <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		blue {
> +			label = "sml5442tw:blue";
> +			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		green {
> +			label = "sml5442tw:green";
> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		red {
> +			label = "sml5442tw:red";
> +			gpios = <&gpio GPIODV_27 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	hdmi_5v: regulator-hdmi-5v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "HDMI_5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&gpio GPIOH_3 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vddio_boot: regulator-vddio_boot {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		clocks = <&wifi32k>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	cvbs-connector {
> +		compatible = "composite-video-connector";
> +
> +		port {
> +			cvbs_connector_in: endpoint {
> +				remote-endpoint = <&cvbs_vdac_out>;
> +			};
> +		};
> +	};
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "meson-gx-audio";
> +
> +		simple-audio-card,dai-link@0 {
> +			/* HDMI Output */
> +			format = "i2s";
> +			mclk-fs = <256>;
> +			bitclock-master =  <&i2s_dai>;
> +			frame-master = <&i2s_dai>;
> +			plat {
> +				sound-dai = <&aiu_i2s_dma>;
> +			};
> +
> +			cpu {
> +				sound-dai = <&i2s_dai>;
> +			};
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};

Still not good, sorry !

> +
> +&cec_AO {
> +	status = "okay";
> +	pinctrl-0 = <&ao_cec_pins>;
> +	pinctrl-names = "default";
> +	hdmi-phandle = <&hdmi_tx>;
> +};
> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> +&ethmac {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	phy-handle = <&internal_phy>;
> +};
> +
> +/* This will enable the bluetooth module */
> +&gpio {
> +	bt-en {
> +		gpio-hog;
> +		gpios = <GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "bt-en";
> +	};
> +};
> +
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> +	pinctrl-names = "default";
> +	hdmi-supply = <&hdmi_5v>;
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +&i2c_A {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&internal_phy {
> +	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +	linux,rc-map-name = "rc-o2cz-khamsin";
> +};
> +
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
> +/* Wireless SDIO Module */
> +&sd_emmc_a {
> +	status = "okay";
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <100000000>;
> +
> +	non-removable;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <100000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	max-frequency = <100000000>;
> +	non-removable;
> +	disable-wp;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +};
> +
> +/* This UART is brought out to the debug header */
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};


