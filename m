Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE63C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5AC20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="slZF7b7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5AC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeGIQrr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:47:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48296 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933433AbeGIQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:47:44 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w69GlJK2036422;
        Mon, 9 Jul 2018 11:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531154839;
        bh=tOvQ2RN2cXCW26zdbBUGJxXYhRAaAhzw0KovOOUfvUY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=slZF7b7/SsevA6bKSpefQpWo2eBtCGBgs5tUX/HpjEBk1VgnS4dIpqwv+/zKYYQch
         jak1B8s1xuwiveTahBiLzjJ2nKj/ljxSXm9p3i6oytrOiQnLE2/afZ/pxaMOGFj2eh
         ennku+sg2epofHk8NwtqHKfNSDQOL/SrZR1moY5w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69GlJuX012923;
        Mon, 9 Jul 2018 11:47:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 11:47:19 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 11:47:19 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w69GkpWG001873;
        Mon, 9 Jul 2018 11:47:16 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>, <sboyd@kernel.org>
Subject: [PATCH v5 6/6] ARM: dts: dra76x: Add MCAN node
Date:   Mon, 9 Jul 2018 22:18:41 +0530
Message-ID: <20180709164841.14182-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MCAN peripheral which supports both classic
CAN messages along with the new CAN-FD message.

Add MCAN node to evm and enable it with a maximum datarate of 5 mbps

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts |  6 ++++++
 arch/arm/boot/dts/dra76x.dtsi   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index c07f0051844d..0ac533784b11 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -436,3 +436,9 @@
 	phys = <&pcie1_phy>, <&pcie2_phy>;
 	phy-names = "pcie-phy0", "pcie-phy1";
 };
+
+&m_can0 {
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 5157cc431574..613e4dc0ed3e 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -26,6 +26,19 @@
 			ti,syss-mask = <1>;
 			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
 			clock-names = "fck";
+
+			m_can0: mcan@1a00 {
+				compatible = "bosch,m_can";
+				reg = <0x1a00 0x4000>, <0x0 0x18FC>;
+				reg-names = "m_can", "message_ram";
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "int0", "int1";
+				clocks = <&mcan_clk>, <&l3_iclk_div>;
+				clock-names = "cclk", "hclk";
+				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+			};
 		};
 	};
 
-- 
2.17.0

