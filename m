Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeFESqo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:46:44 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:53992 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeFESqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:46:39 -0400
X-AuditID: 0a3aad14-925ff70000003a2f-1e-5b16da99210d
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>, <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 5/5] spi,can,char: add companion DT binding documentation
Date: Tue, 5 Jun 2018 20:44:00 +0200
Message-ID: <1528224240-30786-6-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILsWRmVeSWpSXmKPExsXCZbVWVnfmLbFog8m9VhY77txntlj1fSqz
        xeVdc9gs1i+awmJxbIGYxdJ7O1kd2DzmzTrB4vHx0m1Gj/6/Bh6fN8kFsERx2aSk5mSWpRbp
        2yVwZazZPJ+54JB0xZXWjewNjM9Euhg5OSQETCTOXnnL0sXIxSEkMINJYtnrR1DOfkaJptlv
        2SCcbYwSp++eZgFpYRPQkrh5YgcziC0iECox+2kbWAezwEpGiafLzzJ1MXJwCAt4Sny8qAJS
        wyKgIrH5zTmwXl4Bd4lnz64yQqyWk7h5rhNsDqeAh8Tv1nfsILYQUM25TTD1ghInZz4Bs5kF
        JCQOvnjBPIGRfxaS1CwkqQWMTKsYRdNSDcpyDc1NDPSKklKLqwwM9ZLzczcxQgJUZAfjpIcp
        hxgFOBiVeHj/HBSLFmJNLCuuzD3EaMrBpCTKq7MIKMSXlJ9SmZFYnBFfVJqTWqwkxcvIwMAg
        JAwXLi5Nys0sLs7MzzvEKMHBrCTCm3gJqI83JbGyKrUoH6LtEKM0B4uSOG/HmpdRQgLpiSWp
        2ampBalFMFlrDg4lCV6Pm0CNgkWp6akVaZk5JTBpJVmInWLIMsjWMnFwHmI05uAB2u0EMoK3
        uCAxtzgzHapdEqJdCCaK0HqK0VxKnLcSpEcAJJtRmge3VUqGd+5JkWghUSQJhM5XjDcYgeEm
        zDsTpJkHmFYR9knw7hCeEykkCBVEaDJaAtQjsJtbYl5TkcS8HV8ZJSa2PGKW2L+xiVXi1o8N
        rBKHty1nk5i54AObRMvx+ZwSJyYd55R4s7iDV6Lj0FZeiZ6X6wQkflxdICjR09kqJHHp0x9h
        iRmL90tI/FuyUUri84rHQGLhSyDxYqusxMYfR+Qk/k15KCfx5/gGeYn7zdMVJP43rVSU2PHk
        kpLE559vlSQu/VqsLDHvxwNliQtNj5Ql1u//COQuOa/6ChiWTMCwfFYhDArLksQSLGEJFUV4
        TqqBUd857677RYmJ1fmLViuWbj1qqbDDrL1rkytvefIs7RuGN3n+tx6+33ksZLGp6E3hfZGi
        bp0xcqqLlKWVF5QpZdu9i+cpTf779t3a+oq6WbfmWDie2t1X5yTwc82/ez+7viqe4Vkjd/d4
        zr8bN57ffM2eHyj/8PaHw5q7vye78kpmODI78DPnK7EUZyQaajEXFScCAA81uvlEBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 .../devicetree/bindings/spi/bosch,companion.txt    | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt

diff --git a/Documentation/devicetree/bindings/spi/bosch,companion.txt b/Documentation/devicetree/bindings/spi/bosch,companion.txt
new file mode 100644
index 0000000..5ded325
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/bosch,companion.txt
@@ -0,0 +1,82 @@
+Bosch Companion SPI slave device
+
+The functionality bases on an external peripheral chip named Companion.
+It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
+well as one receive FIFO. Besides CAN, undisclosed additional functions
+can be accessed through the char device.
+
+A standard SPI interface with two additional lines for flow control is
+used. The Companion chip is the SPI slave.
+
+The driver suite consists of three separate drivers. The following
+diagram illustrates the dependencies in layers.
+
+           /dev/companion       SocketCAN                User Space
+-------------------------------------------------------------------
+         +----------------+ +---------------+
+         | companion-char | | companion-can |
+         +----------------+ +---------------+
+         +----------------------------------+
+         |          companion-spi           |
+         +----------------------------------+
+         +----------------------------------+
+         |     standard SPI subsystem       |
+         +----------------------------------+          Linux Kernel
+-------------------------------------------------------------------
+               | | | |      | |                            Hardware
+            CS-+ | | |      | +-BUSY
+            CLK--+ | |      +---REQUEST
+            MOSI---+ |
+            MISO-----+
+
+Required properties:
+
+- compatible       : must be "bosch,companion-spi"
+- interrupt-parent : the phandle of the GPIO controller
+- interrupts       : (GPIO) interrupt to which 'request-gpios' is
+                     connected to
+- request-gpios    : GPIO pin to request SPI master to receive data
+- busy-gpios       : GPIO pin to indicate SPI slave is busy
+- cs-gpios         : GPIO pin to select SPI slave
+
+Optional properties:
+
+The controller supports at most 2 CAN and 1 char device subnodes. When
+optionally specify the subnodes, the following properties are required:
+
+- CAN subnode
+  - compatible     : must be "bosch,companion-can"
+  - clock-frequency: CAN device clock in Hz
+  - port           : must be 0 or 1
+
+- Char device subnode
+  - compatible     : must be "bosch,companion-char"
+
+Example:
+
+&ecspi1 {
+	companion-spi@0 {
+		compatible = "bosch,companion-spi";
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		request-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
+		busy-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+
+		companion-can0 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <0>;
+		};
+
+		companion-can1 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <1>;
+		};
+
+		companion-char {
+			compatible = "bosch,companion-char";
+		};
+	};
+};
-- 
2.7.4
