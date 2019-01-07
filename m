Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3755D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="igr5vNYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfAGDur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:50:47 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38049 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfAGDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:50:46 -0500
Received: by mail-qk1-f180.google.com with SMTP id a1so24681100qkc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 19:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Nbe9JYrc+ZcLUDJbtIuZXxkhRaLuM5dP6YX28A3dG0=;
        b=igr5vNYziC+2uQy3Zt82iWvCQNzL2iCz+tHT9u6EZoEeiVchjgsus9YPj+G16uEywC
         JRohOwd0tPLoWj1gM6d01KHKHKZH0O2Kq//yG+cMYFbrt3ZguSjM5HNG+FBaJA33+wOu
         jmwYa+VRMZollvS+bPh4mzSH+AAVw8x9OF0T8qK1b8dEC7Y5VBLThVkskCKpHWnpwbUW
         DxPTOpjUnl8OxCQRIC6IJxI6fZ2c0GAjvj284EhBDC+G0TbkbkNCnnE07t4iqSWafNKp
         Kg0JbM15dpDmhgmqBriJrhNZ5AiSjol13ZpVq38kmz3qHZsV8dbNfNazpvwcZKRSOMzk
         r2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Nbe9JYrc+ZcLUDJbtIuZXxkhRaLuM5dP6YX28A3dG0=;
        b=cUHOaaRpqez9nkKbuSRRYSQg7yzt54uvib51pC62Er6MNVnhKpI6bxY5S681x8GMK6
         bvtQ4ZlraYoKRPjADrvgOP1fYQF+lo+Q9qKLjSFDglCjJoa5WscP0llM5cgJKemljnmp
         2Q98jh1b+AhvN8N/WvKdOc0ir4LsXZX0inBWfczIYGFF2Y8YduBT8JkUxuP2eGmD9QY/
         XkTmSCIcb1lZyuY2nMh8UPQgtTX7dkW9nDD7eAeo80PDhVlNkJ/63IIh/FiOny9jmXwD
         jHZynxjJMlZgAVmH/7RZy7d55VzaddOkNmyTUmKtXPVxMpxn+KEg7HoX9iYHdS1uDFzV
         qaRA==
X-Gm-Message-State: AJcUukeAIGCZ6a3L90bO2zCJSme8w/oGstxGx7q7640rUmZMqapn+CFY
        PMMxiB9kZCj6UPBkxOd4x2jh6Htpgw/f6oVB45jiEQ==
X-Google-Smtp-Source: ALg8bN6B5P2mji2J/TtfaTGMUzdp6fCF+AHweN2lggidIbCSbyes7xKkeBSQxyDQ8qVEKvWrWhftUC3bgIy4Cs9Ig+0=
X-Received: by 2002:a05:620a:158b:: with SMTP id d11mr28828655qkk.275.1546833045050;
 Sun, 06 Jan 2019 19:50:45 -0800 (PST)
MIME-Version: 1.0
References: <CAD8Lp46R2oQxKv5gmC09Zb=WL=nV6o0CGZ3K=JZ80QYm0DJ9QQ@mail.gmail.com>
In-Reply-To: <CAD8Lp46R2oQxKv5gmC09Zb=WL=nV6o0CGZ3K=JZ80QYm0DJ9QQ@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 7 Jan 2019 11:50:33 +0800
Message-ID: <CAD8Lp468JYCGn6Qbc5720wy3JfO2SwQTD-SQWi4RK_9_dBwtbA@mail.gmail.com>
Subject: Re: APIC timer checked before it is set up, boot fails on Connex L1430
To:     Thomas Gleixner <tglx@linutronix.de>, suresh.b.siddha@intel.com
Cc:     Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 2:11 PM Daniel Drake <drake@endlessm.com> wrote:
> On the Connex L1430 laptop based on Intel Apollo Lake N3350, Linux
> doesn't boot. It hangs early on a blank screen. Reproduced with Linus
> git, 4.18 and 4.19 (there is no previous known working kernel
> version). EFI earlyprintk shows:
>
> APIC: switch to symmetric I/O mode setup
> x2apic: IRQ remapping doesn't support X2APIC mode
> ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...tryign to set up timer (IRQ0) through the 8259A ...
> ..... (found apic 0 pin 2) ...
> ....... failed.
> ...trying to set up timer as Virtual Wire IRQ...
> ..... failed.
> ...trying to set up timer as ExtINT IRQ...
> do_IRQ: 0.55 No irq handler for vector
> ..... failed :(.
> Kernel panic - not syncing: IO-APIC + timer doesn't work! Boot with
> apic=debug and send a report.
>
> Looking closer, check_timer() is observing that the IOAPIC timer
> doesn't tick, so it then tries some other approaches but doesn't
> manage to get them working either.
>
> The strange thing is, I booted with the no_timer_check parameter and
> the system works fine! With this parameter it assumes the IOAPIC timer
> is ticking and just continues the boot sequence anyway. Here is the
> boot log with apic=debug no_timer_check:
> https://gist.github.com/dsd/6f40d8ecc7102dd5dcb90c5dedc69214#file-dmesg-txt
>
> /proc/interrupts shows that APIC Local timer interrupts are working
> fine on both CPUs:
> https://gist.github.com/dsd/6f40d8ecc7102dd5dcb90c5dedc69214#file-interrupts-txt
>
> So, check_timer() is incorrectly deducing that the IOAPIC timer isn't
> working. The way it checks this is to do a delay loop and then check
> if jiffies has advanced. I presume the expectation here is that during
> this delay, the hardware IRQ will invoke local_apic_timer_interrupt()
> which will then increment jiffies. Indeed, during check_timer()
> execution this interrupt does not fire, however by using
> no_timer_check and adding a log message I can see that it fires for
> the first time quite some time after check_timer() is done:
>
>  ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>  clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
> 0xfc66f4fc7c, max_idle_ns: 440795224246 ns
>  Calibrating delay loop (skipped), value calculated using timer
> frequency.. 2188.80 BogoMIPS (lpj=1094400)
>  pid_max: default: 32768 minimum: 301
>  LSM: Security Framework initializing
>  SELinux:  Initializing.
>  Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
>  Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
>  Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
>  Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
>  mce: CPU supports 7 MCE banks
>  mce: CPU0: Thermal monitoring enabled (TM1)
>  Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
>  Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
>  Spectre V2 : Spectre mitigation: kernel not compiled with retpoline;
> no mitigation available!
>  Freeing SMP alternatives memory: 44K
>  TSC deadline timer enabled
>  smpboot: CPU0: Intel(R) Celeron(R) CPU N3350 @ 1.10GHz (family: 0x6,
> model: 0x5c, stepping: 0x9)
>  Performance Events: PEBS fmt3+, Goldmont events, 32-deep LBR,
> full-width counters, Intel PMU driver.
>  ... version:                4
>  ... bit width:              48
>  ... generic registers:      4
>  ... value mask:             0000ffffffffffff
>  ... max period:             00007fffffffffff
>  ... fixed-purpose events:   3
>  ... event mask:             000000070000000f
>  rcu: Hierarchical SRCU implementation.
>  smp: Bringing up secondary CPUs ...
>  !!! local_apic_timer_interrupt for the first time cpu0 !!!
>
> Experimenting further, I used the same approach of adding delays and
> checking for the interrupt during the delay to figure out at which
> precise point during the boot sequence the timer interrupt starts
> working. It's here:
>
> static void setup_APIC_timer(void)
> {
> [...]
>     if (this_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
> [...]
>         clockevents_config_and_register(levt,
>                         tsc_khz * (1000 / TSC_DIVISOR),
>                         0xF, ~0UL);
>     }
> }
>
> We reach clockevents_register_device() which does:
>  1. Take a spinlock and disable IRQs
>  2. lapic_set_oneshot() which leads to "TSC deadline timer enabled" message
>  3. lapic_next_deadline()
>  4. Spin unlock & re-enable IRQs
>
> At the exact point where IRQs are re-enabled above, which is at the
> time of return from clockevents_config_and_register(), timer
> interrupts start working.
>
>
> The overall ordering here seems surprising. check_timer() is probing
> whether the APIC timer works well before setup_APIC_timer() has been
> called. Shouldn't the timer be checked only after it has been set up?
>
> Or is Linux assuming that the BIOS will boot with the APIC timer
> already running?

Sorry for the rambling there - having investigated further I see I
made some bad assumptions.

Before all this clock checking happens, Linux does configure the
legacy 8254 timer via the drivers/clocksource/i8253.c driver. You
would then expect these early boot timer interrupts to start arriving
via timer_interrupt(). The APIC timer that gets set up later is not
the way that timer interrupts should appear at this earlier point
(that only gets set up later, as I found in my last mail). I verified
this behaviour on other platforms that do boot correctly.

I asked the motherboard vendor if they have any idea why the 8254 is
not ticking and they sent me a new BIOS where it is now working. So we
can probably consider this a non issue, although there are a few other
curious points to mention:

1. Other platforms with the same Intel N3350 SoC use the HPET timer
instead of PIC during early boot; on this platform there is no HPET
ACPI table though, so it uses PIT instead.

2. It does seem a little redundant that the Linux APIC code goes to
these lengths to check that the legacy 8254 timer interrupt is working
before it then gets disabled a bit later during boot (when
setup_APIC_timer happens, the clocksource layer disables the previous
timer source, in this case the PIT or HPET). Although I can see this
is not a trivial patch to write.

3. Windows 10 boots fine with no HPET & no 8254 timer ticks, so if we
find more platforms that appear in this state, we may want to look for
how to work around this strange situation on the Linux side.

Daniel
