Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeCICI6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:08:58 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41585 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeCICI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:08:57 -0500
X-Google-Smtp-Source: AG47ELuHL6nZVewXtLdLwgeivJfAZosxCfY73xj3/hkh5+oRf4t2WaKirWPJqwxeAo5PIh5m6hMyzxsBAMN6c2arSjo=
MIME-Version: 1.0
References: <20180307162430.2664523-1-arnd@arndb.de>
In-Reply-To: <20180307162430.2664523-1-arnd@arndb.de>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 09 Mar 2018 02:08:45 +0000
Message-ID: <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 8:24 AM Arnd Bergmann <arnd@arndb.de> wrote:

> The top-level CONFIG_ARCH_NPCM symbol is not guarded with a
> dependency, and can be selected for builds of traditional
> (non-multiplatform) builds as well, where it causes a build
> failure:

> arch/arm/boot/Makefile:17: arch/arm/mach-npcm//Makefile.boot: No such
file or directory

> This moves the dependency to avoid that particular condition.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/mach-npcm/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 6ff9df2636be..2bc6697c8d97 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -1,5 +1,5 @@
>   menuconfig ARCH_NPCM
> -       bool "Nuvoton NPCM Architecture"
> +       bool "Nuvoton NPCM Architecture" if ARCH_MULTI_V7
>          select ARCH_REQUIRE_GPIOLIB
>          select USE_OF
>          select PINCTRL
> @@ -10,7 +10,7 @@ if ARCH_NPCM
>   comment "NPCM7XX CPU type"

>   config ARCH_NPCM750
> -       depends on ARCH_NPCM && ARCH_MULTI_V7
> +       depends on ARCH_NPCM
>          bool "Support for NPCM750 BMC CPU (Poleg)"
>          select CACHE_L2X0
>          select CPU_V7
> --
> 2.9.0


Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
