Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDSGxy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:53:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:9588 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbeDSGxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:53:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="44442338"
Date: Thu, 19 Apr 2018 14:53:49 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [string_selftest_init] watchdog: BUG: soft lockup - CPU#0 stuck
 for 23s! [swapper/0:1]
Message-ID: <20180419065349.nga7edte6tudsu5l@wfg-t540p.sh.intel.com>
References: <20180419025052.nvhcfcigjfuhg34i@wfg-t540p.sh.intel.com>
 <CAMuHMdWZaK6hpryCYxcLY_9NbZG1zG2FPs9n2FeqUMqhe=nfMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdWZaK6hpryCYxcLY_9NbZG1zG2FPs9n2FeqUMqhe=nfMQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:22:24AM +0200, Geert Uytterhoeven wrote:
>Hi Fengguang,
>
>On Thu, Apr 19, 2018 at 4:50 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>> FYI this happens in mainline kernel 4.17.0-rc1.
>> It dates back to v4.14-rc1 , perhaps since the test was introduced.
>>
>> It occurs in 1 out of 1 boots.
>
>I guess the test just takes too long, causing a panic if
>BOOTPARAM_HUNG_TASK_PANIC=y?

That does the trick of saving test time. ;) Another option is to add
cond_resched(), will that be feasible?

Thanks,
Fengguang

>> [   83.615461] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
>> [   83.627616] io scheduler noop registered
>> [   83.634396] io scheduler deadline registered (default)
>> [   83.643012] io scheduler mq-deadline registered (default)
>> [   83.652509] io scheduler bfq registered
>> [  108.580122] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:1]
>> [  108.580122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #210
>> [  108.580122] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [  108.580122] RIP: 0010:check_kcov_mode+0x24/0x37:
>>                                                 __read_once_size at include/linux/compiler.h:188 (discriminator 1)
>>                                                  (inlined by) check_kcov_mode at kernel/kcov.c:69 (discriminator 1)
>> [  108.580122] RSP: 0000:ffff88000fd43e48 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
>> [  108.580122] RAX: 0000000000000000 RBX: ffff88000fd3e000 RCX: 0000000000000000
>> [  108.580122] RDX: 0000000000000000 RSI: ffff88000fd3e000 RDI: 0000000000000002
>> [  108.580122] RBP: ffffffff853b9f96 R08: 00000000014000c0 R09: 00000000ffffffff
>> [  108.580122] R10: ffff88000fd3e000 R11: 0000000000000002 R12: ffff88001a6c0458
>> [  108.580122] R13: 0000000000000011 R14: ffff88001a6c0530 R15: 00000000a1a1a1a1
>> [  108.580122] FS:  0000000000000000(0000) GS:ffff88001f600000(0000) knlGS:0000000000000000
>> [  108.580122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  108.580122] CR2: 0000000000000000 CR3: 0000000003c6a000 CR4: 00000000000006b0
>> [  108.580122] Call Trace:
>> [  108.580122]  __sanitizer_cov_trace_pc+0x2b/0x66:
>>                                                 __sanitizer_cov_trace_pc at kernel/kcov.c:101
>> [  108.580122]  string_selftest_init+0x25e/0x5c0:
>>                                                 memset32_selftest at lib/test_string.c:60
>>                                                  (inlined by) string_selftest_init at lib/test_string.c:124
>> [  108.580122]  ? prandom_reseed+0x52/0x52:
>>                                                 string_selftest_init at lib/test_string.c:115
>> [  108.580122]  do_one_initcall+0x18e/0x3df:
>>                                                 do_one_initcall at init/main.c:883
>> [  108.580122]  ? check_kcov_mode+0x5/0x37:
>>                                                 check_kcov_mode at kernel/kcov.c:60
>> [  108.580122]  ? __sanitizer_cov_trace_pc+0x2b/0x66:
>>                                                 __sanitizer_cov_trace_pc at kernel/kcov.c:101
>> [  108.580122]  ? check_kcov_mode+0x5/0x37:
>>                                                 check_kcov_mode at kernel/kcov.c:60
>> [  108.580122]  kernel_init_freeable+0x250/0x3a5:
>>                                                 do_initcall_level at init/main.c:951
>>                                                  (inlined by) do_initcalls at init/main.c:959
>>                                                  (inlined by) do_basic_setup at init/main.c:977
>>                                                  (inlined by) kernel_init_freeable at init/main.c:1127
>> [  108.580122]  ? rest_init+0x13a/0x13a:
>>                                                 kernel_init at init/main.c:1050
>> [  108.580122]  kernel_init+0x17/0x218:
>>                                                 kernel_init at init/main.c:1053
>> [  108.580122]  ? rest_init+0x13a/0x13a:
>>                                                 kernel_init at init/main.c:1050
>> [  108.580122]  ret_from_fork+0x35/0x40:
>>                                                 ret_from_fork at arch/x86/entry/entry_64.S:418
>> [  108.580122] Code: 41 5c 41 5d 41 5e c3 e8 e8 c6 a3 01 48 ff 05 71 33 fd 04 31 c0 65 8b 15 78 00 e5 7e 81 e2 00 01 1f 00 75 19 48 ff 05 61 33 fd 04 <8b> 86 18 1c 00 00 39 c7 0f 94 c0 48 ff 05 57 33 fd 04 c3 e8 b1
>> [  108.580122] Kernel panic - not syncing: softlockup: hung tasks
>> [  108.580122] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G             L    4.17.0-rc1 #210
>> [  108.580122] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [  108.580122] Call Trace:
>> [  108.580122]  <IRQ>
>> [  108.580122]  dump_stack+0xf3/0x135:
>>                                                 __dump_stack at lib/dump_stack.c:77
>>                                                  (inlined by) dump_stack at lib/dump_stack.c:113
>> [  108.580122]  panic+0x173/0x440:
>>                                                 panic at kernel/panic.c:195
>> [  108.580122]  watchdog_timer_fn+0x343/0x382:
>>                                                 watchdog_timer_fn at kernel/watchdog.c:444
>> [  108.580122]  __hrtimer_run_queues+0x2a0/0x4c3:
>>                                                 __run_hrtimer at kernel/time/hrtimer.c:1386
>>                                                  (inlined by) __hrtimer_run_queues at kernel/time/hrtimer.c:1448
>> [  108.580122]  hrtimer_run_queues+0xcb/0xed:
>>                                                 hrtimer_run_queues at kernel/time/hrtimer.c:1621
>> [  108.580122]  run_local_timers+0x2d/0x85:
>>                                                 run_local_timers at kernel/time/timer.c:1704
>> [  108.580122]  update_process_times+0x30/0x7e:
>>                                                 update_process_times at kernel/time/timer.c:1636
>> [  108.580122]  tick_nohz_handler+0x141/0x19a:
>>                                                 tick_sched_handle at kernel/time/tick-sched.c:173
>>                                                  (inlined by) tick_nohz_handler at kernel/time/tick-sched.c:1182
>> [  108.580122]  smp_apic_timer_interrupt+0x1a5/0x2c4:
>>                                                 local_apic_timer_interrupt at arch/x86/kernel/apic/apic.c:1025
>>                                                  (inlined by) smp_apic_timer_interrupt at arch/x86/kernel/apic/apic.c:1050
>> [  108.580122]  apic_timer_interrupt+0xf/0x20:
>>                                                 apic_timer_interrupt at arch/x86/entry/entry_64.S:863
>> [  108.580122]  </IRQ>
>> [  108.580122] RIP: 0010:check_kcov_mode+0x24/0x37:
>>                                                 __read_once_size at include/linux/compiler.h:188 (discriminator 1)
>>                                                  (inlined by) check_kcov_mode at kernel/kcov.c:69 (discriminator 1)
>> [  108.580122] RSP: 0000:ffff88000fd43e48 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
>> [  108.580122] RAX: 0000000000000000 RBX: ffff88000fd3e000 RCX: 0000000000000000
>> [  108.580122] RDX: 0000000000000000 RSI: ffff88000fd3e000 RDI: 0000000000000002
>> [  108.580122] RBP: ffffffff853b9f96 R08: 00000000014000c0 R09: 00000000ffffffff
>> [  108.580122] R10: ffff88000fd3e000 R11: 0000000000000002 R12: ffff88001a6c0458
>> [  108.580122] R13: 0000000000000011 R14: ffff88001a6c0530 R15: 00000000a1a1a1a1
>> [  108.580122]  ? string_selftest_init+0x25e/0x5c0:
>>                                                 memset32_selftest at lib/test_string.c:60
>>                                                  (inlined by) string_selftest_init at lib/test_string.c:124
>> [  108.580122]  ? check_kcov_mode+0x5/0x37:
>>                                                 check_kcov_mode at kernel/kcov.c:60
>> [  108.580122]  __sanitizer_cov_trace_pc+0x2b/0x66:
>>                                                 __sanitizer_cov_trace_pc at kernel/kcov.c:101
>> [  108.580122]  string_selftest_init+0x25e/0x5c0:
>>                                                 memset32_selftest at lib/test_string.c:60
>>                                                  (inlined by) string_selftest_init at lib/test_string.c:124
>> [  108.580122]  ? prandom_reseed+0x52/0x52:
>>                                                 string_selftest_init at lib/test_string.c:115
>> [  108.580122]  do_one_initcall+0x18e/0x3df:
>>                                                 do_one_initcall at init/main.c:883
>> [  108.580122]  ? check_kcov_mode+0x5/0x37:
>>                                                 check_kcov_mode at kernel/kcov.c:60
>> [  108.580122]  ? __sanitizer_cov_trace_pc+0x2b/0x66:
>>                                                 __sanitizer_cov_trace_pc at kernel/kcov.c:101
>> [  108.580122]  ? check_kcov_mode+0x5/0x37:
>>                                                 check_kcov_mode at kernel/kcov.c:60
>> [  108.580122]  kernel_init_freeable+0x250/0x3a5:
>>                                                 do_initcall_level at init/main.c:951
>>                                                  (inlined by) do_initcalls at init/main.c:959
>>                                                  (inlined by) do_basic_setup at init/main.c:977
>>                                                  (inlined by) kernel_init_freeable at init/main.c:1127
>> [  108.580122]  ? rest_init+0x13a/0x13a:
>>                                                 kernel_init at init/main.c:1050
>> [  108.580122]  kernel_init+0x17/0x218:
>>                                                 kernel_init at init/main.c:1053
>> [  108.580122]  ? rest_init+0x13a/0x13a:
>>                                                 kernel_init at init/main.c:1050
>> [  108.580122]  ret_from_fork+0x35/0x40:
>>                                                 ret_from_fork at arch/x86/entry/entry_64.S:418
>> [  108.580122] Kernel Offset: disabled
>>
>> Attached the full dmesg, kconfig and reproduce scripts.
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>-- 
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>                                -- Linus Torvalds
>
