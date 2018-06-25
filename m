Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40679C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E5325751
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E5325751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbeFYKTx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:19:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:20432 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755114AbeFYKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:19:51 -0400
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="15523734"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jun 2018 03:19:50 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Mon, 25 Jun 2018 03:19:49 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v9 2/6] dt-bindings: add binding for atmel-usart in SPI mode
Date:   Mon, 25 Jun 2018 13:21:01 +0300
Message-ID: <20180625102105.28383-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625102105.28383-1-radu.pirea@microchip.com>
References: <20180625102105.28383-1-radu.pirea@microchip.com>
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
index 7c0d6b2f53e4..0348fef0f497 100644
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
+- atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
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
+		atmel,usart-mode = <AT91_USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
new file mode 100644
index 000000000000..2de5bc312e1e
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
+#define AT91_USART_MODE_SERIAL	0
+#define AT91_USART_MODE_SPI	1
+
+#endif /* __DT_BINDINGS_AT91_USART_H__ */
-- 
2.17.1

