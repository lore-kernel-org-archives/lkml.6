Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033023AbeBONqx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:46:53 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:56090 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031806AbeBONqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:46:52 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] ARM: sun7i: dt: Add Mali node
Date: Thu, 15 Feb 2018 14:46:02 +0100
Message-Id: <1518702362-115625-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A20 has an ARM Mali 400 GPU, so add binding to our DT.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c4ed153d..1524ccb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1225,6 +1225,31 @@
 			#size-cells = <0>;
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c50000 0x10000>;
-- 
2.7.4
