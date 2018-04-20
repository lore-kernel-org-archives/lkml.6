Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbeDTP6O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:58:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59857 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755876AbeDTP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:57:06 -0400
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 4/5] ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
Date: Fri, 20 Apr 2018 17:54:43 +0200
Message-ID: <1524239684-25463-5-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
References: <1524239684-25463-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG3NODE6.st.com (10.75.127.73) To GPXDAG6NODE6.st.com
 (10.75.127.82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 3313005ee15c..888548ea9b5c 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -43,7 +43,7 @@
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
 				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
@@ -58,7 +58,7 @@
 		ehci0: usb@9a03e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a03e00 0x100>;
-			interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
@@ -75,7 +75,7 @@
 		ohci1: usb@9a83c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a83c00 0x100>;
-			interrupts = <GIC_SPI 181 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
 				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
@@ -90,7 +90,7 @@
 		ehci1: usb@9a83e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a83e00 0x100>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
@@ -202,7 +202,7 @@
 				reg = <0x8d04000 0x1000>;
 				reg-names = "hdmi-reg";
 				#sound-dai-cells = <0>;
-				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names	= "irq";
 				clock-names = "pix",
 					      "tmds",
@@ -254,7 +254,7 @@
 		bdisp0:bdisp@9f10000 {
 			compatible = "st,stih407-bdisp";
 			reg = <0x9f10000 0x1000>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "bdisp";
 			clocks = <&clk_s_c0_flexgen CLK_IC_BDISP_0>;
 		};
@@ -263,8 +263,8 @@
 			compatible = "st,st-hva";
 			reg = <0x8c85000 0x400>, <0x6000000 0x40000>;
 			reg-names = "hva_registers", "hva_esram";
-			interrupts = <GIC_SPI 58 IRQ_TYPE_NONE>,
-				     <GIC_SPI 59 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_hva";
 			clocks = <&clk_s_c0_flexgen CLK_HVA>;
 		};
@@ -292,7 +292,7 @@
 			reg = <0x94a087c 0x64>;
 			clocks = <&clk_sysin>;
 			clock-names = "cec-clk";
-			interrupts = <GIC_SPI 140 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cec-irq";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_cec0_default>;
-- 
1.9.1
