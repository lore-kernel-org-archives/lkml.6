Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCWJMt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:12:49 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38917 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:12:48 -0400
X-Google-Smtp-Source: AG47ELsp+ZCkzbeTmOxKbFzyqLJ0MqcIVQdMq0X+VKz7eh26sEdKmn2Vcve2Qb6HqOHZVPlJO312Ft02+DnHBAfONyI=
MIME-Version: 1.0
In-Reply-To: <20180305143405.12187-1-anders.roxell@linaro.org>
References: <20180305143405.12187-1-anders.roxell@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 23 Mar 2018 17:12:46 +0800
Message-ID: <CAKv+Gu-chQCu83yS-Pjh2f=CLSD-TUKSTMU_833ZurR9TSnrXA@mail.gmail.com>
Subject: Re: [PATCH v3] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 22:34, Anders Roxell <anders.roxell@linaro.org> wrote:
> While testing multi_v7_defconfig with config fragments that makes the
> kernel size to grow. The kernel fails to load simple modules, as
> reported by kselftest:
>
> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
> 28 out of range (0xbf046044 -> 0xc109f720)
> selftests: printf.sh [FAIL]
>
> The problem that is seen when enabling too much in the kernel without
> enabling ARM_MODULE_PLTS, is that the top of the kernel gets out of
> reach from the bottom of the module area.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7e3d53575486..6831f2d4ee75 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1701,6 +1701,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARM_MODULE_PLTS
>         bool "Use PLTs to allow module memory to spill over into vmalloc area"
>         depends on MODULES
> +       default y
>         help
>           Allocate PLTs when loading modules so that jumps and calls whose
>           targets are too far away for their relative offsets to be encoded
> @@ -1711,7 +1712,8 @@ config ARM_MODULE_PLTS
>           rounding up to page size, the actual memory footprint is usually
>           the same.
>
> -         Say y if you are getting out of memory errors while loading modules
> +         Disabling this is usually safe for small single-platform
> +         configurations. If unsure, say y.
>
>  source "mm/Kconfig"
>
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
