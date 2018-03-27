Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeC0MfO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:35:14 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:1370 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeC0MfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:35:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517900400";
   d="scan'208";a="10562918"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 10/10] ARM: dts: at91: sama5d2: Add resistive touch device
Date: Tue, 27 Mar 2018 15:32:43 +0300
Message-ID: <1522153963-1121-11-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic resistive touch device which is connected to ADC block
inside the SAMA5D2 SoC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
 - now added a generic resistive touchscreen node instead of architecture
specific

 arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index f06ba99..0d87dc0 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1442,6 +1442,16 @@
 				status = "disabled";
 			};
 
+			resistive_touch: resistive-touch {
+				compatible = "generic-resistive-adc-touch";
+				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
+				io-channel-names = "x", "y", "pressure";
+				generic-resistive-adc-touch,pressure-threshold = <10000>;
+				status = "disabled";
+			};
+
 			pioA: pinctrl@fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.7.4
