Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A79C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610D82083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610D82083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeJBULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbeJBULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:40 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB024A67;
        Tue,  2 Oct 2018 13:28:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 102/228] arm64: dts: renesas: Fix VSPD registers range
Date:   Tue,  2 Oct 2018 06:23:19 -0700
Message-Id: <20181002132506.294099564@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit e21adc781bb45e810f1c396c4bc2c1624a4c25b9 ]

The VSPD and FCPVD nodes have overlapping register ranges, as the FCPVD
devices are mapped in the memory range usually used by the VSP LUT and
CLU, which are not present in the VSPD. Fix this by shortening the VSPD
registers range to 0x5000.

Fixes: 9f8573e38a0b ("arm64: dts: renesas: r8a7795: Add VSP instances")
Fixes: 291e0c4994d0 ("arm64: dts: r8a7795: Add support for R-Car H3 ES2.0")
Fixes: f06ffdfbdd90 ("arm64: dts: r8a7796: Add VSP instances")
Fixes: b4f92030d5d3 ("arm64: dts: renesas: r8a77970: add VSPD support")
Fixes: 295952a183d3 ("arm64: dts: renesas: r8a77995: add VSP instances")
Fixes: 85cb3229218a ("arm64: dts: renesas: r8a77965: Add VSP instances")
Reported-by: Simon Horman <horms+renesas@verge.net.au>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     |    6 +++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi     |    6 +++---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi    |    4 ++--
 arch/arm64/boot/dts/renesas/r8a77970.dtsi    |    2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi    |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -80,7 +80,7 @@
 
 	vspd3: vsp@fea38000 {
 		compatible = "renesas,vsp2";
-		reg = <0 0xfea38000 0 0x8000>;
+		reg = <0 0xfea38000 0 0x5000>;
 		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 620>;
 		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2530,7 +2530,7 @@
 
 		vspd0: vsp@fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2541,7 +2541,7 @@
 
 		vspd1: vsp@fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -2552,7 +2552,7 @@
 
 		vspd2: vsp@fea30000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea30000 0 0x8000>;
+			reg = <0 0xfea30000 0 0x5000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2212,7 +2212,7 @@
 
 		vspd0: vsp@fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2223,7 +2223,7 @@
 
 		vspd1: vsp@fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
@@ -2234,7 +2234,7 @@
 
 		vspd2: vsp@fea30000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea30000 0 0x8000>;
+			reg = <0 0xfea30000 0 0x5000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1397,7 +1397,7 @@
 
 		vspd0: vsp@fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
@@ -1416,7 +1416,7 @@
 
 		vspd1: vsp@fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -776,7 +776,7 @@
 
 		vspd0: vsp@fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -699,7 +699,7 @@
 
 		vspd0: vsp@fea20000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea20000 0 0x8000>;
+			reg = <0 0xfea20000 0 0x5000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
@@ -709,7 +709,7 @@
 
 		vspd1: vsp@fea28000 {
 			compatible = "renesas,vsp2";
-			reg = <0 0xfea28000 0 0x8000>;
+			reg = <0 0xfea28000 0 0x5000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;


