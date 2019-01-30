Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F3C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606102087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfA3JKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:10:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42592 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfA3JKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:10:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so16796605lfh.9;
        Wed, 30 Jan 2019 01:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qNcmJLdh/fuAG9dR1RnhHjNa+v4TZUR4kRLUPCzfzw8=;
        b=dsoguaYQUovaUm9+fN+4rLGtr/rpGU/p6oO7VvdsiC0O46nfiG/F2rrmI43thFkGX6
         Ig9nGAet6oly44NrovRcLnW5y6k9UbYReAwIdEXpiInp1XLPC383vM4sOwtTssWhtZhU
         Hw0oCyPQSbb9O8GZFp8O8VtcY3cPR9YNJ+yWoBHsGeYvXgIgpkofLD0G83Pc1WInu9zq
         RjtXXDjrke8P3k9QGHtJp5kJqrGedK/cnR7C024dKDi4ri/VSM+ocelR+JC65TSGVxMN
         GYSLO3PYPJG1MWH6PsIPLT1ZzAeLHCQR7WsC60pPM+/aAbALntH1H45bmQ9EhxYqxcs9
         eKNg==
X-Gm-Message-State: AJcUukf7FDt+wMA5jYbsghrplQkjUlTo/s/Mp09Y9G9+R6K4GNZDKPaC
        Qe1ecmccG8nFqBgXhACYlkY=
X-Google-Smtp-Source: ALg8bN5B3xdrbzM8ZrM1g44Fk50ac+63biWfFSf+4OeqgC1XVXfMd+kEOlFEA0IfbVLdo3p9odW7cg==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr20241760lfg.93.1548839409296;
        Wed, 30 Jan 2019 01:10:09 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r26-v6sm174147lji.25.2019.01.30.01.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 01:10:08 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:09:55 +0200
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
Subject: [RFC PATCH v3 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
Message-ID: <eb5d03f3adc72db580a10f95ff6cb07aefce5b47.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
drivers) and 4 GPIO pins which can be configured for I/O or
as interrupt sources withe configurable trigger levels.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
new file mode 100644
index 000000000000..21801440a53a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
@@ -0,0 +1,104 @@
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
+ - interrupt-parent	: Phandle to the parent interrupt controller.
+ - interrupts		: The interrupt line the device is connected to.
+ - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.
+ - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells
+			  variant of ../interrupt-controller/interrupts.txt
+ - gpio-controller	: To indicate bd70528 acts as a gpio controller.
+ - #gpio-cells		: Should be 2. The first cell is the pin number and
+			  the second cell is used to specify flags. See
+			  ../gpio/gpio.txt for more information.
+ - clock-frequency	: Should be 32768
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
+pmic: bd70528@4b {
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
Matti Vaittinen
ROHM Semiconductors Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
