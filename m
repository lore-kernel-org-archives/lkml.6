Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeDMQKa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:10:30 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10397 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeDMQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:10:27 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517900400";
   d="scan'208";a="10537207"
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH 0/3] Driver for AT91 USART in SPI mode
Date: Fri, 13 Apr 2018 19:11:14 +0300
Message-ID: <20180413161117.20274-1-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote this driver for USART IP that is found in AT91 and SAMA5 SoCs. The
IP has an internal chip select, but is not used because is deasserted and
asserted after every byte sent over the wires. Gpio chip selects are used
instead of internal one. The driver works with actual USART nodes from
device tree of boards, but compatible must be changed, SCK pin muxed and
cs-gpio, size-cells and address-cells must be added. Of course, at the end
of the wires must be an SPI slave linked, not a serial console. :)

I tested the driver on sama5d4-xplained and sama5d3-xplained and works
without issues.

Radu Pirea (3):
  MAINTAINERS: add usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi

 .../bindings/spi/microchip,at91-usart-spi.txt |  24 +
 MAINTAINERS                                   |   7 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 545 ++++++++++++++++++
 5 files changed, 585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/spi/spi-at91-usart.c

-- 
2.17.0
