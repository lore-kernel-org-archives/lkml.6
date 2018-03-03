Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeCCOWT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 09:22:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeCCOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 09:22:17 -0500
Date: Sat, 3 Mar 2018 15:21:56 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Matheus Castello <matheus@castello.eng.br>
Cc: linus.walleij@linaro.org, eric@anholt.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <431699005.307231.1520086916739@email.1und1.de>
In-Reply-To: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
References: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
Subject: Re: [PATCH] pinctrl: bc2835: Add brcm,level property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:BR37JSdNSmTJq+S7A+lgWaIZvknAW7RkTWrATTHYUU3TTNLBvYf
 skHChT+MqPhpCMudsZAd1FO5FXScpOh4EyH3qfEUFLrcn1Zmm4n/t/ksHULNRq4+2Hkyqu4
 ArXfVYvi4NcdyyK3bpj/8MaWiMQCtPMMrV1+F94oz7ug3b08D3DQn58twqr1Us0fwH73kYo
 Wq4Ofp82zNJ6TMOuPqKsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uwrajxUHSQ4=:dkIvNYUNEaijQn/zPDiinE
 TYOlMuzLEXiwbShraRM69kNFnVauqdJMW36aNwenjTCTy5QJ2jFiSE73xsAkEbjVszD5FCj0H
 fq7S7C6zKFxtt42Aq952bI9hqQmyZnukhGBt6YYDvXeBzWxhMzG9ezXBrPbX15PwFPR5OK5D/
 Q0pR6kAsWdhLyU1OYysfpFUbv15Sn2iT0Y5lXajD3nceyQ7vERmQHvKlv6dJsGc9PgcNvTKmV
 w8PwwTojKbH/rmBqwz4wjYNRpPpAFvGGqjy00D0W4FqC8qMcsi1r6sW+Mxw4B1IEU58TYaSeR
 qHn7De+T/z/g2TldrIuFDeC8v+TahLnHa7ZvZ7TOuCqx3EBnTVgAa8Zage0OOELPTkUyFkORx
 2jnknnYqUKEzS7BQFT75+YG0wnbM79UwMDeZYo7h4rngo/MAHfJGbZH40+bOs15ckJvOlS5Ie
 rwwFw1IQSDRtD2O/ZGNiw+V9io9cuHzyHEWafNeNLgtnVWbowcmiJrdFkcorT7C4JQiRXosmS
 ecZMxTcItLAtHvInbM86oviGdb/ZW1xedneC0bribZTcjKMfb6eXD3qc2ZRfQPEDoT2TYEUCR
 zcjgaIDXhffbZBeQlH+M66goqv8LXfFLDrYirwlZE4JKITMmACkzRyIuZjVI4L61dlqSznNPX
 68TG0bm1AHT9h+/qfiev4uumoELMnDwcqAahF64Yv+WE8O6pSMVxbJYEpgOENpyEzDc25esZX
 b49io4RkUzR0uBNqLYc+Qg6ht2ukBEyTfKChSn3t+9HIjBJoupSctXQNvvI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

sorry for my late reply.

> Matheus Castello <matheus@castello.eng.br> hat am 22. Februar 2018 um 18:44 geschrieben:
> 
> 
> Property to set initial value of pin output buffer.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../bindings/pinctrl/brcm,bcm2835-gpio.txt         |  5 +-
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 90 +++++++++++++++++-----
>  2 files changed, 75 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> index 2569866..6834f1d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt

Changes to the devicetree binding should be a separate patch. Please read [1] and use the get_maintainers script for all patches.

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/submitting-patches.txt

> @@ -54,8 +54,11 @@ Optional subnode-properties:
>    0: none
>    1: down
>    2: up
> +- brcm,level: Integer, representing the value of output buffer to apply to the pin(s):
> +  0: low
> +  1: high

As Linus suggested please don't introduce new legacy properties. We already have generic ones for this. After mention the supported properties, simply make a reference to the generic binding.

>  
> -Each of brcm,function and brcm,pull may contain either a single value which
> +Each of brcm,function, brcm,pull and brcm,level may contain either a single value which
>  will be applied to all pins in brcm,pins, or 1 value for each entry in
>  brcm,pins.
>  
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 785c366..0ace548 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -73,6 +73,8 @@
>  enum bcm2835_pinconf_param {
>  	/* argument: bcm2835_pinconf_pull */
>  	BCM2835_PINCONF_PARAM_PULL,
> +	/* argument: bcm2835_pinconf_level */
> +	BCM2835_PINCONF_PARAM_LEVEL,
>  };
>  
>  #define BCM2835_PINCONF_PACK(_param_, _arg_) ((_param_) << 16 | (_arg_))
> @@ -725,16 +727,42 @@ static int bcm2835_pctl_dt_node_to_map_pull(struct bcm2835_pinctrl *pc,
>  	return 0;
>  }
>  
> +static int bcm2835_pctl_dt_node_to_map_level(struct bcm2835_pinctrl *pc,
> +		struct device_node *np, u32 pin, u32 level,
> +		struct pinctrl_map **maps)
> +{
> +	struct pinctrl_map *map = *maps;
> +	unsigned long *configs;
> +
> +	if (level > 2) {
> +		dev_err(pc->dev, "%pOF: invalid brcm,level %d\n", np, level);
> +		return -EINVAL;
> +	}
> +
> +	configs = kzalloc(sizeof(*configs), GFP_KERNEL);
> +	if (!configs)
> +		return -ENOMEM;
> +	configs[0] = BCM2835_PINCONF_PACK(BCM2835_PINCONF_PARAM_LEVEL, level);
> +
> +	map->type = PIN_MAP_TYPE_CONFIGS_PIN;
> +	map->data.configs.group_or_pin = bcm2835_gpio_pins[pin].name;
> +	map->data.configs.configs = configs;
> +	map->data.configs.num_configs = 1;
> +	(*maps)++;
> +
> +	return 0;
> +}
> +
>  static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		struct device_node *np,
>  		struct pinctrl_map **map, unsigned *num_maps)
>  {
>  	struct bcm2835_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> -	struct property *pins, *funcs, *pulls;
> -	int num_pins, num_funcs, num_pulls, maps_per_pin;
> +	struct property *pins, *funcs, *pulls, *levels;
> +	int num_pins, num_funcs, num_pulls, num_levels, maps_per_pin;
>  	struct pinctrl_map *maps, *cur_map;
>  	int i, err;
> -	u32 pin, func, pull;
> +	u32 pin, func, pull, level;
>  
>  	pins = of_find_property(np, "brcm,pins", NULL);
>  	if (!pins) {
> @@ -744,6 +772,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  
>  	funcs = of_find_property(np, "brcm,function", NULL);
>  	pulls = of_find_property(np, "brcm,pull", NULL);
> +	levels = of_find_property(np, "brcm,level", NULL);
>  
>  	if (!funcs && !pulls) {
>  		dev_err(pc->dev,
> @@ -755,6 +784,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	num_pins = pins->length / 4;
>  	num_funcs = funcs ? (funcs->length / 4) : 0;
>  	num_pulls = pulls ? (pulls->length / 4) : 0;
> +	num_levels = levels ? (levels->length / 4) : 0;
>  
>  	if (num_funcs > 1 && num_funcs != num_pins) {
>  		dev_err(pc->dev,
> @@ -770,11 +800,20 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		return -EINVAL;
>  	}
>  
> +	if (num_levels > 1 && num_levels != num_pins) {
> +		dev_err(pc->dev,
> +			"%pOF: brcm,level must have 1 or %d entries\n",
> +			np, num_pins);
> +		return -EINVAL;
> +	}
> +
>  	maps_per_pin = 0;
>  	if (num_funcs)
>  		maps_per_pin++;
>  	if (num_pulls)
>  		maps_per_pin++;
> +	if (num_levels)
> +		maps_per_pin++;
>  	cur_map = maps = kzalloc(num_pins * maps_per_pin * sizeof(*maps),
>  				GFP_KERNEL);
>  	if (!maps)
> @@ -811,6 +850,17 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  			if (err)
>  				goto out;
>  		}
> +		if (num_levels) {
> +			err = of_property_read_u32_index(np, "brcm,level",
> +					(num_levels > 1) ? i : 0, &level);
> +			if (err)
> +				goto out;
> +
> +			err = bcm2835_pctl_dt_node_to_map_level(pc, np, pin,
> +							level, &cur_map);
> +			if (err)
> +				goto out;
> +		}
>  	}
>  
>  	*map = maps;
> @@ -931,23 +981,25 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
>  		param = BCM2835_PINCONF_UNPACK_PARAM(configs[i]);
>  		arg = BCM2835_PINCONF_UNPACK_ARG(configs[i]);
>  
> -		if (param != BCM2835_PINCONF_PARAM_PULL)
> +		if (param == BCM2835_PINCONF_PARAM_PULL) {
> +			off = GPIO_REG_OFFSET(pin);
> +			bit = GPIO_REG_SHIFT(pin);
> +
> +			bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> +			/*
> +			* Docs say to wait 150 cycles, but not of what. We assume a
> +			* 1 MHz clock here, which is pretty slow...
> +			*/
> +			udelay(150);
> +			bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> +			udelay(150);
> +			bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +		} else if (param == BCM2835_PINCONF_PARAM_LEVEL) {
> +			/* write in register */
> +			bcm2835_gpio_set_bit(pc, arg ? GPSET0 : GPCLR0, pin);
> +		} else {

Please separate the restructuring and the really new code into 2 patches. This make it easier to review.

Thanks
Stefan

>  			return -EINVAL;
> -
> -		off = GPIO_REG_OFFSET(pin);
> -		bit = GPIO_REG_SHIFT(pin);
> -
> -		bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> -		/*
> -		 * BCM2835 datasheet say to wait 150 cycles, but not of what.
> -		 * But the VideoCore firmware delay for this operation
> -		 * based nearly on the same amount of VPU cycles and this clock
> -		 * runs at 250 MHz.
> -		 */
> -		udelay(1);
> -		bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> -		udelay(1);
> -		bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +		}
>  	} /* for each config */
>  
>  	return 0;
> -- 
> 2.7.4
>
