Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeBUJAt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:00:49 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:43314 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBUJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:00:47 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] ARM: dts: artpec: add node for hardware crypto accelerator
Date: Wed, 21 Feb 2018 10:00:00 +0100
Message-Id: <20180221090000.18091-9-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180221090000.18091-1-niklas.cassel@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
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
index b7720be8afb1..3e4115c2cd75 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -232,6 +232,12 @@
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
