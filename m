Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A74208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A74208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbeKMWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:20:05 -0500
Received: from foss.arm.com ([217.140.101.70]:54254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbeKMWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:20:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 766B9EBD;
        Tue, 13 Nov 2018 04:22:11 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14EC03F5CF;
        Tue, 13 Nov 2018 04:22:07 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:22:04 +0000
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
Subject: Re: [PATCH v4 25/26] [DO NOT MERGE] arm64: dts: allwinner:
 bananapi-m64: Bananapi S070WV20-CT16 DSI panel
Message-ID: <20181113122204.337db8b1@donnerap.cambridge.arm.com>
In-Reply-To: <20181113111633.20189-26-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
        <20181113111633.20189-26-jagan@amarulasolutions.com>
Organization: ARM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 16:46:32 +0530
Jagan Teki <jagan@amarulasolutions.com> wrote:

Hi,

> This patch add support for Bananapi S070WV20-CT16 DSI panel to
> BPI-M64 board.
> 
> DSI panel connected via board DSI port with,
> - DC1SW as AVDD supply

Are you sure of that? I don't see anything in the schematic to support
this. The only power lines that go to the DSI connector are DCDC1 and
PS. DC1SW is only connected to PortD on the SoC and to the Ethernet PHY.
Is there anything I miss?

> - DCDC1 as DVDD supply

That seems right, but doesn't match with what you write below.

> - PD6 gpio for reset pin
> - PD5 gpio for backlight enable pin
> - PD7 gpio for backlight vdd supply
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42
> +++++++++++++++++++ 1 file changed, 42 insertions(+)
> 
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts index
> ef1c90401bb2..6cb010e3bbd9 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts @@ -45,6
> +45,7 @@ #include "sun50i-a64.dtsi" 
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
>  
>  / {
>  	model = "BananaPi-M64";
> @@ -56,6 +57,15 @@
>  		serial1 = &uart1;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <1 2 4 8 16 32 64 128 512>;
> +		default-brightness-level = <2>;
> +		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /*
> LCD-BL-EN: PD5 */
> +		power-supply = <&reg_vdd_backlight>;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> @@ -91,6 +101,15 @@
>  		};
>  	};
>  
> +	reg_vdd_backlight: vdd-backlight {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-backlight";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN:
> PD7 */
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> @@ -101,6 +120,23 @@
>  	status = "okay";
>  };
>  
> +&dphy {
> +	status = "okay";
> +};
> +
> +&dsi {
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "bananapi,s070wv20-ct16-icn6211";
> +		reg = <0>;
> +		avdd-supply = <&reg_dc1sw>;

As mentioned above, I don't see this on the DSI connector.

> +		dvdd-supply = <&reg_dldo1>;

Mmh, this line is connected to the *SoC*, to drive the DSI data lines
or the DPHY, presumably. So I wouldn't expect it in the panel node, but
rather in the DPHY or DSI node. Although I can't find a power-supply
property in those bindings.

Cheers,
Andre.

> +		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /*
> LCD-RST: PD6 */
> +		backlight = <&backlight>;
> +	};
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -193,6 +229,12 @@
>  	status = "okay";
>  };
>  
> +&r_pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&r_pwm_pin>;
> +	status = "okay";
> +};
> +
>  &r_rsb {
>  	status = "okay";
>  

