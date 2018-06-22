Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E25C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD17A24260
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD17A24260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeFVNGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:06:02 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57797 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeFVNGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:06:00 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id E79276301B;
        Fri, 22 Jun 2018 13:05:49 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 7/7] arm64: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi
Date:   Fri, 22 Jun 2018 21:05:24 +0800
Message-Id: <20180622130524.57131-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On usual A64 board design the power of HDMI controller is connected to
DLDO1 of the AXP803 PMIC. If this regulator is shut down, the HDMI
output will be blank. Therefore the simplefb driver should keep this
regulator on.

Add the regulator to all currently available A64 boards' simplefb_hdmi
device node, if the board is capable of outputing HDMI.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Added HDMI regulator configuration on two A64 laptops (Pinebook and
  TERES-I).

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts       | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts        | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts         | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts          | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 0716b1441187..094cfed13df9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -296,6 +296,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e2dce48fa29a..98dbff19f5cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -195,6 +195,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 3b3081b10ecb..3f531393eaee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -214,6 +214,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index bf42690a3361..1221764f5719 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -191,6 +191,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index a75825798a71..1b9b92e541d2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -229,6 +229,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 /* On Euler connector */
 &spdif {
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 58253d6f9be1..104f8a6c6ca8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -263,6 +263,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index abe179de35d7..c21f2331add6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -134,6 +134,10 @@
 	regulator-name = "vcc-wifi";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index d9baab3dc96b..9065f30a758e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -253,6 +253,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dldo1>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.1

