Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeDYM6t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:58:49 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61795 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754023AbeDYMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:55:41 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-doc@vger.kernel.org>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 08/15] ARM: dts: am574x-idk: Add pinmux configuration for MMC
Date: Wed, 25 Apr 2018 18:24:42 +0530
Message-ID: <20180425125449.19755-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Include dra76x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for am574x SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in am574x-idk.dts.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am574x-idk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index 41e12a382d2f..500235e6d1c6 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "dra76x.dtsi"
+#include "dra76x-mmc-iodelay.dtsi"
 #include "am572x-idk-common.dtsi"
 
 / {
@@ -20,3 +21,21 @@
 		spi-max-frequency = <96000000>;
 	};
 };
+
+&mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_default>;
+	pinctrl-3 = <&mmc1_pins_hs>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_conf>;
+	pinctrl-6 = <&mmc1_pins_ddr50 &mmc1_iodelay_sdr104_conf>;
+};
+
+&mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_default>;
+	pinctrl-2 = <&mmc2_pins_default>;
+};
-- 
2.17.0
