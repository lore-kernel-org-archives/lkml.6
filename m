Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbeDWMNJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:13:09 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33328 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754729AbeDWMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:13:05 -0400
X-Google-Smtp-Source: AIpwx49UOC9ODY4NJzQiyUbDeRJxGwGolMU9caJBU36LUOGhI9foo6NANB92y/K5O2iGc25bMRQsjePAbDoA/izrnkY=
MIME-Version: 1.0
In-Reply-To: <1524484097-8315-1-git-send-email-gilad@benyossef.com>
References: <1524484097-8315-1-git-send-email-gilad@benyossef.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 14:13:04 +0200
X-Google-Sender-Auth: l-wMvc--LislnRLxRC2CgMFErxU
Message-ID: <CAMuHMdXNAkCVpyGyQMKRMRGuXyjOHAGgvHT4QGkuYdZetOr-9Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: limit build to plausible archs
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Mon, Apr 23, 2018 at 1:48 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Limit option to compile ccree to plausible architectures.

Thanks for your patch!

> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index d1ea1a0..7302785 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -726,6 +726,7 @@ config CRYPTO_DEV_ARTPEC6
>  config CRYPTO_DEV_CCREE
>         tristate "Support for ARM TrustZone CryptoCell family of security processors"
>         depends on CRYPTO && CRYPTO_HW && OF && HAS_DMA
> +       depends on (XTENSA || X86 || UNICORE32 || SUPERH || RISCV || PPC32 || OPENRISC || NIOS2 || NDS32 || MIPS || MICROBLAZE || HEXAGON || H8300 || ARM || ARM64 || ARC || COMPILE_TEST)

That list looks a bit excessive to me...

>         default n
>         select CRYPTO_HASH
>         select CRYPTO_BLKCIPHER

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
