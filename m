Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeDMQKz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:10:55 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10397 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeDMQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:10:30 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517900400";
   d="scan'208";a="10537215"
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
Date: Fri, 13 Apr 2018 19:11:16 +0300
Message-ID: <20180413161117.20274-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161117.20274-1-radu.pirea@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are bindings for at91-usart IP in spi spi mode. There is no support for
internal chip select. Only kind of chip selects available are gpio chip
selects.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 .../bindings/spi/microchip,at91-usart-spi.txt | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
new file mode 100644
index 000000000000..92d33ccdffae
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
@@ -0,0 +1,24 @@
+* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
+
+Required properties:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- compatible: Should be "microchip,at91sam9g45-usart-spi" or "microchip,sama5d2-usart-spi" 
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- clocks: phandles to input clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "usart"
+- cs-gpios: chipselects (internal cs not supported)
+
+Example:
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "microchip,sama5d2-usart-spi", "microchip,at91sam9g45-usart-spi";
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
-- 
2.17.0
