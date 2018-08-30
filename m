Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D920658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809D920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeH3RPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:15:21 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60600 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbeH3RPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:15:21 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 30 Aug 2018 22:13:14 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 05A5E81BAC;
        Thu, 30 Aug 2018 22:13:14 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,306,1531753200"; 
   d="scan'208";a="289528133"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii1.idc.renesas.com with ESMTP; 30 Aug 2018 22:13:11 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
Date:   Thu, 30 Aug 2018 14:12:53 +0100
Message-Id: <1535634775-19365-2-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 device family PINCTRL node description.

Based on a patch originally written by Michel Pollet at Renesas.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Change filename to generic rzn1, instead of device specific.
 - Add "renesas,rzn1-pinctrl" compatible fallback string.
 - Example register size corrected.
 - Typos fixed.
 - Changes suggested by Jacopo Mondi.
 - rzn1-pinctrl.h squashed into this as requested by Rob Herring.
---
 .../bindings/pinctrl/renesas,rzn1-pinctrl.txt      |  97 +++++++++++
 include/dt-bindings/pinctrl/rzn1-pinctrl.h         | 191 +++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
 create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
new file mode 100644
index 0000000..d254388
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
@@ -0,0 +1,97 @@
+Renesas RZ/N1 SoC Pinctrl node description.
+
+Pin controller node
+-------------------
+Required properties:
+- compatible: SoC-specific compatible string "renesas,<soc-specific>-pinctrl"
+  followed by "renesas,rzn1-pinctrl" as fallback. The SoC-specific compatible
+  strings must be one of:
+	"renesas,r9a06g032-pinctrl" for RZ/N1D
+	"renesas,r9a06g033-pinctrl" for RZ/N1S
+- reg: Address base and length of the memory area where the pin controller
+  hardware is mapped to.
+- clocks: phandles for the clock, see the description of clock-names below.
+- clock-names: Contains the name of the clock:
+    "bus", the bus clock, sometimes described as pclk, for register accesses.
+
+Example:
+	pinctrl: pin-controller@40067000 {
+	    compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
+	    reg = <0x40067000 0x1000>, <0x51000000 0x480>;
+	    clocks = <&sysctrl R9A06G032_HCLK_PINCONFIG>;
+	    clock-names = "bus";
+	};
+
+Sub-nodes
+---------
+  The child nodes of the pin controller node describe a pin multiplexing
+  group that can be used by device nodes.
+
+  A pin multiplexing sub-node describes how to configure a set of pins, or a
+  single pin, in some desired alternate function mode.
+  A single sub-node may define several pin configurations.
+
+  The allowed generic formats for a pin multiplexing sub-node are the
+  following ones:
+
+  Client sub-nodes shall refer to pin multiplexing sub-nodes using the phandle
+  of the most external one. See the generic pinctrl-bindings.txt for details.
+
+  Required properties:
+    - renesas,rzn1-pinctrl:
+      Array of integers representing each 'pin' and it's configuration.
+
+      A 'pin number' does not correspond 1:1 to the hardware manual notion of
+      PL_GPIO directly. Numbers 0...169 are PL_GPIOs, however there is also two
+      extra 170 and 171 that corresponds to the MDIO0 and MDIO1 bus config.
+
+      A 'function' also does not correspond 1:1 to the hardware manual. There
+      are 2 levels of pin muxing, Level 1, level 2 -- to this are added the
+      MDIO configurations.
+
+      Helper macros to ease assembling the pin index and function identifier
+      are provided by the pin controller header file at:
+      <include/dt-bindings/pinctrl/rzn1-pinctrl.h>
+
+Example #1:
+  A simple case configuring only the function for a given 'pin' works as follow:
+	#include <include/dt-bindings/pinctrl/rzn1-pinctrl.h>
+	&pinctrl {
+		pinsuart0: pinsuart0 {
+			renesas,rzn1-pinmux-ids = <
+				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
+				RZN1_MUX(104, UART0_I)	/* UART0_RXD */
+			>;
+		};
+	};
+
+  Note that in this case the other attributes of the pins, pull up/down/none and
+  drive strength, are not changed.
+
+Example #2:
+  Here we also set the pullups on the RXD pin:
+	&pinctrl {
+		pinsuart0: pinsuart0 {
+			renesas,rzn1-pinmux-ids = <
+				RZN1_MUX(103, UART0_I)	/* UART0_TXD */
+				RZN1_MUX_PUP(104, UART0_I)	/* UART0_RXD */
+			>;
+		};
+	};
+  There are many alternative macros to set the pull up/down/none and the drive
+  strength in the rzn1-pinctrl.h header file.
+
+Example #3:
+  The SoC has two configurable MDIO muxes, these can also be configured
+  with this interface using the 'special' MDIO constants:
+
+	&pinctrl {
+		mdio_mux: mdiomux {
+			renesas,rzn1-pinmux-ids = <
+				RZN1_MUX(RZN1_MDIO_BUS0, RZN1_FUNC_MDIO_MUX_MAC0)
+				RZN1_MUX(RZN1_MDIO_BUS1, RZN1_FUNC_MDIO_MUX_SWITCH)
+			>;
+		};
+	};
+  Clearly the pull up/down/none and drive constants will be ignored, even if
+  specified.
diff --git a/include/dt-bindings/pinctrl/rzn1-pinctrl.h b/include/dt-bindings/pinctrl/rzn1-pinctrl.h
new file mode 100644
index 0000000..dc90d35
--- /dev/null
+++ b/include/dt-bindings/pinctrl/rzn1-pinctrl.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Defines macros and constants for Renesas RZ/N1 pin controller pin
+ * muxing functions.
+ */
+#ifndef __DT_BINDINGS_RZN1_PINCTRL_H
+#define __DT_BINDINGS_RZN1_PINCTRL_H
+
+#define RZN1_MUX_FUNC_BIT			8
+#define RZN1_MUX_HAS_FUNC_BIT			15
+#define RZN1_MUX_HAS_DRIVE_BIT			16
+#define RZN1_MUX_DRIVE_BIT			17
+#define RZN1_MUX_HAS_PULL_BIT			19
+#define RZN1_MUX_PULL_BIT			20
+
+#define RZN1_MUX_PULL_UP			1
+#define RZN1_MUX_PULL_DOWN			3
+#define RZN1_MUX_PULL_NONE			0
+
+#define RZN1_MUX_DRIVE_4MA			0
+#define RZN1_MUX_DRIVE_6MA			1
+#define RZN1_MUX_DRIVE_8MA			2
+#define RZN1_MUX_DRIVE_12MA			3
+
+#define RZN1_MUX(_gpio, _func) \
+	(((RZN1_FUNC_##_func) << RZN1_MUX_FUNC_BIT) | \
+		(1 << RZN1_MUX_HAS_FUNC_BIT) | \
+		(_gpio))
+
+#define RZN1_MUX_PULL(_pull) \
+		((1 << RZN1_MUX_HAS_PULL_BIT) | \
+		((_pull) << RZN1_MUX_PULL_BIT))
+
+#define RZN1_MUX_DRIVE(_drive) \
+		((1 << RZN1_MUX_HAS_DRIVE_BIT) | \
+		((_drive) << RZN1_MUX_DRIVE_BIT))
+
+#define RZN1_MUX_PUP(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_PULL(RZN1_MUX_PULL_UP))
+#define RZN1_MUX_PDOWN(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_PULL(RZN1_MUX_PULL_DOWN))
+#define RZN1_MUX_PNONE(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_PULL(RZN1_MUX_PULL_NONE))
+
+#define RZN1_MUX_4MA(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_4MA))
+#define RZN1_MUX_6MA(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_6MA))
+#define RZN1_MUX_8MA(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_8MA))
+#define RZN1_MUX_12MA(_gpio, _func) \
+	(RZN1_MUX(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_12MA))
+
+#define RZN1_MUX_PUP_4MA(_gpio, _func) \
+	(RZN1_MUX_PUP(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_4MA))
+#define RZN1_MUX_PUP_6MA(_gpio, _func) \
+	(RZN1_MUX_PUP(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_6MA))
+#define RZN1_MUX_PUP_8MA(_gpio, _func) \
+	(RZN1_MUX_PUP(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_8MA))
+#define RZN1_MUX_PUP_12MA(_gpio, _func) \
+	(RZN1_MUX_PUP(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_12MA))
+
+#define RZN1_MUX_PDOWN_4MA(_gpio, _func) \
+	(RZN1_MUX_PDOWN(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_4MA))
+#define RZN1_MUX_PDOWN_6MA(_gpio, _func) \
+	(RZN1_MUX_PDOWN(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_6MA))
+#define RZN1_MUX_PDOWN_8MA(_gpio, _func) \
+	(RZN1_MUX_PDOWN(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_8MA))
+#define RZN1_MUX_PDOWN_12MA(_gpio, _func) \
+	(RZN1_MUX_PDOWN(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_12MA))
+
+#define RZN1_MUX_PNONE_4MA(_gpio, _func) \
+	(RZN1_MUX_PNONE(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_4MA))
+#define RZN1_MUX_PNONE_6MA(_gpio, _func) \
+	(RZN1_MUX_PNONE(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_6MA))
+#define RZN1_MUX_PNONE_8MA(_gpio, _func) \
+	(RZN1_MUX_PNONE(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_8MA))
+#define RZN1_MUX_PNONE_12MA(_gpio, _func) \
+	(RZN1_MUX_PNONE(_gpio, _func) | RZN1_MUX_DRIVE(RZN1_MUX_DRIVE_12MA))
+
+/*
+ * Use these "gpio" numbers with the RZN1_FUNC_MDIO_MUX* functions
+ * to set the destination of the two MDIO busses.
+ */
+#define RZN1_MDIO_BUS0				170
+#define RZN1_MDIO_BUS1				171
+
+/*
+ * This can be used to set pullups/down/driver for pins without changing
+ * any function that might have already been set
+ */
+#define RZN1_FUNC_NONE				0xff
+
+/*
+ * Given the different levels of muxing on the SoC, it was decided to
+ * 'linearize' them into one numerical space. So mux level 1, 2 and the MDIO
+ * muxes are all represented by one single value.
+ *
+ * You can derive the hardware value pretty easily too, as
+ * 0...9   are Level 1
+ * 10...71 are Level 2. The Level 2 mux will be set to this
+ *         value - RZN1_FUNC_LEVEL2_OFFSET, and the Level 1 mux will be
+ *         set accordingly.
+ * 72...79 are for the 2 MUDIO muxes for "GPIO" 170/171. These muxes will
+ *         be set to this value - 72.
+ */
+#define RZN1_FUNC_HIGHZ				0
+#define RZN1_FUNC_0L				1
+#define RZN1_FUNC_CLK_ETH_MII_RGMII_RMII	2
+#define RZN1_FUNC_CLK_ETH_NAND			3
+#define RZN1_FUNC_QSPI				4
+#define RZN1_FUNC_SDIO				5
+#define RZN1_FUNC_LCD				6
+#define RZN1_FUNC_LCD_E				7
+#define RZN1_FUNC_MSEBIM			8
+#define RZN1_FUNC_MSEBIS			9
+#define RZN1_FUNC_LEVEL2_OFFSET			10	/* I'm Special */
+#define RZN1_FUNC_HIGHZ1			10
+#define RZN1_FUNC_ETHERCAT			11
+#define RZN1_FUNC_SERCOS3			12
+#define RZN1_FUNC_SDIO_E			13
+#define RZN1_FUNC_ETH_MDIO			14
+#define RZN1_FUNC_ETH_MDIO_E1			15
+#define RZN1_FUNC_USB				16
+#define RZN1_FUNC_MSEBIM_E			17
+#define RZN1_FUNC_MSEBIS_E			18
+#define RZN1_FUNC_RSV				19
+#define RZN1_FUNC_RSV_E				20
+#define RZN1_FUNC_RSV_E1			21
+#define RZN1_FUNC_UART0_I			22
+#define RZN1_FUNC_UART0_I_E			23
+#define RZN1_FUNC_UART1_I			24
+#define RZN1_FUNC_UART1_I_E			25
+#define RZN1_FUNC_UART2_I			26
+#define RZN1_FUNC_UART2_I_E			27
+#define RZN1_FUNC_UART0				28
+#define RZN1_FUNC_UART0_E			29
+#define RZN1_FUNC_UART1				30
+#define RZN1_FUNC_UART1_E			31
+#define RZN1_FUNC_UART2				32
+#define RZN1_FUNC_UART2_E			33
+#define RZN1_FUNC_UART3				34
+#define RZN1_FUNC_UART3_E			35
+#define RZN1_FUNC_UART4				36
+#define RZN1_FUNC_UART4_E			37
+#define RZN1_FUNC_UART5				38
+#define RZN1_FUNC_UART5_E			39
+#define RZN1_FUNC_UART6				40
+#define RZN1_FUNC_UART6_E			41
+#define RZN1_FUNC_UART7				42
+#define RZN1_FUNC_UART7_E			43
+#define RZN1_FUNC_SPI0_M			44
+#define RZN1_FUNC_SPI0_M_E			45
+#define RZN1_FUNC_SPI1_M			46
+#define RZN1_FUNC_SPI1_M_E			47
+#define RZN1_FUNC_SPI2_M			48
+#define RZN1_FUNC_SPI2_M_E			49
+#define RZN1_FUNC_SPI3_M			50
+#define RZN1_FUNC_SPI3_M_E			51
+#define RZN1_FUNC_SPI4_S			52
+#define RZN1_FUNC_SPI4_S_E			53
+#define RZN1_FUNC_SPI5_S			54
+#define RZN1_FUNC_SPI5_S_E			55
+#define RZN1_FUNC_SGPIO0_M			56
+#define RZN1_FUNC_SGPIO1_M			57
+#define RZN1_FUNC_GPIO				58
+#define RZN1_FUNC_CAN				59
+#define RZN1_FUNC_I2C				60
+#define RZN1_FUNC_SAFE				61
+#define RZN1_FUNC_PTO_PWM			62
+#define RZN1_FUNC_PTO_PWM1			63
+#define RZN1_FUNC_PTO_PWM2			64
+#define RZN1_FUNC_PTO_PWM3			65
+#define RZN1_FUNC_PTO_PWM4			66
+#define RZN1_FUNC_DELTA_SIGMA			67
+#define RZN1_FUNC_SGPIO2_M			68
+#define RZN1_FUNC_SGPIO3_M			69
+#define RZN1_FUNC_SGPIO4_S			70
+#define RZN1_FUNC_MAC_MTIP_SWITCH		71
+/* These correspond to the functions used for the two MDIO muxes. */
+#define RZN1_FUNC_MDIO_MUX_HIGHZ		72
+#define RZN1_FUNC_MDIO_MUX_MAC0			73
+#define RZN1_FUNC_MDIO_MUX_MAC1			74
+#define RZN1_FUNC_MDIO_MUX_ECAT			75
+#define RZN1_FUNC_MDIO_MUX_S3_MDIO0		76
+#define RZN1_FUNC_MDIO_MUX_S3_MDIO1		77
+#define RZN1_FUNC_MDIO_MUX_HWRTOS		78
+#define RZN1_FUNC_MDIO_MUX_SWITCH		79
+#define RZN1_FUNC_MAX				80
+
+#endif /* __DT_BINDINGS_RZN1_PINCTRL_H */
-- 
2.7.4

