Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E23C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21882075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfBEJGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:06:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33736 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:06:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so2082196lfc.0;
        Tue, 05 Feb 2019 01:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wv4Js3I9YI/0htJd0RLFTCyvaRrdaU6LxMBWju/lp0Q=;
        b=RuJ3uBTpY5L5zWF/7ZLiZAramp2aza8oWiDZhzZgakUJLcBRrEhuhI0zzXjkbkclrT
         E9JQyLzZY0K/V6lVe1JcnkBwwjc8MfSKXZKFl+hMEbbFbsYT2aY8ZJGtsw0cTckJGCoD
         jPG8OZs+4pfxJb1bhtmv/23Sp9PVJzUfO7M4N/krFzz1aH2ehrGMjgBZntjHCIZlFqVw
         IsGpmfpryfzp80EL+WMj3jYvbEQXh1bGXHw1u5SmQIsSRP4CfQ19tgy2mJ17RyUGMJyU
         qkovl/D8zHo/edXa48+CD10069Mnh0tsXoHR8gFCqMQwGm9B8BHZjaUDlix8BCCHL373
         THDw==
X-Gm-Message-State: AHQUAubgRMzBTm3C9vBQRz5BaRUzoE0SQM0SQi3tGkJfjy6YrO3MflRm
        NYDdyRq+Slv4zoqOKoVJZXY=
X-Google-Smtp-Source: AHgI3IZpFxb2pUQ1wuq1BWgzrUVrNGOxCjL5wuhOeNWnTe5S8bOPi/Mev2fjpQpBjGWODJ6q5KNdQw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr2472355lfe.154.1549357589884;
        Tue, 05 Feb 2019 01:06:29 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c22sm3129324lfi.27.2019.02.05.01.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:06:29 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:06:16 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 06/10] devicetree: bindings: Document first ROHM BD70528
 bindings
Message-ID: <3b86b75b19e54c533ba6fe91f915981824dec3bd.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
drivers) and 4 GPIO pins which can be configured for I/O or
as interrupt sources withe configurable trigger levels.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
new file mode 100644
index 000000000000..f80be7e40184
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -0,0 +1,102 @@
+* ROHM BD70528 Power Management Integrated Circuit bindings
+
+BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
+for battery-powered portable devices. The IC integrates 3 ultra-low current
+consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
+GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
+for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC
+for battery temperature monitor and 1S battery charger with scalable charge
+currents.
+
+Required properties:
+ - compatible		: Should be "rohm,bd70528"
+ - reg			: I2C slave address.
+ - interrupts		: The interrupt line the device is connected to.
+ - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.
+ - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells
+			  variant of ../interrupt-controller/interrupts.txt
+ - gpio-controller	: To indicate bd70528 acts as a gpio controller.
+ - #gpio-cells		: Should be 2. The first cell is the pin number and
+			  the second cell is used to specify flags. See
+			  ../gpio/gpio.txt for more information.
+ - #clock-cells		: Should be 0.
+ - regulators:		: List of child nodes that specify the regulators.
+			  Please see ../regulator/rohm,bd70528-regulator.txt
+
+Optional properties:
+ - clock-output-names	: Should contain name for output clock.
+
+Example:
+/* external oscillator */
+osc: oscillator {
+	compatible = "fixed-clock";
+	#clock-cells = <1>;
+	clock-frequency  = <32768>;
+	clock-output-names = "osc";
+};
+
+pmic: pmic@4b {
+	compatible = "rohm,bd70528";
+	reg = <0x4b>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <29 GPIO_ACTIVE_LOW>;
+	clocks = <&osc 0>;
+	#clock-cells = <0>;
+	clock-output-names = "bd70528-32k-out";
+	#gpio-cells = <2>;
+	gpio-controller;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	regulators {
+		buck1: BUCK1 {
+			regulator-name = "buck1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <125>;
+		};
+		buck2: BUCK2 {
+			regulator-name = "buck2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <125>;
+		};
+		buck3: BUCK3 {
+			regulator-name = "buck3";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-ramp-delay = <250>;
+		};
+		ldo1: LDO1 {
+			regulator-name = "ldo1";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+		ldo2: LDO2 {
+			regulator-name = "ldo2";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+
+		ldo3: LDO3 {
+			regulator-name = "ldo3";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		led_ldo1: LED_LDO1 {
+			regulator-name = "led_ldo1";
+			regulator-min-microvolt = <200000>;
+			regulator-max-microvolt = <300000>;
+		};
+		led_ldo2: LED_LDO2 {
+			regulator-name = "led_ldo2";
+			regulator-min-microvolt = <200000>;
+			regulator-max-microvolt = <300000>;
+		};
+	};
+};
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
