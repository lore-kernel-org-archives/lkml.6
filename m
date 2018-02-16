Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeBPSot (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:44:49 -0500
Received: from chicot.dit.umontreal.ca ([132.204.13.19]:51662 "EHLO
        chicot.dit.umontreal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeBPSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:44:31 -0500
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
Subject: [PATCH] ARM: dts: sun7i: Enable HDMI support on the Banana Pi
Message-ID: <jwvbmgoapat.fsf-monnier@gnu.org>
Date: Fri, 16 Feb 2018 11:16:04 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 5
X-NAI-Spam-Score: 0
X-NAI-Spam-Rules: 2 Rules triggered
        EDT_SA_DN_PASS=0, RV6224=0
X-NAI-Spam-Version: 2.3.0.9418 : core <6224> : inlines <6404> : streams
 <1779159> : uri <2593957>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Monnier <monnier@iro.umontreal.ca>

Enable the display pipeline and HDMI output

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 88a1c2363c6c..45da8a282288 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -63,6 +63,17 @@
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
@@ -109,6 +120,10 @@
 		>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -130,6 +145,16 @@
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
