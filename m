Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeBGQLq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:11:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40306 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754381AbeBGQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:11:44 -0500
X-Google-Smtp-Source: AH8x225j3y2kbR6GpGOUi76rT+0b7nm+qDxSiGw+CKtkNReEDh2RhlAmLKNub4S3FWfASwnSHJ4rFQ==
Date: Wed, 7 Feb 2018 16:11:40 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pwm-backlight: add a
 num-interpolation-steps property.
Message-ID: <20180207161140.irxnsv6dwwmuwczu@oak.lan>
References: <20180207141337.22247-1-enric.balletbo@collabora.com>
 <20180207141337.22247-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207141337.22247-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 03:13:35PM +0100, Enric Balletbo i Serra wrote:
> The num-interpolated-steps property specifies the number of
> interpolated steps between each value of brightness-level table. This is
> useful for high resolution PWMs to not have to list out every possible
> value in the brightness-level array.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes since v1:
> - Add an example with a small but realistic curve. Suggested by Rob and
>   Daniel
> 
>  .../bindings/leds/backlight/pwm-backlight.txt         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 310810906613..ce9b5746b774 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -21,6 +21,11 @@ Optional properties:
>                            and enabling the backlight using GPIO.
>    - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
>                        and setting PWM value to 0.
> +  - num-interpolated-steps: Number of interpolated steps between each value
> +                            of brightness-levels table. This way a high
> +                            resolution pwm duty cycle can be used without
> +                            having to list out every possible value in the
> +                            brightness-level array.
>  
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -39,3 +44,17 @@ Example:
>  		post-pwm-on-delay-ms = <10>;
>  		pwm-off-delay-ms = <10>;
>  	};
> +
> +Example using num-interpolation-steps:
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 5000000>;
> +
> +		brightness-levels = <0 2048 4096 8192 16384 65535>;
> +		num-interpolated-steps = <2048>;
> +		default-brightness-level = <4096>;
> +
> +		power-supply = <&vdd_bl_reg>;
> +		enable-gpios = <&gpio 58 0>;
> +	};
> -- 
> 2.15.1
> 
