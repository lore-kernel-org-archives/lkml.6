Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3424C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E4820848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E4820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLCLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46067 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbeLCLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:13 -0500
X-UUID: 9cd2eccea8954489abae62ad8260c66d-20181203
X-UUID: 9cd2eccea8954489abae62ad8260c66d-20181203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 714875319; Mon, 03 Dec 2018 19:36:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:26 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:26 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 4/8] arm64: dts: add spi nodes for MT2712
Date:   Mon, 3 Dec 2018 19:35:58 +0800
Message-ID: <1543836962-18293-5-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E2A0513212962A709977EADCA740F84B8B21384915524F0B04FB52814DD1B4F42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 7bac8b6..4843376 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -463,6 +463,19 @@
 		status = "disabled";
 	};
 
+	spi0: spi@1100a000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
 	i2c3: i2c@11010000 {
 		compatible = "mediatek,mt2712-i2c";
 		reg = <0 0x11010000 0 0x90>,
@@ -508,6 +521,58 @@
 		status = "disabled";
 	};
 
+	spi2: spi@11015000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11015000 0 0x100>;
+		interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI2>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi3: spi@11016000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11016000 0 0x100>;
+		interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI3>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi4: spi@10012000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x10012000 0 0x100>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&infracfg CLK_INFRA_AO_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi5: spi@11018000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11018000 0 0x100>;
+		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI5>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
 	uart4: serial@11019000 {
 		compatible = "mediatek,mt2712-uart",
 			     "mediatek,mt6577-uart";
-- 
1.9.1

