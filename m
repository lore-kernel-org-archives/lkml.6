Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBDRzP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:55:15 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37798 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeBDRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:54:52 -0500
X-Google-Smtp-Source: AH8x225ph7moTE4IPGTwanR2f7u1n3WC/kg+F/gS2Z3cYXw/kazDR6gQ4F3/750Q6LAb1J+DEnVMeg==
From: Jagan Teki <jagannadh.teki@gmail.com>
X-Google-Original-From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/7] ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
Date: Sun,  4 Feb 2018 23:19:26 +0530
Message-Id: <1517766571-409-3-git-send-email-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use ampire,am-800480aytzqw-00h LVDS timings from
panel-simple instead hard coding the same in dts.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 arch/arm/boot/dts/imx6q-icore.dts    | 31 +++++++++++++++++--------------
 arch/arm/boot/dts/imx6qdl-icore.dtsi |  2 +-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 5613dd9..c8e464e 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -48,6 +48,17 @@
 / {
 	model = "Engicam i.CoreM6 Quad/Dual Starter Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -71,22 +82,14 @@
 	status = "okay";
 
 	lvds-channel@0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
+		reg = <0>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <60000000>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <30>;
-				hfront-porch = <30>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <64>;
-				vsync-len = <20>;
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index a1b469c..5fd9e00 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -49,7 +49,7 @@
 		reg = <0x10000000 0x80000000>;
 	};
 
-	backlight {
+	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm3 0 100000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
-- 
2.7.4
