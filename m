Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935388AbeBMM5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:57:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46699 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935218AbeBMMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:44 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 06/11] ARM: dts: STi: Add fake reg property for remote processors
Date: Tue, 13 Feb 2018 13:53:32 +0100
Message-ID: <1518526417-11919-7-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

As st231-gp0, st231-delta are part of SoC, we add a fake reg
property instead of moving all these nodes outside soc node.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/st231-gp0 missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/st231-delta missing or empty reg/ranges property
arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/delta0 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/st231-gp0 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/st231-delta missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/delta0 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/st231-gp0 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/st231-delta missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/delta0 missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/st231-gp0 missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/st231-delta missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/delta0 missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none
v2: _ add a fake reg property to node without reg property


 arch/arm/boot/dts/stih407-family.dtsi | 9 ++++++---
 arch/arm/boot/dts/stih410.dtsi        | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c8dc659fd14e..5a0bad07da9e 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -805,8 +805,9 @@
 			status		= "okay";
 		};
 
-		st231_gp0: st231-gp0 {
+		st231_gp0: st231-gp0@0 {
 			compatible	= "st,st231-rproc";
+			reg		= <0 0>;
 			memory-region	= <&gp0_reserved>;
 			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
 			reset-names	= "sw_reset";
@@ -818,8 +819,9 @@
 			mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
 		};
 
-		st231_delta: st231-delta {
+		st231_delta: st231-delta@0 {
 			compatible	= "st,st231-rproc";
+			reg		= <0 0>;
 			memory-region	= <&delta_reserved>;
 			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
 			reset-names	= "sw_reset";
@@ -982,8 +984,9 @@
 			status = "disabled";
 		};
 
-		delta0 {
+		delta0@0 {
 			compatible = "st,st-delta";
+			reg = <0 0>;
 			clock-names = "delta",
 				      "delta-st231",
 				      "delta-flash-promip";
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index d9f964702933..815df2f7c103 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -274,7 +274,7 @@
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		delta0 {
+		delta0@0 {
 			compatible = "st,st-delta";
 			clock-names = "delta",
 				      "delta-st231",
-- 
1.9.1
