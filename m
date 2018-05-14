Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeENVXb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:23:31 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44897 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeENVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:23:28 -0400
X-Google-Smtp-Source: AB8JxZoAt85Gt4m5EHklzVD8I6NZVX+lggD5AI3ueckU1ouv+0gLXiHdJkdJLxCmhIgEyzSCs2Hdj4ATr9dR1cXlFP4=
MIME-Version: 1.0
In-Reply-To: <cb51c6f8eb93452d405180d9da0f1e203b469d2a.camel@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com> <20180514184634.2160-2-bart.vanassche@wdc.com>
 <CAMo8Bf+Wgm2VrZiY+CfjN=CM=ysYBpRyTMdozV+6A8Brk4DKDQ@mail.gmail.com> <cb51c6f8eb93452d405180d9da0f1e203b469d2a.camel@wdc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 23:23:26 +0200
X-Google-Sender-Auth: 9f5YcRDtK39AvLx1G_AkExD1hvs
Message-ID: <CAMuHMdWqegF9Akr4N9VwB8bEN+ryMWEybWc7wtcWhMRoHdFYYQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "deller@gmx.de" <deller@gmx.de>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Mon, May 14, 2018 at 10:42 PM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Mon, 2018-05-14 at 11:50 -0700, Max Filippov wrote:
>> On Mon, May 14, 2018 at 11:46 AM, Bart Van Assche
>> <bart.vanassche@wdc.com> wrote:
>> > The next patch in this series introduces a call to cmpxchg64()
>> > in the block layer core for those architectures on which this
>> > functionality is available. Make it possible to test whether
>> > cmpxchg64() is available by introducing CONFIG_ARCH_HAVE_CMPXCHG64.
>> >
>> > ---
>>
>> [...]
>>
>> > diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>> > index c921e8bccdc8..8234278a821d 100644
>> > --- a/arch/xtensa/Kconfig
>> > +++ b/arch/xtensa/Kconfig
>> > @@ -23,6 +23,7 @@ config XTENSA
>> >         select HAVE_DMA_CONTIGUOUS
>> >         select HAVE_EXIT_THREAD
>> >         select HAVE_FUNCTION_TRACER
>> > +       select ARCH_HAVE_CMPXCHG64
>>
>> This breaks alphabetical sorting of Kconfig entries.
>
> Hello Max,
>
> Thanks for the feedback. Do you perhaps know whether keeping names in
> alphabetical order is a requirement for arch/xtensa/Kconfig only or
> whether this is required for all arch/*/Kconfig files?

It's a good practice anyway, as it reduces the probability of merge conflicts.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
