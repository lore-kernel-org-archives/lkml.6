Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B8C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A53020895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrZqJGCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A53020895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeGZHiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:38:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32942 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeGZHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:38:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so1021742oii.0;
        Wed, 25 Jul 2018 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h5JnXN/kWbjaFkVDjc/SzmRvFMuqBJpLcdmcR6PvKvo=;
        b=lrZqJGCYEn4XkdyRr3+wAFs7u/RxTqS0IErDFz6hWZvwCpZ6htyordtC6smBfT0kaA
         sJS3l0hoOhUOaB4iUVZsbEkqvNAcsa3lMInRR3ulRhnEAKLnoZ690n22N1ZQTzPvZhMl
         QB9IQVC3Y5/Kwe4voq9gYqUbkfs98X8+DnzUknkeHG4OBFbKTXB2SxUllJQxGDFGA0LH
         gWbDSx5UEFWrHvi7Rsz7i0temEzfECg59kbXmmePAI3F6cFyCx6sOsnTBIaGqgr+m77n
         qj3EOPIjdxnfvK+C8AaXkW6nxQ9gdL07lvakWOA2ZRsSRzjfP7UeFaVELdusWgPFWd4a
         +5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h5JnXN/kWbjaFkVDjc/SzmRvFMuqBJpLcdmcR6PvKvo=;
        b=gcAmfi42zPsTYqCrTHk5x1ftBUCa+YgtczY7bo7tKenQbgs6Wog3XwT46gUe0Vo9wm
         UIz7fLs4yAGpWEkFzOYfD1LBj/urIYvmUWp4CXYIqVNRjNRu2rf3VcDA+kCKBaN+O2ZS
         A7Cq8fxTnI90E2nL+NVGhHLb9lQCELYa9k8Z/o8Z8IRbwfYlZT6EhvBznFNfKUmMRLxb
         CCeBajoU7JCx1I9nWjbjjBWEJ28LFicGatCs77/cZCPcFz3KfqGqqaCnyjBfFvPpWDNO
         W1yCBylUbuAlQKGQQiWklSKo5tZ+kqVaI76tSZNnVmxNs/VOoDcKMWt9gY+pdZgLL+tE
         zr6w==
X-Gm-Message-State: AOUpUlEqyL5++pR6flK18b0YMVPzBcLVoS9SjHJVdT0H4tFA+AbdiwQg
        lxKwFb70w/x1bWultv7nKIC2X1OcTYkDC9/t6aw=
X-Google-Smtp-Source: AAOMgpdUlpHpFKjQUv5t2TtNy2LpaZ9DHVr3wjMgVGnl2GDj0NW1v1kEgxBcEdc3AGGuaHkrJH9DbxJ2/K/FC34xcp8=
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr677513oih.269.1532586168888;
 Wed, 25 Jul 2018 23:22:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:22:28
 -0700 (PDT)
In-Reply-To: <20180724164946.6274-4-krzk@kernel.org>
References: <20180724164946.6274-1-krzk@kernel.org> <20180724164946.6274-4-krzk@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 26 Jul 2018 11:52:28 +0530
Message-ID: <CANAwSgSChhEzDf5oSqZ2Srt62n16Z+ppFnupT=0pGkaSCv90vw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: exynos: Fix imprecise abort during Exynos5422
 suspend to RAM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 24 July 2018 at 22:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
> imprecise abort:
>
>         PM: Syncing filesystems ... done.
>         Freezing user space processes ... (elapsed 0.003 seconds) done.
>         OOM killer disabled.
>         Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
>         wake enabled for irq 139
>         Disabling non-boot CPUs ...
>         IRQ51 no longer affine to CPU1
>         IRQ52 no longer affine to CPU2
>         IRQ53 no longer affine to CPU3
>         IRQ54 no longer affine to CPU4
>         IRQ55 no longer affine to CPU5
>         IRQ56 no longer affine to CPU6
>         cpu cpu4: Dropping the link to regulator.40
>         IRQ57 no longer affine to CPU7
>         Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
>         Internal error: : 1008 [#1] PREEMPT SMP ARM
>
> with last call trace in exynos_suspend_enter().
>
> The abort is caused by writing to register in secure part of sysram.
> Boards booted under secure firmware (e.g. Hardkernel Odroid boards)
> should access non-secure sysram.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>

I could not get the suspend to ram working on my Odroid-XU4.

Current default time zone: 'Asia/Kolkata'
Local time is now:      Thu Jul 26 11:34:50 IST 2018.
Universal Time is now:  Thu Jul 26 06:04:50 UTC 2018.

root@odroidxu4:~#
root@odroidxu4:~#
root@odroidxu4:~# rtcwake -d /dev/rtc0 -s 30 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jul 26 06:06:40 2018

System freezes with no output in console. Any other way to test this feature.
I have also tried below setting.

/* Set the wakeup alarm for 30s */
# echo +30 > /sys/class/rtc/rtc0/wakealarm
/* Suspend system to RAM */
# echo -n mem > /sys/power/state

but result is the same.

Well suspend to ram works well on Odroid-U3+
----------------------------------------------------------------------
root@odroidu3:~# rtcwake -d /dev/rtc0 -s 30 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jul 26 05:52:09 2018
[   58.655171] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   58.655186] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
root@odroidu3:~#
root@odroidu3:~#
root@odroidu3:~#
root@odroidu3:~#
root@odroidu3:~# rtcwake -d /dev/rtc0 -s 30 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jul 26 05:55:36 2018
[  235.633796] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[  235.633811] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
root@odroidu3:~#
root@odroidu3:~#

But also observer following kernel crash on Odroid-U3+.

root@odroidu3:~# rtcwake -d /dev/rtc0 -s 30 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jul 26 06:17:20 2018
[   48.794091] smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
[   48.823822] wake enabled for irq 119
[   48.838208] usb3503 0-0008: switched to STANDBY mode
[   48.838883] wake enabled for irq 123
[   48.844391] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   48.844743] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   48.844758] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   49.030155] samsung-pinctrl 11000000.pinctrl: Setting external
wakeup interrupt wakeup mask: 0xfbfff7ff
[   49.054626] Disabling non-boot CPUs ...
[   49.172267]
[   49.172889] =============================
[   49.172895] WARNING: suspicious RCU usage
[   49.172902] 4.18.0-rc1-xu3 #1 Not tainted
[   49.172908] -----------------------------
[   49.172917] kernel/sched/fair.c:6629 suspicious
rcu_dereference_check() usage!
[   49.172922]
[   49.172922] other info that might help us debug this:
[   49.172922]
[   49.172930]
[   49.172930] RCU used illegally from offline CPU!
[   49.172930] rcu_scheduler_active = 2, debug_locks = 0
[   49.172938] 3 locks held by swapper/2/0:
[   49.172944]  #0: c108528f ((cpu_died).wait.lock){....}, at:
complete+0x14/0x48
[   49.172978]  #1: 5327b14b (&p->pi_lock){-.-.}, at: try_to_wake_up+0x38/0x620
[   49.173008]  #2: cb644f0e (rcu_read_lock){....}, at:
select_task_rq_fair+0x1b4/0x11a4
[   49.173041]
[   49.173041] stack backtrace:
[   49.173050] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.0-rc1-xu3 #1
[   49.173056] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   49.173070] [<c01130f0>] (unwind_backtrace) from [<c010ed7c>]
(show_stack+0x10/0x14)
[   49.173084] [<c010ed7c>] (show_stack) from [<c0a3ad64>]
(dump_stack+0x98/0xc4)
[   49.173099] [<c0a3ad64>] (dump_stack) from [<c0166a48>]
(select_task_rq_fair+0x5c8/0x11a4)
[   49.173111] [<c0166a48>] (select_task_rq_fair) from [<c015aaac>]
(try_to_wake_up+0x168/0x620)
[   49.173123] [<c015aaac>] (try_to_wake_up) from [<c0176c60>]
(__wake_up_common+0x8c/0x14c)
[   49.173135] [<c0176c60>] (__wake_up_common) from [<c0176e24>]
(__wake_up_locked+0x18/0x20)
[   49.173146] [<c0176e24>] (__wake_up_locked) from [<c0177c18>]
(complete+0x38/0x48)
[   49.173159] [<c0177c18>] (complete) from [<c0111874>]
(arch_cpu_idle_dead+0x24/0x84)
[   49.173171] [<c0111874>] (arch_cpu_idle_dead) from [<c0160e8c>]
(do_idle+0x1d0/0x2bc)
[   49.173184] [<c0160e8c>] (do_idle) from [<c0161308>]
(cpu_startup_entry+0x18/0x1c)
[   49.173195] [<c0161308>] (cpu_startup_entry) from [<4010280c>] (0x4010280c)
[   49.232931] Enabling non-boot CPUs ...
[   49.237088] CPU1 is up
[   49.238630] CPU2 is up
[   49.242535] CPU3 is up
[   49.243777] s3c-i2c 13860000.i2c: slave address 0x00
[   49.243834] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[   49.243862] s3c-i2c 13870000.i2c: slave address 0x00
[   49.243876] s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
[   49.243899] s3c-i2c 13880000.i2c: slave address 0x00
[   49.243913] s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
[   49.243935] s3c-i2c 138e0000.i2c: slave address 0x00
[   49.243948] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[   49.255899] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[   49.256413] dwc2 12480000.hsotg: resuming usb gadget g_ether
[   49.260032] usb usb1: root hub lost power or was reset
[   49.260889] s3c2410-wdt 10060000.watchdog: watchdog disabled
[   49.261036] wake disabled for irq 123
[   49.270297] usb3503 0-0008: switched to HUB mode
[   49.359166] wake disabled for irq 119
[   49.376207]
[   49.376213] ======================================================
[   49.376218] WARNING: possible circular locking dependency detected
[   49.376221] 4.18.0-rc1-xu3 #1 Not tainted
[   49.376225] ------------------------------------------------------
[   49.376228] swapper/2/0 is trying to acquire lock:
[   49.376233] 54f93603 ((console_sem).lock){-...}, at: down_trylock+0xc/0x2c
[   49.376244]
[   49.376247] but task is already holding lock:
[   49.376250] 5327b14b (&p->pi_lock){-.-.}, at: try_to_wake_up+0x38/0x620
[   49.376261]
[   49.376264] which lock already depends on the new lock.
[   49.376266]
[   49.376268]
[   49.376272] the existing dependency chain (in reverse order) is:
[   49.376274]
[   49.376276] -> #1 (&p->pi_lock){-.-.}:
[   49.376287]        try_to_wake_up+0x38/0x620
[   49.376290]        up+0x4c/0x60
[   49.376293]        __up_console_sem+0x2c/0x58
[   49.376295]        console_unlock+0x3b4/0x644
[   49.376298]        con_set_unimap+0x140/0x22c
[   49.376301]        vt_ioctl+0x1364/0x1710
[   49.376304]        tty_ioctl+0xec/0xb54
[   49.376307]        do_vfs_ioctl+0xb0/0x9f8
[   49.376310]        ksys_ioctl+0x34/0x58
[   49.376313]        ret_fast_syscall+0x0/0x28
[   49.376315]        0xbefc02a4
[   49.376317]
[   49.376320] -> #0 ((console_sem).lock){-...}:
[   49.376331]        _raw_spin_lock_irqsave+0x44/0x58
[   49.376333]        down_trylock+0xc/0x2c
[   49.376337]        __down_trylock_console_sem+0x24/0x88
[   49.376340]        console_trylock+0x10/0x58
[   49.376343]        vprintk_emit+0x224/0x420
[   49.376346]        vprintk_default+0x20/0x28
[   49.376349]        printk+0x30/0x54
[   49.376352]        lockdep_rcu_suspicious+0x2c/0x108
[   49.376355]        select_task_rq_fair+0x5c8/0x11a4
[   49.376358]        try_to_wake_up+0x168/0x620
[   49.376361]        __wake_up_common+0x8c/0x14c
[   49.376364]        __wake_up_locked+0x18/0x20
[   49.376367]        complete+0x38/0x48
[   49.376370]        arch_cpu_idle_dead+0x24/0x84
[   49.376372]        do_idle+0x1d0/0x2bc
[   49.376375]        cpu_startup_entry+0x18/0x1c
[   49.376378]        0x4010280c
[   49.376380]
[   49.376383] other info that might help us debug this:
[   49.376385]
[   49.376388]  Possible unsafe locking scenario:
[   49.376391]
[   49.376394]        CPU0                    CPU1
[   49.376396]        ----                    ----
[   49.376399]   lock(&p->pi_lock);
[   49.376406]                                lock((console_sem).lock);
[   49.376413]                                lock(&p->pi_lock);
[   49.376419]   lock((console_sem).lock);
[   49.376425]
[   49.376428]  *** DEADLOCK ***
[   49.376430]
[   49.376434] 3 locks held by swapper/2/0:
[   49.376436]  #0: c108528f ((cpu_died).wait.lock){....}, at:
complete+0x14/0x48
[   49.376449]  #1: 5327b14b (&p->pi_lock){-.-.}, at: try_to_wake_up+0x38/0x620
[   49.376461]  #2: cb644f0e (rcu_read_lock){....}, at:
select_task_rq_fair+0x1b4/0x11a4
[   49.376473]
[   49.376476] stack backtrace:
[   49.376480] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.0-rc1-xu3 #1
[   49.376483] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   49.376487] [<c01130f0>] (unwind_backtrace) from [<c010ed7c>]
(show_stack+0x10/0x14)
[   49.376491] [<c010ed7c>] (show_stack) from [<c0a3ad64>]
(dump_stack+0x98/0xc4)
[   49.376495] [<c0a3ad64>] (dump_stack) from [<c0183a2c>]
(print_circular_bug.constprop.15+0x210/0x32c)
[   49.376500] [<c0183a2c>] (print_circular_bug.constprop.15) from
[<c0186eac>] (__lock_acquire+0x155c/0x1ac8)
[   49.376504] [<c0186eac>] (__lock_acquire) from [<c0187e38>]
(lock_acquire+0xe0/0x2bc)
[   49.376508] [<c0187e38>] (lock_acquire) from [<c0a58604>]
(_raw_spin_lock_irqsave+0x44/0x58)
[   49.376512] [<c0a58604>] (_raw_spin_lock_irqsave) from [<c0180390>]
(down_trylock+0xc/0x2c)
[   49.376516] [<c0180390>] (down_trylock) from [<c0192878>]
(__down_trylock_console_sem+0x24/0x88)
[   49.376521] [<c0192878>] (__down_trylock_console_sem) from
[<c01928ec>] (console_trylock+0x10/0x58)
[   49.376525] [<c01928ec>] (console_trylock) from [<c0194544>]
(vprintk_emit+0x224/0x420)
[   49.376529] [<c0194544>] (vprintk_emit) from [<c01948f0>]
(vprintk_default+0x20/0x28)
[   49.376532] [<c01948f0>] (vprintk_default) from [<c0194d54>]
(printk+0x30/0x54)
[   49.376536] [<c0194d54>] (printk) from [<c01836e8>]
(lockdep_rcu_suspicious+0x2c/0x108)
[   49.376541] [<c01836e8>] (lockdep_rcu_suspicious) from [<c0166a48>]
(select_task_rq_fair+0x5c8/0x11a4)
[   49.376545] [<c0166a48>] (select_task_rq_fair) from [<c015aaac>]
(try_to_wake_up+0x168/0x620)
[   49.376549] [<c015aaac>] (try_to_wake_up) from [<c0176c60>]
(__wake_up_common+0x8c/0x14c)
[   49.376553] [<c0176c60>] (__wake_up_common) from [<c0176e24>]
(__wake_up_locked+0x18/0x20)
[   49.376557] [<c0176e24>] (__wake_up_locked) from [<c0177c18>]
(complete+0x38/0x48)
[   49.376560] [<c0177c18>] (complete) from [<c0111874>]
(arch_cpu_idle_dead+0x24/0x84)
[   49.376565] [<c0111874>] (arch_cpu_idle_dead) from [<c0160e8c>]
(do_idle+0x1d0/0x2bc)
[   49.376569] [<c0160e8c>] (do_idle) from [<c0161308>]
(cpu_startup_entry+0x18/0x1c)
[   49.376572] [<c0161308>] (cpu_startup_entry) from [<4010280c>] (0x4010280c)
[   49.659576] usb 1-2: reset high-speed USB device number 2 using exynos-ehci
[   50.009654] usb 1-3: reset high-speed USB device number 3 using exynos-ehci
[   51.113111] OOM killer enabled.
[   51.116204] Restarting tasks ... done.
[   51.147734] PM: suspend exit
root@odroidu3:~# [   51.713940] smsc95xx 1-2:1.0 eth0: link up,
100Mbps, full-duplex, lpa 0xC5E1

Best Regards
-Anand
