Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeBFJxd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:53:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39713 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752640AbeBFJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:19 -0500
X-UUID: 64320c3eeee7406cb9cf5fc2fbb863ca-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 03/16] arm64: dts: mt7622: add power domain controller device nodes
Date: Tue, 6 Feb 2018 17:52:52 +0800
Message-ID: <7f68b0b408401e36e120660009065fa5d9d38fc4.1517910489.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add power domain controller nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 73e5d62..81207e6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7622-clk.h>
+#include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/reset/mt7622-reset.h>
 
 / {
@@ -109,6 +110,20 @@
 		#reset-cells = <1>;
 	};
 
+	scpsys: scpsys@10006000 {
+		compatible = "mediatek,mt7622-scpsys",
+			     "syscon";
+		#power-domain-cells = <1>;
+		reg = <0 0x10006000 0 0x1000>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
+		infracfg = <&infracfg>;
+		clocks = <&topckgen CLK_TOP_HIF_SEL>;
+		clock-names = "hif_sel";
+	};
+
 	sysirq: interrupt-controller@10200620 {
 		compatible = "mediatek,mt7622-sysirq",
 			     "mediatek,mt6577-sysirq";
-- 
2.7.4
