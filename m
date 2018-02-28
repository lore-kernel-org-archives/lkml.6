Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeB1KsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:48:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38234 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932145AbeB1KsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:48:13 -0500
X-Google-Smtp-Source: AG47ELs0WcElH7HOgITNLTBph5EFg3TuMRjjrJ+2nf89Tufsx6ky3zgrfCoBN/pub5zr8RIAsdqUAA==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@linaro.org, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [RESEND PATCH 6/7] arm64: dts: Add DMA device node for Spreadtrum SC9860
Date: Wed, 28 Feb 2018 18:47:09 +0800
Message-Id: <ea86e77a5d07111b8d2db5e0766c7200d7dfa8b8.1519814593.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum SC9860 platform has two DMA controllers, one is located
on the ap-ahb system, and another one is located on the agcp system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index f2cdf4d..66a881e 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -107,6 +107,23 @@
 			};
 		};
 
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			ap_dma: dma-controller@20100000 {
+				compatible = "sprd,sc9860-dma";
+				reg = <0 0x20100000 0 0x4000>;
+				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				#dma-channels = <32>;
+				clock-names = "enable";
+				clocks = <&apahb_gate CLK_DMA_EB>;
+			};
+		};
+
 		aon {
 			compatible = "simple-bus";
 			#address-cells = <2>;
@@ -151,6 +168,23 @@
 				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
 			};
 		};
+
+		agcp {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			agcp_dma: dma-controller@41580000 {
+				compatible = "sprd,sc9860-dma";
+				reg = <0 0x41580000 0 0x4000>;
+				#dma-cells = <1>;
+				#dma-channels = <32>;
+				clock-names = "enable", "ashb_eb";
+				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
+				       <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
+			};
+		};
 	};
 
 	ext_32k: ext_32k {
-- 
1.7.9.5
