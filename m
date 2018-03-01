Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162222AbeCAVfh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:35:37 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33437 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162207AbeCAVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:35:34 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 16/16] ARM64: dts: sun50i: h5: Enable HDMI output on H5 boards
Date: Thu,  1 Mar 2018 22:34:42 +0100
Message-Id: <20180301213442.16677-17-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDMI output on all boards with HDMI connector.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 25 ++++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 25 ++++++++++++++++++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 25 ++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 58505fbc2667..98862c7c7258 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -67,6 +67,17 @@
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
 
@@ -121,6 +132,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -153,6 +168,16 @@
 	};
 };
 
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
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 803566608ed8..b75ca4d7d001 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -62,6 +62,17 @@
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
 
@@ -128,6 +139,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -160,6 +175,16 @@
 	};
 };
 
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
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index eda24d813282..53c8c11620e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
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
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
@@ -73,6 +84,20 @@
 	};
 };
 
+&de {
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
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-- 
2.16.2
