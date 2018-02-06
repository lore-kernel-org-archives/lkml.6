Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeBFW55 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 17:57:57 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42262 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeBFW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 17:57:55 -0500
X-Google-Smtp-Source: AH8x224v90nJGTIcRoslN6JWM5b3M9rrhnps8sely4R9UhlpemtWew5s8BSncimF8xR6k2cX/xxkuw8EjEPVJKNn/Is=
MIME-Version: 1.0
In-Reply-To: <20180205190552.14282-1-ulfalizer@gmail.com>
References: <20180205081151.GA11907@Red> <20180205190552.14282-1-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 6 Feb 2018 23:57:53 +0100
Message-ID: <CAFkk2KSNiaOLjKZhij7kmtOsb3oOVThZ9SoE7_yqPvAmQQQafg@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] kconfig: Remove leftover references to AVR32 symbol
To: corentin labbe <clabbe.montjoie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Sean Paul <seanpaul@chromium.org>, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 8:05 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture"). Remove the remaining references to it
> from the Kconfig files.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
> Changes in v3:
> Removal of the AVR32 dependency in PWM_ATMEL is already pending:
> https://lkml.org/lkml/2018/1/18/699
>
> Changes in v2:
> Removal of AVR32_AT32AP_CPUFREQ is already pending in
> https://marc.info/?i=20180118200202.11883-1-clabbe.montjoie%40gmail.com (which
> also does it properly -- I forgot to search for related files here). Just
> remove the other references.
>
>  drivers/spi/Kconfig           | 2 +-
>  drivers/video/console/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 603783976b81..c1e455d46c7f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -72,7 +72,7 @@ config SPI_ARMADA_3700
>  config SPI_ATMEL
>         tristate "Atmel SPI Controller"
>         depends on HAS_DMA
> -       depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
> +       depends on (ARCH_AT91 || COMPILE_TEST)
>         help
>           This selects a driver for the Atmel SPI Controller, present on
>           many AT32 (AVR32) and AT91 (ARM) chips.
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fbcef9e..be63759b6027 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -7,7 +7,7 @@ menu "Console display driver support"
>  config VGA_CONSOLE
>         bool "VGA text console" if EXPERT || !X86
>         depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
> -               !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
> +               !SUPERH && !BLACKFIN && !MN10300 && !CRIS && \
>                 (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
>                 !ARM64 && !ARC && !MICROBLAZE && !OPENRISC
>         default y
> --
> 2.14.1
>

Superseded by two patches, split up per subsystem:

https://lkml.org/lkml/2018/2/6/805
https://lkml.org/lkml/2018/2/6/808

Cheers,
Ulf
