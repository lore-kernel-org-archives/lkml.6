Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeFAIMj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:12:39 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33392 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:12:26 -0400
X-Google-Smtp-Source: ADUXVKJX/uWMJBAZjKzgS3pzw/K4nqs438b/KP5KRX9FHdWa0ZaabNlJ4v2SC7tP/5+/B0d7mjQSxEpIQ+knR+pUEeQ=
MIME-Version: 1.0
In-Reply-To: <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-6-git-send-email-gilad@benyossef.com> <20180529161936.prhp4oikzamr6u3n@verge.net.au>
 <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 10:12:24 +0200
X-Google-Sender-Auth: DT01bD8UY6f8CjP0U9d8J8ZOFJ4
Message-ID: <CAMuHMdUX874g6pAz-Ze-yA3S+6aOhzUkfGN9wmQUhy-y0f7dMw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
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
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Thu, May 31, 2018 at 1:55 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Tue, May 29, 2018 at 7:19 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, May 24, 2018 at 03:19:10PM +0100, Gilad Ben-Yossef wrote:
>>> Add bindings for CryptoCell instance in the SoC.
>>>
>>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>>
>> In so far as I can review the details of this (which is not much) this
>> looks fine to me. I am, however, a little unclear in when it should be
>> accepted.
>
> Since Herbert Xu ACKed the driver changes, I would say the only gating
> commit is Geert's CR clock patch.

These are queued for v4.19.

> If that one is in, than I would say this one should go in as well.

As the device node now has a power-domains property, the genpd code will
try to attach it to the CPG/MSSR PM Domain, which is a clock domain.
In the absence of the clock patch, the device's module clock cannot be
found, and dev_pm_domain_attach() and thus platform_drv_probe() will fail,
before calling the device driver's .probe() function.

So there is no longer a dependency on the clock patch, and the DT patch can
go in in parallel (although I prefer its subject to be changed
s/binding/device device/).

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
