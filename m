Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeCSO1L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:27:11 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:42181 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbeCSO1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:27:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w2JEQvcL017507
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AG47ELsTCbPymovGuf8woDMEY4NR2zisJZUwDpjABSEyNzIK6Un4B11YnoJrGwbWEF1IbU/3uojX5PGyJGMMj/9c18A=
MIME-Version: 1.0
In-Reply-To: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521447194-26514-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 19 Mar 2018 23:26:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASO71M_LDtpOs4Z_wTCz22rrjkLSbZiYRwM7xungGT2Ag@mail.gmail.com>
Message-ID: <CAK7LNASO71M_LDtpOs4Z_wTCz22rrjkLSbZiYRwM7xungGT2Ag@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: add UART hardware flow control pin-mux settings
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-19 17:13 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> UniPhier SoCs have the following pins for hardware flow control of UART:
>   XRTS, XCTS
> and for modem control of UART:
>   XDTR, XDSR, XDCD, XRI
>
> The port number with the flow control is SoC-dependent.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c | 5 ++++-
>  drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 5 ++++-
>  9 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> index 8a5ecd6..eba7eb6 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
> @@ -504,6 +504,8 @@ static const unsigned uart2_pins[] = {90, 91};
>  static const int uart2_muxvals[] = {1, 1};
>  static const unsigned uart3_pins[] = {94, 95};
>  static const int uart3_muxvals[] = {1, 1};
> +static const unsigned uart3_ctsrts_pins[] = {96, 97, 98, 99, 100, 101};
> +static const int uart3_ctsrts_muxvals[] = {1, 1, 1, 1, 1, 1};
>  static const unsigned usb0_pins[] = {46, 47};
>  static const int usb0_muxvals[] = {0, 0};
>  static const unsigned usb1_pins[] = {48, 49};
> @@ -562,6 +564,7 @@ static const struct uniphier_pinctrl_group uniphier_ld11_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> +       UNIPHIER_PINCTRL_GROUP(uart3_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(usb0),
>         UNIPHIER_PINCTRL_GROUP(usb1),
>         UNIPHIER_PINCTRL_GROUP(usb2),
> @@ -586,7 +589,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>  static const char * const uart0_groups[] = {"uart0"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
> -static const char * const uart3_groups[] = {"uart3"};
> +static const char * const uart3_groups[] = {"uart3", "uart3_ctsrts"};
>  static const char * const usb0_groups[] = {"usb0"};
>  static const char * const usb1_groups[] = {"usb1"};
>  static const char * const usb2_groups[] = {"usb2"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> index 3be7967..353a33d 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c
> @@ -591,6 +591,8 @@ static const unsigned uart2_pins[] = {90, 91};
>  static const int uart2_muxvals[] = {1, 1};
>  static const unsigned uart3_pins[] = {94, 95};
>  static const int uart3_muxvals[] = {1, 1};
> +static const unsigned uart3_ctsrts_pins[] = {96, 97, 98, 99, 100, 101};
> +static const int uart3_ctsrts_muxvals[] = {1, 1, 1, 1, 1, 1};
>  static const unsigned usb0_pins[] = {46, 47};
>  static const int usb0_muxvals[] = {0, 0};
>  static const unsigned usb1_pins[] = {48, 49};
> @@ -648,6 +650,7 @@ static const struct uniphier_pinctrl_group uniphier_ld20_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> +       UNIPHIER_PINCTRL_GROUP(uart3_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(usb0),
>         UNIPHIER_PINCTRL_GROUP(usb1),
>         UNIPHIER_PINCTRL_GROUP(usb2),
> @@ -672,7 +675,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>  static const char * const uart0_groups[] = {"uart0"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
> -static const char * const uart3_groups[] = {"uart3"};
> +static const char * const uart3_groups[] = {"uart3", "uart3_ctsrts"};
>  static const char * const usb0_groups[] = {"usb0"};
>  static const char * const usb1_groups[] = {"usb1"};
>  static const char * const usb2_groups[] = {"usb2"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
> index 8403828..0b10ebc 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
> @@ -590,6 +590,8 @@ static const unsigned system_bus_cs3_pins[] = {156};
>  static const int system_bus_cs3_muxvals[] = {1};
>  static const unsigned uart0_pins[] = {85, 88};
>  static const int uart0_muxvals[] = {1, 1};
> +static const unsigned uart0_ctsrts_pins[] = {86, 87, 89};
> +static const int uart0_ctsrts_muxvals[] = {1, 1, 1};
>  static const unsigned uart1_pins[] = {155, 156};
>  static const int uart1_muxvals[] = {13, 13};
>  static const unsigned uart1b_pins[] = {69, 70};
> @@ -644,6 +646,7 @@ static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
>         UNIPHIER_PINCTRL_GROUP(uart0),
> +       UNIPHIER_PINCTRL_GROUP(uart0_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart1b),
>         UNIPHIER_PINCTRL_GROUP(uart2),
> @@ -669,7 +672,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs1",
>                                                  "system_bus_cs2",
>                                                  "system_bus_cs3"};
> -static const char * const uart0_groups[] = {"uart0"};
> +static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts"};
>  static const char * const uart1_groups[] = {"uart1", "uart1b"};
>  static const char * const uart2_groups[] = {"uart2"};
>  static const char * const uart3_groups[] = {"uart3"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
> index 493a90c..8e4d45fe 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
> @@ -785,6 +785,8 @@ static const unsigned system_bus_cs5_pins[] = {55};
>  static const int system_bus_cs5_muxvals[] = {6};
>  static const unsigned uart0_pins[] = {135, 136};
>  static const int uart0_muxvals[] = {3, 3};
> +static const unsigned uart0_ctsrts_pins[] = {137, 138, 139, 140, 141, 124};
> +static const int uart0_ctsrts_muxvals[] = {3, 3, 3, 3, 3, 3};
>  static const unsigned uart0b_pins[] = {11, 12};
>  static const int uart0b_muxvals[] = {2, 2};
>  static const unsigned uart1_pins[] = {115, 116};
> @@ -856,6 +858,7 @@ static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
>         UNIPHIER_PINCTRL_GROUP(uart0),
> +       UNIPHIER_PINCTRL_GROUP(uart0_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart0b),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart1b),
> @@ -885,7 +888,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs3",
>                                                  "system_bus_cs4",
>                                                  "system_bus_cs5"};
> -static const char * const uart0_groups[] = {"uart0", "uart0b"};
> +static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts", "uart0b"};
>  static const char * const uart1_groups[] = {"uart1", "uart1b"};
>  static const char * const uart2_groups[] = {"uart2", "uart2b"};
>  static const char * const usb0_groups[] = {"usb0"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
> index 603204a..24788a7 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
> @@ -1078,6 +1078,8 @@ static const unsigned uart2_pins[] = {131, 132};
>  static const int uart2_muxvals[] = {0, 0};
>  static const unsigned uart3_pins[] = {88, 89};
>  static const int uart3_muxvals[] = {2, 2};
> +static const unsigned uart3_ctsrts_pins[] = {80, 81, 82, 83, 90, 91};
> +static const int uart3_ctsrts_muxvals[] = {2, 2, 2, 2, 2, 2};
>  static const unsigned usb0_pins[] = {180, 181};
>  static const int usb0_muxvals[] = {0, 0};
>  static const unsigned usb1_pins[] = {182, 183};
> @@ -1149,6 +1151,7 @@ static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> +       UNIPHIER_PINCTRL_GROUP(uart3_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(usb0),
>         UNIPHIER_PINCTRL_GROUP(usb1),
>         UNIPHIER_PINCTRL_GROUP(usb2),
> @@ -1180,7 +1183,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>  static const char * const uart0_groups[] = {"uart0"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
> -static const char * const uart3_groups[] = {"uart3"};
> +static const char * const uart3_groups[] = {"uart3", "uart3_ctsrts"};
>  static const char * const usb0_groups[] = {"usb0"};
>  static const char * const usb1_groups[] = {"usb1"};
>  static const char * const usb2_groups[] = {"usb2"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
> index 9381a4f..d5d5e57 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
> @@ -842,6 +842,8 @@ static const unsigned uart0_pins[] = {47, 48};
>  static const int uart0_muxvals[] = {0, 0};
>  static const unsigned uart0b_pins[] = {227, 228};
>  static const int uart0b_muxvals[] = {3, 3};
> +static const unsigned uart0b_ctsrts_pins[] = {229, 230, 231, 232, 233, 234};
> +static const int uart0b_ctsrts_muxvals[] = {3, 3, 3, 3, 3, 3};
>  static const unsigned uart1_pins[] = {49, 50};
>  static const int uart1_muxvals[] = {0, 0};
>  static const unsigned uart2_pins[] = {51, 52};
> @@ -913,6 +915,7 @@ static const struct uniphier_pinctrl_group uniphier_pro5_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs7),
>         UNIPHIER_PINCTRL_GROUP(uart0),
>         UNIPHIER_PINCTRL_GROUP(uart0b),
> +       UNIPHIER_PINCTRL_GROUP(uart0b_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> @@ -940,7 +943,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs5",
>                                                  "system_bus_cs6",
>                                                  "system_bus_cs7"};
> -static const char * const uart0_groups[] = {"uart0", "uart0b"};
> +static const char * const uart0_groups[] = {"uart0", "uart0b", "uart0b_ctsrts"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
>  static const char * const uart3_groups[] = {"uart3"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
> index c0ef40a..769960e 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
> @@ -774,6 +774,8 @@ static const unsigned uart0_pins[] = {217, 218};
>  static const int uart0_muxvals[] = {8, 8};
>  static const unsigned uart0b_pins[] = {179, 180};
>  static const int uart0b_muxvals[] = {10, 10};
> +static const unsigned uart0b_ctsrts_pins[] = {176, 177, 178, 183, 184, 185};
> +static const int uart0b_ctsrts_muxvals[] = {10, 10, 10, 10, 10, 10};
>  static const unsigned uart1_pins[] = {115, 116};
>  static const int uart1_muxvals[] = {8, 8};
>  static const unsigned uart2_pins[] = {113, 114};
> @@ -842,6 +844,7 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
>         UNIPHIER_PINCTRL_GROUP(uart0),
>         UNIPHIER_PINCTRL_GROUP(uart0b),
> +       UNIPHIER_PINCTRL_GROUP(uart0b_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> @@ -868,7 +871,7 @@ static const char * const nand_groups[] = {"nand", "nand_cs1"};
>  static const char * const sd_groups[] = {"sd"};
>  static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs1"};
> -static const char * const uart0_groups[] = {"uart0", "uart0b"};
> +static const char * const uart0_groups[] = {"uart0", "uart0b", "uart0b_ctsrts"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
>  static const char * const uart3_groups[] = {"uart3", "uart3b"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
> index dbe94a9..535bb2e 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c
> @@ -816,6 +816,8 @@ static const unsigned int system_bus_cs1_pins[] = {15};
>  static const int system_bus_cs1_muxvals[] = {0};
>  static const unsigned int uart0_pins[] = {92, 93};
>  static const int uart0_muxvals[] = {0, 0};
> +static const unsigned int uart0_ctsrts_pins[] = {243, 244, 245, 246, 247, 248};
> +static const int uart0_ctsrts_muxvals[] = {3, 3, 3, 3, 3, 3};
>  static const unsigned int uart1_pins[] = {94, 95};
>  static const int uart1_muxvals[] = {0, 0};
>  static const unsigned int uart2_pins[] = {96, 97};
> @@ -887,6 +889,7 @@ static const struct uniphier_pinctrl_group uniphier_pxs3_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus),
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
>         UNIPHIER_PINCTRL_GROUP(uart0),
> +       UNIPHIER_PINCTRL_GROUP(uart0_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> @@ -912,7 +915,7 @@ static const char * const nand_groups[] = {"nand"};
>  static const char * const sd_groups[] = {"sd"};
>  static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs1"};
> -static const char * const uart0_groups[] = {"uart0"};
> +static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
>  static const char * const uart3_groups[] = {"uart3"};
> diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
> index 1af430d..0f921a6 100644
> --- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
> +++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
> @@ -520,6 +520,8 @@ static const unsigned system_bus_cs5_pins[] = {13};
>  static const int system_bus_cs5_muxvals[] = {1};
>  static const unsigned uart0_pins[] = {70, 71};
>  static const int uart0_muxvals[] = {3, 3};
> +static const unsigned uart0_ctsrts_pins[] = {72, 73, 74};
> +static const int uart0_ctsrts_muxvals[] = {3, 3, 3};
>  static const unsigned uart1_pins[] = {114, 115};
>  static const int uart1_muxvals[] = {0, 0};
>  static const unsigned uart2_pins[] = {112, 113};
> @@ -575,6 +577,7 @@ static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
>         UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
>         UNIPHIER_PINCTRL_GROUP(uart0),
> +       UNIPHIER_PINCTRL_GROUP(uart0_ctsrts),
>         UNIPHIER_PINCTRL_GROUP(uart1),
>         UNIPHIER_PINCTRL_GROUP(uart2),
>         UNIPHIER_PINCTRL_GROUP(uart3),
> @@ -601,7 +604,7 @@ static const char * const system_bus_groups[] = {"system_bus",
>                                                  "system_bus_cs3",
>                                                  "system_bus_cs4",
>                                                  "system_bus_cs5"};
> -static const char * const uart0_groups[] = {"uart0"};
> +static const char * const uart0_groups[] = {"uart0", "uart0_ctsrts"};
>  static const char * const uart1_groups[] = {"uart1"};
>  static const char * const uart2_groups[] = {"uart2"};
>  static const char * const uart3_groups[] = {"uart3"};
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
