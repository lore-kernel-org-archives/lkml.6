Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C488C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F920834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8F920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLCLhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53448 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726369AbeLCLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:22 -0500
X-UUID: d31003e3a2524ceb9f84b818aff93692-20181203
X-UUID: d31003e3a2524ceb9f84b818aff93692-20181203
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 119335718; Mon, 03 Dec 2018 19:36:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:32 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:32 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Subject: [PATCH 8/8] arm64: dts: add pcie nodes for MT2712
Date:   Mon, 3 Dec 2018 19:36:02 +0800
Message-ID: <1543836962-18293-9-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0BFAFADDB01FA537091C5B19D1297478478762E62F69B7E15D3AC1B36A88AEFD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patch add device node for mt2712 pcie.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e8afb54..976d92a 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -791,6 +791,69 @@
 		};
 	};
 
+	pcie: pcie@11700000 {
+		compatible = "mediatek,mt2712-pcie";
+		device_type = "pci";
+		reg = <0 0x11700000 0 0x1000>,
+		      <0 0x112ff000 0 0x1000>;
+		reg-names = "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
+			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
+			 <&pericfg CLK_PERI_PCIE0>,
+			 <&pericfg CLK_PERI_PCIE1>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
+		phys = <&u3port0 PHY_TYPE_PCIE>, <&u3port1 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy0", "pcie-phy1";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
+
+		pcie0: pcie@0,0 {
+			device_type = "pci";
+			status = "disabled";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1,0 {
+			device_type = "pci";
+			status = "disabled";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
 	mfgcfg: syscon@13000000 {
 		compatible = "mediatek,mt2712-mfgcfg", "syscon";
 		reg = <0 0x13000000 0 0x1000>;
-- 
1.9.1

