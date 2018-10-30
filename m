Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A140C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9162081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="BJNytPjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9162081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJaHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:09:50 -0400
Received: from the.earth.li ([46.43.34.31]:54244 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJaHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JJMEdzBMrNnJ7b5efrEICcCar/n7/EFpp+zoElJCmfo=; b=BJNytPjkFaWXR90inTbzQlrMn/
        sALJvLeZzkIfli+C0ixu2XBKq5HwtmAfg1qW6r6KBxP1cgRc7ncpTIjpo2uzWjJ057depX8noYf2j
        wwL2BqPy6jGGxa1pbqO70tN1UAL/6HYggWjpwJCQvAe76JaghxSHZ/fi3f/1f6wZMYvG5Jg3A/28o
        CHcxXxtGbDz97ub+WHuCMoMjoWdY/hWVl1YFGA7KcHxQCZDaYfwN4k3QZ/PYzvp+Alpn2iVW/j6/v
        ayHcwh7/x4Tr/esG3eyTR23FFiaCbR69ckPJww1hI0IqGEchSuSOsoH2GXuUwb9iNHGjaMNrWAO7j
        NhyFW2jA==;
Received: from noodles by the.earth.li with local (Exim 4.89)
        (envelope-from <noodles@earth.li>)
        id 1gHcHO-0005Qh-SR; Tue, 30 Oct 2018 22:14:30 +0000
Date:   Tue, 30 Oct 2018 22:14:30 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCHv2] ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130
Message-ID: <20181030221430.wu5cxicyf4ub2boa@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mapleboard MP130 is a single board computer based on the Allwinner
H3 SoC, with all schematics freely available. The Lite version includes
1GB main memory and 8GB eMMC.

https://www.mapleboard.org/en (still mostly in Chinese even when English
is selected)

This DTS is based upon the DTS shipped with the board which uses
mapleboard,mp130- prefixes instead of the allwinner,sun8i variants.

v2: Fold in review comments from Maxime Ripard

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-h3-mapleboard-mp130.dts    | 174 ++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..dcf1b9e7f71e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1035,6 +1035,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-beelink-x2.dtb \
 	sun8i-h3-libretech-all-h3-cc.dtb \
+	sun8i-h3-mapleboard-mp130.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
new file mode 100644
index 000000000000..13ad55be4454
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Centrum Embedded Systems, Jia-Bin Huang <jb@ces.com.tw>
+ * Copyright (C) 2018 Jonathan McDowell <noodles@earth.li>
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "MapleBoard MP130";
+	compatible = "mapleboard,mp130", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+
+		pwr_led {
+			label = "mp130:orange:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "mp130:orange:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	r_gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+
+		power {
+			label = "mp130:power";
+			linux,code = <KEY_POWER>;
+			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
+		};
+
+		user {
+			label = "mp130:user";
+			linux,code = <BTN_0>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"LINEIN", "Line In";
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
+&ehci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
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
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	leds_pio: led_pins {
+		pins = "PA15";
+		function = "gpio_out";
+	};
+};
+
+&r_pio {
+	leds_r_pio: led_pins {
+		pins = "PL10";
+		function = "gpio_out";
+	};
+
+	sw_r_pio: key_pins {
+		pins = "PL3", "PL4";
+		function = "gpio_in";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	/* USB VBUS is always on */
+	status = "okay";
+};
-- 
2.19.1

