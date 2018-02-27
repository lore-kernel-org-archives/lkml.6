Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeB0KYD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:24:03 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60108 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbeB0KYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:24:00 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] arm64: dts: renesas: r8a77965: Add EtherAVB device node
Date: Tue, 27 Feb 2018 11:22:54 +0100
Message-Id: <1519726974-23160-11-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519726974-23160-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate the ethernet@e6800000 device node to enable Ethernet interface
for R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1 -> v2:
- Replace ALWAYS_ON power area identifier with numeric constant
v2 -> v3:
- Send as part of a dedicated series reworking "rgmii" properties in all
  mainline Renesas boards/SoC
- Add iommu dependencies
v3 -> v4:
- Remove iommu dependencies
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 43 ++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 8c9648a..1f25934 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -522,11 +522,48 @@
 		};
 
 		avb: ethernet@e6800000 {
+			compatible = "renesas,etheravb-r8a77965",
+				     "renesas,etheravb-rcar-gen3";
+			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15",
+					  "ch16", "ch17", "ch18", "ch19",
+					  "ch20", "ch21", "ch22", "ch23",
+					  "ch24";
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
 			#address-cells = <1>;
 			#size-cells = <0>;
-
-			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
-			/* placeholder */
+			status = "disabled";
 		};
 
 		csi20: csi2@fea80000 {
-- 
2.7.4
