Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeB1Pr6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:47:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46821 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933437AbeB1Prv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:47:51 -0500
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 1/5] dt-bindings: mmc: document the stm32 sdmmc bindings
Date: Wed, 28 Feb 2018 16:47:20 +0100
Message-ID: <1519832844-28068-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

Document the binding for stm32 sdmmc controller.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
new file mode 100644
index 0000000..74d0bff
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
@@ -0,0 +1,35 @@
+* STMicroelectronics STM32 SDMMC controller
+
+The highspeed MMC host controller on STM32 soc family
+provides an interface for MMC, SD and SDIO types of memory cards.
+
+This file documents differences between the core properties described
+by mmc.txt and the properties used by the sdmmc driver.
+
+Required properties:
+ - compatible: Should be "st,stm32h7-sdmmc"
+ - reg: mmc controller base registers
+ - interrupts: Should contain the interrupt number
+ - clocks: Should contain phandle for the clock feeding the controller
+ - resets: Should contain phandle for the reset feeding the controller
+
+Optional property:
+- st,dir-output-high: Allow to select direction polarity of external voltage
+  transceiver (which manage data and command direction).
+  if set: Voltage transceiver IOs are driven as output when direction signals are high,
+  else: Voltage transceiver IOs are driven as output when direction signals are low.
+- st,neg-edge: generate data & command on sdmmc clock falling edge
+- st,use-ckin: use sdmmc_ckin pin from an external driver to sample
+  the receive data (example: with voltage switch transceiver).
+
+Example:
+	sdmmc1: mmc@52007000 {
+		compatible = "st,stm32h7-sdmmc";
+		reg = <0x52007000 0x1000>;
+		interrupts = <49>;
+		clocks = <&rcc SDMMC1_CK>;
+		resets = <&rcc SDMMC1_R>;
+		bus-width = <4>;
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+	};
-- 
2.7.4
