Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D07C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46DE2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfBMNdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:33:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfBMNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:33:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so1556393lfc.12;
        Wed, 13 Feb 2019 05:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=is80derPQ3XmUGfTm+3T38jwgAXtOjEufW3kUQBYsGc=;
        b=ZFVPCZbE/9hFsUW0Ivwh45yOtu5fDq+zrObXaO3hGTmD3ur5vzRdxIjN+t3rKMD5vp
         cdAeGHNOporz4bakWQ4ndxh3FcvS29gBO7lkbd46pVk10+jRoXkvFXW+6V5OTuuk79jP
         5IFN4ZbgvbVLLUMYI4dFUVBJalBWiidME63+vTYTptgqQXkUq7gvHGx6wF5MMvL9l4/b
         KEqazgxDUhkhOAhGZRkraZ5J8Upn9Z7L31+x58NHErb0rrniaq8w8kWiPr6bsOWXDR4a
         gr83pvMImhlv0dpdfoIDDPo5qs5rseYBPcw+cc9ddr9AqmvleEFLOM2cEJh+XX5v9u2W
         34QQ==
X-Gm-Message-State: AHQUAubR3KRyPqTwot6oalEJ1ZYzMs4durcwRbW1rXxQk0X31p7sSk54
        3TwD8or5I9S+XgE0EeGR58Y=
X-Google-Smtp-Source: AHgI3IYXLUhWKg8I/ioCM7qZEdMTRYYumq0dXvzLglSSK0sgSPtHL4oFWamizN3NdLA5M664noDUYg==
X-Received: by 2002:a19:5601:: with SMTP id k1mr299142lfb.99.1550064790553;
        Wed, 13 Feb 2019 05:33:10 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id l12-v6sm3418571lja.13.2019.02.13.05.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 05:33:09 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:33:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: [PATCH v9 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Message-ID: <a604584183bd8913431b5dd2dc5f799cf0a87976.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
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

I maintained reviewed-by and acked-by tags as modifictions to this
version were only grammar fixes and using whole word instead
of an abbreviation. Please let me know if there is any objections.

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
new file mode 100644
index 000000000000..120462c17904
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -0,0 +1,102 @@
+* ROHM BD70528 Power Management Integrated Circuit bindings
+
+BD70528MWV is an ultra-low quiescet current general purpose single-chip
+power management IC for battery-powered portable devices. The IC
+integrates 3 ultra-low current consumption buck converters, 3 LDOs and 2
+LED Drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
+clock gate, high-accuracy VREF for use with an external ADC, flexible
+dual-input power path, 10 bit SAR ADC for battery temperature monitor and
+1S battery charger with scalable charge currents.
+
+Required properties:
+ - compatible		: Should be "rohm,bd70528"
+ - reg			: I2C slave address.
+ - interrupts		: The interrupt line the device is connected to.
+ - interrupt-controller	: To indicate BD70528 acts as an interrupt controller.
+ - #interrupt-cells	: Should be 2. Usage is compliant to the 2 cells
+			  variant of ../interrupt-controller/interrupts.txt
+ - gpio-controller	: To indicate BD70528 acts as a GPIO controller.
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
