Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B540C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D1D206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881845;
	bh=QX5uUdByjiiWq59lOPox1ugOK6t4CcL2NDP3rUjVtqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnbPPZkOzbXYlUTpjy53ervYRg/+qZ282SV+beEjazjBHz6lck3kwv3vYmMwAL0NJ
	 M/NXC/jiH2rHk42NBK94WasUpStC4UDFKdGfEpprZfKBdC9e3XywDhVOTthpZkTIXg
	 3pJkkhnWnahpbW3eLgdnmDWS/don7jRnqLbEDjSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBWAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:30:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35317 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBWAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:30:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id u128so3172324oie.2;
        Fri, 22 Feb 2019 16:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mj2zpxbrV3m06WEbub19SHYmtQa20P4XRmG7bK+Mjbs=;
        b=XxK82EtFsXU68IRCpo7V+iy4EG3bjrkfipmBauy4Zgc8vIGpPH3hpaNioQT5tI3j4Y
         43RhUzEynlWOa+wmnMHRdFEUNhFA/ockwB5lsKdxb7f0bfJG50O5Udvwsr+btnhT4jnp
         yQfoGqR2f/5oATCv6zdw0JC7sjsMOiq0HxQbZit+5r2v9kKxc0GSwVr7W7+fo7ea2BBr
         nVVDeGDa1iSFhEs7CI2Yno4RtQccEUgGA0M1hjOrUeK4Ukb6uaj4yHokC5fc7bMSLRMe
         u2TubQS19GxiMD1hdemGTKaNhytaw6+CAXAJW5ocYlC9urCQ7KykWaBhah1bZtmvUnTW
         mjdg==
X-Gm-Message-State: AHQUAua9+X9Xl0uv5avfADu9byLy2yuZQDEf7IxLei7lNNrrVd7zjWmL
        o+Kpx2KhUTNOUE/eYxYogg==
X-Google-Smtp-Source: AHgI3IZIFbKG9LmWSTtxCInD2vwNyddirZjOsIU49Y/DbcMTCyBhZRB/VdSyNFTaSWg92TKy38tyfQ==
X-Received: by 2002:aca:dbc4:: with SMTP id s187mr4030761oig.124.1550881842825;
        Fri, 22 Feb 2019 16:30:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm1208979otc.7.2019.02.22.16.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:30:42 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:30:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 07/13] devicetree: bindings: Document first ROHM
 BD70528 bindings
Message-ID: <20190223003041.GA16670@bogus>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80de7a2b537ae3f414b0281736652256f38cf94c.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:45:38AM +0200, Matti Vaittinen wrote:
> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.

'dt-bindings: mfd: ...' for the subject.

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

Don't need to document this. It is implied and could be in the parent.

> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.
> + - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells
> +			  variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller	: To indicate bd70528 acts as a gpio controller.
> + - #gpio-cells		: Should be 2. The first cell is the pin number and
> +			  the second cell is used to specify flags. See
> +			  ../gpio/gpio.txt for more information.
> + - clock-frequency	: Should be 32768
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
> ROHM Semiconductors
> 
> ~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
