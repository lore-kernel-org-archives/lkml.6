Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeBARaq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:30:46 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38742 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeBARao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:30:44 -0500
X-Google-Smtp-Source: AH8x227gIqphBx18+hqX7ygYhSuGIhYIFadDuSYn2ME7k4/t50owZ8lwDRRKzuT/A2d8nVL78TRutX6QmcrfsrrMmlU=
MIME-Version: 1.0
In-Reply-To: <1517480520-4465-1-git-send-email-geert@linux-m68k.org>
References: <1517480520-4465-1-git-send-email-geert@linux-m68k.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 1 Feb 2018 17:30:43 +0000
Message-ID: <CAKv+Gu_YjkGAjO1bM_eGFw8z3732y06M2EXfS7A34CaYkNdatA@mail.gmail.com>
Subject: Re: [PATCH 1/3] compiler-gcc.h: Introduce __optimize function attribute
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Christopher Li <sparse@chrisli.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        Linux-Sparse <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11HUqCe018191

On 1 February 2018 at 10:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Create a new function attribute __optimize, which allows to specify an
> optimization level on a per-function basis.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
> I assume this is supported as of gcc-4.4:
>   - gcc version 4.3.3 (GCC): warning: ‘__optimize__’ attribute directive
>     ignored
>   - gcc version 4.4.7 (Ubuntu/Linaro 4.4.7-1ubuntu2): OK
> ---
>  include/linux/compiler-gcc.h | 4 ++++
>  include/linux/compiler.h     | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 631354acfa720475..0a278a527944ad2f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -196,6 +196,10 @@
>  #endif /* __CHECKER__ */
>  #endif /* GCC_VERSION >= 40300 */
>
> +#if GCC_VERSION >= 40400
> +#define __optimize(level)      __attribute__((__optimize__(level)))
> +#endif /* GCC_VERSION >= 40400 */
> +
>  #if GCC_VERSION >= 40500
>
>  #ifndef __CHECKER__
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 52e611ab9a6cf6fd..5ff818e9a836e898 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -271,6 +271,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>
>  #endif /* __ASSEMBLY__ */
>
> +#ifndef __optimize
> +# define __optimize(level)
> +#endif
> +
>  /* Compile time object size, -1 for unknown */
>  #ifndef __compiletime_object_size
>  # define __compiletime_object_size(obj) -1
> --
> 2.7.4
>
