Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeCNHFR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 03:05:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:48067 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCNHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 03:05:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2E74w3b021031
X-Nifty-SrcIP: [209.85.213.50]
X-Google-Smtp-Source: AG47ELsmS1yedfZHZyHNbpe4KAhjivjZsApu5qrdQfolKhbWWeeGkpf+4ypsFVoWsm6vuGn2WPvYIT5Z78RO9UG/5i0=
MIME-Version: 1.0
In-Reply-To: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
References: <20180314063535.13303-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Mar 2018 16:04:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJ49LeFSG_WYoF_LJBAzyb4JSp9DENdG9s2u9gY=5Nwg@mail.gmail.com>
Message-ID: <CAK7LNASJ49LeFSG_WYoF_LJBAzyb4JSp9DENdG9s2u9gY=5Nwg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: divide I2S and S/PDIF audio out
 pin-mux group
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-14 15:35 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch divides large pin-mux group 'aio' of UniPhier LD11/LD20
> to 2 groups as following:
>   aout1   : 8ch I2S output: AO1DACCK, AO1BCK, AO1LRCK, AO1D[0-2]
>   aoutiec1: S/PDIF output : AO1IEC, AO1ARC
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 15 ++++++++++-----
>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 15 ++++++++++-----
>  2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> index 8a5ecd6277d8..5ec5afa70413 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> @@ -470,8 +470,10 @@ static const struct pinctrl_pin_desc uniphier_ld11_pins[] = {
>                              166, UNIPHIER_PIN_PULL_DOWN),
>  };
>
> -static const unsigned aout_pins[] = {135, 136, 137, 138, 139, 140, 141, 142};
> -static const int aout_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
> +static const unsigned aout1_pins[] = {137, 138, 139, 140, 141, 142};
> +static const int aout1_muxvals[] = {0, 0, 0, 0, 0, 0};
> +static const unsigned aoutiec1_pins[] = {135, 136};
> +static const int aoutiec1_muxvals[] = {0, 0};
>  static const unsigned int emmc_pins[] = {19, 20, 21, 22, 23, 24, 25};
>  static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
>  static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
> @@ -547,7 +549,8 @@ static const unsigned int gpio_range5_pins[] = {
>  };
>
>  static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
> -       UNIPHIER_PINCTRL_GROUP(aout),
> +       UNIPHIER_PINCTRL_GROUP(aout1),
> +       UNIPHIER_PINCTRL_GROUP(aoutiec1),
>         UNIPHIER_PINCTRL_GROUP(emmc),
>         UNIPHIER_PINCTRL_GROUP(emmc_dat8),
>         UNIPHIER_PINCTRL_GROUP(ether_rmii),
> @@ -573,7 +576,8 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
>         UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range5),
>  };
>
> -static const char * const aout_groups[] = {"aout"};
> +static const char * const aout1_groups[] = {"aout1"};
> +static const char * const aoutiec1_groups[] = {"aoutiec1"};
>  static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
>  static const char * const ether_rmii_groups[] = {"ether_rmii"};
>  static const char * const i2c0_groups[] = {"i2c0"};
> @@ -592,7 +596,8 @@ static const char * const usb1_groups[] = {"usb1"};
>  static const char * const usb2_groups[] = {"usb2"};
>
>  static const struct uniphier_pinmux_function uniphier_ld11_functions[] = {
> -       UNIPHIER_PINMUX_FUNCTION(aout),
> +       UNIPHIER_PINMUX_FUNCTION(aout1),
> +       UNIPHIER_PINMUX_FUNCTION(aoutiec1),
>         UNIPHIER_PINMUX_FUNCTION(emmc),
>         UNIPHIER_PINMUX_FUNCTION(ether_rmii),
>         UNIPHIER_PINMUX_FUNCTION(i2c0),
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> index 3be7967edae0..eb5d4cc6a3ba 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> @@ -551,8 +551,10 @@ static const struct pinctrl_pin_desc uniphier_ld20_pins[] = {
>                              175, UNIPHIER_PIN_PULL_DOWN),
>  };
>
> -static const unsigned aout_pins[] = {135, 136, 137, 138, 139, 140, 141, 142};
> -static const int aout_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
> +static const unsigned aout1_pins[] = {137, 138, 139, 140, 141, 142};
> +static const int aout1_muxvals[] = {0, 0, 0, 0, 0, 0};
> +static const unsigned aoutiec1_pins[] = {135, 136};
> +static const int aoutiec1_muxvals[] = {0, 0};
>  static const unsigned int emmc_pins[] = {19, 20, 21, 22, 23, 24, 25};
>  static const int emmc_muxvals[] = {0, 0, 0, 0, 0, 0, 0};
>  static const unsigned emmc_dat8_pins[] = {26, 27, 28, 29};
> @@ -631,7 +633,8 @@ static const unsigned int gpio_range2_pins[] = {
>  };
>
>  static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
> -       UNIPHIER_PINCTRL_GROUP(aout),
> +       UNIPHIER_PINCTRL_GROUP(aout1),
> +       UNIPHIER_PINCTRL_GROUP(aoutiec1),
>         UNIPHIER_PINCTRL_GROUP(emmc),
>         UNIPHIER_PINCTRL_GROUP(emmc_dat8),
>         UNIPHIER_PINCTRL_GROUP(ether_rgmii),
> @@ -657,7 +660,8 @@ static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
>         UNIPHIER_PINCTRL_GROUP_GPIO(gpio_range2),
>  };
>
> -static const char * const aout_groups[] = {"aout"};
> +static const char * const aout1_groups[] = {"aout1"};
> +static const char * const aoutiec1_groups[] = {"aoutiec1"};
>  static const char * const emmc_groups[] = {"emmc", "emmc_dat8"};
>  static const char * const ether_rgmii_groups[] = {"ether_rgmii"};
>  static const char * const ether_rmii_groups[] = {"ether_rmii"};
> @@ -679,7 +683,8 @@ static const char * const usb2_groups[] = {"usb2"};
>  static const char * const usb3_groups[] = {"usb3"};
>
>  static const struct uniphier_pinmux_function uniphier_ld20_functions[] = {
> -       UNIPHIER_PINMUX_FUNCTION(aout),
> +       UNIPHIER_PINMUX_FUNCTION(aout1),
> +       UNIPHIER_PINMUX_FUNCTION(aoutiec1),
>         UNIPHIER_PINMUX_FUNCTION(emmc),
>         UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
>         UNIPHIER_PINMUX_FUNCTION(ether_rmii),
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
