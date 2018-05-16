Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEPHYe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:24:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60816 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPHYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:24:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 16 May 2018 09:24:31 +0200
From: Stefan Agner <stefan@agner.ch>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
In-Reply-To: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
References: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
Message-ID: <682aea7dc714fea095f935d41c8fa270@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2018 08:39, Nikita Yushchenko wrote:
> Vybrid has single internal temperature sensor connected to both internal
> ADC modules.
> 
> vf610-zii-dev already has ADC0 enabled. Now, to get temperature sensor
> captured by iio_hwmon driver, need to configure iio_hwmon node to use
> that ADC.

That seems sensible.

Acked-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++++
>  arch/arm/boot/dts/vfxxx.dtsi         | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi
> b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> index 4890b8a5aa44..5ae5abfe1d55 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
> +++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> @@ -222,6 +222,10 @@
>  	status = "okay";
>  };
>  
> +&tempsensor {
> +	io-channels = <&adc0 16>;
> +};
> +
>  &iomuxc {
>  	pinctrl_adc0_ad5: adc0ad5grp {
>  		fsl,pins = <
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index c3f09b737924..d392794d9c13 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -84,7 +84,7 @@
>  		mask = <0x1000>;
>  	};
>  
> -	iio-hwmon {
> +	tempsensor: iio-hwmon {
>  		compatible = "iio-hwmon";
>  		io-channels = <&adc0 16>, <&adc1 16>;
>  	};
