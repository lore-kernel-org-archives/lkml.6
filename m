Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeBFJyb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:54:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752719AbeBFJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:32 -0500
X-UUID: ab271e6af053436786d6394c497ed031-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 15/16] arm64: dts: mt7622: add High-Speed DMA device nodes
Date: Tue, 6 Feb 2018 17:53:04 +0800
Message-ID: <40c5f7cdd094166d4a3eb1f36f89cdb8edf6d243.1517910489.git.sean.wang@mediatek.com>
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

add High-Speed DMA (HSDMA) nodes

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6cf67dd..ed7ee78 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -712,6 +712,16 @@
 		#reset-cells = <1>;
 	};
 
+	hsdma: dma-controller@1b007000 {
+		compatible = "mediatek,mt7622-hsdma";
+		reg = <0 0x1b007000 0 0x1000>;
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ethsys CLK_ETH_HSDMA_EN>;
+		clock-names = "hsdma";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
+		#dma-cells = <1>;
+	};
+
 	eth: ethernet@1b100000 {
 		compatible = "mediatek,mt7622-eth",
 			     "mediatek,mt2701-eth",
-- 
2.7.4
