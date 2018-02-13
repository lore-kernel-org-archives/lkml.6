Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965924AbeBMVsV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:48:21 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42839 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965843AbeBMVsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:48:20 -0500
X-Google-Smtp-Source: AH8x2277lPakFMCXx9tWxLhqGaGMiPPe1MdndcQwH5uHuLMwZgfyXXjELHAqoQ4tmNQ24vi6fPWpaQ==
Date: Tue, 13 Feb 2018 13:48:18 -0800 (PST)
X-Google-Original-Date: Tue, 13 Feb 2018 13:40:29 PST (-0800)
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
CC: antonynpavlov@gmail.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        matt.redfearn@mips.com
From: Palmer Dabbelt <palmer@sifive.com>
To: matt.redfearn@mips.com
Message-ID: <mhng-a034032e-b23a-4c52-8965-1e9d6e133f43@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Feb 2018 05:22:52 PST (-0800), matt.redfearn@mips.com wrote:
> When these are included into arch Kconfig files, maintaining
> alphabetical ordering of the selects means these get split up. To allow
> for keeping things tidier and alphabetical, rename the selects to
> GENERIC_LIB_*
>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks!  Do you want me to take this in my tree?

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

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
>  	bool "RV32I"
>  	select CPU_SUPPORTS_32BIT_KERNEL
>  	select 32BIT
> -	select GENERIC_ASHLDI3
> -	select GENERIC_ASHRDI3
> -	select GENERIC_LSHRDI3
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_LSHRDI3
>
>  config ARCH_RV64I
>  	bool "RV64I"
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
>  	bool
>
> -config GENERIC_ASHRDI3
> +config GENERIC_LIB_ASHRDI3
>  	bool
>
> -config GENERIC_LSHRDI3
> +config GENERIC_LIB_LSHRDI3
>  	bool
>
> -config GENERIC_MULDI3
> +config GENERIC_LIB_MULDI3
>  	bool
>
> -config GENERIC_CMPDI2
> +config GENERIC_LIB_CMPDI2
>  	bool
>
> -config GENERIC_UCMPDI2
> +config GENERIC_LIB_UCMPDI2
>  	bool
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
