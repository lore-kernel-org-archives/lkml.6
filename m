Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214FC20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214FC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLCLhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39339 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbeLCLhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:17 -0500
X-UUID: 61fa3bdee752427cbb03096412968724-20181203
X-UUID: 61fa3bdee752427cbb03096412968724-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 454374608; Mon, 03 Dec 2018 19:36:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:29 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:29 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 6/8] arm64: dts: add mmc nodes for MT2712
Date:   Mon, 3 Dec 2018 19:36:00 +0800
Message-ID: <1543836962-18293-7-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e9856fe..4f0aa65 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -611,6 +611,40 @@
 		status = "disabled";
 	};
 
+	mmc0: mmc@11230000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11230000 0 0x1000>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_0>,
+			 <&pericfg CLK_PERI_MSDC50_0_HCLK_EN>,
+			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>,
+			 <&pericfg CLK_PERI_MSDC50_0_EN>;
+		clock-names = "source", "hclk", "bus_clk", "source_cg";
+		status = "disabled";
+	};
+
+	mmc1: mmc@11240000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11240000 0 0x1000>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_1>,
+			 <&topckgen CLK_TOP_AXI_SEL>,
+			 <&pericfg CLK_PERI_MSDC30_1_EN>;
+		clock-names = "source", "hclk", "source_cg";
+		status = "disabled";
+	};
+
+	mmc2: mmc@11250000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11250000 0 0x1000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_2>,
+			 <&topckgen CLK_TOP_AXI_SEL>,
+			 <&pericfg CLK_PERI_MSDC30_2_EN>;
+		clock-names = "source", "hclk", "source_cg";
+		status = "disabled";
+	};
+
 	ssusb: usb@11271000 {
 		compatible = "mediatek,mt2712-mtu3", "mediatek,mtu3";
 		reg = <0 0x11271000 0 0x3000>,
-- 
1.9.1

