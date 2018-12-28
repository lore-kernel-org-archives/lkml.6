Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97592148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeL1IKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:10:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12845 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731869AbeL1IKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:10:12 -0500
X-UUID: 80b88a328e0c4f37af52a0e50643c633-20181228
X-UUID: 80b88a328e0c4f37af52a0e50643c633-20181228
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1834598019; Fri, 28 Dec 2018 16:10:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Dec 2018 16:10:00 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Dec 2018 16:10:01 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-clk@vger.kernel.org>, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v5 5/6] dt-bindings: pinctrl: mt8183: add binding document
Date:   Fri, 28 Dec 2018 16:09:40 +0800
Message-ID: <1545984581-25843-6-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
References: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

The commit adds mt8183 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
new file mode 100644
index 0000000..7b5285e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
@@ -0,0 +1,110 @@
+* Mediatek MT8183 Pin Controller
+
+The Mediatek's Pin controller is used to control SoC pins.
+
+Required properties:
+- compatible: value should be one of the following.
+	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
+  binding is used, the amount of cells must be specified as 2. See the below
+  mentioned gpio binding representation for description of particular cells.
+- gpio-ranges : gpio valid number range.
+
+	Eg: <&pio 6 0>
+	<[phandle of the gpio controller node]
+	[line number within the gpio controller]
+	[flags]>
+
+	Values for gpio specifier:
+	- Line number: is a value between 0 to 202.
+	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
+            Only the following flags are supported:
+            0 - GPIO_ACTIVE_HIGH
+            1 - GPIO_ACTIVE_LOW
+
+Optional properties:
+- reg: physicall address base for gpio base registers.
+- reg-names: gpio base registers name.
+- interrupt-controller: Marks the device node as an interrupt controller
+- #interrupt-cells: Should be two.
+- interrupts : The interrupt outputs from the controller.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+Subnode format
+A pinctrl node should contain at least one subnodes representing the
+pinctrl groups available on the machine. Each subnode will list the
+pins it needs, and how they should be configured, with regard to muxer
+configuration, pullups, drive strength, input enable/disable and input schmitt.
+
+    node {
+	pinmux = <PIN_NUMBER_PINMUX>;
+	GENERIC_PINCONFIG;
+    };
+
+Required properties:
+- pinmux: integer array, represents gpio pin number and mux setting.
+    Supported pin number and mux varies for different SoCs, and are defined
+    as macros in boot/dts/<soc>-pinfunc.h directly.
+
+Optional properties:
+- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
+    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
+    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
+
+    Some special pins have extra pull up strength, there are R0 and R1 pull-up
+    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
+    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
+    it support arguments for those special pins.
+
+    When config drive-strength, it can support some arguments, such as
+    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
+
+Examples:
+
+#include "mt8183-pinfunc.h"
+
+...
+{
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt8183-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x11F20000 0 0x1000>,
+		      <0 0x11E80000 0 0x1000>,
+		      <0 0x11E70000 0 0x1000>,
+		      <0 0x11E90000 0 0x1000>,
+		      <0 0x11D30000 0 0x1000>,
+		      <0 0x11D20000 0 0x1000>,
+		      <0 0x11C50000 0 0x1000>,
+		      <0 0x11F30000 0 0x1000>;
+		reg-names = "iocfg0", "iocfg1", "iocfg2",
+			    "iocfg3", "iocfg4", "iocfg5",
+			    "iocfg6", "iocfg7", "iocfg8";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pio 0 0 192>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+
+		i2c0_pins_a: i2c0@0 {
+			pins1 {
+				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
+					 <PINMUX_GPIO49__FUNC_SDA5>;
+				mediatek,pull-up-adv = <11>;
+			};
+		};
+
+		i2c1_pins_a: i2c1@0 {
+			pins {
+				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
+					 <PINMUX_GPIO51__FUNC_SDA3>;
+				mediatek,pull-down-adv = <10>;
+			};
+		};
+		...
+	};
+};
-- 
1.9.1

