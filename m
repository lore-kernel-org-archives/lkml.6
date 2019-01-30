Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF005C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7838520821
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548874431;
	bh=8THRmyz+fgVaniTI/ueITJ/39qS9j7bJWcj5iJMtXUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VTbmMkbIuFsmy2zQnJq0ScVC+sXe6ss0OEJON74Qz1Xivji9mVU8H1r14Z1/O5Djo
	 zfbyAqMYtuYLTWIxYoho2xX5FqbyYGnaeYIcSr22vqm2b2mCQEw+Q1yJ/9NRBRnUbB
	 G5ZcQNNjQ0YxRY0WU0VwWvf1H14asiyqd5Z8FEbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfA3Sxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:53:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34972 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbfA3Sxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:53:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so568625otj.2;
        Wed, 30 Jan 2019 10:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n82G04yy4y3goYBawCI7wFPB8cbwDuNMggACM2cuDHk=;
        b=inQi00FgZD7pqz/FUfro3jR2gfmKOf0aO1hq07xCKaerZoCijF7YEAgusecES6nvxZ
         5z0/Kc/bAeybKi1tSjEaDQaEcCjU3Wl655/m0+k6Nz/uoEOy+6/Zv0bfIbpK2ypfKQdJ
         tbOvYoprDWUBPXPug0LugwmtJ1cQxH+KXj5hrQhzDUBQWkEyTcyO4abJEg4S6wTozwtd
         3w/qRcRpLXLlDsdeO0YwaI/hg0LcFSFJx4faqLSKXy7j056V+4HCmvRa8+Wwa8Xl5045
         9k9uNjZAigVGCN6TdEUCvRQ46Wer2jl6g91xsXmqPHmKVLniGWbZbDbM1S6xHWh75twm
         wGDg==
X-Gm-Message-State: AJcUukc12ujspAztjD0HG2U4Nn9y6wNN+28jSnn2xNwOPRbuG/65KUik
        p4n6mcHPZ4nF2LYCbLWflg==
X-Google-Smtp-Source: ALg8bN78dpbhX+G1WlRrgcaNgGSK7wsj/zturmTUWLqS9PIiYBxcZiupeuhNZ1kO86BSOnAWgnL4Cw==
X-Received: by 2002:a9d:e8c:: with SMTP id 12mr23937974otj.297.1548874425431;
        Wed, 30 Jan 2019 10:53:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm830341otf.73.2019.01.30.10.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:53:44 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:53:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v3 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
Message-ID: <20190130185344.GA14789@bogus>
References: <cover.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
 <eb5d03f3adc72db580a10f95ff6cb07aefce5b47.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5d03f3adc72db580a10f95ff6cb07aefce5b47.1548838724.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:09:55AM +0200, Matti Vaittinen wrote:
> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> new file mode 100644
> index 000000000000..21801440a53a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> @@ -0,0 +1,104 @@
> +* ROHM BD70528 Power Management Integrated Circuit bindings
> +
> +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC
> +for battery-powered portable devices. The IC integrates 3 ultra-low current
> +consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
> +GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
> +for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC
> +for battery temperature monitor and 1S battery charger with scalable charge
> +currents.
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd70528"
> + - reg			: I2C slave address.
> + - interrupt-parent	: Phandle to the parent interrupt controller.

Don't document this. It is implied and could be in a parent node.

> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.
> + - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells
> +			  variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller	: To indicate bd70528 acts as a gpio controller.
> + - #gpio-cells		: Should be 2. The first cell is the pin number and
> +			  the second cell is used to specify flags. See
> +			  ../gpio/gpio.txt for more information.
> + - clock-frequency	: Should be 32768

Forget to drop this?

> + - #clock-cells		: Should be 0.
> + - regulators:		: List of child nodes that specify the regulators.
> +			  Please see ../regulator/rohm,bd70528-regulator.txt
> +
> +Optional properties:
> + - clock-output-names	: Should contain name for output clock.
> +
> +Example:
> +/* external oscillator */
> +osc: oscillator {
> +	compatible = "fixed-clock";
> +	#clock-cells = <1>;
> +	clock-frequency  = <32768>;
> +	clock-output-names = "osc";
> +};
> +
> +pmic: bd70528@4b {

pmic@4b

Node names should be generic.

> +	compatible = "rohm,bd70528";
> +	reg = <0x4b>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <29 GPIO_ACTIVE_LOW>;
> +	clocks = <&osc 0>;
> +	#clock-cells = <0>;
> +	clock-output-names = "bd70528-32k-out";
> +	#gpio-cells = <2>;
> +	gpio-controller;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	regulators {
> +		buck1: BUCK1 {
> +			regulator-name = "buck1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck2: BUCK2 {
> +			regulator-name = "buck2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck3: BUCK3 {
> +			regulator-name = "buck3";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <250>;
> +		};
> +		ldo1: LDO1 {
> +			regulator-name = "ldo1";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +		ldo2: LDO2 {
> +			regulator-name = "ldo2";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +
> +		ldo3: LDO3 {
> +			regulator-name = "ldo3";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +		led_ldo1: LED_LDO1 {
> +			regulator-name = "led_ldo1";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +		led_ldo2: LED_LDO2 {
> +			regulator-name = "led_ldo2";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +	};
> +};
> -- 
> 2.14.3
> 
> 
> -- 
> Matti Vaittinen
> ROHM Semiconductors Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
