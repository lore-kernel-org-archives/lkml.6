Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC0Mex (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:34:53 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53948 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeC0Mev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:34:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517900400";
   d="scan'208";a="13309089"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 03/10] dt-bindings: input: touchscreen: touch_adc: create bindings
Date: Tue, 27 Mar 2018 15:32:36 +0300
Message-ID: <1522153963-1121-4-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added bindings for generic resistive touchscreen ADC.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
 - modified bindings to have a generic resistive touchscreen adc driver
instead of specific architecture one.

 .../bindings/input/touchscreen/touch_adc.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
new file mode 100644
index 0000000..27abcdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touch_adc.txt
@@ -0,0 +1,33 @@
+Generic resistive touchscreen ADC
+
+Required properties:
+
+ - compatible: must be "generic-resistive-adc-touch"
+The device must be connected to an IIO device that provides channels for
+position measurement and optional pressure.
+Refer to ../iio/iio-bindings.txt for details
+ - iio-channels: must have at least two channels connected to an IIO device.
+These should correspond to the channels exposed by the IIO device and should
+have the right index as the IIO device registers them. These channels
+represent the relative position on the "x" and "y" axes.
+ - iio-channel-names: must have all the channels' names. Mandatory channels
+are "x" and "y".
+
+Optional properties:
+ - iio-channels: The third channel named "pressure" is optional and can be
+used if the IIO device also measures pressure besides position.
+If this channel is missing, pressure will be ignored and the touchscreen
+will only report position.
+ - iio-channel-names: optional channel named "pressure".
+ - generic-resistive-adc-touch,pressure-threshold: a pressure threshold for
+the touchscreen, if we are using the "pressure" channel as well.
+Represented by an integer value.
+
+Example:
+
+	resistive_touch: resistive_touch {
+		compatible = "generic-resistive-adc-touch";
+		generic-resistive-adc-touch,pressure-threshold = <10000>;
+		io-channels = <&adc 24>, <&adc 25>, <&adc 26>;
+		io-channel-names = "x", "y", "pressure";
+	};
-- 
2.7.4
