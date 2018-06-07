Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1G8ZIpAQGVtMHgAAmS7hNA
	; Thu, 07 Jun 2018 11:01:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 377A86089E; Thu,  7 Jun 2018 11:01:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B71EA6063F;
	Thu,  7 Jun 2018 11:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B71EA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932631AbeFGLBs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:01:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:31666 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeFGK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:59:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="12270503"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Jun 2018 03:59:48 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 7 Jun 2018 03:59:46 -0700
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC: <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v6 2/6] dt-bindings: add binding for atmel-usart in SPI mode
Date: Thu, 7 Jun 2018 14:00:16 +0300
Message-ID: <20180607110020.20565-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607110020.20565-1-radu.pirea@microchip.com>
References: <20180607110020.20565-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the bindings for serial from serial/atmel-usart.txt to
mfd/atmel-usart.txt and adds bindings for USART in SPI mode.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
 include/dt-bindings/mfd/at91-usart.h          | 17 +++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
similarity index 76%
rename from Documentation/devicetree/bindings/serial/atmel-usart.txt
rename to Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 7c0d6b2f53e4..3b9e18642c3b 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,6 +1,6 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
-Required properties:
+Required properties for USART:
 - compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
   The compatible <chip> indicated will be the first SoC to support an
   additional mode or an USART new feature.
@@ -11,7 +11,13 @@ Required properties:
 	Required elements: "usart"
 - clocks: phandles to input clocks.
 
-Optional properties:
+Required properties for USART in SPI mode:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- cs-gpios: chipselects (internal cs not supported)
+- atmel,usart-mode : Must be <USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
+
+Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
@@ -62,3 +68,18 @@ Example:
 		dma-names = "tx", "rx";
 		atmel,fifo-size = <32>;
 	};
+
+- SPI mode:
+	#include <dt-bindings/mfd/at91-usart.h>
+
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
+		atmel,usart-mode = <USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
new file mode 100644
index 000000000000..ac811628a42d
--- /dev/null
+++ b/include/dt-bindings/mfd/at91-usart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for AT91 USART DT bindings.
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_AT91_USART_H__
+#define __DT_BINDINGS_AT91_USART_H__
+
+#define AT91_USART_MODE_SERIAL	1
+#define AT91_USART_MODE_SPI	2
+
+#endif /* __DT_BINDINGS_AT91_USART_H__ */
-- 
2.17.1
