Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeEQNfT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:35:19 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33003 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:35:09 -0400
X-Google-Smtp-Source: AB8JxZp7Bu4qQrHFVwYYaCN+Zp27O3HnCpE4JlgTLYq97LMHFwIWa1AOgNHsDaoKxsNAJOReEmnu2FcfaoRWHlP9k3A=
MIME-Version: 1.0
In-Reply-To: <CAOtvUMdVNX_vBRofpc5rNiVL-a1NvWMDyWSOaXKYPkm57wkR_A@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com> <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au> <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
 <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com> <CAOtvUMdVNX_vBRofpc5rNiVL-a1NvWMDyWSOaXKYPkm57wkR_A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 May 2018 15:35:07 +0200
X-Google-Sender-Auth: gs-Fck79NtTe73Y_FID-OJQmCXg
Message-ID: <CAMuHMdX5quhZzaPkcrtB4CuHWeaKsyF1SustjB9V0SWw_SzXVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Thu, May 17, 2018 at 3:09 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Thu, May 17, 2018 at 1:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> However, even with your clock patch, the signature checking fails for me,
>> on both R-Car H3 ES1.0 and ES2.0.
>> Does this need changes to the ARM Trusted Firmware, to allow Linux to
>> access the public SCEG module?
>
> Well, this is actually something different. If you look you will
> notice that my patch was part of a 3 part patch series,
> the first of which disabled this test.

Sorry, I had completely forgotten about the first patch from the series.
With that applied, it continues:

        ccree e6601000.crypto: ARM CryptoCell 630P Driver: HW version
0x00000000, Driver version 4.0
        ccree e6601000.crypto: Cache params previous: 0x00000777
        ccree e6601000.crypto: Cache params current: 0x00000000
(expect: 0x00000000)
        alg: No test for cts1(cbc(aes)) (cts1-cbc-aes-ccree)
        alg: No test for authenc(xcbc(aes),cbc(aes))
(authenc-xcbc-aes-cbc-aes-ccree)
        alg: No test for authenc(xcbc(aes),rfc3686(ctr(aes)))
(authenc-xcbc-aes-rfc3686-ctr-aes-ccree)
        ccree e6601000.crypto: ARM ccree device initialized

Is HW version 0x00000000 expected?

> If you take all the 3 patches, it will work.

is there an easy way to test proper operation?
I enabled CONFIG_CRYPT_TEST, and did insmod tcrypt.ko, but I mostly see
"Failed to load transform" messages.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
