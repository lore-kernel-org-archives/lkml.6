Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBEBqh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:46:37 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40413 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeBEBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:46:30 -0500
X-Google-Smtp-Source: AH8x225avF8ktZK95X7ueuqkHR3Dq8WjW7YESj7ZNHL9KrJeOQ7JUInFBRktmMqhXqYy6gMGe/Lu+ziPgVwF4Vq8Qk0=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-13-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-13-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 02:46:28 +0100
Message-ID: <CAFkk2KQVCxSiQf8D1Dcp0SKcKuu7wn3m6P0+DKoyjNEaFb=F=g@mail.gmail.com>
Subject: Re: [PATCH 12/20] ARM: debug: Remove ARCH_MSM dep. from UNCOMPRESS_INCLUDE
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> The ARCH_MSM symbol was removed in commit c0c89fafa289 ("ARM: Remove
> mach-msm and associated ARM architecture code"), but a default in
> UNCOMPRESS_INCLUDE still depends on it.
>
> Remove the ARCH_MSM dependency from the default in UNCOMPRESS_INCLUDE.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/arm/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 78a647080ebc..20c601a045d2 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1825,7 +1825,7 @@ config DEBUG_UNCOMPRESS
>
>  config UNCOMPRESS_INCLUDE
>         string
> -       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
> +       default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
>                                         PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
>         default "mach/uncompress.h"
>
> --
> 2.14.1
>

These globally undefined symbols (with no historical definitions that
I could find) are also referenced in this file:

DEBUG_OMAP4UART2
DEBUG_OMAP4UART1
DEBUG_OMAP5UART1
DEBUG_OMAP5UART2
DEBUG_OMAP3UART2
DEBUG_OMAP3UART1

Cheers,
Ulf
