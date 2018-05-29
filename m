Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeE2KRX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:17:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54139 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbeE2KRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:17:21 -0400
X-Google-Smtp-Source: ADUXVKIQfGHypgiz3wUmkdWop8IzNI2Dxz1VNHmHdbIz3ohSUfMWuBtyG6BqGzKYyxurP2qcpzCne5XNBZHVduUa0Lo=
MIME-Version: 1.0
In-Reply-To: <20180529190846.764421ea@canb.auug.org.au>
References: <20180529190846.764421ea@canb.auug.org.au>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 29 May 2018 12:16:59 +0200
Message-ID: <CAAUqJDu=Ez2CQY0JPTWA+K2UKVZbjRF-YFQdpP0=xmtqd7kEzQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the crypto tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

there is already a patch pending that fixes the issue:

https://patchwork.kernel.org/patch/10416245/

Cheers,
Ondrej

2018-05-29 11:08 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Herbert,
>
> After merging the crypto tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> /home/sfr/next/next/crypto/morus640_glue.c:24:10: fatal error: asm/fpu/api.h: No such file or directory
>  #include <asm/fpu/api.h>
>           ^~~~~~~~~~~~~~~
> /home/sfr/next/next/crypto/morus1280_glue.c:24:10: fatal error: asm/fpu/api.h: No such file or directory
>  #include <asm/fpu/api.h>
>           ^~~~~~~~~~~~~~~
>
> Caused by commit
>
>   56e8e57fc3a7 ("crypto: morus - Add common SIMD glue code for MORUS")
>
> I have marked them as broken for now:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 29 May 2018 18:59:17 +1000
> Subject: [PATCH] crypto: make common SIMD glue code for MORUS as BROKEN for
>  now
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  crypto/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 75f5efde9aa3..ad69785dc9d3 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -342,6 +342,7 @@ config CRYPTO_MORUS640
>
>  config CRYPTO_MORUS640_GLUE
>         tristate "MORUS-640 AEAD algorithm (glue for SIMD optimizations)"
> +       depends on BROKEN
>         select CRYPTO_AEAD
>         select CRYPTO_CRYPTD
>         help
> @@ -351,6 +352,7 @@ config CRYPTO_MORUS640_GLUE
>  config CRYPTO_MORUS640_SSE2
>         tristate "MORUS-640 AEAD algorithm (x86_64 SSE2 implementation)"
>         depends on X86 && 64BIT
> +       depends on BROKEN
>         select CRYPTO_AEAD
>         select CRYPTO_MORUS640_GLUE
>         help
> @@ -364,6 +366,7 @@ config CRYPTO_MORUS1280
>
>  config CRYPTO_MORUS1280_GLUE
>         tristate "MORUS-1280 AEAD algorithm (glue for SIMD optimizations)"
> +       depends on BROKEN
>         select CRYPTO_AEAD
>         select CRYPTO_CRYPTD
>         help
> @@ -373,6 +376,7 @@ config CRYPTO_MORUS1280_GLUE
>  config CRYPTO_MORUS1280_SSE2
>         tristate "MORUS-1280 AEAD algorithm (x86_64 SSE2 implementation)"
>         depends on X86 && 64BIT
> +       depends on BROKEN
>         select CRYPTO_AEAD
>         select CRYPTO_MORUS1280_GLUE
>         help
> @@ -382,6 +386,7 @@ config CRYPTO_MORUS1280_SSE2
>  config CRYPTO_MORUS1280_AVX2
>         tristate "MORUS-1280 AEAD algorithm (x86_64 AVX2 implementation)"
>         depends on X86 && 64BIT
> +       depends on BROKEN
>         select CRYPTO_AEAD
>         select CRYPTO_MORUS1280_GLUE
>         help
> --
> 2.17.0
>
> --
> Cheers,
> Stephen Rothwell
