Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD17BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA7D2195D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0kIL7DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBGOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:04:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35805 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbfBGOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:04:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z18so10924099wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NnkYkY79hk+jvPvsN3Y+qhBvp39+aQqXIYNmpPifzYg=;
        b=t0kIL7DZ1GbOPDlyDvMOtQLIex+0qFztfSjTsvR6lZBkcw2ekZLPzYWcu74GCCr0tH
         9dIozVUFrx68hsVdmZM4h7LqDMEt7o2wWk/LBmGcjJnL8Ee64mKBtkaUU70SoMzkCydv
         YyE8K8SJlvsRRHQ1yQtURvpTKCnV7ryByzFNJPfFMXKdVcMzIzpnGudTZklXLpTu9Agb
         P0kJwyW5ml10zE0jqC3Ed/Nsq4kpPOkQjOTvl7J+Rawhrlq1c4zE6u1by7Z/VjSStFjG
         zbYrYDljvZPZToypPZhDGEqrOMITMMJFrDvQwYJVr+2t4w/zIoksfkN6kVJW/8mZaXWl
         Re2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NnkYkY79hk+jvPvsN3Y+qhBvp39+aQqXIYNmpPifzYg=;
        b=DyV1Efjzad3fDIopZlzUweRBv3WWLfdRFuf9cWAlKqDF8mstAJ0K+ePnubtB5i1Ja6
         c7s72Sxhi6w4/djPYUgHkwn6DyDhD5ju2MoNO9WJ4OTKvSm88YRUhOLahLCcALwUL2AA
         F0NSk70zLuV0wpBmJc5IM/0iDxaH1UzKZ+E1Ba2O3elytyLE4+V+xwCx69NrnnU2TE6u
         AE+daeJRYruRq8AC7plCLsNP1hrQ6lcucYrEInh6aRaP3z9Yd51/NL5oOda0D0D71XA3
         9Y7TQfhLRLzbn8fdJwlHSK8EZ85W5HBXkEjr30T3h4zANREMiENLnX/J0314t03T0Zfy
         nfGQ==
X-Gm-Message-State: AHQUAuZV/eAYkJDNQYOkGCpNEikO2KUBcdX8G619Q6wJ6pIBI/CeDJpG
        Ycg3Rz8Wjr4EpPzL7xqkxcQUqA==
X-Google-Smtp-Source: AHgI3IbEyfIM3qljzk86aDIDDKYiiJdIvfHaHYDpkfaMY07ofR4qnUP0NA640vr7YDIxMgZZclIYdQ==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr12623003wrc.191.1549548260651;
        Thu, 07 Feb 2019 06:04:20 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id v7sm8900322wru.73.2019.02.07.06.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 06:04:19 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:04:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Message-ID: <20190207140418.GH20638@dell>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Matti Vaittinen wrote:

> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> new file mode 100644
> index 000000000000..f80be7e40184
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> @@ -0,0 +1,102 @@
> +* ROHM BD70528 Power Management Integrated Circuit bindings
> +
> +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC

What's an Iq?

> +for battery-powered portable devices. The IC integrates 3 ultra-low current
> +consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
> +GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
> +for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC

"bit"

> +for battery temperature monitor and 1S battery charger with scalable charge
> +currents.
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd70528"
> + - reg			: I2C slave address.
> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.

"BS70528"

> + - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells

"Usage"

> +			  variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller	: To indicate bd70528 acts as a gpio controller.

"BD*"

"GPIO"

> + - #gpio-cells		: Should be 2. The first cell is the pin number and
> +			  the second cell is used to specify flags. See
> +			  ../gpio/gpio.txt for more information.
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
> +pmic: pmic@4b {
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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
