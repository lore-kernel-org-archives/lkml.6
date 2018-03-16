Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeCPR4p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:56:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52848 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeCPR4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:56:43 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 7/7] arm64: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi
Date: Sat, 17 Mar 2018 01:53:54 +0800
Message-Id: <20180316175354.21437-8-icenowy@aosc.io>
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On usual A64 board design the power of HDMI controller is connected to
DLDO1 of the AXP803 PMIC. If this regulator is shut down, the HDMI
output will be blank. Therefore the simplefb driver should keep this
regulator on.

Add the regulator to all currently available A64 boards' simplefb_hdmi
device node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts       | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts        | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts     | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 2250dec9974c..2fd343512d41 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -282,6 +282,10 @@
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
-- 
2.15.1
