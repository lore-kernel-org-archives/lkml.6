Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeBTPOZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:14:25 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39289 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbeBTPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:14:21 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/19] ARM64: dts: r8a77965: Add SCIF device nodes
Date: Tue, 20 Feb 2018 16:12:16 +0100
Message-Id: <1519139541-18783-15-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCIF[0-5] device nodes for M3-N (r8a77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1 -> v2:
- Replace clock and power areas definition with raw numbers
- Fix compatible strings s/r8a7796/r8a77965/
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 85 ++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index b83dafc..3cb1a33 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -335,27 +335,100 @@
 		};
 
 		scif0: serial@e6e60000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
+			       <&dmac2 0x51>, <&dmac2 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 207>;
+			status = "disabled";
 		};
 
 		scif1: serial@e6e68000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
+			       <&dmac2 0x53>, <&dmac2 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 206>;
+			status = "disabled";
 		};
 
 		scif2: serial@e6e88000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 310>;
+			status = "disabled";
 		};
 
 		scif3: serial@e6c50000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 204>;
+			status = "disabled";
 		};
 
 		scif4: serial@e6c40000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 203>;
+			status = "disabled";
 		};
 
 		scif5: serial@e6f30000 {
-			/* placeholder */
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
+			       <&dmac2 0x5b>, <&dmac2 0x5a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 202>;
+			status = "disabled";
 		};
 
 		avb: ethernet@e6800000 {
-- 
2.7.4
