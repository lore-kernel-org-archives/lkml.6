Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeC0MfK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:35:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:5755 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeC0MfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:35:05 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517900400";
   d="scan'208";a="10562914"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 08/10] dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific consumer info
Date: Tue, 27 Mar 2018 15:32:41 +0300
Message-ID: <1522153963-1121-9-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added defines for channel consumer device-tree binding

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
index 6469a4c..4a3c1d4 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
@@ -21,6 +21,14 @@ Optional properties:
   - dmas: Phandle to dma channel for the ADC.
   - dma-names: Must be "rx" when dmas property is being used.
   See ../../dma/dma.txt for details.
+  - #io-channel-cells: in case consumer drivers are attached, this must be 1.
+  See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details.
+
+Properties for consumer drivers:
+  - Consumer drivers can be connected to this producer device, as specified
+  in <Documentation/devicetree/bindings/iio/iio-bindings.txt>
+  - Channels exposed are specified in:
+  <dt-bindings/iio/adc/at91-sama5d2_adc.txt>
 
 Example:
 
@@ -38,4 +46,5 @@ adc: adc@fc030000 {
 	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
 	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
 	dma-names = "rx";
+	#io-channel-cells = <1>;
 }
diff --git a/include/dt-bindings/iio/adc/at91-sama5d2_adc.h b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
new file mode 100644
index 0000000..70f99db
--- /dev/null
+++ b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for configuring the AT91 SAMA5D2 ADC
+ */
+
+#ifndef _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
+#define _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
+
+/* X relative position channel index */
+#define AT91_SAMA5D2_ADC_X_CHANNEL		24
+/* Y relative position channel index */
+#define AT91_SAMA5D2_ADC_Y_CHANNEL		25
+/* pressure channel index */
+#define AT91_SAMA5D2_ADC_P_CHANNEL		26
+
+#endif
-- 
2.7.4
