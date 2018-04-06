Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756488AbeDFOF0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:05:26 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49543 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeDFOFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:05:24 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3] ARM: sun8i: v40: enable USB host ports for Banana Pi M2 Berry
Date: Fri,  6 Apr 2018 22:03:44 +0800
Message-Id: <20180406140344.9457-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
ports, and it's connected to the USB1 port of the SoC.

Enable it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3:
- Dropped OHCI node and added hub model comment in EHCI.

 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index a26d72c3f9b5..35859d8f3267 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -87,6 +87,11 @@
 	};
 };
 
+&ehci1 {
+	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -170,3 +175,8 @@
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
-- 
2.15.1
