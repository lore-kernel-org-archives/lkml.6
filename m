Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09921477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="pko0gKTM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="Ank7lVtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD09921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJLR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:56:19 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:42168 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJLR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:56:18 -0400
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 42C5C5605EDA;
        Fri, 12 Oct 2018 13:24:33 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback10g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8QxSG6dMe0-OVRWOhGT;
        Fri, 12 Oct 2018 13:24:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339873;
        bh=oyzhB+d4cAfFvtNx1g6EVlsAy3ZN6OJXRO8j8QMrbUo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pko0gKTM8T7TuiEkvOByfIjLXM74kvq/5EVmB6jV275eRr55xcZqRR+4rIfofxAvU
         fzjW+YFTOLgfzY72Vk8jqxPhGi6LGqRcpgXiAGlrBW26aoOAexCbgxMlVJ1qhp1h1Q
         kZrQ6+7ivpA/JRNwdVBmFiQxIHRFHr6x2mbIhfxs=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id u1IFFFPc8s-OTJK1BOT;
        Fri, 12 Oct 2018 13:24:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339869;
        bh=oyzhB+d4cAfFvtNx1g6EVlsAy3ZN6OJXRO8j8QMrbUo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Ank7lVtrKmrewBCB7t1j/uALen+lMOswN7m3b/F02wUc/XAY0fkXth/LZVKqUS3Jf
         23qvdp16BAyrC3DKYSFKn2daoojnmoW46pmFO08eTGcF3lf2pH80CbsEHN3DR++g52
         Tp8U96wJJ0Po22XHNTEhbuc4UB6yUHOhlqbmwryU=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@emlid.com
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] arm64: dts: allwinner: new board - Emlid Neutis N5
Date:   Fri, 12 Oct 2018 13:23:58 +0300
Message-Id: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emlid Neutis N5 is a SoM based on Allwinner H5, has a WiFi & BT
module, DDR3 RAM and eMMC.

- add neutis n5 dtsi file for SoM needs
- add neutis devboard dts file
- add neutis devboard target to dtb makefile

Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 147 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  59 +++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 9ffa7a0..eefe74c 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
new file mode 100644
index 0000000..1086029
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR X11)
+ *
+ * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h5-emlid-neutis-n5.dtsi"
+
+/ {
+	model = "Emlid Neutis N5 Developer board";
+	compatible = "emlid,neutis-n5-devboard",
+		     "emlid,neutis-n5",
+		     "allwinner,sun50i-h5";
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
+	reg_usb0_vbus: usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>;   /* PL9 */
+		status = "okay";
+	};
+
+	vdd_cpux: gpio-regulator {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>; /* 4ms */
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+	};
+};
+
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"LINEIN", "Line In",
+		"MIC1", "Mic",
+		"MIC2", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
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
+&ohci0 {
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
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
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
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
new file mode 100644
index 0000000..b098658
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR X11)
+ *
+ * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h5.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		reset-gpios = <&pio 2 7 GPIO_ACTIVE_LOW>; /* PC7 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_LOW>;	/* PL5 */
+		interrupt-names = "host-wake";
+	};
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
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+};
-- 
2.7.4

