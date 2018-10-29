Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFB62082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFB62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeJ2Lw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:52:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14723 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729129AbeJ2Lw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:52:26 -0400
X-UUID: 4a3db0faf6844c40a3a74248af303f89-20181029
X-UUID: 4a3db0faf6844c40a3a74248af303f89-20181029
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 725315670; Mon, 29 Oct 2018 11:05:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Oct 2018 11:05:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 11:05:14 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <biao.huang@mediatek.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Subject: [PATCH 2/2] dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712 DWMAC
Date:   Mon, 29 Oct 2018 11:04:54 +0800
Message-ID: <1540782294-27721-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 406B5756FE8E0221FFB956AE1E26D25AE3E090EC4D3D5B276CE6C4187304936A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds the device tree binding documentation for the MediaTek DWMAC
found on MediaTek MT2712.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.txt     |   49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
new file mode 100644
index 0000000..8baf0e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
@@ -0,0 +1,49 @@
+MediaTek DWMAC glue layer controller
+
+This file documents platform glue layer for stmmac.
+Please see stmmac.txt for the other unchanged properties.
+
+The device node has following properties.
+
+Required properties:
+- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
+- reg:  Address and length of the register set for the device
+- interrupts:  Should contain the MAC interrupts
+- interrupt-names: Should contain a list of interrupt names corresponding to
+	the interrupts in the interrupts property, if available.
+	Should be "macirq" for the main MAC IRQ
+- clocks: Must contain a phandle for each entry in clock-names.
+- clock-names: the name of the clock listed in the clocks property. These are
+	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
+	for MT2712 SoC
+- mac-address: See ethernet.txt in the same directory
+- phy-mode: See ethernet.txt in the same directory
+
+Example:
+
+	eth: ethernet@1101c000 {
+		compatible = "mediatek,mt2712-gmac";
+		reg = <0 0x1101c000 0 0x1300>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		phy-mode ="rgmii-id";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_ext",
+			      "mac_parent",
+			      "ptp_ref",
+			      "ptp_parent",
+			      "ptp_top";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHERPLL_125M>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
+			 <&topckgen CLK_TOP_APLL1_D3>,
+			 <&topckgen CLK_TOP_APLL1>;
+		snps,txpbl = <32>;
+		snps,rxpbl = <32>;
+		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
+		snps,reset-active-low;
+	};
-- 
1.7.9.5

