Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeBFJtv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:49:51 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45101 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeBFJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:49:37 -0500
X-Google-Smtp-Source: AH8x226lAPHihps3BjcTZnw0kb7ug1/Pir5ESXpHC+ftfD+RyoACFl2TCbQTheE3vuqtTSS+1gdD8gCgvppIqtUt3Vc=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KR5YyziwO8V9LeRh4yxVAakm+U2sej2nDCH_cxfLcZ2rA@mail.gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-8-ulfalizer@gmail.com>
 <CACRpkdY-3ab=o0TpURqa-MyTMJOd86SWqBaD4n7+KGYhgbYjzg@mail.gmail.com>
 <CAFkk2KQzCE5KrUvyvL0Va+KT0O4BvT3PQAT2ZP4u3SGYUWcp2g@mail.gmail.com> <CAFkk2KR5YyziwO8V9LeRh4yxVAakm+U2sej2nDCH_cxfLcZ2rA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 10:49:35 +0100
Message-ID: <CACRpkdZB6nQfA8+opcBhHfXX=XeKW8nTmdxtrijZRuwb6KtqGA@mail.gmail.com>
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>, tfiga@chromium.org,
        paul.burton@mips.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
        Christoph Hellwig <hch@lst.de>, mina86@mina86.com,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Paul Mackerras <paulus@ozlabs.org>, Will Deacon <will.deacon@arm.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:49 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 12:38 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>> On Tue, Feb 6, 2018 at 12:25 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>>>
>>>> The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
>>>> ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
>>>> just be selected explicitly if needed.
>>>>
>>>> Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
>>>>
>>>> See commit 0145071b3314 ("x86: Do away with
>>>> ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
>>>> away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
>>>>
>>>> Discovered with the
>>>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>>>> script.
>>>>
>>>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>>>
>>> This should probaly be replaced with
>>> select GPIOLIB
>>>
>>> Yours,
>>> Linus Walleij
>>
>> That'd make more sense if GPIOLIB is actually used. The select has
>> been a no-op since mid-2016 at least, but maybe something else selects
>> GPIOLIB.
>>
>> Cheers,
>> Ulf
>
> Just replace it with your own patch once you've figured out the proper
> fix. More efficient than having a middle man making (sometimes poor)
> guesses.

I think it's just a side effect of the new RISCV arch being developed
outside of the mainline kernel. And they may have had a gpio driver
outside of the mainline as well.

Normally we don't encourage out-of-tree development, but new archs
are a bit of an exception since they have to be merged as a big
piece of upfront code at some point...

Anyways, if they don't have any GPIO in their machine yet, let's
let the RISCV maintainers apply this.

Yours,
Linus Walleij
