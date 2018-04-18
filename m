Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDRHn0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:43:26 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42301 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeDRHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:43:24 -0400
X-Google-Smtp-Source: AIpwx48JMg9/QZajpJ13NMwhbM0GN5wWhdnos2uBnlYjxjh8PaLKwRwg6DG8FnAsTGbF/DwsBm62mkp2aCKrdSbpawA=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0fRZmumK5zLRgqT1iPtn2HgEjg6qyv-PMEaM1Z1W6aDw@mail.gmail.com>
References: <1523988865-26848-1-git-send-email-geert@linux-m68k.org> <CAK8P3a0fRZmumK5zLRgqT1iPtn2HgEjg6qyv-PMEaM1Z1W6aDw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 09:43:23 +0200
X-Google-Sender-Auth: zprCh2gch7OTl1qmatgLDd-fkZc
Message-ID: <CAMuHMdWyuo+y6bTv39gwg4VH7NvzHNSDXprNcM_m854g6ZfiPg@mail.gmail.com>
Subject: Re: [PATCH/RFC] crypto: Add platform dependencies for CRYPTO_DEV_CCREE
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Apr 17, 2018 at 9:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Apr 17, 2018 at 8:14 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> The ARM TrustZone CryptoCell is found on ARM SoCs only.  Hence make it
>> depend on ARM or ARM64, unless compile-testing.
>>
>> Drop the dependency on HAS_DMA, as DMA is always available on ARM and
>> ARM64 platforms, and doing so will increase compile coverage.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Is ARM || ARM64 OK?
>> Or should this be limited to either ARM or ARM64? Or something else?
>
> ARM || ARM64 seems fine, but don't you need '|| (HAS_DMA && COMPILE_TEST)'?
>
> I assume the HAS_DMA dependency was added to prevent compile
> testing to run into a build error.

Probably it was. But in v4.17-rc1, dummies are present in the NO_DMA case,
so everything compile-tests fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
