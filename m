Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4391C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC520844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FC520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeGaS43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:56:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41378 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727135AbeGaS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:56:29 -0400
X-UUID: ae7bdcfe755c44a886be8e1a1045292a-20180801
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1383639138; Wed, 01 Aug 2018 01:15:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 1 Aug 2018 01:15:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 1 Aug 2018 01:15:02 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v7 1/3] dt-bindings: net: bluetooth: Add mediatek-bluetooth
Date:   Wed, 1 Aug 2018 01:14:58 +0800
Message-ID: <a3e8870dfb1302a60b041077a05c44faa42675b6.1533056925.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1533056925.git.sean.wang@mediatek.com>
References: <cover.1533056925.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 0000000..14ceb2a
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
+- compatible:	Must be
+		  "mediatek,mt7622-bluetooth": for MT7622 SoC
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

