Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245BD2413F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245BD2413F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeGEKj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:39:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45867 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeGEKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:39:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id q5-v6so6289684ljh.12;
        Thu, 05 Jul 2018 03:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OgxBrs+vcj8ZKFEvFtUZdRkIl+L0crXaz/CYUY6CUWM=;
        b=btMDkhSeeI8yrjluqTwAsqg8+fZGHHsf2BWeXNR8FsnDzq3nsMPAl9CoEo17tqAZZ1
         m9BkbzcyYsRCR7qCRTwOrkVOSqKStwt7Wi5vvRj8+EN2LmjPmKdQp4ZjJlogVCN/qAjv
         5RaF/9oRN25QSjXy+uWsFU4agoOioT2RWG2Ulws+D3eHceqDJyJhvA84k1x4W6W4Se6V
         pkPi7H9Q7liLs+A0uGd/KWxicZpl3G09vF7YHsnmjznygSDVm+PkFWBpaqeJrzHaILVn
         gSBtlIjpJUKxekBLsSXJtHm5oNmFJPZE63TY7nh9hGVcTo0b7ATFYALhvkngcqfbFEOa
         XPzw==
X-Gm-Message-State: APt69E3trT+l0xXSL7H59HeIFT+AR0b1D5NY0x7rI/nCI1wluBpZT2ep
        KRNeEGHO2Xmfw4mBKCD0GIY=
X-Google-Smtp-Source: AAOMgpe9DOuiy1sSS5gXm3NO97+vUk5QivQF2B8KZQSi4xLB68X2UC4oSLWVLbSgJVIm/Y09hiHl6Q==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr3541645lji.11.1530787163531;
        Thu, 05 Jul 2018 03:39:23 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-162.bb.dnainternet.fi. [82.203.190.162])
        by smtp.gmail.com with ESMTPSA id y6-v6sm893387ljy.42.2018.07.05.03.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:39:23 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:39:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180705103919.GB8426@localhost.localdomain>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705092444.GL496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705092444.GL496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And thanks again Lee!

On Thu, Jul 05, 2018 at 10:24:44AM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> 
> > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > new file mode 100644
> > index 000000000000..67f2616288d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > @@ -0,0 +1,67 @@
> > +* ROHM BD71837 Power Management Integrated Circuit bindings
> > +
> > +BD71837MWV is a programmable Power Management IC for powering single-core,
> > +dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
> 
> Nit: s/SOC's/SOCs/

I'll change this.

> > +low BOM cost and compact solution footprint. It integrates 8 Buck
> > +egulators and 7 LDO’s to provide all the power rails required by the SoC and
> 
> Nit: s/LDO's/LDOs/

I'll change this.

> > +the commonly used peripherals.
> > +
> > +Datasheet for PMIC is available at:
> > +https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> > +
> > +Required properties:
> > + - compatible		: Should be "rohm,bd71837".
> > + - reg			: I2C slave address.
> > + - interrupt-parent	: Phandle to the parent interrupt controller.
> > + - interrupts		: The interrupt line the device is connected to.
> > + - clocks		: The parent clock connected to PMIC. If this is missng
> 
> s/missng/missing/

I'll change this.

> > +			  32768 KHz clock is assumed.
> > + - #clock-cells		: Should be 0
> > + - regulators:		: List of child nodes that specify the regulators
> 
> By your convention, the bottom two entries are missing '.'s.

I'll change this.

> > +			  Please see ../regulator/rohm,bd71837-regulator.txt
> > +
> > +Optional properties:
> > +- clock-output-names	: Should contain name for output clock.
> > +
> > +Example:
> > +
> > +	/* external oscillator node */
> 
> Uppercase character to start a sentence.

I'll change this.

> > +	osc: oscillator {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <1>;
> > +		clock-frequency  = <32768>;
> > +		clock-output-names = "osc";
> > +	};
> > +
> > +	/* PMIC node */
> 
> Is this comment really necessary?  The node is called "pmic".

I'll remove this.

> > +	pmic: pmic@4b {
> > +		compatible = "rohm,bd71837";
> > +		reg = <0x4b>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <29 GPIO_ACTIVE_LOW>;
> > +		interrupt-names = "irq";
> > +		#clock-cells = <0>;
> > +		clocks = <&osc 0>;
> > +		clock-output-names = "bd71837-32k-out";
> > +
> > +		regulators {
> > +			buck1: BUCK1 {
> > +				regulator-name = "buck1";
> > +				regulator-min-microvolt = <700000>;
> > +				regulator-max-microvolt = <1300000>;
> > +				regulator-boot-on;
> > +				regulator-ramp-delay = <1250>;
> > +			};
> > +			/* ... */
> > +		};
> > +	};
> > +
> > +	/* Clock consumer node */
> > +
> > +	foo@0 {
> > +		compatible = "bar,foo";
> > +		/* ... */
> 
> No need for this line.  Additional properties are always expected.

I'll remove this.

> > +		clock-names = "my-clock";
> > +		clocks = <&pmic>;
> > +	};
> 
> Do you have a real example to give?

For clock consumer? Sorry, no I don't.

Br,
	Matti Vaittinen

> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
