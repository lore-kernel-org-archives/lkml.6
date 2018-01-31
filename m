Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeAaUYL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:24:11 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43474 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeAaUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:24:10 -0500
X-Google-Smtp-Source: AH8x227DzAdHc7fUXyfwCAdFH/S8qDgiZznNlY4AjYo047o46Dud84UiwcF9PGZAAtjpq5lQ7oWsBfKXRb6ymWOStNk=
MIME-Version: 1.0
In-Reply-To: <20180131201911.19253-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org> <20180131201911.19253-1-anders.roxell@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 31 Jan 2018 20:24:09 +0000
Message-ID: <CAKv+Gu-r40TKuPZyfhFBkqPT=Fg+3Z=sP0fJBOdU4FqUETQCsw@mail.gmail.com>
Subject: Re: [PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 January 2018 at 20:19, Anders Roxell <anders.roxell@linaro.org> wrote:
> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
> fails to load simple modules, as reported by kselftest:
>
> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
> 28 out of range (0xbf046044 -> 0xc109f720)
> selftests: printf.sh [FAIL]
>
> The problem that is seen when LOCKDEP is enabled without
> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
> kernel gets out of reach from the bottom of the module area.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 51c8df561077..8014c8c322df 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1702,6 +1702,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARM_MODULE_PLTS
>         bool "Use PLTs to allow module memory to spill over into vmalloc area"
>         depends on MODULES
> +       default y
>         help
>           Allocate PLTs when loading modules so that jumps and calls whose
>           targets are too far away for their relative offsets to be encoded
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
