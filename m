Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeEHNVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:21:03 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:56821 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755193AbeEHNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:20:23 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>
CC: <bcousson@baylibre.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH 3/4] ARM: dts: am437x-epos-evm: Fixup (again) tps65218 irq type
Date: Tue, 8 May 2018 16:20:52 +0300
Message-ID: <20180508132053.5471-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508132053.5471-1-peter.ujfalusi@ti.com>
References: <20180508132053.5471-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the correct IRQ level fixed the WARN_ON(), but prevented the probe
of tps65218 as GIC_SPI does not support LEVEL_LOW (?)

Use LEVEL_HIGH as it looks to be the accurate one since the INTn of TPS is
connected to NMIn of the SoC.

Fixes: 7a53a34622da ("ARM: dts: am437x-epos-evm: Correct tps65218 irq type")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 7a5b06fb2cff..6502d3397653 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -595,7 +595,7 @@
 	tps65218: tps65218@24 {
 		reg = <0x24>;
 		compatible = "ti,tps65218";
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_LOW>; /* NMIn */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* NMIn */
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
