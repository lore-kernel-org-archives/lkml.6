Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEVHsO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:48:14 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42462 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:48:09 -0400
X-Google-Smtp-Source: AB8JxZr2vN283WQHA8JPwl7bAkVFX8JDxde7nFieiKdRsJy2ateWZPcaaCPehggJvFW+9wIg82W7izW7Jk4tWCOXWVA=
MIME-Version: 1.0
In-Reply-To: <CAOtvUMcf-fHduThORv3cbcN16wEm_Si27OjSjAmSc9g5eK4PJw@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com> <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au> <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
 <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com> <CAOtvUMcf-fHduThORv3cbcN16wEm_Si27OjSjAmSc9g5eK4PJw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 09:48:06 +0200
X-Google-Sender-Auth: LveANQyKv7Kpz_xt53-jV9OWLTM
Message-ID: <CAMuHMdX-t8WfjRKpZ7UxXBbBNojsn-8z7_BM9grmLJcf=9Ks2Q@mail.gmail.com>
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

On Mon, May 21, 2018 at 3:43 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Thu, May 17, 2018 at 1:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Indeed. From a quick glance, it looks like drivers/crypto/ccree/cc_driver.c
>> does not distinguish between the absence of the clock property, and an
>> actual error in getting the clock, and never considers any error a failure
>> (incl. -PROBE_DEFER).
>>
>> As of_clk_get() returns -ENOENT for both a missing clock property and a
>> missing clock, you should use (devm_)clk_get() instead, and distinguish
>> between NULL (no clock property) and IS_ERR() (actual failure -> abort).
>
> I was trying to do as you suggested but I didn't quite get what is the
> dev_id (2nd) parameter to devm_clk_get parameter is supposed to be.

It's the (optional) name of the clock, helpful in case there is more than one.
In your case, NULL is fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
