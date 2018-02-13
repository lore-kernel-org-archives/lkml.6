Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeBMMys (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:54:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1627 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935220AbeBMMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:45 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 08/11] ARM: dts: STi: Add fake reg property for usb2_picophyX nodes
Date: Tue, 13 Feb 2018 13:53:34 +0100
Message-ID: <1518526417-11919-9-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add fake reg property for usb2_picophy nodes.
This allows to fix the following warning when compiling dtb
with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ none
v2: _ add a fake reg property to node without reg property.


 arch/arm/boot/dts/stih407-family.dtsi | 3 ++-
 arch/arm/boot/dts/stih410-b2120.dts   | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts   | 4 ++--
 arch/arm/boot/dts/stih410.dtsi        | 6 ++++--
 arch/arm/boot/dts/stih418.dtsi        | 6 ++++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 00a3838236d1..5df827b00eb6 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -385,8 +385,9 @@
 			status = "disabled";
 		};
 
-		usb2_picophy0: phy1 {
+		usb2_picophy0: phy1@0 {
 			compatible = "st,stih407-usb2-phy";
+			reg = <0 0>;
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0x100 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 23199b1b0991..d1d908b9e34c 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -37,11 +37,11 @@
 			sd-uhs-ddr50;
 		};
 
-		usb2_picophy1: phy2 {
+		usb2_picophy1: phy2@0 {
 			status = "okay";
 		};
 
-		usb2_picophy2: phy3 {
+		usb2_picophy2: phy3@0 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index cea5c840ca9f..8bcd58118dba 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -127,11 +127,11 @@
 			status = "okay";
 		};
 
-		usb2_picophy1: phy2 {
+		usb2_picophy1: phy2@0 {
 			status = "okay";
 		};
 
-		usb2_picophy2: phy3 {
+		usb2_picophy2: phy3@0 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 815df2f7c103..bfbc73743b29 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -16,8 +16,9 @@
 	};
 
 	soc {
-		usb2_picophy1: phy2 {
+		usb2_picophy1: phy2@0 {
 			compatible = "st,stih407-usb2-phy";
+			reg = <0 0>;
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0xf8 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
@@ -27,8 +28,9 @@
 			status = "disabled";
 		};
 
-		usb2_picophy2: phy3 {
+		usb2_picophy2: phy3@0 {
 			compatible = "st,stih407-usb2-phy";
+			reg = <0 0>;
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0xfc 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index e6525ab4d9bb..0efb3cd6a86e 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -30,8 +30,9 @@
 	};
 
 	soc {
-		usb2_picophy1: phy2 {
+		usb2_picophy1: phy2@0 {
 			compatible = "st,stih407-usb2-phy";
+			reg = <0 0>;
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0xf8 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
@@ -39,8 +40,9 @@
 			reset-names = "global", "port";
 		};
 
-		usb2_picophy2: phy3 {
+		usb2_picophy2: phy3@0 {
 			compatible = "st,stih407-usb2-phy";
+			reg = <0 0>;
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0xfc 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-- 
1.9.1
