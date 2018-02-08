Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeBHSCn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:02:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:29009 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752433AbeBHR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:58:59 -0500
X-UUID: 7336b5bc5b3e49d7ba5d0837c69f1a5b-20180209
From: <sean.wang@mediatek.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 1/5] dt-bindings: dmaengine: Add MediaTek High-Speed DMA controller bindings
Date: Fri, 9 Feb 2018 01:58:47 +0800
Message-ID: <8e5bfa200cf28056741034c5b32c9b68e1974b5f.1518110810.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518110810.git.sean.wang@mediatek.com>
References: <cover.1518110810.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Document the devicetree bindings for MediaTek High-Speed DMA controller
which could be found on MT7623 SoC or other similar Mediatek SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/dma/mtk-hsdma.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
new file mode 100644
index 0000000..4bb31735
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
@@ -0,0 +1,33 @@
+MediaTek High-Speed DMA Controller
+==================================
+
+This device follows the generic DMA bindings defined in dma/dma.txt.
+
+Required properties:
+
+- compatible:	Must be one of
+		  "mediatek,mt7622-hsdma": for MT7622 SoC
+		  "mediatek,mt7623-hsdma": for MT7623 SoC
+- reg:		Should contain the register's base address and length.
+- interrupts:	Should contain a reference to the interrupt used by this
+		device.
+- clocks:	Should be the clock specifiers corresponding to the entry in
+		clock-names property.
+- clock-names:	Should contain "hsdma" entries.
+- power-domains: Phandle to the power domain that the device is part of
+- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
+		in dmas property of a client device represents the channel
+		number.
+Example:
+
+        hsdma: dma-controller@1b007000 {
+		compatible = "mediatek,mt7623-hsdma";
+		reg = <0 0x1b007000 0 0x1000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
+		clock-names = "hsdma";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		#dma-cells = <1>;
+	};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
2.7.4
