Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeBPUw7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:52:59 -0500
Received: from chene.dit.umontreal.ca ([132.204.246.20]:45024 "EHLO
        chene.dit.umontreal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeBPUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:52:57 -0500
From: Stefan Monnier <monnier@IRO.UMontreal.CA>
To: Maxime Ripard <maxime.ripard@free-electrons.com> (maintainer:ARM/Allwinner
        sunXi SoC support)
Cc: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
        FLATTENED DEVICE TREE BINDINGS),
        Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND
        FLATTENED DEVICE TREE BINDINGS),
        Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT),
        Chen-Yu Tsai <wens@csie.org> (maintainer:ARM/Allwinner sunXi SoC
        support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: sun7i: Enable HDMI support on the Orange Pi mini
Message-ID: <jwvr2pk8xrb.fsf-monnier+diro@gnu.org>
Date: Fri, 16 Feb 2018 15:52:09 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 5
X-NAI-Spam-Score: 0
X-NAI-Spam-Rules: 2 Rules triggered
        EDT_SA_DN_PASS=0, RV6224=0
X-NAI-Spam-Version: 2.3.0.9418 : core <6224> : inlines <6405> : streams
 <1779177> : uri <2594061>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Monnier <monnier@iro.umontreal.ca>

Enable the display pipeline and HDMI output for the Orange Pi mini

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 7af4c8fc1865..ce02ab532bc8 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -61,6 +61,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
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
 		pinctrl-names = "default";
@@ -98,6 +109,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -119,6 +134,16 @@
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
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
