Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C22C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682232145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLRCmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:42:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10015 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbeLRCmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:42:33 -0500
X-UUID: 28ad668f78264d83a0b04bfc54222e9c-20181218
X-UUID: 28ad668f78264d83a0b04bfc54222e9c-20181218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1027768327; Tue, 18 Dec 2018 10:42:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 10:42:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:42:26 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <biao.huang@mediatek.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Subject: [PATCH 1/2] dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712 DWMAC
Date:   Tue, 18 Dec 2018 10:42:16 +0800
Message-ID: <1545100937-16093-2-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
References: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7B8D261EC96FC0899EFE6A64779041C6E1BE97EFEAAFA524AA0318BD886D11442000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds the device tree binding documentation for the MediaTek DWMAC
found on MediaTek MT2712.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.txt     |   78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
new file mode 100644
index 0000000..9071063
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
@@ -0,0 +1,78 @@
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
+- clock-names: The name of the clock listed in the clocks property. These are
+	"axi", "apb", "mac_main", "ptp_ref" for MT2712 SoC
+- mac-address: See ethernet.txt in the same directory
+- phy-mode: See ethernet.txt in the same directory
+- mediatek,pericfg: A phandle to the syscon node that control ethernet
+	interface and timing delay.
+
+Optional properties:
+- mediatek,tx-delay-ps: TX clock delay macro value. Default is 0.
+	It should be defined for rgmii/rgmii-rxid/mii interface.
+- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
+	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
+Both delay properties need to be a multiple of 170 for rgmii interface,
+or will round down. Range 0~31*170.
+Both delay properties need to be a multiple of 550 for mii/rmii interface,
+or will round down. Range 0~31*550.
+
+- mediatek,rmii-rxc: boolean property, if present indicates that the rmii
+	reference clock, which is from external PHYs, is connected to RXC pin
+	on MT2712 SoC.
+	Otherwise, is connected to TXC pin.
+- mediatek,txc-inverse: boolean property, if present indicates that
+	1. tx clock will be inversed in mii/rgmii case,
+	2. tx clock inside MAC will be inversed relative to reference clock
+	   which is from external PHYs in rmii case, and it rarely happen.
+- mediatek,rxc-inverse: boolean property, if present indicates that
+	1. rx clock will be inversed in mii/rgmii case.
+	2. reference clock will be inversed when arrived at MAC in rmii case.
+- assigned-clocks: mac_main and ptp_ref clocks
+- assigned-clock-parents: parent clocks of the assigned clocks
+
+Example:
+	eth: ethernet@1101c000 {
+		compatible = "mediatek,mt2712-gmac";
+		reg = <0 0x1101c000 0 0x1300>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		phy-mode ="rgmii";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_main",
+			      "ptp_ref",
+			      "ptp_top";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clocks = <&topckgen CLK_TOP_ETHER_125M_SEL>,
+				  <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_ETHERPLL_125M>,
+					 <&topckgen CLK_TOP_APLL1_D3>;
+		mediatek,pericfg = <&pericfg>;
+		mediatek,tx-delay-ps = <1530>;
+		mediatek,rx-delay-ps = <1530>;
+		mediatek,rmii-rxc;
+		mediatek,txc-inverse;
+		mediatek,rxc-inverse;
+		snps,txpbl = <32>;
+		snps,rxpbl = <32>;
+		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
+		snps,reset-active-low;
+	};
-- 
1.7.9.5

