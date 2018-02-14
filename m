Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030957AbeBNO6Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:58:16 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39065 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:58:14 -0500
X-Google-Smtp-Source: AH8x227INWrUUWrc7aB8mHbW4wh59aPDQ0UwwMIm+DNBU75kILBmh9KqX2eQ2V24EL3gUIx3dr6eZb3IbNNBe0ssWnA=
MIME-Version: 1.0
In-Reply-To: <20180117093813.20227-1-benjamin.gaignard@st.com>
References: <20180117093813.20227-1-benjamin.gaignard@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 14 Feb 2018 15:58:13 +0100
Message-ID: <CA+M3ks75nSfy_+fZgbb=r9rps8aLNdzPKFc8uuqUJrvW7dCoEQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: stm32: add configuration flags for each of the
 stm32 drivers
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-17 10:38 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> Add two configuration flags to be able to not compile all the time
> stm32f and stm32h7 drivers when ARCH_STM32 is set.
> That help to save some space on those small platforms.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Gentle ping on this patch, thanks

Benjamin

> ---
>  drivers/clk/Kconfig  | 14 ++++++++++++++
>  drivers/clk/Makefile |  4 ++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1c4e1aa6767e..47243e8675c1 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -226,6 +226,20 @@ config COMMON_CLK_VC5
>           This driver supports the IDT VersaClock 5 and VersaClock 6
>           programmable clock generators.
>
> +config COMMON_CLK_STM32F
> +       bool "Clock driver for stm32f4 and stm32f7 SoC families"
> +       depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
> +       help
> +       ---help---
> +         Support for stm32f4 and stm32f7 SoC families clocks
> +
> +config COMMON_CLK_STM32H7
> +       bool "Clock driver for stm32h7 SoC family"
> +       depends on MACH_STM32H743
> +       help
> +       ---help---
> +         Support for stm32h7 SoC family clocks
> +
>  source "drivers/clk/bcm/Kconfig"
>  source "drivers/clk/hisilicon/Kconfig"
>  source "drivers/clk/imgtec/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f7f761b02bed..956dce66587b 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -44,8 +44,8 @@ obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
>  obj-$(CONFIG_COMMON_CLK_SI5351)                += clk-si5351.o
>  obj-$(CONFIG_COMMON_CLK_SI514)         += clk-si514.o
>  obj-$(CONFIG_COMMON_CLK_SI570)         += clk-si570.o
> -obj-$(CONFIG_ARCH_STM32)               += clk-stm32f4.o
> -obj-$(CONFIG_ARCH_STM32)               += clk-stm32h7.o
> +obj-$(CONFIG_COMMON_CLK_STM32F)        += clk-stm32f4.o
> +obj-$(CONFIG_COMMON_CLK_STM32H7)       += clk-stm32h7.o
>  obj-$(CONFIG_ARCH_TANGO)               += clk-tango4.o
>  obj-$(CONFIG_CLK_TWL6040)              += clk-twl6040.o
>  obj-$(CONFIG_ARCH_U300)                        += clk-u300.o
> --
> 2.15.0
>
