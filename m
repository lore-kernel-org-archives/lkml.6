Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEOIy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:54:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52757 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752555AbeEOIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:52:38 -0400
X-UUID: 38731af7cb4a4192989bc315a3718eb5-20180515
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/7] dt-bindings: net: bluetooth: Add mediatek-bluetooth
Date: Tue, 15 May 2018 16:52:16 +0800
Message-ID: <e63b2e552987d56bc12b65c185a30258c24c0eac.1526374087.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526374087.git.sean.wang@mediatek.com>
References: <cover.1526374087.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add binding document for a SoC built-in device using MediaTek protocol.
Which could be found on MT7622 SoC or other similar MediaTek SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
new file mode 100644
index 0000000..1335429
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -0,0 +1,35 @@
+MediaTek SoC built-in Bluetooth Devices
+==================================
+
+This device is a serial attached device to BTIF device and thus it must be a
+child node of the serial node with BTIF. The dt-bindings details for BTIF
+device can be known via Documentation/devicetree/bindings/serial/8250.txt.
+
+Required properties:
+
+- compatible:	Must be one of
+		  "mediatek,mt7622-bluetooth"": for MT7622 SoC
+- clocks:	Should be the clock specifiers corresponding to the entry in
+		clock-names property.
+- clock-names:	Should contain "ref" entries.
+- power-domains: Phandle to the power domain that the device is part of
+
+Example:
+
+	btif: serial@1100c000 {
+		compatible = "mediatek,mt7622-btif",
+			     "mediatek,mtk-btif";
+		reg = <0 0x1100c000 0 0x1000>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_BTIF_PD>;
+		clock-names = "main";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+
+		bluetooth {
+			compatible = "mediatek,mt7622-bluetooth";
+			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
+			clocks = <&clk25m>;
+			clock-names = "ref";
+		};
+	};
-- 
2.7.4
