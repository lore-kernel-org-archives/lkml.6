Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032853AbeBONgW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:36:22 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59574 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031445AbeBONgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:36:19 -0500
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 3/5] ARM: dts: stm32: add sdmmc support for stm32h743
Date: Thu, 15 Feb 2018 14:34:55 +0100
Message-ID: <1518701697-14242-4-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
References: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds sdmmc support for stm32h743.
2×SD/SDIO/MMC interfaces (up to 125 MHz)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index bbfcbac..5e85538 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -217,6 +217,19 @@
 			};
 		};
 
+		sdmmc2: sdmmc@48022400 {
+			compatible = "st,stm32h7-sdmmc";
+			reg = <0x48022400 0x400>;
+			reg-names = "sdmmc";
+			interrupts = <124>;
+			clocks = <&rcc SDMMC2_CK>;
+			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <125000000>;
+			status = "disabled";
+		};
+
 		mdma1: dma@52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
@@ -227,6 +240,19 @@
 			dma-requests = <32>;
 		};
 
+		sdmmc1: sdmmc@52007000 {
+			compatible = "st,stm32h7-sdmmc";
+			reg = <0x52007000 0x1000>;
+			reg-names = "sdmmc";
+			interrupts = <49>;
+			clocks = <&rcc SDMMC1_CK>;
+			resets = <&rcc STM32H7_AHB3_RESET(SDMMC1)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <125000000>;
+			status = "disabled";
+		};
+
 		lptimer2: timer@58002400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
