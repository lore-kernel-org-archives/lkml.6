Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40914C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEBA20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dZ+roU8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfAQOBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:01:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38484 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfAQOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:01:13 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so7866034ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IotE6xnVPx1DKYX/Wn7ErENMX7pC9eU2NgmLk8rr0Hs=;
        b=dZ+roU8xfnsZFe3FAcyuftQ1wvpwZEDpeLW8czFlQoeLO9XMhHYR91mZQ6v88E7yh1
         IW+Cxa7UrIxxPuJCuqrPZRaWxTtxJbbNUX6O3jHgMltOkj33hJ6Kc9LtaEjaM8zzRAb0
         vJgNw+gcNX8Mj5ZQlVUGfNYItWGLE73ZbFbljYWSdkZz87kxe29tQ7Oj2iQD/JoRmXUY
         IUhI6YU7jOo0sbFPQyX75iXn6Pdh07/0KsyxXgl3tYbtIy9ObQPN0iwd+hmT6eIjSP8t
         0kO+sRdMVm93miYNOTrcPfvaWTQHlXscqiZcSppmXMwIdzi30+yY6ZOppHzrlYaQXPSc
         enVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IotE6xnVPx1DKYX/Wn7ErENMX7pC9eU2NgmLk8rr0Hs=;
        b=YXPIIKggk9U7AiLMkTZSQmVY7Hc8E2Y0PqSgyLUf4O/+ZgeCqNsYxpKpq6dOwG6B5J
         rmFIY6f+CVtQwaeNSDVRv2TA2IgBhNfKwtavWi837QYrru2wTa8fKMFgy0Sb6qS20x+1
         X6i0l7zVC9g9xo/JvXZxQfaMQApcMNpyh2uVtWgmrwKFjfylqUkQ0MP0dvqEvP0EOruF
         j09TYCZcluWRPY485Q5eGTxLrNbi7fsRprLJ4NTq/xQCxccJq+RCf7O7q5mYYZVWynQL
         6P4qX1OBQaQNctfDCNmj5UMaicIzz2pbV9/5a4WSauwJHam1b4cPqMxBGzzPwYtO7BxF
         vkmA==
X-Gm-Message-State: AJcUukfvHtZy4Swn96NkKxFNVxPf5unI5Cv9APX4eigMJN3k2n4K1WiZ
        v6N6XENJvw88UcqynTDrpWMzk/h1L5th5y37VB2K4A==
X-Google-Smtp-Source: ALg8bN4o5mgiBRAPQg5EcR53Kovyq4GBU7TQKGvYDlLSpLYUttB+oVoLjFShXC7k2+EId0PujSk/LYy+w0l84jdMUWQ=
X-Received: by 2002:a5d:928b:: with SMTP id s11mr8291606iom.111.1547733672383;
 Thu, 17 Jan 2019 06:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20190111172134.30147-1-brgl@bgdev.pl> <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com> <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
 <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com> <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
In-Reply-To: <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Jan 2019 15:01:01 +0100
Message-ID: <CAMRc=McPCJxd7i7Ei+xOKOXYhYZgC=MYYFwyn2zAjStQov91fw@mail.gmail.com>
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 sty 2019 o 13:42 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 16/01/19 2:48 PM, Sekhar Nori wrote:
> > On 14/01/19 10:09 PM, Bartosz Golaszewski wrote:
> >> pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a)=
:
> >>>
> >>> Hi Bartosz,
> >>>
> >>> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>
> >>>> Currently the clocksource and clockevent support for davinci platfor=
ms
> >>>> lives in mach-davinci. It hard-codes many things, used global variab=
les,
> >>>> implements functionalities unused by any platform and has code fragm=
ents
> >>>> scattered across many (often unrelated) files.
> >>>>
> >>>> Implement a new, modern and simplified timer driver and put it into
> >>>> drivers/clocksource. We still need to support legacy board files so
> >>>> export a config structure and a function that allows machine code to
> >>>> register the timer.
> >>>>
> >>>> We don't check the return values of regmap reads and writes since wi=
th
> >>>> mmio it's only likely to fail due to programmer's errors.
> >>>>
> >>>> We also don't bother freeing resources on errors in
> >>>> davinci_timer_register() as the system won't boot without a timer an=
yway.
> >>>>
> >>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> With this series, DA830 fails to boot. Rest of the devices are okay f=
rom
> >>> boot perspective.
> >>>
> >>> DA830 is pretty unique because it uses the same timer-half for both
> >>> clocksource and clockevent. May be you can set the same configuration=
 on
> >>> your DA850 to see the same issue? Else, I will enable low-level debug
> >>> and try to provide more debug data.
> >>>
> >>
> >> I can't boot da850 with the same config as da830 (0x60 compare
> >> register, compare irq 74) even with the old timer code. Just to make
> >> sure: does da830 boot fine with mainline v5.0-rc2?
> >
> > Yeah, I did check that without the patch DA830 does boot.
>
> You are right that DA850 lacks compare interrupts for timers 0 and 1.
> So, yes, it seems like we will have to shift to timer2 to test
> compare interrupts on DA850.
>

Timers 2 and 3 are a bit different on da850 - for instance they don't
have separate interrupts for bottom and top halfs.

I configured the old code to use timer 2 - bottom half only with
compare register 0x60 and compare intterupt 74. It boots although very
slowly and something's broken with timekeeping as the clock goes
backwards and forward (seemingly) randomly.

Kevin has an OMAP-L137 starter kit - is this the same as da830-evm? If
so, then I can get remote access to it and work on this problem.
Otherwise, I can prepare something that works on da850 with broken
timekeeping and let you see if it works correctly on da830.

Bart

> Just to confirm, DA830 boots fine with the compare section removed:
>
> ---8<---
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.=
c
> index 0d81a8fdd9e6..f34398a7e47c 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -788,14 +788,6 @@ static const struct davinci_timer_cfg da830_timer_cf=
g =3D {
>                         .flags  =3D IORESOURCE_IRQ,
>                 },
>         },
> -       .cmp =3D {
> -               .irq =3D {
> -                       .start  =3D IRQ_DA830_T12CMPINT0_0,
> -                       .end    =3D IRQ_DA830_T12CMPINT0_0,
> -                       .flags  =3D IORESOURCE_IRQ,
> -               },
> -               .offset         =3D DA830_CMP12_0,
> -       }
>  };
>
>  static const struct davinci_soc_info davinci_soc_info_da830 =3D {
> ---8<---
>
> And the low-level debug with your patches shows that its hanging at
> delay loop calibration.
>
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 5.0.0-rc1-08699-gc87d386784f3-dirty (a0875516@psplinux063) =
(gcc v9
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D0005317f
> CPU: VIVT data cache, VIVT instruction cache
> Machine: DaVinci DA830/OMAP-L137/AM17x EVM
> Memory policy: Data cache writethrough
> cma: Reserved 16 MiB at 0xc2800000
> DaVinci da830/omap-l137 rev2.0 variant 0x9
> On node 0 totalpages: 14336
>   DMA zone: 112 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 14336 pages, LIFO batch:3
> random: get_random_bytes called from start_kernel+0x80/0x3ec with crng_in=
it=3D0
> pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
> pcpu-alloc: [0] 0
> Built 1 zonelists, mobility grouping on.  Total pages: 14224
> Kernel command line: console=3DttyS2,115200n8
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 33876K/57344K available (4607K kernel code, 308K rwdata, 1072K ro=
data, )
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>     vmalloc : 0xc4000000 - 0xff800000   ( 952 MB)
>     lowmem  : 0xc0000000 - 0xc3800000   (  56 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0x(ptrval) - 0x(ptrval)   (4609 kB)
>       .init : 0x(ptrval) - 0x(ptrval)   ( 212 kB)
>       .data : 0x(ptrval) - 0x(ptrval)   ( 309 kB)
>        .bss : 0x(ptrval) - 0x(ptrval)   ( 137 kB)
> SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
> rcu: Preemptible hierarchical RCU implementation.
>         Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> NR_IRQS: 245
> clocksource: timer0_0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_=
ns: 79s
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> Console: colour dummy device 80x30
> Calibrating delay loop...
> <hangs>
>
> Thanks,
> Sekhar
