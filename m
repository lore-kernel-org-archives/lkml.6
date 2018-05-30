Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeE3TzN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:55:13 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44758 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932246AbeE3TzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:55:09 -0400
X-Google-Smtp-Source: ADUXVKIHitKuuLaKe/DLTcvh2x6lpOH8TIiV6EuO6fiktWOxJL2bgwF4wGPmxkB9HNE/dOd9ULCV/dYdnStTQU0i3Bo=
MIME-Version: 1.0
In-Reply-To: <10880132-7686-78f6-7f9f-3fc29c3e554a@linux-m68k.org>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
 <10880132-7686-78f6-7f9f-3fc29c3e554a@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 21:55:08 +0200
X-Google-Sender-Auth: l5Dbc9jxR05ucJzArUXUVtlZ9t0
Message-ID: <CAMuHMdUzp-Bqc0s7SsKFKuiiC8Eb9dk3uUcynjVApg=UQ6g-yQ@mail.gmail.com>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@lst.de>, Michael Schmitz <schmitzmic@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, May 30, 2018 at 2:28 AM, Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 28/05/18 20:15, Geert Uytterhoeven wrote:
>> On Mon, May 28, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au>
>> wrote:
>>> On Mon, 28 May 2018, Michael Schmitz wrote:
>>>> Am 27.05.2018 um 17:49 schrieb Finn Thain:
>>>>> On Sun, 27 May 2018, Michael Schmitz wrote:
>>>>>> That should have fixed the warning already ...
>>>>>
>>>>> It's still not fixed (hence my "acked-by" for Geunter's patch).
>>>>
>>>> Odd - does link order still matter even though the
>>>> arch_setup_dev_archdata() function from the core platform code is
>>>> declared as a weak symbol?
>>>>
>>>> I'll see what I can find out on elgar ...
>>>
>>> Any one of the numerous patches/rfcs/suggestions that I sent will avoid
>>> the WARN splat.
>>>
>>> When I said "it's still not fixed", what I meant to say was, "it's still
>>> not fixed in mainline and no proposed fix was accepted to the best of my
>>> knowledge".
>>
>> Indeed.
>>
>> Do we have a consensus on the way forward? The merge window for
>> v4.18 will open soon.
>
> For whatever it is worth I thought Finn's patch was the best approach
> (https://lkml.org/lkml/2018/5/17/333, "m68k: Set default dma mask for
> platform device").

FTR: done.

> We seem to be hitting quite a few places (within m68k) that otherwise
> need individual fixes. There is no immediate need to revert existing
> changes that have already been applied if we use this now either
> (like my FEC fix, commit f61e64310b75 "m68k: set dma and coherent
> masks for platform FEC ethernets").

Indeed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
