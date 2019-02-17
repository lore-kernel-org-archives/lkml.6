Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E7217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550411462;
	bh=q7kqbR42qHwAyYyclpzKvqEwQ2PQZJFvpMdKp5+g6/s=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=qa7EPTMRpU6OkH9TZ3nLeZdryo9wcn41L4mZysjihfDXF6qHM5onw5EgTOUkSkWrp
	 +nuqLSg4kK03q23AgdkcEXwbgaexWumi9gBb4emZwV3Pc04MJFBlJ1TTQEM9+lNkvl
	 TDwtHfTC8cvZi8YeZe/XIf5D44Qgaf0j9LQUPOZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBQNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:51:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8015 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbfBQNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:51:00 -0500
X-UUID: 215552f8ecc947c085a498ac76ed69c5-20190217
X-UUID: 215552f8ecc947c085a498ac76ed69c5-20190217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@kernel.org>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1171513622; Sun, 17 Feb 2019 21:50:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 21:50:51 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 21:50:51 +0800
From:   Ryder Lee <ryder.lee@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] dt-bindings: mediatek: update bindings for MT7629 SoC
Date:   Sun, 17 Feb 2019 21:50:30 +0800
Message-ID: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 62F34D0A1C1C7C9016F1E28AA7EAB233CBB20A03B91CD1E06D80D7E9F0D71AC62000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This updates bindings for MT7629 SoC, which includes very basic items
such as system timer, UART, sysirq and scpsys unit.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt     | 5 +++--
 Documentation/devicetree/bindings/serial/mtk-uart.txt                | 3 ++-
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt            | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index c5d5891..e8b3688 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -1,6 +1,6 @@
-+Mediatek MT65xx/MT67xx/MT81xx sysirq
+MediaTek sysirq
 
-Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
+MediaTek SOCs sysirq support controllable irq inverter for each GIC SPI
 interrupt.
 
 Required properties:
@@ -10,6 +10,7 @@ Required properties:
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
 	"mediatek,mt7623-sysirq", "mediatek,mt6577-sysirq": for MT7623
+	"mediatek,mt7629-sysirq", "mediatek,mt6577-sysirq": for MT7629
 	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
 	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
 	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 742cb47..4910f63 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -1,4 +1,4 @@
-* Mediatek Universal Asynchronous Receiver/Transmitter (UART)
+* MediaTek Universal Asynchronous Receiver/Transmitter (UART)
 
 Required properties:
 - compatible should contain:
@@ -13,6 +13,7 @@ Required properties:
   * "mediatek,mt6797-uart" for MT6797 compatible UARTS
   * "mediatek,mt7622-uart" for MT7622 compatible UARTS
   * "mediatek,mt7623-uart" for MT7623 compatible UARTS
+  * "mediatek,mt7629-uart" for MT7629 compatible UARTS
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index d6fe16f..9a88d418 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -23,6 +23,7 @@ Required properties:
 	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
 	- "mediatek,mt7623a-scpsys": For MT7623A SoC
+	- "mediatek,mt7629-scpsys", "mediatek,mt7622-scpsys": For MT7629 SoC
 	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
@@ -33,7 +34,7 @@ Required properties:
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
-	Required clocks for MT7622: "hif_sel"
+	Required clocks for MT7622 or MT7629: "hif_sel"
 	Required clocks for MT7622A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
-- 
1.9.1

