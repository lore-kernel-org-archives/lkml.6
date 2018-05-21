Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeEUKeF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:34:05 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:3521 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbeEUKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:33:46 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="14487307"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v6 9/9] ARM: dts: at91: sama5d2: Add resistive touch device
Date: Mon, 21 May 2018 13:27:57 +0300
Message-ID: <1526898477-9952-10-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
References: <1526898477-9952-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic resistive touch device which is connected to ADC block
inside the SAMA5D2 SoC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v5:
 - renamed touchscreen-threshold-pressure to touchscreen-min-pressure

 arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index f06ba99..a44f325 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1442,6 +1442,16 @@
 				status = "disabled";
 			};
 
+			resistive_touch: resistive-touch {
+				compatible = "resistive-adc-touch";
+				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
+				io-channel-names = "x", "y", "pressure";
+				touchscreen-min-pressure = <50000>;
+				status = "disabled";
+			};
+
 			pioA: pinctrl@fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.7.4
