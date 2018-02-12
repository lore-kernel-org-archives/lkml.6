Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeBLOoF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:44:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31405 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754354AbeBLOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:44:00 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 11/12] ARM: dts: STi: Move clk_sysin clock ouside soc node
Date: Mon, 12 Feb 2018 15:43:09 +0100
Message-ID: <1518446590-16800-12-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

As clk_sysin node describes the external oscillator, there is no
reason to put it into soc node.
This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clk-sysin missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ move clk_sys_in outside soc node

 arch/arm/boot/dts/stih407-clock.dtsi | 18 +++++++++---------
 arch/arm/boot/dts/stih410-clock.dtsi | 20 ++++++++++----------
 arch/arm/boot/dts/stih418-clock.dtsi | 20 ++++++++++----------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 1bba47e06ebe..f4e21e2234c9 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -7,21 +7,21 @@
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
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs@0 {
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 41fb1a910d49..9481f8769e8a 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -7,6 +7,16 @@
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
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,16 +25,6 @@
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
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs@0 {
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 50413eabe73a..9e3790198f51 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -7,6 +7,16 @@
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
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -15,16 +25,6 @@
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
 		 * ARM Peripheral clock for timers
 		 */
 		arm_periph_clk: clk-m-a9-periphs@0 {
-- 
1.9.1
