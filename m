Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB047C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150D20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A150D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeKJEXF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:23:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:50543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJEXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:23:04 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MWk7n-1g1cm91D9X-00XtFj; Fri, 09
 Nov 2018 19:41:06 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <0e926f4b-1148-289b-39a1-ef76baa8cf9d@arm.com>
Date:   Fri, 9 Nov 2018 13:41:03 -0500
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <960D7493-0D43-40A3-9441-CF7F0D76A534@gmx.us>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
 <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
 <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com>
 <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
 <930d61db-6e44-8501-983d-09cd3759d153@arm.com>
 <CAPKp9uY7DOV9xMhCQcAC8yh0z3-=2U-CmZq064Br=d4VYrcg=A@mail.gmail.com>
 <0e926f4b-1148-289b-39a1-ef76baa8cf9d@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:SCj1khCZ2KUervSiO8U5J5wQnXaqBaED8qoHBl3d5NWTQQkz4ss
 QkygVEAgwaxsKkiYSlhJ1uRsJeG7nDBQyAWpNJa/EflWhBZRpC08lPmCPFfLJxMhk4Aa7Ss
 9BQ61EbBfqZ0FOWgVvDHyRjNr/+EVK3JMjg4la41psk8gzgaKfn8TJTsaDa45MG188dh3e/
 5CJc2Pic1WLh9bJGWe3AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VhKCI/vrZGs=:4loNjj0lRhA0+ig6S6G5q7
 bArR07tegfiHni40oWdRrVzn2E9xHhM5DP6PnJ4GxhAv0vlFUmH+viKJ6BhM6ZHyIh/SHoFvS
 5doCUKrVZ6pE61ECWQQfVzE3wB9VbvjwCcdDqNnLvE/GYCuj5hR+7qn6R0/ntiug2JnHODFxS
 rK9F/sIZyaClc6SbSjkBqwvG4nP2we0YO6wOytpFeAGnJV2ZLjKrouICK8iG/YRwZku1NbOpv
 4vANQmXE4DtSjCrNOt6DGE1eX1BKzkWn6qZJFBiHSTIZvB0jnahYYt6AWUsAx+66TR4Ydtnuf
 kDEyZWbzHfx48Qic6saNo1u2C9y6rd5ebDSj8tp/pf4xkLlO+2JTuYf5EJk58rqkT3MgvDIfD
 FLbQFrsbPACEMlRK1nF6D7wgw1P51DAaA4vDdSpZw6sc/EvOb+yWZZv0WLgVc7CTA8yVkTgW8
 eHHrwWgzqw47BC6TUXjV5Fb3PySiYT9iDAOSt+1TDYm09xy/FTBrkk2V2rTXPGiBawcLqSo0u
 qz/CURn0CSckp8/ZFruhaxH1ItXUv1o105v1cjqemRCcnrAE0bzRRvVr16Wrqg25coYP0deGQ
 GkPoTBy3jkqXel7cxQKjShxC8s/IiZ8FzMdowXiZS0vTudY2lAZ6Ax3HPkLo1FCui2Pnn9DKS
 Xz6ikNUuWlenVJfhn66kco5JlFWLZ9Qh42xcNXzytphqXLuZqT8xrB6UrQi45JEPvd/MZYLll
 PcBm5IwfH5Ykl9nKQ14WhZM1jVNNMYUAwbQdqypH0LEZGzHoHHrOaPf6FQ3U7DeJ6ObVS8WYG
 yqmzV7rE8IpTTn8CTsoYOKFeXLeMKdErXLTwCdIP8Nn5ReXH/f7VdpsDKXBZWWqBQprgjEWud
 W7VKkbNeJLmVImzCfZiFC8bTT5PrMkP8ET7JT3PsXXxQXUwxRNDhrYM8LbNe75wX+mvQ/vgVW
 vhE1Tvqu8GG3acMtg96blLkUMNaMhFtnzKqQkDmIuX0qw7dGw/rI4DPPMyxa+bERHATsV8Ra1
 zA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 12:41 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On 09/11/18 17:28, Sudeep Holla wrote:
>> On Fri, Nov 9, 2018 at 4:10 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> 
>> [...]
>> 
>>> 
>>> See bb42ca474010 and d003d029cea8 for details.
>>> 
>>> Now, activating this workaround leads to lockdep being really angry,
>>> most likely because the cpus_read_lock is not taken, which is a change
>>> in behaviour...
>>> 
>>> I'm trying to dig into this now.
>>> 
>> 
>> Yes we found similar issue in kernel/sched/core.c sched_init_smp
>> There's a fix with detailed description in -next
>> (Commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")
>> 
>> The behaviour changed since  commit cb538267ea1e ("jump_label/lockdep:
>> Assert we hold the hotplug lock for _cpuslocked() operations")
> 
> I indeed came to the same conclusion, but the fix is slightly less than
> obvious. I have the following arm64-specific crap, but it is pretty
> terrible:
> 
> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
> index f258636273c9..9e96e9eaca9b 100644
> --- a/arch/arm64/kernel/time.c
> +++ b/arch/arm64/kernel/time.c
> @@ -36,6 +36,7 @@
> #include <linux/clocksource.h>
> #include <linux/clk-provider.h>
> #include <linux/acpi.h>
> +#include <linux/cpu.h>
> 
> #include <clocksource/arm_arch_timer.h>
> 
> @@ -69,7 +70,9 @@ void __init time_init(void)
> 	u32 arch_timer_rate;
> 
> 	of_clk_init(NULL);
> +	cpus_read_lock();
> 	timer_probe();
> +	cpus_read_unlock();
> 
> 	tick_setup_hrtimer_broadcast();
> 
> Qian, can you please let me know if this helps? If it does, we'll have
> to think of something a bit better…
After applied the above patch, the original warning is gone but there
Is now a new warning.

> [    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
> [    0.000000] 
> [    0.000000] ======================================================
> [    0.000000] WARNING: possible circular locking dependency detected
> [    0.000000] 4.20.0-rc1+ #10 Tainted: G                T
> [    0.000000] ------------------------------------------------------
> [    0.000000] swapper/0/0 is trying to acquire lock:
> [    0.000000] (____ptrval____) (acpi_probe_mutex){....}, at: __acpi_probe_device_table+0xac/0x1ec
> [    0.000000] 
> [    0.000000] but task is already holding lock:
> [    0.000000] (____ptrval____) (cpu_hotplug_lock.rw_sem){....}, at: time_init+0x44/0xa0
> [    0.000000] 
> [    0.000000] which lock already depends on the new lock.
> [    0.000000] 
> [    0.000000] 
> [    0.000000] the existing dependency chain (in reverse order) is:
> [    0.000000] 
> [    0.000000] -> #1 (cpu_hotplug_lock.rw_sem){....}:
> [    0.000000]        __lock_acquire+0x3cc/0x858
> [    0.000000]        lock_acquire+0x124/0x330
> [    0.000000]        cpus_read_lock+0x6c/0x100
> [    0.000000]        __cpuhp_setup_state+0x38/0x78
> [    0.000000]        gic_init_bases+0x3ac/0x5d8
> [    0.000000]        gic_acpi_init+0x2cc/0x564
> [    0.000000]        acpi_match_madt+0x9c/0x15c
> [    0.000000]        acpi_table_parse_entries_array+0x3e0/0x5d8
> [    0.000000]        acpi_table_parse_entries+0xbc/0x114
> [    0.000000]        acpi_table_parse_madt+0x4c/0x80
> [    0.000000]        __acpi_probe_device_table+0x134/0x1ec
> [    0.000000]        irqchip_init+0x48/0x74
> [    0.000000]        init_IRQ+0xe4/0x12c
> [    0.000000]        start_kernel+0x4d0/0x7d4
> [    0.000000] 
> [    0.000000] -> #0 (acpi_probe_mutex){....}:
> [    0.000000]        validate_chain.isra.19+0xcd8/0x1158
> [    0.000000]        __lock_acquire+0x3cc/0x858
> [    0.000000]        lock_acquire+0x124/0x330
> [    0.000000]        __mutex_lock+0x110/0xa68
> [    0.000000]        mutex_lock_nested+0x3c/0x50
> [    0.000000]        __acpi_probe_device_table+0xac/0x1ec
> [    0.000000]        timer_probe+0x1bc/0x254
> [    0.000000]        time_init+0x48/0xa0
> [    0.000000]        start_kernel+0x4ec/0x7d4
> [    0.000000] 
> [    0.000000] other info that might help us debug this:
> [    0.000000] 
> [    0.000000]  Possible unsafe locking scenario:
> [    0.000000] 
> [    0.000000]        CPU0                    CPU1
> [    0.000000]        ----                    ----
> [    0.000000]   lock(cpu_hotplug_lock.rw_sem);
> [    0.000000]                                lock(acpi_probe_mutex);
> [    0.000000]                                lock(cpu_hotplug_lock.rw_sem);
> [    0.000000]   lock(acpi_probe_mutex);
> [    0.000000] 
> [    0.000000]  *** DEADLOCK ***
> [    0.000000] 
> [    0.000000] 1 lock held by swapper/0/0:
> [    0.000000]  #0: (____ptrval____) (cpu_hotplug_lock.rw_sem){....}, at: time_init+0x44/0xa0
> [    0.000000] 
> [    0.000000] stack backtrace:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-rc1+ #10
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x248
> [    0.000000]  show_stack+0x24/0x30
> [    0.000000]  dump_stack+0xb8/0xf4
> [    0.000000]  print_circular_bug.isra.15+0x240/0x368
> [    0.000000]  check_prev_add.constprop.24+0x444/0xa38
> [    0.000000]  validate_chain.isra.19+0xcd8/0x1158
> [    0.000000]  __lock_acquire+0x3cc/0x858
> [    0.000000]  lock_acquire+0x124/0x330
> [    0.000000]  __mutex_lock+0x110/0xa68
> [    0.000000]  mutex_lock_nested+0x3c/0x50
> [    0.000000]  __acpi_probe_device_table+0xac/0x1ec
> [    0.000000]  timer_probe+0x1bc/0x254
> [    0.000000]  time_init+0x48/0xa0
> [    0.000000]  start_kernel+0x4ec/0x7d4
> [    0.000000] arch_timer: Enabling global workaround for HiSilicon erratum 161010101
> [    0.000000] arch_timer: CPU0: Trapping CNTVCT access
> [    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns

