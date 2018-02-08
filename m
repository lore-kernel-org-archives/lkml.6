Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBHO3Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:29:24 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61434 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751343AbeBHO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:28:35 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Amelie Delaunay" <amelie.delaunay@st.com>
Subject: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander driver
Date: Thu, 8 Feb 2018 15:27:32 +0100
Message-ID: <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (MFX).

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/mfd/st-mfx.txt | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt

diff --git a/Documentation/devicetree/bindings/mfd/st-mfx.txt b/Documentation/devicetree/bindings/mfd/st-mfx.txt
new file mode 100644
index 0000000..423d800
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st-mfx.txt
@@ -0,0 +1,51 @@
+STMicroelectronics Multi-Function eXpander
+
+ST Multi-Function eXpander (MFX) is a slave controller using I2C for
+communication with the main MCU. Its main features are gpio expansion, main
+MCU IDD measurement (IDD is the amount of current that flows through VDD)
+and resistive touchscreen controller.
+
+Required properties:
+- compatible: must be "st,mfx"
+- reg: I2C address of the device
+- interrupts: interrupt triggered by MFX_IRQ_OUT signal
+- interrupt-parent: interrupt controller MFX is connected to
+- interrupt-controller: marks the device as an interrupt controller
+- #interrupt-cells: should be <1>, index of the interrupt within the
+  controller, in accordance with the "one cell" variant of
+  <devicetree/bindings/interrupt-controller/interrupt.txt>
+
+Optional nodes:
+
+* GPIO eXpander
+MFX provides 16 programmable GPIOs, and it is also possible to recover 8
+alternate GPIOs if the main functions are not used (touchscreen controller and
+IDD measurement not enabled).
+
+Required properties:
+- compatible : must be "st,mfx-gpio"
+- interrupt-parent : must be <&mfx>
+- interrupts = must be <0>
+- gpio-controller: marks the device node as a GPIO controller
+- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
+  controller, the second cell is the gpio flags in accordance with
+  <dt-bindings/gpio/st-mfx-gpio.h>.
+
+Example:
+
+	mfx: mfx@42 {
+		compatible = "st,mfx";
+		reg = <0x42>;
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpioi>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		mfxgpio: mfx_gpio {
+			compatible = "st,mfx-gpio";
+			interrupt-parent = <&mfx>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
-- 
2.7.4
