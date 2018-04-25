Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeDYM4R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:56:17 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:11951 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeDYMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:55:56 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-doc@vger.kernel.org>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH v3 12/15] ARM: dts: dra76-evm: Add wilink8 wlan support
Date: Wed, 25 Apr 2018 18:24:46 +0530
Message-ID: <20180425125449.19755-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishal Mahaveer <vishalm@ti.com>

Add support for WLAN using wilink8 module. On dra76-evm, MMC4 is
used for connecting to wilink8 module.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb96405d06..ad154c7b0632 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -42,6 +42,16 @@
 		regulator-boot-on;
 	};
 
+	vio_3v6: fixedregulator-vio_3v6 {
+		compatible = "regulator-fixed";
+		regulator-name = "vio_3v6";
+		regulator-min-microvolt = <3600000>;
+		regulator-max-microvolt = <3600000>;
+		vin-supply = <&vsys_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_3v3: fixedregulator-vsys3v3 {
 		/* Output of Cntlr A of TPS43351-Q1 on dra76-evm */
 		compatible = "regulator-fixed";
@@ -81,6 +91,16 @@
 		vin-supply = <&smps5_reg>;
 	};
 
+	vmmcwl_fixed: fixedregulator-mmcwl {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcwl_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio5 8 0>;	/* gpio5_8 */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	vtt_fixed: fixedregulator-vtt {
 		compatible = "regulator-fixed";
 		regulator-name = "vtt_fixed";
@@ -331,6 +351,17 @@
 	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_conf>;
 };
 
+&mmc4 {
+	status = "okay";
+	vmmc-supply = <&vio_3v6>;
+	vqmmc-supply = <&vmmcwl_fixed>;
+	pinctrl-names = "default", "hs", "sdr12", "sdr25";
+	pinctrl-0 = <&mmc4_pins_hs &mmc4_iodelay_default_conf>;
+	pinctrl-1 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+	pinctrl-2 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+	pinctrl-3 = <&mmc4_pins_hs &mmc4_iodelay_manual1_conf>;
+};
+
 /* No RTC on this device */
 &rtc {
 	status = "disabled";
-- 
2.17.0
