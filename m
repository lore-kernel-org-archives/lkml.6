Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933758AbeE1T7l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:59:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36476 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933699AbeE1T7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:59:38 -0400
X-Google-Smtp-Source: AB8JxZpZODp9gYGvol4DYM7AKh/RoRHKcyz6dL0X0clUrWbzfO77jucFn1H/084FfeV29J4amPH6pZ7f4Mj0vcVCyRU=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Tue, 29 May 2018 07:59:37 +1200
Message-ID: <CAOmrzkKVu6vPgMgvR9JuR==Q=XmTnDf_iyXfP7sDVymaXDX20Q@mail.gmail.com>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

my preference would be Finn's patch introducing a m68k
arch_setup_pdev_archdata(). It nicely preserves what bus code sets up
prior to registering a platform device (important for Zorro devices
using platform or mfd devices), and allows overriding by drivers that
need it.

If ever a kernel-wide consensus is reached to move this setup to the
generic arch_setup_pdev_archdata(), we can still back out his patch at
that time. Finn found one counterexample where absence of DMA mask
signaled 'do not use DMA', so I think moving the DMA mask setup to
generic code is unlikely to happen any time.

Just my $0.02 ...

Cheers,

  MIchael

On Mon, May 28, 2018 at 10:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, May 28, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> On Mon, 28 May 2018, Michael Schmitz wrote:
>>> Am 27.05.2018 um 17:49 schrieb Finn Thain:
>>> > On Sun, 27 May 2018, Michael Schmitz wrote:
>>> >
>>> >> That should have fixed the warning already ...
>>> >
>>> > It's still not fixed (hence my "acked-by" for Geunter's patch).
>>> >
>>>
>>> Odd - does link order still matter even though the
>>> arch_setup_dev_archdata() function from the core platform code is
>>> declared as a weak symbol?
>>>
>>> I'll see what I can find out on elgar ...
>>>
>>
>> Any one of the numerous patches/rfcs/suggestions that I sent will avoid
>> the WARN splat.
>>
>> When I said "it's still not fixed", what I meant to say was, "it's still
>> not fixed in mainline and no proposed fix was accepted to the best of my
>> knowledge".
>
> Indeed.
>
> Do we have a consensus on the way forward? The merge window for
> v4.18 will open soon.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
