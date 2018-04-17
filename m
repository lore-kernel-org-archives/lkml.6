Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDQTx4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 15:53:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32771 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeDQTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 15:53:51 -0400
X-Google-Smtp-Source: AIpwx48GPBch1cASA0tA2CmD3zJZf5W3J36kzpdwO1XcicMwTCzwVkOqWtX8K0e5JCFAh0Ookf/GLEJGJdQRvjCpxio=
MIME-Version: 1.0
In-Reply-To: <1523988865-26848-1-git-send-email-geert@linux-m68k.org>
References: <1523988865-26848-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Apr 2018 21:53:49 +0200
X-Google-Sender-Auth: _xHoiGaCZOo0Wgc9oVivLc3EA4c
Message-ID: <CAK8P3a0fRZmumK5zLRgqT1iPtn2HgEjg6qyv-PMEaM1Z1W6aDw@mail.gmail.com>
Subject: Re: [PATCH/RFC] crypto: Add platform dependencies for CRYPTO_DEV_CCREE
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Apr 17, 2018 at 8:14 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> The ARM TrustZone CryptoCell is found on ARM SoCs only.  Hence make it
> depend on ARM or ARM64, unless compile-testing.
>
> Drop the dependency on HAS_DMA, as DMA is always available on ARM and
> ARM64 platforms, and doing so will increase compile coverage.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Is ARM || ARM64 OK?
> Or should this be limited to either ARM or ARM64? Or something else?

ARM || ARM64 seems fine, but don't you need '|| (HAS_DMA && COMPILE_TEST)'?

I assume the HAS_DMA dependency was added to prevent compile
testing to run into a build error.

        Arnd
