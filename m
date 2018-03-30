Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4/KGmzW3xtloR0eYFLfuXbCtDdkswuuZ/wfWBRNWlBNxsSVYQ8X/cDNMJxuFLemwOmZvB7t
ARC-Seal: i=1; a=rsa-sha256; t=1522396081; cv=none;
        d=google.com; s=arc-20160816;
        b=f5sWsFYu+Moa8eS645UmyN/dAA1henSbuLEpJ1lVqOKgVJo9e9IicatWwDL5mh7DVh
         FiDbNBHLXESoK8Pi+Zg2Rl4nQYkJA+VJrmYXuUiFGDbV6EZF9lLOGFQSDXAUPt5C3V3Q
         L5sFa+Ul0mtC3JsV3MfdtmQGR3xSAiyLTwjpuwQHr/GeIBTUPj/zTre5p3d26XPlOX06
         A2XhhJQH0HOTEtPkPHThwjQ3DrpDkNjRGnWTl6ndyTDucvL2SQdn42nyoS1aeJLPqghW
         L0MV+q0v3Lg2VD1dtVB6/v6gvtCAQocqz6uOwXGWIcVQQSTn47jXUCZgDWX1EXJNGifs
         jqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ZtLFCGr/M8gHi+fGK27zl8U0mZgxFBtQx3PlcM7Htw0=;
        b=bI5ltDL2S6NFWVnAHL13SkqWjU8+HkECBs9qEA/3wLb+WyR6he+cktwUaaI+qObpxi
         HvHuGZhnPkrexCO+cM/nz+OqwXf8sej0ozyWG+l2ipGvUF1Awv1op70c5MHNaTsnSVU2
         IIWxJOEpGK90TFRjjvyKbWUXhEd2gaSsTmUhqKAYPW77JSQUdfVWK4qmGPSi7RNyFNly
         u8o4WjhaMdX/yuQLtzWCMQp9dDn2IN7ISIOl9EbVE5eTr3Emx/ljBSyh4/ug2Db/+fQ6
         PXlfazpBuQQZgHSomW0t20rHt9EaLBKa7uo3x0d7pwI4AGdpfVjvOoCQOpuyWtBl+Ugq
         N0rw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 10/10] dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
Date: Fri, 30 Mar 2018 09:47:51 +0200
Message-Id: <20180330074751.25987-11-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347993996271622?=
X-GMAIL-MSGID: =?utf-8?q?1596347993996271622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document the Cadence I3C gpio expander bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v4:
- Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
- Fix the unit-address in the example
---
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
new file mode 100644
index 000000000000..d0155a9cea79
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
@@ -0,0 +1,39 @@
+* Cadence I3C GPIO expander
+
+The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
+This GPIOs can be configured in output or input mode and if they are in input
+mode they can generate IBIs (In Band Interrupts).
+
+Required properties for GPIO node:
+- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
+	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
+	more details.
+	Should be <0x0 0x392 0x0>.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+  GPIO_ACTIVE_LOW)
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2. The first cell is the GPIO number.
+  The second cell is used to specify trigger type and level flags.
+  The following trigger types are accepted (see
+  <dt-bindings/interrupt-controller/irq.h> for their definition):
+	IRQ_TYPE_EDGE_RISING
+	IRQ_TYPE_EDGE_FALLING
+	IRQ_TYPE_EDGE_BOTH
+	IRQ_TYPE_LEVEL_HIGH
+	IRQ_TYPE_LEVEL_LOW
+
+Example:
+
+	i3c-master@xxx {
+		...
+		i3c_gpio_expander: gpio@0,39200000000 {
+			reg = <0 0x392 0x0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+		...
+	};
-- 
2.14.1
