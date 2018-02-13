Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964891AbeBMMzQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:55:16 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10483 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964842AbeBMMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:55:00 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 01/11] ARM: dts: STi: Fix bindings notation
Date: Tue, 13 Feb 2018 13:53:27 +0100
Message-ID: <1518526417-11919-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove leading 0x and 0s from bindings notation
Add missing unit-address and remove some which are useless.

This allows to fix several warnings like :

Warning (unit_address_vs_reg): Node XXXX has a reg or ranges property, but no unit name
Warning (simple_bus_reg): Node XXXX simple-bus unit address format error, expected "123456"
Warning (unit_address_vs_reg): Node XXXX has a unit name, but no reg property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3: _ Add Reviewed-by
v2: _ none

 arch/arm/boot/dts/stih407-b2120.dts    |  2 +-
 arch/arm/boot/dts/stih407-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stih407-family.dtsi  |  8 ++++----
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++++-----
 arch/arm/boot/dts/stih410-b2120.dts    |  2 +-
 arch/arm/boot/dts/stih410-b2260.dts    |  4 ++--
 arch/arm/boot/dts/stih410-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stih410-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/stih410.dtsi         |  2 +-
 arch/arm/boot/dts/stih418-b2199.dts    |  4 ++--
 arch/arm/boot/dts/stih418-clock.dtsi   |  4 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  4 ++--
 12 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index c8ad905d0309..cf8bc8a8b947 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index d0a24d9e517a..b882dcf3a649 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -83,7 +83,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0@13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -260,7 +260,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2@x9106000 {
+		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index cf3756976c39..1608c70f05a9 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -92,7 +92,7 @@
 		clocks = <&arm_periph_clk>;
 	};
 
-	l2: cache-controller {
+	l2: cache-controller@8762000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x08762000 0x1000>;
 		arm,data-latency = <3 3 3>;
@@ -389,7 +389,7 @@
 			reset-names = "global", "port";
 		};
 
-		miphy28lp_phy: miphy28lp@9b22000 {
+		miphy28lp_phy: miphy28lp {
 			compatible = "st,miphy28lp-phy";
 			st,syscfg = <&syscfg_core>;
 			#address-cells	= <1>;
@@ -803,7 +803,7 @@
 			status		= "okay";
 		};
 
-		st231_gp0: st231-gp0@0 {
+		st231_gp0: st231-gp0 {
 			compatible	= "st,st231-rproc";
 			memory-region	= <&gp0_reserved>;
 			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
@@ -816,7 +816,7 @@
 			mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
 		};
 
-		st231_delta: st231-delta@0 {
+		st231_delta: st231-delta {
 			compatible	= "st,st231-rproc";
 			memory-region	= <&delta_reserved>;
 			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a29090077fdf..53c6888d1fc0 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -45,7 +45,7 @@
 	};
 
 	soc {
-		pin-controller-sbc {
+		pin-controller-sbc@961f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-sbc-pinctrl";
@@ -369,7 +369,7 @@
 			};
 		};
 
-		pin-controller-front0 {
+		pin-controller-front0@920f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-front-pinctrl";
@@ -929,7 +929,7 @@
 			};
 		};
 
-		pin-controller-front1 {
+		pin-controller-front1@921f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-front-pinctrl";
@@ -962,7 +962,7 @@
 			};
 		};
 
-		pin-controller-rear {
+		pin-controller-rear@922f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-rear-pinctrl";
@@ -1157,7 +1157,7 @@
 			};
 		};
 
-		pin-controller-flash {
+		pin-controller-flash@923f080 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stih407-flash-pinctrl";
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9830be577433..37a42afa0dd1 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c663b70c43a7..faafc7b12951 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -19,7 +19,7 @@
 		linux,stdout-path = &uart1;
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x40000000>;
 	};
@@ -201,7 +201,7 @@
 			};
 		};
 
-		miphy28lp_phy: miphy28lp@9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port1: port@9b2a000 {
 				st,osc-force-ext;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index fde5df17f575..4df1b2187aa2 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -85,7 +85,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0@13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -272,7 +272,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2@x9106000 {
+		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stih410-pinctrl.dtsi b/arch/arm/boot/dts/stih410-pinctrl.dtsi
index b3e9dfc81c07..5ae1fd66c0b8 100644
--- a/arch/arm/boot/dts/stih410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih410-pinctrl.dtsi
@@ -10,7 +10,7 @@
 / {
 
 	soc {
-		pin-controller-rear {
+		pin-controller-rear@922f080 {
 
 			usb0 {
 				pinctrl_usb0: usb2-0 {
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 68b5ff91d6a7..e4b7e3ddc9ee 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -235,7 +235,7 @@
 					 <&clk_s_d2_quadfs 1>;
 			};
 
-			sti-hqvdp@9c000000 {
+			sti-hqvdp@9c00000 {
 				compatible = "st,stih407-hqvdp";
 				reg = <0x9C00000 0x100000>;
 				clock-names = "hqvdp", "pix_main";
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 4e6d915c85ff..5418a0ece659 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -18,7 +18,7 @@
 		linux,stdout-path = &sbc_serial0;
 	};
 
-	memory {
+	memory@40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0xc0000000>;
 	};
@@ -88,7 +88,7 @@
 			non-removable;
 		};
 
-		miphy28lp_phy: miphy28lp@9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port0: port@9b22000 {
 				st,osc-rdy;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 9a157c1a99b1..e68bf28bd038 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -85,7 +85,7 @@
 		 * Bootloader initialized system infrastructure clock for
 		 * serial devices.
 		 */
-		clk_ext2f_a9: clockgen-c0@13 {
+		clk_ext2f_a9: clockgen-c0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <200000000>;
@@ -265,7 +265,7 @@
 			clock-frequency = <0>;
 		};
 
-		clockgen-d2@x9106000 {
+		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
 
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 7f80c2c414c8..68783e8223b8 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -80,7 +80,7 @@
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
 
-		miphy28lp_phy: miphy28lp@9b22000 {
+		miphy28lp_phy: miphy28lp {
 
 			phy_port0: port@9b22000 {
 				st,osc-rdy;
@@ -126,7 +126,7 @@
 			clock-names	= "c8sectpfe";
 
 			/* tsin0 is TSA on NIMA */
-			tsin0: port@0 {
+			tsin0: port {
 				tsin-num	= <0>;
 				serial-not-parallel;
 				i2c-bus		= <&ssc2>;
-- 
1.9.1
