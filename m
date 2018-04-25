Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756030AbeDYRku (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:40:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36097 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755622AbeDYRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:40:05 -0400
X-Google-Smtp-Source: AB8JxZr9sQHOpi4lQNZC+QvURv8zoHyITBQP7nQIHXjrsTO0fwBrgzTVMIlme2v3GLTaC3z+WFKtqg==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/4] ARM: dts: i.MX6: imx6dl-mamoj: Add usb host and device support
Date: Wed, 25 Apr 2018 23:09:32 +0530
Message-Id: <20180425173932.7213-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425173932.7213-1-jagan@amarulasolutions.com>
References: <20180425173932.7213-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add USB host and device support for BTicino i.MX6DL Mamoj board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-mamoj.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 5034b086035f..a727e1471006 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -134,6 +134,17 @@
 		vin-supply = <&reg_lcd_vgl>;
 	};
 
+	reg_usb_host: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbhost-vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhost>;
+		regulator-min-microvolt = <50000000>;
+		regulator-max-microvolt = <50000000>;
+		gpio = <&gpio6 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1807";
@@ -297,6 +308,16 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_host>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -428,6 +449,12 @@
 		>;
 	};
 
+	pinctrl_usbhost: usbhost {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x4001b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
-- 
2.14.3
