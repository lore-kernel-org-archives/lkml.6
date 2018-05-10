Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935126AbeEJKtT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:18027 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935006AbeEJKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:14 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="14726560"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 4/9] dt-bindings: input: touchscreen: resistive-adc-touch: create bindings
Date: Thu, 10 May 2018 13:45:09 +0300
Message-ID: <1525949114-29263-5-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added bindings for generic resistive touchscreen ADC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v5:
 - changed property name touchscreen-threshold-pressure to
touchscreen-min-pressure

Changes in v3:
 - renamed file and compatible to exclude "generic" keyword
 - removed the pressure threshold property, added it as a common
touchscreen property in the touchscreen common bindings in a separate
commit.

Changes in v2:
 - modified bindings to have a generic resistive touchscreen adc driver
instead of specific architecture one.


 .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
new file mode 100644
index 0000000..51456c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
@@ -0,0 +1,30 @@
+Generic resistive touchscreen ADC
+
+Required properties:
+
+ - compatible: must be "resistive-adc-touch"
+The device must be connected to an ADC device that provides channels for
+position measurement and optional pressure.
+Refer to ../iio/iio-bindings.txt for details
+ - iio-channels: must have at least two channels connected to an ADC device.
+These should correspond to the channels exposed by the ADC device and should
+have the right index as the ADC device registers them. These channels
+represent the relative position on the "x" and "y" axes.
+ - iio-channel-names: must have all the channels' names. Mandatory channels
+are "x" and "y".
+
+Optional properties:
+ - iio-channels: The third channel named "pressure" is optional and can be
+used if the ADC device also measures pressure besides position.
+If this channel is missing, pressure will be ignored and the touchscreen
+will only report position.
+ - iio-channel-names: optional channel named "pressure".
+
+Example:
+
+	resistive_touch: resistive_touch {
+		compatible = "resistive-adc-touch";
+		touchscreen-min-pressure = <50000>;
+		io-channels = <&adc 24>, <&adc 25>, <&adc 26>;
+		io-channel-names = "x", "y", "pressure";
+	};
-- 
2.7.4
