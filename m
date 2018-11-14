Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73364C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22374223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtRZ+fvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22374223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeKNSYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:24:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38944 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:24:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so2843381pfc.6;
        Wed, 14 Nov 2018 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=K7ItcJWwvKMLaQcfSseVZvj/btn1QQHDrmPP1U1fZzA=;
        b=rtRZ+fvwv6D4KLK0GYe3CnpLy5e74ugBAP/DSK13U0UNPMirbBSrSoom1MLV8kdxy7
         h5kmcPy1r6XGjsDPZdFyMFAZ7WQwoJQ84/DGuztowjKsFGoNyhPSU8ipJGa04FQTDshX
         FiYEDNgAIUBEUcDVoG2S3a6sKVefTBOUnJA0rrOAINoGKiOIaINjuhUikJ7k/tXrNzK3
         CQHJQGgOUxCXm9Yxzq3CBUs6iRzUuXx8cXnxUMvOd4f+gj4sO4v0WkKWRInUVjpu5GyZ
         Xy5/KFodaQ8Zw0+Cwn85r8bDvXJFU2nSVE0u27fEQJlKzq58YRyrzk0W5X+s7vLxloED
         hfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K7ItcJWwvKMLaQcfSseVZvj/btn1QQHDrmPP1U1fZzA=;
        b=X8R8hWbLYffL+hnQHXUJk7YBIV+eT6AhtpWjb4XJSPlerSbwGsUmg23rclI0Uwujes
         eoVgwtBeFCvJunAEWo9CIDjRgX15zT3ZjRnd+Zf/z+EnkGRLywfgjJYQkPdYt3+U0KZE
         yuLzv62NXzH2ZQzugvq9rYC5t8+JsaufPcbrdfwhUaVNAmEp+8mL3c65P06rP2U0xo4q
         nHLqkT9AgrUNS8U+06nmS+y3oilFbPRPtWTYltaMBA2qBODtNyUyQRJprI7Po++3AXPn
         LPsdp8VKooExB9Wo662XxaSZr34F+6sL27I28L6sY03SxkH5NwWnqLUO2UzL6JsHkobX
         zyKA==
X-Gm-Message-State: AGRZ1gIAfxBV9Oz8+zn7RsV7eI08GHa9s5nRD94bCI9wsNIS+IonD9uy
        2+D67TyB9HJfJJvGCwiERwU=
X-Google-Smtp-Source: AJdET5eKTw3u71M45Scq91nQq0zhcJ5qivNsiIlaQKKSbc7plMY8vUS3hQLIHHYdZiirOEyVJWMmBg==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr846448pga.237.1542183738908;
        Wed, 14 Nov 2018 00:22:18 -0800 (PST)
Received: from arx-s1 ([114.95.230.67])
        by smtp.gmail.com with ESMTPSA id g7-v6sm24334012pfo.139.2018.11.14.00.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 00:22:18 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:22:07 +0800
From:   hao_zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, linus.walleij@linaro.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io
Subject: [PATCH v0 1/2] ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.
Message-ID: <20181114082207.GA21068@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T3/R40/V40 using the same sdk and config file in allwinner
sdk, it seem they are the same SOC just with different name, so
compatible with R40.

The t3-cqa3t-bv3 based on Allwinner T3 SoC, it has various connectors,
leds, buttons, and sell on:
https://item.taobao.com/item.htm?spm=2013.1.w4023-4203040713.25.62704cce7UCgLS&id=557154455330

It features:
 - X-Powers AXP221s PMIC connected to i2c0
 - 1/2 GB DDR3 DRAM
 - 8 GB eMMC
 - 2x USB 2.0 hosts
 - 1x USB 2.0 OTG
 - 2 LVDS connectors
 - 24 bit RGB LCD connector
 - HDMI output
 - DVP camera interface (support 500w cmos camera)
 - GPIO connectors
 - 5 TTL uarts and 2 RS232 uarts
 - 1 RS485 connector
 - support i2c capacitive tp and usb infrared tp
 - boot control, reset and customer buttons
 - 3.5mm headphone and 3.5mm mic jack
 - 100M RJ45
 - micro SD card slot
 - DC power jack
 - RCT power slot
 - 1 CVBS TVIN
 - 1 CVBS TVOUT
 - 2 customer leds
 - 1 buzzer
 - 1 minipcie
 - I2C output
 - SPI output
 - PCM output
 - wifi and bt connector reserved.

Board info can find here:
https://github.com/Axl-zhang/Allwinner-V40-T3-R40-manual

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts | 226 +++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2a1a8c6..7ca266a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1053,6 +1053,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
+	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
new file mode 100644
index 0000000..6931aaa
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun8i-r40.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "t3-cqa3t-bv3";
+	compatible = "qihua,t3-cqa3t-bv3", "allwinner,sun8i-t3",
+		     "allwinner,sun8i-r40";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
+		enable-active-high;
+	};
+};
+
+&ahci {
+	ahci-supply = <&reg_dldo4>;
+	phy-supply = <&reg_eldo3>;
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp22x: pmic@34 {
+		compatible = "x-powers,axp221";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 15 GPIO_ACTIVE_LOW>; /* PH15 */
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vcc-pa";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avcc";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pg";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-dldo3";
+};
+
+&reg_eldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-pe";
+};
+
+&tcon_tv0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	usb2_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.7.4

