Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeDCHQN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:16:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58293 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754855AbeDCHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:16:07 -0400
X-UUID: 9557350225c342259d90566c8738db45-20180403
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 1/7] dt-bindings: net: bluetooth: Add mediatek-bluetooth
Date: Tue, 3 Apr 2018 15:15:51 +0800
Message-ID: <958f8a0ef0b557fdfcc02a1e86536e1f97a16e22.1522736996.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TM-AS-Result: No-8.527300-8.000000-10
X-TMASE-MatchedRID: bPjU8R/NGeExFdXyW/P+XXBRIrj8R47FuftX4oH7dy438zfZwr5+SMNU
        ZqLXyeOudZ+iOIKZPqKsMR/ATxTHjSWvhQBtQUwTyeVujmXuYYWagpdUd+Iwz+TcZ41tGho2ky5
        P5/5L4poWl6j129YpPj0ZAfBnk8YHy1ki1BndNJOerwYKAG2gtk+fvhSDkQoQxy4VLVnNTm+jxY
        yRBa/qJShNCXvA0fw+jaPj0W1qn0SyO81X3yak86ZgyB5OFWNtjEkrGb0ebEiplpQqsnxM9WXdB
        Yi5jyuCiRgvOTvS2v1+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.527300-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23760.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add binding document for a SoC built-in device using MediaTek protocol.
Which could be found on MT7622 SoC or other similar MediaTek SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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
