Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeESSdL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:33:11 -0400
Received: from mailout7.siol.net ([213.250.19.134]:34877 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752722AbeESSdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:33:05 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 15/15] ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
Date: Sat, 19 May 2018 20:31:27 +0200
Message-Id: <20180519183127.2718-16-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since HDMI can be considered as main output, most capable mixer is
connected to it (mixer0).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 27d9ccd0ef2f..66b492ad5847 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -58,6 +58,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
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
 	leds {
 		compatible = "gpio-leds";
 
@@ -93,6 +104,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -101,6 +116,22 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_tcon_tv0: endpoint {
+		remote-endpoint = <&tcon_tv0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -161,6 +192,12 @@
 	regulator-name = "vcc-wifi";
 };
 
+&mixer0_out {
+	mixer0_out_tcon_tv0: endpoint {
+		remote-endpoint = <&tcon_tv0_in_mixer0>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
@@ -195,6 +232,19 @@
 	status = "okay";
 };
 
+&tcon_tv0_in {
+	tcon_tv0_in_mixer0: endpoint {
+		remote-endpoint = <&mixer0_out_tcon_tv0>;
+	};
+};
+
+&tcon_tv0_out {
+	tcon_tv0_out_hdmi: endpoint@1 {
+		reg = <1>;
+		remote-endpoint = <&hdmi_in_tcon_tv0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.17.0
