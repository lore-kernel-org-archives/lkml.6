Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935501AbeBLOqA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:46:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57499 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933739AbeBLOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:43:55 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 12/12] ARM: dts: STi: Remove unused clk_ext2f_a9 clock
Date: Mon, 12 Feb 2018 15:43:10 +0100
Message-ID: <1518446590-16800-13-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This clock node is unused, remove it.
This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ remove clk_ext2f_a9 node


 arch/arm/boot/dts/stih407-clock.dtsi | 11 -----------
 arch/arm/boot/dts/stih410-clock.dtsi | 11 -----------
 arch/arm/boot/dts/stih418-clock.dtsi | 11 -----------
 3 files changed, 33 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index f4e21e2234c9..d63d5e83e1ce 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -81,17 +81,6 @@
 			clock-mult = <1>;
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 9481f8769e8a..c061b67e09d2 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -83,17 +83,6 @@
 			clock-mult = <1>;
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 9e3790198f51..14cdeb5d1599 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -83,17 +83,6 @@
 			clock-mult = <1>;
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
-- 
1.9.1
