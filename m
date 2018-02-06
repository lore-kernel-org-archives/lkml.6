Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBFJ3u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:29:50 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45121 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeBFJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:29:06 -0500
X-Google-Smtp-Source: AH8x227ABwfQBWqQOkejH/ooeAV+MIvcrdG1UJCNT+LS/b9vRSyKMFneYJiBUChU08Oq/ezSHr08jA==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@spreadtrum.com, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 6/7] arm64: dts: Add DMA device node for Spreadtrum SC9860
Date: Tue,  6 Feb 2018 17:28:25 +0800
Message-Id: <ec74e9b83ec9b1c83f7ad54d0a80be68ce7bb2e0.1517908478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
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
