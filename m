Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B72C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394358AbeKVVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:07:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61957 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390677AbeKVVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:07:52 -0500
X-UUID: cc58944a3b2f4a54a7bdc3fb3db0b0c3-20181122
X-UUID: cc58944a3b2f4a54a7bdc3fb3db0b0c3-20181122
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2044991465; Thu, 22 Nov 2018 18:28:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Nov 2018 18:28:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Nov 2018 18:28:56 +0800
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
Subject: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document for MediaTek MT2712 DWMAC
Date:   Thu, 22 Nov 2018 18:28:41 +0800
Message-ID: <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
index 0000000..0f8a915
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
+
+Optional properties:
+- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
+	It should be defined for rgmii/rgmii-rxid/mii interface.
+- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
+	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
+- mediatek,fine-tune: boolean property, if present indicates that fine delay
+	is selected for rgmii interface.
+	If present, tx-delay/rx-delay is 170+/-50ps per stage.
+	Else tx-delay/rx-delay of coarse delay macro is 0.55+/-0.2ns per stage.
+	This property do not apply to non-rgmii PHYs.
+	Only coarse-tune delay is supported for mii/rmii PHYs.
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
+		phy-mode ="rgmii-id";
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
+		mediatek,tx-delay = <9>;
+		mediatek,rx-delay = <9>;
+		mediatek,fine-tune;
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

