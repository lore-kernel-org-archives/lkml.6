Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964862AbeBMMzC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:55:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44783 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964797AbeBMMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:58 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 04/11] ARM: dts: STi: Add fake reg property for miphy28lp_phy
Date: Tue, 13 Feb 2018 13:53:30 +0100
Message-ID: <1518526417-11919-5-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add fake reg property to miphy28lp_phy.
This allows to fix the following warning when compiling
dtb with W=1 option:

arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
Node /soc/miphy28lp missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/miphy28lp missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /soc/miphy28lp missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/miphy28lp missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ none
v2: _ add a fake reg property to node without reg property

 arch/arm/boot/dts/stih407-family.dtsi | 3 ++-
 arch/arm/boot/dts/stih410-b2260.dts   | 2 +-
 arch/arm/boot/dts/stih418-b2199.dts   | 2 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 1608c70f05a9..e279cd07ba67 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -389,12 +389,13 @@
 			reset-names = "global", "port";
 		};
 
-		miphy28lp_phy: miphy28lp {
+		miphy28lp_phy: miphy28lp@0 {
 			compatible = "st,miphy28lp-phy";
 			st,syscfg = <&syscfg_core>;
 			#address-cells	= <1>;
 			#size-cells	= <1>;
 			ranges;
+			reg = <0 0>;
 
 			phy_port0: port@9b22000 {
 				reg = <0x9b22000 0xff>,
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 69c2abcaeda8..cea5c840ca9f 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -200,7 +200,7 @@
 			};
 		};
 
-		miphy28lp_phy: miphy28lp {
+		miphy28lp_phy: miphy28lp@0 {
 
 			phy_port1: port@9b2a000 {
 				st,osc-force-ext;
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 1ce38ce79952..be0bbb05c5ec 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -88,7 +88,7 @@
 			non-removable;
 		};
 
-		miphy28lp_phy: miphy28lp {
+		miphy28lp_phy: miphy28lp@0 {
 
 			phy_port0: port@9b22000 {
 				st,osc-rdy;
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 1fd3a2b5b938..66c1c6a5eb76 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -80,7 +80,7 @@
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
 
-		miphy28lp_phy: miphy28lp {
+		miphy28lp_phy: miphy28lp@0 {
 
 			phy_port0: port@9b22000 {
 				st,osc-rdy;
-- 
1.9.1
