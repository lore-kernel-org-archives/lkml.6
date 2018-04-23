Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbeDWGdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:33:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44324 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeDWGdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:33:10 -0400
X-Google-Smtp-Source: AIpwx4+Ba8zEO2T9Ts6jM4qka/vdQnFUZ/+oeQG/hy5plqD2u3VIo+m+aAZi1SsaIAyRuHg56mRSWA==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 3/3] arm64: allwinner: a64: bananapi-m64: add usb otg
Date: Mon, 23 Apr 2018 12:02:39 +0530
Message-Id: <20180423063239.3988-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180423063239.3988-1-jagan@amarulasolutions.com>
References: <20180423063239.3988-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb otg support for bananapi-m64 board,
- USB-ID connected with PH9
- USB-DRVVBUS controlled by N_VBUSEN pin from PMIC

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes for v6:
- Rebase on master 
Changes for v5:
- Kept reg_drivevbus node in alphabetical order.
- Collect Chen-Yu reviewed-by tag
Changes for v4:
- rebase on master
- tested otg host mode.
Changes for v3:
- Move the position of reg_drivevbus as per binding documentation.
Changes for v2:
- add drvvbus regulator
- add N_VBUSEN pin

 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 2250dec9974c..0716b1441187 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -86,6 +86,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -155,6 +159,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
@@ -167,6 +175,7 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
 
@@ -254,6 +263,11 @@
 	regulator-name = "vcc-wifi-io";
 };
 
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
 &reg_eldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
@@ -294,6 +308,13 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_vbus-supply = <&reg_drivevbus>;
 	status = "okay";
 };
-- 
2.14.3
