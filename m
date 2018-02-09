Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeBINpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:45:55 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34652 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753707AbeBINpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:45:50 -0500
X-Google-Smtp-Source: AH8x224mwAVz3fPB37XUrwMJFBtgq5KrLj4jxVDQ1EpdI+gGosBiHRGb/eK9R1KlFfDsOpWG2ZmSz7e0GYoG3K7Qn/s=
MIME-Version: 1.0
In-Reply-To: <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
References: <mhng-f000d448-7ead-4cee-9e2f-5d58692c0922@palmer-si-x1c4> <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 15:45:48 +0200
Message-ID: <CAHp75VeiAUg1NCK59wZjZNnLZqEXDF5dpi8pmtTcP1WhX2wvVA@mail.gmail.com>
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, antonynpavlov@gmail.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>, jhogan@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:22 PM, Matt Redfearn <matt.redfearn@mips.com> wrote:
> When these are included into arch Kconfig files, maintaining
> alphabetical ordering of the selects means these get split up. To allow
> for keeping things tidier and alphabetical, rename the selects to
> GENERIC_LIB_*
>

I don't remember who suggested that, if it wasn't you, please add
Suggested-by tag with appropriate name.

> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>  arch/riscv/Kconfig |  6 +++---
>  lib/Kconfig        | 12 ++++++------
>  lib/Makefile       | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2c6adf12713a..5f1e2188d029 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -99,9 +99,9 @@ config ARCH_RV32I
>         bool "RV32I"
>         select CPU_SUPPORTS_32BIT_KERNEL
>         select 32BIT
> -       select GENERIC_ASHLDI3
> -       select GENERIC_ASHRDI3
> -       select GENERIC_LSHRDI3
> +       select GENERIC_LIB_ASHLDI3
> +       select GENERIC_LIB_ASHRDI3
> +       select GENERIC_LIB_LSHRDI3
>
>  config ARCH_RV64I
>         bool "RV64I"
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c5e84fbcb30b..946d0890aad6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -584,20 +584,20 @@ config STRING_SELFTEST
>
>  endmenu
>
> -config GENERIC_ASHLDI3
> +config GENERIC_LIB_ASHLDI3
>         bool
>
> -config GENERIC_ASHRDI3
> +config GENERIC_LIB_ASHRDI3
>         bool
>
> -config GENERIC_LSHRDI3
> +config GENERIC_LIB_LSHRDI3
>         bool
>
> -config GENERIC_MULDI3
> +config GENERIC_LIB_MULDI3
>         bool
>
> -config GENERIC_CMPDI2
> +config GENERIC_LIB_CMPDI2
>         bool
>
> -config GENERIC_UCMPDI2
> +config GENERIC_LIB_UCMPDI2
>         bool
> diff --git a/lib/Makefile b/lib/Makefile
> index d11c48ec8ffd..7e1ef77e86a3 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>  obj-$(CONFIG_PARMAN) += parman.o
>
>  # GCC library routines
> -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
> -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
> -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
> -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
> -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
> -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
> +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
> +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
> +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
> +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
