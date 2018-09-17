Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680E8214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680E8214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeIQLzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:55:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34209 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbeIQLzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:55:45 -0400
X-UUID: bb5ee283a4f74590972a26b181c3b102-20180917
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 656744510; Mon, 17 Sep 2018 14:29:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 17 Sep 2018 14:29:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 17 Sep 2018 14:29:40 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <biao.huang@mediatek.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] dt-binding: mediatek: Add binding document for MediaTek GMAC
Date:   Mon, 17 Sep 2018 14:29:22 +0800
Message-ID: <1537165763-13112-2-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 499ECE32E55AE2F040A5228BA9BD48D77208C09178222832B9E0D12B0473E4272000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds the device tree binding documentation for the MediaTek
GMAC found on Mediatek MT2712.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-gmac.txt      |   45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-gmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-gmac.txt b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
new file mode 100644
index 0000000..14876ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
@@ -0,0 +1,45 @@
+MediaTek Gigabit Ethernet controller
+=========================================
+
+The gigabit ethernet controller can be found on MediaTek SoCs.
+
+* Ethernet controller node
+
+Required properties:
+- compatible: Should be
+	"mediatek,mt2712-eth": for MT2712 SoC
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the MAC interrupts
+- interrupt-names: the name of interrupt in the interrupts property. These are
+	"macirq": For MT2712 SoC
+- clocks: the clock used by the controller
+- clock-names: the names of the clock listed in the clocks property. These are
+	"axi", "apb", "mac_ext", "ptp", "ptp_parent", "ptp_top": For MT2712 SoC
+- mac-address: See ethernet.txt in the same directory
+- power-domains: phandle to the power domain that the ethernet is part of
+- phy-mode: See ethernet.txt file in the same directory.
+- reset-gpio: gpio number for phy reset.
+
+Example:
+
+eth: eth@1101c000 {
+		compatible = "mediatek,mt2712-eth";
+		reg = <0 0x1101c000 0 0x1200>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		phy-mode ="rgmii";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_ext",
+			      "ptp",
+			      "ptp_parent",
+			      "ptp_top";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
+			 <&topckgen CLK_TOP_APLL1_D3>,
+			 <&topckgen CLK_TOP_APLL1>;
+		reset-gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
+	};
-- 
1.7.9.5

