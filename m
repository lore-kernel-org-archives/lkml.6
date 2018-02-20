Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeBTRBy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:01:54 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:34018 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeBTRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:52 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ARM: dts: artpec: add node for hardware crypto accelerator
Date: Tue, 20 Feb 2018 18:00:49 +0100
Message-Id: <20180220170049.22809-9-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the hardware crypto acceleration used in the artpec6 SoC.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 8d02d210574a..c0bbdbc8c7ba 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -234,6 +234,12 @@
 		ranges;
 		dma-ranges;
 
+		crypto@f4264000 {
+			compatible = "axis,artpec6-crypto";
+			reg = <0xf4264000 0x4000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		dma0: dma@f8019000 {
 			compatible = "renesas,nbpfaxi64dmac8b16";
 			reg = <0xf8019000 0x400>;
-- 
2.14.2
