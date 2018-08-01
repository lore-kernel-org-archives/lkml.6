Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ABCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D1520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D1520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeHAT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:57:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405665AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3C22510AC;
        Wed,  1 Aug 2018 17:03:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 188/336] ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
Date:   Wed,  1 Aug 2018 18:48:43 +0200
Message-Id: <20180801165036.293080068@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrice Chotard <patrice.chotard@st.com>

[ Upstream commit fd827d0ec86bce8d421423ad2c4add84aa23e1b9 ]

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/stih410.dtsi |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -43,7 +43,7 @@
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-			interrupts = <GIC_SPI 180 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
 				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT0_POWERDOWN>,
@@ -58,7 +58,7 @@
 		ehci0: usb@9a03e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a03e00 0x100>;
-			interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
@@ -75,7 +75,7 @@
 		ohci1: usb@9a83c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a83c00 0x100>;
-			interrupts = <GIC_SPI 181 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
 				 <&clk_s_c0_flexgen CLK_RX_ICN_DISP_0>;
 			resets = <&powerdown STIH407_USB2_PORT1_POWERDOWN>,
@@ -90,7 +90,7 @@
 		ehci1: usb@9a83e00 {
 			compatible = "st,st-ehci-300x";
 			reg = <0x9a83e00 0x100>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
@@ -202,7 +202,7 @@
 				reg = <0x8d04000 0x1000>;
 				reg-names = "hdmi-reg";
 				#sound-dai-cells = <0>;
-				interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names	= "irq";
 				clock-names = "pix",
 					      "tmds",
@@ -254,7 +254,7 @@
 		bdisp0:bdisp@9f10000 {
 			compatible = "st,stih407-bdisp";
 			reg = <0x9f10000 0x1000>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "bdisp";
 			clocks = <&clk_s_c0_flexgen CLK_IC_BDISP_0>;
 		};
@@ -263,8 +263,8 @@
 			compatible = "st,st-hva";
 			reg = <0x8c85000 0x400>, <0x6000000 0x40000>;
 			reg-names = "hva_registers", "hva_esram";
-			interrupts = <GIC_SPI 58 IRQ_TYPE_NONE>,
-				     <GIC_SPI 59 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "clk_hva";
 			clocks = <&clk_s_c0_flexgen CLK_HVA>;
 		};
@@ -292,7 +292,7 @@
 			reg = <0x94a087c 0x64>;
 			clocks = <&clk_sysin>;
 			clock-names = "cec-clk";
-			interrupts = <GIC_SPI 140 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cec-irq";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_cec0_default>;


