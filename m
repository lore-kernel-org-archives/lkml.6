Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE4AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0222243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0222243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbeKMWar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:30:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbeKMWar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:30:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD7FEBD;
        Tue, 13 Nov 2018 04:32:51 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B87913F5CF;
        Tue, 13 Nov 2018 04:32:47 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:32:41 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v4 26/26] arm64: dts: allwinner: a64-amarula-relic:
 Enable Techstar TS8550B MIPI-DSI panel
Message-ID: <20181113123241.7d0960b4@donnerap.cambridge.arm.com>
In-Reply-To: <20181113111633.20189-27-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
        <20181113111633.20189-27-jagan@amarulasolutions.com>
Organization: ARM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 16:46:33 +0530
Jagan Teki <jagan@amarulasolutions.com> wrote:

Hi,

I couldn't find a schematic for this board, but some things in here
look inconsistent:

> Amarula A64-Relic board by default bound with Techstar TS8550B
> MIPI-DSI panel, add support for it.
> 
> DSI panel connected via board DSI port with,
> - DC1SW as AVDD supply
> - DCDC2 as DVDD supply

Are you sure of that? That's typically the CPU power supply. Also I
can't find it below. Should that read DLDO2 instead?

> - DCDC1 as VCC-DSI supply

Can't find this below, either. Is it DLDO1?

> - PD24 gpio for reset pin
> - PD23 gpio for backlight enable pin
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 46
> +++++++++++++++++++ 1 file changed, 46 insertions(+)
> 
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts index
> 6cb2b7f0c817..ecc0d8094815 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts @@ -9,6
> +9,7 @@ #include "sun50i-a64.dtsi" 
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
>  
>  / {
>  	model = "Amarula A64-Relic";
> @@ -18,6 +19,14 @@
>  		serial0 = &uart0;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <1 2 4 8 16 32 64 128 512>;
> +		default-brightness-level = <2>;
> +		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /*
> LCD-BL-EN: PD23 */
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -30,6 +39,28 @@
>  	};
>  };
>  
> +&de {
> +	status = "okay";
> +};
> +
> +&dphy {
> +	status = "okay";
> +};
> +
> +&dsi {
> +	vcc-dsi-supply = <&reg_dldo1>;

Ah, there we have the SoC DSI power supply I was missing for the
BPi-M64 patch.
But is it DLDO1 or DCDC1, like you wrote above?

> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "techstar,ts8550b";
> +		reg = <0>;
> +		avdd-supply = <&reg_dc1sw>;
> +		dvdd-supply = <&reg_dldo2>;
> +		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /*
> LCD-RST: PD24 */
> +		backlight = <&backlight>;
> +	};
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -72,6 +103,12 @@
>  	status = "okay";
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pin>;
> +	status = "okay";
> +};
> +
>  &r_rsb {
>  	status = "okay";
>  
> @@ -107,6 +144,15 @@
>  	regulator-name = "vcc-pll-avcc";
>  };
>  
> +&reg_dc1sw {
> +	/*
> +	 * This regulator also indirectly drives the PD pingroup
> GPIOs,
> +	 * which also controls the power LED.
> +	 */

Is that true for this board as well or is this just a copy&paste
leftover from the BananaPi-M64? If not, you should loose the
regulator-always-on property.

> +	regulator-always-on;
> +	regulator-name = "vcc-phy";

Shouldn't this be called "vcc-dsi" or so?

Cheers,
Andre.

> +};
> +
>  &reg_dcdc1 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <3300000>;

