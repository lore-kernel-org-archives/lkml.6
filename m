Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754497AbeDYN2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:28:07 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:10308 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeDYN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:28:02 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
Date: Wed, 25 Apr 2018 18:57:45 +0530
Message-ID: <20180425132746.13911-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425132746.13911-1-kishon@ti.com>
References: <20180425132746.13911-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sdhci-omap programming model based on the generic sdhci
library for programming the MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index da78c0034427..af6bf1301cf5 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -391,13 +391,10 @@
 		};
 
 		mmc0: mmc@23000000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23000000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 24 0>, <&edma1 25 0>;
-			dma-names = "tx", "rx";
 			bus-width = <4>;
-			ti,needs-special-reset;
 			no-1-8-v;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xb>;
@@ -407,13 +404,12 @@
 		};
 
 		mmc1: mmc@23100000 {
-			compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
+			compatible = "ti,k2g-sdhci";
 			reg = <0x23100000 0x400>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
-			dmas = <&edma1 26 0>, <&edma1 27 0>;
-			dma-names = "tx", "rx";
 			bus-width = <8>;
-			ti,needs-special-reset;
+			no-1-8-v;
+			non-removable;
 			max-frequency = <96000000>;
 			power-domains = <&k2g_pds 0xc>;
 			clocks = <&k2g_clks 0xc 1>, <&k2g_clks 0xc 2>;
-- 
2.17.0
