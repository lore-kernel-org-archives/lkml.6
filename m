Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964839AbeBMMy4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:54:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:65009 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S964797AbeBMMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:51 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 10/11] ARM: dts: STi: Update clocks node location
Date: Tue, 13 Feb 2018 13:53:36 +0100
Message-ID: <1518526417-11919-11-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Move:
 _ arm_periph_clk node as child of clockgen-a9@92b0000 node
 _ clk_m_a9_ext2f_div2 node as child of clk_s_c0_flexgen node
 _ clk-tmdsout-hdmi node outiside soc node

This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-periphs missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-m-a9-ext2f-div2s missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-tmdsout-hdmi missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ update location of some clocks node and remove the fake reg property
    _ merge previous patch 10 and 11
v2: _ add a fake reg property to node without reg property.


 arch/arm/boot/dts/stih407-clock.dtsi | 79 +++++++++++++++++-----------------
 arch/arm/boot/dts/stih410-clock.dtsi | 83 ++++++++++++++++++------------------
 arch/arm/boot/dts/stih418-clock.dtsi | 82 +++++++++++++++++------------------
 3 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index b882dcf3a649..084c02926f33 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -7,33 +7,27 @@
  */
 #include <dt-bindings/clock/stih407-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+	};
+
+	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-		};
-
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		arm_periph_clk: clk-m-a9-periphs {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-
-			clocks = <&clk_m_a9>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/*
 		 * A9 PLL.
 		 */
 		clockgen-a9@92b0000 {
@@ -62,21 +56,19 @@
 				 <&clockgen_a9_pll 0>,
 				 <&clk_s_c0_flexgen 13>,
 				 <&clk_m_a9_ext2f_div2>;
-		};
-
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
 
-			clocks = <&clk_s_c0_flexgen 13>;
 
-			clock-output-names = "clk-m-a9-ext2f-div2";
+			/*
+			 * ARM Peripheral clock for timers
+			 */
+			arm_periph_clk: clk-m-a9-periphs {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
 
-			clock-div = <2>;
-			clock-mult = <1>;
+				clocks = <&clk_m_a9>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
 		};
 
 		/*
@@ -204,6 +196,21 @@
 						 <CLK_EXT2F_A9>,
 						 <CLK_ICN_LMI>,
 						 <CLK_ICN_SBC>;
+
+				/*
+				 * ARM Peripheral clock for timers
+				 */
+				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+					#clock-cells = <0>;
+					compatible = "fixed-factor-clock";
+
+					clocks = <&clk_s_c0_flexgen 13>;
+
+					clock-output-names = "clk-m-a9-ext2f-div2";
+
+					clock-div = <2>;
+					clock-mult = <1>;
+				};
 			};
 		};
 
@@ -254,12 +261,6 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-		};
-
 		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 4df1b2187aa2..b2c814f1261a 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -7,6 +7,22 @@
  */
 #include <dt-bindings/clock/stih410-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+		clock-output-names = "CLK_SYSIN";
+	};
+
+	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,27 +31,6 @@
 		compatible = "st,stih410-clk", "simple-bus";
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-			clock-output-names = "CLK_SYSIN";
-		};
-
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		arm_periph_clk: clk-m-a9-periphs {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clocks = <&clk_m_a9>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/*
 		 * A9 PLL.
 		 */
 		clockgen-a9@92b0000 {
@@ -64,21 +59,16 @@
 				 <&clockgen_a9_pll 0>,
 				 <&clk_s_c0_flexgen 13>,
 				 <&clk_m_a9_ext2f_div2>;
-		};
-
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-
-			clocks = <&clk_s_c0_flexgen 13>;
-
-			clock-output-names = "clk-m-a9-ext2f-div2";
-
-			clock-div = <2>;
-			clock-mult = <1>;
+			/*
+			 * ARM Peripheral clock for timers
+			 */
+			arm_periph_clk: clk-m-a9-periphs {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clocks = <&clk_m_a9>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
 		};
 
 		/*
@@ -214,6 +204,21 @@
 						 <CLK_EXT2F_A9>,
 						 <CLK_ICN_LMI>,
 						 <CLK_ICN_SBC>;
+
+				/*
+				 * ARM Peripheral clock for timers
+				 */
+				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+					#clock-cells = <0>;
+					compatible = "fixed-factor-clock";
+
+					clocks = <&clk_s_c0_flexgen 13>;
+
+					clock-output-names = "clk-m-a9-ext2f-div2";
+
+					clock-div = <2>;
+					clock-mult = <1>;
+				};
 			};
 		};
 
@@ -266,12 +271,6 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-		};
-
 		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index e68bf28bd038..a192608ff689 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -7,6 +7,22 @@
  */
 #include <dt-bindings/clock/stih418-clks.h>
 / {
+	/*
+	 * Fixed 30MHz oscillator inputs to SoC
+	 */
+	clk_sysin: clk-sysin {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+		clock-output-names = "CLK_SYSIN";
+	};
+
+	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,27 +31,6 @@
 		compatible = "st,stih418-clk", "simple-bus";
 
 		/*
-		 * Fixed 30MHz oscillator inputs to SoC
-		 */
-		clk_sysin: clk-sysin {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <30000000>;
-			clock-output-names = "CLK_SYSIN";
-		};
-
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		arm_periph_clk: clk-m-a9-periphs {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clocks = <&clk_m_a9>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/*
 		 * A9 PLL.
 		 */
 		clockgen-a9@92b0000 {
@@ -64,21 +59,17 @@
 				 <&clockgen_a9_pll 0>,
 				 <&clk_s_c0_flexgen 13>,
 				 <&clk_m_a9_ext2f_div2>;
-		};
 
-		/*
-		 * ARM Peripheral clock for timers
-		 */
-		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-
-			clocks = <&clk_s_c0_flexgen 13>;
-
-			clock-output-names = "clk-m-a9-ext2f-div2";
-
-			clock-div = <2>;
-			clock-mult = <1>;
+			/*
+			 * ARM Peripheral clock for timers
+			 */
+			arm_periph_clk: clk-m-a9-periphs {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clocks = <&clk_m_a9>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
 		};
 
 		/*
@@ -207,6 +198,21 @@
 						     "clk-proc-mixer",
 						     "clk-proc-sc",
 						     "clk-avsp-hevc";
+
+				/*
+				 * ARM Peripheral clock for timers
+				 */
+				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+					#clock-cells = <0>;
+					compatible = "fixed-factor-clock";
+
+					clocks = <&clk_s_c0_flexgen 13>;
+
+					clock-output-names = "clk-m-a9-ext2f-div2";
+
+					clock-div = <2>;
+					clock-mult = <1>;
+				};
 			};
 		};
 
@@ -259,12 +265,6 @@
 					     "clk-s-d2-fs0-ch3";
 		};
 
-		clk_tmdsout_hdmi: clk-tmdsout-hdmi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-		};
-
 		clockgen-d2@9106000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x9106000 0x1000>;
-- 
1.9.1
