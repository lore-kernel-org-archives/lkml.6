Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06568C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6572083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6572083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeIGFno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:43:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:40404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeIGFnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:43:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 18:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="gz'50?scan'50,208,50";a="71232548"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 18:05:15 -0700
Date:   Fri, 7 Sep 2018 09:05:39 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] 0a3856392c [   10.513760] INFO: trying to register non-static
 key.
Message-ID: <20180907010539.GB6655@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 0a3856392cff1542170b5bc37211c9a21fd0c3f6
Author:     Matthew Wilcox <willy@infradead.org>
AuthorDate: Mon Jun 18 17:23:37 2018 -0400
Commit:     Matthew Wilcox <willy@infradead.org>
CommitDate: Tue Aug 21 23:54:20 2018 -0400

    test_ida: Move ida_check_leaf
    
    Convert to new API and move to kernel space.  Take the opportunity to
    test the situation a little more thoroughly (ie at different offsets).
    
    Signed-off-by: Matthew Wilcox <willy@infradead.org>

06b0111366  idr-test: Convert ida_check_nomem to new API
0a3856392c  test_ida: Move ida_check_leaf
b36fdc6853  Merge tag 'gpio-v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
509d1f0c29  Add linux-next specific files for 20180906
+--------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                    | 06b0111366 | 0a3856392c | b36fdc6853 | next-20180906 |
+--------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                     | 0          | 0          | 0          | 0             |
| boot_failures                                                      | 50         | 17         | 21         | 13            |
| WARNING:at_mm/page_alloc.c:#__alloc_pages_slowpath                 | 50         | 17         | 21         | 13            |
| RIP:__alloc_pages_slowpath                                         | 50         | 17         | 21         | 13            |
| Mem-Info                                                           | 50         | 17         | 21         | 13            |
| WARNING:suspicious_RCU_usage                                       | 50         |            |            |               |
| lib/test_rhashtable.c:#suspicious_rcu_dereference_protected()usage | 50         |            |            |               |
| invoked_oom-killer:gfp_mask=0x                                     | 3          | 0          | 0          | 2             |
| Out_of_memory:Kill_process                                         | 2          |            |            |               |
| INFO:trying_to_register_non-static_key                             | 0          | 17         | 21         | 13            |
| IP-Config:Auto-configuration_of_network_failed                     | 0          | 0          | 4          |               |
| Out_of_memory_and_no_killable_processes                            | 0          | 0          | 0          | 2             |
| Kernel_panic-not_syncing:System_is_deadlocked_on_memory            | 0          | 0          | 0          | 2             |
+--------------------------------------------------------------------+------------+------------+------------+---------------+

[   10.508200 ] test_hash: __hash_32() has no arch implementation to
test.
[   10.509510 ] test_hash: hash_32() has no arch implementation to test.
[   10.510791 ] test_hash: hash_64() has no arch implementation to test.
[   10.512048 ] test_hash: 33152 tests passed.
[   10.512895 ] test_siphash: self-tests: pass
[   10.513760 ] INFO: trying to register non-static key.
[   10.514744 ] the code is fine but needs lockdep annotation.
[   10.515826 ] turning off the locking correctness validator.
[   10.516906 ] CPU: 0 PID: 1 Comm: swapper Not tainted
4.18.0-00024-g0a38563 #1
[   10.517071 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.517071 ] Call Trace:
[   10.517071 ]  register_lock_class+0x20b/0x517
[   10.517071 ]  ? look_up_lock_class+0x11e/0x11e
[   10.517071 ]  ? lock_release+0x2fa/0x334
[   10.517071 ]  ? hlock_class+0x6d/0x8b
[   10.517071 ]  ? mark_lock+0x3a/0x26d
[   10.517071 ]  __lock_acquire+0x1c3/0x1475
[   10.517071 ]  ? pvclock_clocksource_read+0xbf/0x14b
[   10.517071 ]  ? ida_alloc_range+0x88/0x118
[   10.517071 ]  ? sched_clock_local+0x8b/0xa7
[   10.517071 ]  ? debug_show_all_locks+0x155/0x155
[   10.517071 ]  ? lock_release+0x2fa/0x334
[   10.517071 ]  ? lock_downgrade+0x282/0x282
[   10.517071 ]  ? mark_held_locks+0x28/0x7f
[   10.517071 ]  ? console_unlock+0x4ed/0x509
[   10.517071 ]  ? console_unlock+0x184/0x509
[   10.517071 ]  ? trace_hardirqs_on_caller+0x235/0x242
[   10.517071 ]  ? console_unlock+0x4f5/0x509
[   10.517071 ]  ? ida_alloc_range+0x88/0x118
[   10.517071 ]  ? lock_acquire+0x95/0xd0
[   10.517071 ]  lock_acquire+0x95/0xd0
[   10.517071 ]  ? ida_alloc_range+0x88/0x118
[   10.517071 ]  _raw_spin_lock_irqsave+0x3e/0x75
[   10.517071 ]  ? ida_alloc_range+0x88/0x118
[   10.517071 ]  ida_alloc_range+0x88/0x118
[   10.517071 ]  ? ida_destroy+0x165/0x165
[   10.517071 ]  ? loglevel+0xb6/0xb6
[   10.517071 ]  ida_check_leaf+0x34/0x104
[   10.517071 ]  ? set_debug_rodata+0xc/0xc
[   10.517071 ]  ida_checks+0xaa/0x124
[   10.517071 ]  ? ida_check_leaf+0x104/0x104
[   10.517071 ]  ? test_hash_init+0x3e2/0x3e2
[   10.517071 ]  ? ida_check_leaf+0x104/0x104
[   10.517071 ]  do_one_initcall+0xc0/0x1bf
[   10.517071 ]  ? start_kernel+0x59c/0x59c
[   10.517071 ]  ? lock_downgrade+0x282/0x282
[   10.517071 ]  kernel_init_freeable+0x189/0x21a
[   10.517071 ]  ? rest_init+0xa5/0xa5
[   10.517071 ]  kernel_init+0x7/0xf4
[   10.517071 ]  ? rest_init+0xa5/0xa5
[   10.517071 ]  ret_from_fork+0x3a/0x50
[   10.554149 ] IDA: 3085 of 3085 tests passed
[   10.572760 ] test_overflow: u8 : 18 tests
[   10.573577 ] test_overflow: s8 : 19 tests
[   10.574364 ] test_overflow: u16: 17 tests
[   10.575149 ] test_overflow: s16: 17 tests
[   10.575930 ] test_overflow: u32: 17 tests
[   10.576733 ] test_overflow: s32: 17 tests
[   10.577510 ] test_overflow: u64: 17 tests
[   10.578288 ] test_overflow: s64: 21 tests
[   10.579635 ] WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:4065
__alloc_pages_slowpath+0x9a/0xa03
[   10.580053 ] CPU: 0 PID: 1 Comm: swapper Not tainted
4.18.0-00024-g0a38563 #1
[   10.580053 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.580053 ] RIP: 0010:__alloc_pages_slowpath+0x9a/0xa03
[   10.580053 ] Code: 18 00 00 00 f2 65 48 8b 04 25 28 00 00 00 48 89 84
24 60 01 00 00 31 c0 83 fe 0a 76 14 45 31 e4 0f ba e7 09 0f 82 21 09 00
00 <0f> 0b e9 1a 09 00 00 89 f8 41 89 f7 48 89 d3 25 00 00 28 00 89 fd 
[   10.580053 ] RSP: 0000:ffff8800001773d0 EFLAGS: 00010246
[   10.580053 ] RAX: 0000000000000000 RBX: 00000000006040c0 RCX:
ffffffff811797c9
[   10.580053 ] RDX: ffff880000177590 RSI: 0000000000000034 RDI:
00000000006040c0
[   10.580053 ] RBP: 0000000000000000 R08: dffffc0000000000 R09:
fffffffffff13458
[   10.580053 ] R10: 0000000000000000 R11: ffffffff83ac57cf R12:
0000000000000000
[   10.580053 ] R13: 00000000006040c0 R14: 0000000000000000 R15:
ffff880000177590
[   10.580053 ] FS:  0000000000000000(0000) GS:ffffffff830d0000(0000)
knlGS:0000000000000000
[   10.580053 ] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.580053 ] CR2: 0000000000000000 CR3: 000000000307e001 CR4:
00000000000606f0
[   10.580053 ] Call Trace:
[   10.580053 ]  ? __kasan_slab_free+0x10e/0x130
[   10.580053 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.580053 ]  ? __zone_watermark_ok+0x82/0x12f
[   10.580053 ]  ? get_page_from_freelist+0xb68/0xbed
[   10.580053 ]  ? kernel_init+0x7/0xf4
[   10.580053 ]  ? gfp_pfmemalloc_allowed+0xb/0xb
[   10.580053 ]  ? _raw_spin_unlock+0x1f/0x27
[   10.580053 ]  ? __zone_watermark_ok+0x12f/0x12f
[   10.580053 ]  ? warn_alloc+0x20a/0x20a
[   10.580053 ]  ? lock_acquire+0xa1/0xd0
[   10.580053 ]  ? debug_lockdep_rcu_enabled+0x26/0x51
[   10.580053 ]  __alloc_pages_nodemask+0x13c/0x1b1
[   10.580053 ]  ? __free_pages+0x37/0x37
[   10.580053 ]  ? __kasan_slab_free+0x124/0x130
[   10.580053 ]  kmalloc_order+0x1e/0x86
[   10.580053 ]  __kmalloc+0x3b/0x131
[   10.580053 ]  ? kfree+0x99/0x11f
[   10.580053 ]  test_module_init+0x1c89/0x27f6
[   10.580053 ]  ? list_sort_test+0x32d/0x32d
[   10.580053 ]  ? __save_stack_trace+0xb9/0xdc
[   10.580053 ]  ? __lock_acquire+0xf5/0x1475
[   10.580053 ]  ? on_stack+0x33/0x68
[   10.580053 ]  ? depot_save_stack+0x1c7/0x37f
[   10.580053 ]  ? deref_stack_reg+0x83/0xbb
[   10.580053 ]  ? __lock_acquire+0xf5/0x1475
[   10.580053 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.580053 ]  ? get_page_from_freelist+0x5c1/0xbed
[   10.580053 ]  ? debug_show_all_locks+0x155/0x155
[   10.580053 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   10.580053 ]  ? debug_show_all_locks+0x155/0x155
[   10.580053 ]  ? __lock_acquire+0xf5/0x1475
[   10.580053 ]  ? on_stack+0x33/0x68
[   10.580053 ]  ? depot_save_stack+0x1c7/0x37f
[   10.580053 ]  ? deref_stack_reg+0x83/0xbb
[   10.580053 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.580053 ]  ? debug_show_all_locks+0x155/0x155
[   10.580053 ]  ? __save_stack_trace+0x6f/0xdc
[   10.580053 ]  ? on_stack+0x33/0x68
[   10.580053 ]  ? stack_access_ok+0xd/0x39
[   10.580053 ]  ? deref_stack_reg+0x83/0xbb
[   10.580053 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.580053 ]  ? __orc_find+0x53/0x91
[   10.580053 ]  ? ret_from_fork+0x39/0x50
[   10.580053 ]  ? unwind_next_frame+0x7cc/0x80f
[   10.580053 ]  ? lock_release+0x2fa/0x334
[   10.580053 ]  ? lock_downgrade+0x282/0x282
[   10.580053 ]  ? depot_save_stack+0x1c7/0x37f
[   10.580053 ]  ? lock_acquire+0xa1/0xd0
[   10.580053 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.580053 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.580053 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.580053 ]  ? depot_save_stack+0x33b/0x37f
[   10.580053 ]  ? save_stack+0x9a/0xa3
[   10.580053 ]  ? __kasan_slab_free+0x10e/0x130
[   10.580053 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.580053 ]  ? kfree+0x99/0x11f
[   10.580053 ]  ? list_sort_test+0x2f4/0x32d
[   10.580053 ]  ? do_one_initcall+0xc0/0x1bf
[   10.580053 ]  ? kernel_init_freeable+0x189/0x21a
[   10.580053 ]  ? kernel_init+0x7/0xf4
[   10.580053 ]  ? ret_from_fork+0x3a/0x50
[   10.580053 ]  ? save_stack+0x9a/0xa3
[   10.580053 ]  ? check+0xcb/0xfc
[   10.580053 ]  ? cmp+0x2a/0x32
[   10.580053 ]  ? merge+0xcf/0x10e
[   10.580053 ]  ? lcm_not_zero+0x1f/0x1f
[   10.580053 ]  ? lock_release+0x2fa/0x334
[   10.580053 ]  ? lock_downgrade+0x282/0x282
[   10.580053 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   10.580053 ]  ? lock_acquire+0xa1/0xd0
[   10.580053 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.580053 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.580053 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.580053 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.580053 ]  ? quarantine_put+0x13d/0x15b
[   10.580053 ]  ? loglevel+0xb6/0xb6
[   10.580053 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.580053 ]  ? list_sort_test+0x2f4/0x32d
[   10.580053 ]  ? kfree+0x99/0x11f
[   10.580053 ]  ? list_sort_test+0x2f4/0x32d
[   10.580053 ]  ? cmp+0x32/0x32
[   10.580053 ]  ? list_sort_test+0x32d/0x32d
[   10.580053 ]  ? set_debug_rodata+0xc/0xc
[   10.580053 ]  do_one_initcall+0xc0/0x1bf
[   10.580053 ]  ? start_kernel+0x59c/0x59c
[   10.580053 ]  ? lock_downgrade+0x282/0x282
[   10.580053 ]  kernel_init_freeable+0x189/0x21a
[   10.580053 ]  ? rest_init+0xa5/0xa5
[   10.580053 ]  kernel_init+0x7/0xf4
[   10.580053 ]  ? rest_init+0xa5/0xa5
[   10.580053 ]  ret_from_fork+0x3a/0x50
[   10.580053 ] irq event stamp: 498258
[   10.580053 ] hardirqs last  enabled at (498257): [<ffffffff8111e019>]
console_unlock+0x4ed/0x509
[   10.580053 ] hardirqs last disabled at (498258): [<ffffffff8219e8d1>]
_raw_spin_lock_irqsave+0x19/0x75
[   10.580053 ] softirqs last  enabled at (498254): [<ffffffff8240025f>]
__do_softirq+0x25f/0x2ac
[   10.580053 ] softirqs last disabled at (498247): [<ffffffff810d68f3>]
irq_exit+0x5e/0x9a
[   10.580053 ] ---[ end trace 3ba60ce16ffd7542  ]---
[   10.685004 ] test_overflow: kmalloc detected saturation
[   10.686141 ] test_overflow: kmalloc_node detected saturation
[   10.687361 ] test_overflow: kzalloc detected saturation
[   10.688485 ] test_overflow: kzalloc_node detected saturation
[   10.689698 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
[   10.691807 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   10.693461 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.695093 ] Call Trace:
[   10.695603 ]  warn_alloc+0x13c/0x20a
[   10.696318 ]  ? zone_watermark_ok_safe+0x72/0x72
[   10.697232 ]  ? memcg_kmem_enabled+0x1d/0x29
[   10.698066 ]  ? __alloc_pages_nodemask+0x144/0x1b1
[   10.698990 ]  __vmalloc_node_range+0x2dc/0x2f0
[   10.699849 ]  __vmalloc_node+0x25/0x2a
[   10.700604 ]  ? test_module_init+0x1fe7/0x27f6
[   10.701484 ]  test_module_init+0x1fe7/0x27f6
[   10.702326 ]  ? list_sort_test+0x32d/0x32d
[   10.703134 ]  ? __save_stack_trace+0xb9/0xdc
[   10.703980 ]  ? __lock_acquire+0xf5/0x1475
[   10.704780 ]  ? on_stack+0x33/0x68
[   10.705452 ]  ? depot_save_stack+0x1c7/0x37f
[   10.706286 ]  ? deref_stack_reg+0x83/0xbb
[   10.707091 ]  ? __lock_acquire+0xf5/0x1475
[   10.707895 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.709009 ]  ? get_page_from_freelist+0x5c1/0xbed
[   10.709946 ]  ? debug_show_all_locks+0x155/0x155
[   10.710859 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   10.711774 ]  ? debug_show_all_locks+0x155/0x155
[   10.712670 ]  ? __lock_acquire+0xf5/0x1475
[   10.713489 ]  ? on_stack+0x33/0x68
[   10.714166 ]  ? depot_save_stack+0x1c7/0x37f
[   10.715005 ]  ? deref_stack_reg+0x83/0xbb
[   10.715789 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.716903 ]  ? debug_show_all_locks+0x155/0x155
[   10.717804 ]  ? __save_stack_trace+0x6f/0xdc
[   10.718636 ]  ? on_stack+0x33/0x68
[   10.719308 ]  ? on_stack+0x33/0x68
[   10.719975 ]  ? stack_access_ok+0xd/0x39
[   10.720758 ]  ? deref_stack_reg+0x83/0xbb
[   10.721556 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.722669 ]  ? __orc_find+0x53/0x91
[   10.723391 ]  ? ret_from_fork+0x39/0x50
[   10.724139 ]  ? ret_from_fork+0x39/0x50
[   10.724878 ]  ? unwind_next_frame+0x7cc/0x80f
[   10.725722 ]  ? lock_release+0x2fa/0x334
[   10.726507 ]  ? lock_downgrade+0x282/0x282
[   10.727329 ]  ? depot_save_stack+0x1c7/0x37f
[   10.728170 ]  ? lock_acquire+0xa1/0xd0
[   10.728905 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.729746 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.730707 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.731690 ]  ? depot_save_stack+0x33b/0x37f
[   10.732520 ]  ? save_stack+0x9a/0xa3
[   10.733221 ]  ? __kasan_slab_free+0x10e/0x130
[   10.734093 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.735015 ]  ? kfree+0x99/0x11f
[   10.735655 ]  ? list_sort_test+0x2f4/0x32d
[   10.736466 ]  ? do_one_initcall+0xc0/0x1bf
[   10.737283 ]  ? kernel_init_freeable+0x189/0x21a
[   10.738181 ]  ? kernel_init+0x7/0xf4
[   10.738874 ]  ? ret_from_fork+0x3a/0x50
[   10.739623 ]  ? save_stack+0x9a/0xa3
[   10.740345 ]  ? check+0xcb/0xfc
[   10.740961 ]  ? cmp+0x2a/0x32
[   10.741549 ]  ? merge+0xcf/0x10e
[   10.742188 ]  ? lcm_not_zero+0x1f/0x1f
[   10.742924 ]  ? lock_release+0x2fa/0x334
[   10.743708 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   10.744688 ]  ? lock_acquire+0xa1/0xd0
[   10.745421 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.746252 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.747221 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.748180 ]  ? quarantine_put+0x13d/0x15b
[   10.748987 ]  ? loglevel+0xb6/0xb6
[   10.749652 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.750583 ]  ? list_sort_test+0x2f4/0x32d
[   10.751385 ]  ? kfree+0x99/0x11f
[   10.752030 ]  ? list_sort_test+0x2f4/0x32d
[   10.752827 ]  ? cmp+0x32/0x32
[   10.753436 ]  ? list_sort_test+0x32d/0x32d
[   10.754248 ]  ? set_debug_rodata+0xc/0xc
[   10.755028 ]  do_one_initcall+0xc0/0x1bf
[   10.755801 ]  ? start_kernel+0x59c/0x59c
[   10.756570 ]  ? lock_downgrade+0x282/0x282
[   10.757382 ]  kernel_init_freeable+0x189/0x21a
[   10.758223 ]  ? rest_init+0xa5/0xa5
[   10.758878 ]  kernel_init+0x7/0xf4
[   10.759528 ]  ? rest_init+0xa5/0xa5
[   10.760214 ]  ret_from_fork+0x3a/0x50
[   10.760909 ] Mem-Info:
[   10.761374 ] active_anon:0 inactive_anon:0 isolated_anon:0
[   10.761374 ]  active_file:0 inactive_file:0 isolated_file:0
[   10.761374 ]  unevictable:5115 dirty:0 writeback:0 unstable:0
[   10.761374 ]  slab_reclaimable:566 slab_unreclaimable:5261
[   10.761374 ]  mapped:0 shmem:0 pagetables:0 bounce:0
[   10.761374 ]  free:78915 free_pcp:197 free_cma:0
[   10.767161 ] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:20460kB isolated(anon):0kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
unstable:0kB all_unreclaimable? no
[   10.771933 ] DMA32 free:315660kB min:2404kB low:3004kB high:3604kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:20460kB writepending:0kB present:523712kB managed:365140kB
mlocked:0kB kernel_stack:1408kB pagetables:0kB bounce:0kB free_pcp:788kB
local_pcp:788kB free_cma:0kB
[   10.776934 ] lowmem_reserve[]: 0 0 0
[   10.777624 ] DMA32: 5*4kB (M) 7*8kB (UME) 4*16kB (UM) 4*32kB (ME)
4*64kB (UM) 4*128kB (M) 1*256kB (E) 4*512kB (UME) 5*1024kB (UME)
4*2048kB (UM) 73*4096kB (M) = 315660kB
[   10.780497 ] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[   10.782078 ] 5129 total pagecache pages
[   10.782790 ] 130928 pages RAM
[   10.783423 ] 0 pages HighMem/MovableOnly
[   10.784164 ] 39643 pages reserved
[   10.784778 ] 0 pages hwpoisoned
[   10.785387 ] test_overflow: kvmalloc detected saturation
[   10.786479 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
[   10.788529 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   10.790142 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.791703 ] Call Trace:
[   10.792194 ]  warn_alloc+0x13c/0x20a
[   10.792866 ]  ? zone_watermark_ok_safe+0x72/0x72
[   10.793754 ]  ? memcg_kmem_enabled+0x1d/0x29
[   10.794563 ]  ? __alloc_pages_nodemask+0x144/0x1b1
[   10.795456 ]  __vmalloc_node_range+0x2dc/0x2f0
[   10.796288 ]  __vmalloc_node+0x25/0x2a
[   10.797016 ]  ? test_module_init+0x20c3/0x27f6
[   10.797851 ]  test_module_init+0x20c3/0x27f6
[   10.798656 ]  ? list_sort_test+0x32d/0x32d
[   10.799426 ]  ? __save_stack_trace+0xb9/0xdc
[   10.800250 ]  ? __lock_acquire+0xf5/0x1475
[   10.801031 ]  ? on_stack+0x33/0x68
[   10.801670 ]  ? depot_save_stack+0x1c7/0x37f
[   10.802474 ]  ? deref_stack_reg+0x83/0xbb
[   10.803229 ]  ? __lock_acquire+0xf5/0x1475
[   10.804021 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.805086 ]  ? get_page_from_freelist+0x5c1/0xbed
[   10.805983 ]  ? debug_show_all_locks+0x155/0x155
[   10.806860 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   10.807752 ]  ? debug_show_all_locks+0x155/0x155
[   10.808621 ]  ? __lock_acquire+0xf5/0x1475
[   10.809394 ]  ? on_stack+0x33/0x68
[   10.810062 ]  ? depot_save_stack+0x1c7/0x37f
[   10.810862 ]  ? deref_stack_reg+0x83/0xbb
[   10.811621 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.812683 ]  ? debug_show_all_locks+0x155/0x155
[   10.813568 ]  ? __save_stack_trace+0x6f/0xdc
[   10.814377 ]  ? on_stack+0x33/0x68
[   10.815022 ]  ? on_stack+0x33/0x68
[   10.815662 ]  ? stack_access_ok+0xd/0x39
[   10.816404 ]  ? deref_stack_reg+0x83/0xbb
[   10.817178 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.818237 ]  ? __orc_find+0x53/0x91
[   10.818909 ]  ? ret_from_fork+0x39/0x50
[   10.819633 ]  ? ret_from_fork+0x39/0x50
[   10.820377 ]  ? unwind_next_frame+0x7cc/0x80f
[   10.821202 ]  ? lock_release+0x2fa/0x334
[   10.821935 ]  ? lock_downgrade+0x282/0x282
[   10.822704 ]  ? depot_save_stack+0x1c7/0x37f
[   10.823525 ]  ? lock_acquire+0xa1/0xd0
[   10.824240 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.825040 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.825944 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.826903 ]  ? depot_save_stack+0x33b/0x37f
[   10.827714 ]  ? save_stack+0x9a/0xa3
[   10.828394 ]  ? __kasan_slab_free+0x10e/0x130
[   10.829216 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.830115 ]  ? kfree+0x99/0x11f
[   10.830728 ]  ? list_sort_test+0x2f4/0x32d
[   10.831504 ]  ? do_one_initcall+0xc0/0x1bf
[   10.832278 ]  ? kernel_init+0x7/0xf4
[   10.832948 ]  ? ret_from_fork+0x3a/0x50
[   10.833688 ]  ? save_stack+0x9a/0xa3
[   10.834372 ]  ? check+0xcb/0xfc
[   10.834962 ]  ? cmp+0x2a/0x32
[   10.835531 ]  ? merge+0xcf/0x10e
[   10.836163 ]  ? lcm_not_zero+0x1f/0x1f
[   10.836883 ]  ? lock_release+0x2fa/0x334
[   10.837633 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   10.838583 ]  ? lock_acquire+0xa1/0xd0
[   10.839294 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.840128 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.841048 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.841958 ]  ? quarantine_put+0x13d/0x15b
[   10.842728 ]  ? loglevel+0xb6/0xb6
[   10.843389 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.844293 ]  ? list_sort_test+0x2f4/0x32d
[   10.845075 ]  ? kfree+0x99/0x11f
[   10.845688 ]  ? list_sort_test+0x2f4/0x32d
[   10.846463 ]  ? cmp+0x32/0x32
[   10.847051 ]  ? list_sort_test+0x32d/0x32d
[   10.847823 ]  ? set_debug_rodata+0xc/0xc
[   10.848564 ]  do_one_initcall+0xc0/0x1bf
[   10.849304 ]  ? start_kernel+0x59c/0x59c
[   10.850074 ]  ? lock_downgrade+0x282/0x282
[   10.850848 ]  kernel_init_freeable+0x189/0x21a
[   10.851688 ]  ? rest_init+0xa5/0xa5
[   10.852353 ]  kernel_init+0x7/0xf4
[   10.852996 ]  ? rest_init+0xa5/0xa5
[   10.853666 ]  ret_from_fork+0x3a/0x50
[   10.854365 ] test_overflow: kvmalloc_node detected saturation
[   10.855544 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null)
[   10.857771 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   10.859357 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.860930 ] Call Trace:
[   10.861423 ]  warn_alloc+0x13c/0x20a
[   10.862101 ]  ? zone_watermark_ok_safe+0x72/0x72
[   10.862967 ]  ? memcg_kmem_enabled+0x1d/0x29
[   10.863792 ]  ? __alloc_pages_nodemask+0x144/0x1b1
[   10.864694 ]  __vmalloc_node_range+0x2dc/0x2f0
[   10.865533 ]  __vmalloc_node+0x25/0x2a
[   10.866246 ]  ? test_module_init+0x219f/0x27f6
[   10.867102 ]  test_module_init+0x219f/0x27f6
[   10.867901 ]  ? list_sort_test+0x32d/0x32d
[   10.868677 ]  ? __save_stack_trace+0xb9/0xdc
[   10.869482 ]  ? __lock_acquire+0xf5/0x1475
[   10.870272 ]  ? on_stack+0x33/0x68
[   10.870918 ]  ? depot_save_stack+0x1c7/0x37f
[   10.871720 ]  ? deref_stack_reg+0x83/0xbb
[   10.872480 ]  ? __lock_acquire+0xf5/0x1475
[   10.873248 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.874323 ]  ? get_page_from_freelist+0x5c1/0xbed
[   10.875225 ]  ? debug_show_all_locks+0x155/0x155
[   10.876092 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   10.876991 ]  ? debug_show_all_locks+0x155/0x155
[   10.877856 ]  ? __lock_acquire+0xf5/0x1475
[   10.878630 ]  ? on_stack+0x33/0x68
[   10.879277 ]  ? depot_save_stack+0x1c7/0x37f
[   10.880105 ]  ? deref_stack_reg+0x83/0xbb
[   10.880863 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.881923 ]  ? debug_show_all_locks+0x155/0x155
[   10.882796 ]  ? __save_stack_trace+0x6f/0xdc
[   10.883617 ]  ? on_stack+0x33/0x68
[   10.884269 ]  ? on_stack+0x33/0x68
[   10.884907 ]  ? stack_access_ok+0xd/0x39
[   10.885644 ]  ? deref_stack_reg+0x83/0xbb
[   10.886400 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.887481 ]  ? __orc_find+0x53/0x91
[   10.888163 ]  ? ret_from_fork+0x39/0x50
[   10.888883 ]  ? ret_from_fork+0x39/0x50
[   10.889614 ]  ? unwind_next_frame+0x7cc/0x80f
[   10.890452 ]  ? lock_release+0x2fa/0x334
[   10.891196 ]  ? lock_downgrade+0x282/0x282
[   10.891961 ]  ? depot_save_stack+0x1c7/0x37f
[   10.892763 ]  ? lock_acquire+0xa1/0xd0
[   10.893491 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.894302 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.895249 ]  ? depot_save_stack+0x33b/0x37f
[   10.896052 ]  ? save_stack+0x9a/0xa3
[   10.896737 ]  ? __kasan_slab_free+0x10e/0x130
[   10.897562 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.898446 ]  ? kfree+0x99/0x11f
[   10.899062 ]  ? list_sort_test+0x2f4/0x32d
[   10.899826 ]  ? do_one_initcall+0xc0/0x1bf
[   10.900623 ]  ? kernel_init+0x7/0xf4
[   10.901300 ]  ? ret_from_fork+0x3a/0x50
[   10.902024 ]  ? save_stack+0x9a/0xa3
[   10.902692 ]  ? check+0xcb/0xfc
[   10.903288 ]  ? cmp+0x2a/0x32
[   10.903865 ]  ? merge+0xcf/0x10e
[   10.904481 ]  ? lcm_not_zero+0x1f/0x1f
[   10.905190 ]  ? lock_release+0x2fa/0x334
[   10.905926 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   10.906906 ]  ? lock_acquire+0xa1/0xd0
[   10.907625 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.908432 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.909347 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.910296 ]  ? quarantine_put+0x13d/0x15b
[   10.911074 ]  ? loglevel+0xb6/0xb6
[   10.911711 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.912591 ]  ? list_sort_test+0x2f4/0x32d
[   10.913380 ]  ? kfree+0x99/0x11f
[   10.914005 ]  ? list_sort_test+0x2f4/0x32d
[   10.914775 ]  ? cmp+0x32/0x32
[   10.915344 ]  ? list_sort_test+0x32d/0x32d
[   10.916113 ]  ? set_debug_rodata+0xc/0xc
[   10.916863 ]  do_one_initcall+0xc0/0x1bf
[   10.917610 ]  ? start_kernel+0x59c/0x59c
[   10.918349 ]  ? lock_downgrade+0x282/0x282
[   10.919120 ]  kernel_init_freeable+0x189/0x21a
[   10.919948 ]  ? rest_init+0xa5/0xa5
[   10.920628 ]  kernel_init+0x7/0xf4
[   10.921275 ]  ? rest_init+0xa5/0xa5
[   10.921928 ]  ret_from_fork+0x3a/0x50
[   10.922617 ] test_overflow: kvzalloc detected saturation
[   10.923740 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null)
[   10.925951 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   10.927546 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   10.929116 ] Call Trace:
[   10.929598 ]  warn_alloc+0x13c/0x20a
[   10.930293 ]  ? zone_watermark_ok_safe+0x72/0x72
[   10.931163 ]  ? memcg_kmem_enabled+0x1d/0x29
[   10.931958 ]  ? __alloc_pages_nodemask+0x144/0x1b1
[   10.932854 ]  __vmalloc_node_range+0x2dc/0x2f0
[   10.933701 ]  __vmalloc_node+0x25/0x2a
[   10.934411 ]  ? test_module_init+0x227b/0x27f6
[   10.935246 ]  test_module_init+0x227b/0x27f6
[   10.936051 ]  ? list_sort_test+0x32d/0x32d
[   10.936834 ]  ? __save_stack_trace+0xb9/0xdc
[   10.937642 ]  ? __lock_acquire+0xf5/0x1475
[   10.938412 ]  ? on_stack+0x33/0x68
[   10.939058 ]  ? depot_save_stack+0x1c7/0x37f
[   10.939851 ]  ? deref_stack_reg+0x83/0xbb
[   10.940625 ]  ? __lock_acquire+0xf5/0x1475
[   10.941402 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.942457 ]  ? get_page_from_freelist+0x5c1/0xbed
[   10.943372 ]  ? debug_show_all_locks+0x155/0x155
[   10.944245 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   10.945094 ]  ? debug_show_all_locks+0x155/0x155
[   10.945986 ]  ? __lock_acquire+0xf5/0x1475
[   10.946774 ]  ? on_stack+0x33/0x68
[   10.947424 ]  ? depot_save_stack+0x1c7/0x37f
[   10.948224 ]  ? deref_stack_reg+0x83/0xbb
[   10.948977 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.950051 ]  ? debug_show_all_locks+0x155/0x155
[   10.950919 ]  ? __save_stack_trace+0x6f/0xdc
[   10.951719 ]  ? on_stack+0x33/0x68
[   10.952364 ]  ? on_stack+0x33/0x68
[   10.953005 ]  ? stack_access_ok+0xd/0x39
[   10.953755 ]  ? deref_stack_reg+0x83/0xbb
[   10.954513 ]  ? __read_once_size_nocheck+0x7/0x7
[   10.955567 ]  ? __orc_find+0x53/0x91
[   10.956244 ]  ? ret_from_fork+0x39/0x50
[   10.956987 ]  ? ret_from_fork+0x39/0x50
[   10.957710 ]  ? unwind_next_frame+0x7cc/0x80f
[   10.958535 ]  ? lock_release+0x2fa/0x334
[   10.959273 ]  ? lock_downgrade+0x282/0x282
[   10.960061 ]  ? depot_save_stack+0x1c7/0x37f
[   10.960862 ]  ? lock_acquire+0xa1/0xd0
[   10.961573 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.962377 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   10.963324 ]  ? depot_save_stack+0x33b/0x37f
[   10.964147 ]  ? save_stack+0x9a/0xa3
[   10.964817 ]  ? __kasan_slab_free+0x10e/0x130
[   10.965636 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.966520 ]  ? kfree+0x99/0x11f
[   10.967157 ]  ? list_sort_test+0x2f4/0x32d
[   10.967926 ]  ? do_one_initcall+0xc0/0x1bf
[   10.968701 ]  ? kernel_init+0x7/0xf4
[   10.969378 ]  ? ret_from_fork+0x3a/0x50
[   10.970120 ]  ? save_stack+0x9a/0xa3
[   10.970792 ]  ? check+0xcb/0xfc
[   10.971390 ]  ? cmp+0x2a/0x32
[   10.971949 ]  ? merge+0xcf/0x10e
[   10.972559 ]  ? lcm_not_zero+0x1f/0x1f
[   10.973269 ]  ? lock_release+0x2fa/0x334
[   10.974031 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   10.974979 ]  ? lock_acquire+0xa1/0xd0
[   10.975687 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   10.976493 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.977430 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   10.978346 ]  ? quarantine_put+0x13d/0x15b
[   10.979118 ]  ? loglevel+0xb6/0xb6
[   10.979754 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   10.980663 ]  ? list_sort_test+0x2f4/0x32d
[   10.981438 ]  ? kfree+0x99/0x11f
[   10.982052 ]  ? list_sort_test+0x2f4/0x32d
[   10.982813 ]  ? cmp+0x32/0x32
[   10.983398 ]  ? list_sort_test+0x32d/0x32d
[   10.984175 ]  ? set_debug_rodata+0xc/0xc
[   10.984905 ]  do_one_initcall+0xc0/0x1bf
[   10.985648 ]  ? start_kernel+0x59c/0x59c
[   10.986383 ]  ? lock_downgrade+0x282/0x282
[   10.987170 ]  kernel_init_freeable+0x189/0x21a
[   10.988005 ]  ? rest_init+0xa5/0xa5
[   10.988660 ]  kernel_init+0x7/0xf4
[   10.989305 ]  ? rest_init+0xa5/0xa5
[   10.989958 ]  ret_from_fork+0x3a/0x50
[   10.990669 ] test_overflow: kvzalloc_node detected saturation
[   11.407404 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
[   11.412376 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   11.413814 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   11.415223 ] Call Trace:
[   11.415667 ]  warn_alloc+0x13c/0x20a
[   11.416286 ]  ? zone_watermark_ok_safe+0x72/0x72
[   11.417078 ]  ? lock_acquire+0xa1/0xd0
[   11.417719 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.418461 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.419327 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.420169 ]  __vmalloc_node_range+0x2dc/0x2f0
[   11.420926 ]  ? test_module_init+0x231e/0x27f6
[   11.421665 ]  __vmalloc_node+0x25/0x2a
[   11.422295 ]  ? test_module_init+0x233f/0x27f6
[   11.423053 ]  test_module_init+0x233f/0x27f6
[   11.423789 ]  ? list_sort_test+0x32d/0x32d
[   11.424498 ]  ? __save_stack_trace+0xb9/0xdc
[   11.425217 ]  ? __lock_acquire+0xf5/0x1475
[   11.425900 ]  ? on_stack+0x33/0x68
[   11.426465 ]  ? depot_save_stack+0x1c7/0x37f
[   11.427210 ]  ? deref_stack_reg+0x83/0xbb
[   11.427885 ]  ? __lock_acquire+0xf5/0x1475
[   11.428587 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.429532 ]  ? get_page_from_freelist+0x5c1/0xbed
[   11.430356 ]  ? debug_show_all_locks+0x155/0x155
[   11.431137 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   11.431920 ]  ? debug_show_all_locks+0x155/0x155
[   11.432694 ]  ? __lock_acquire+0xf5/0x1475
[   11.433409 ]  ? on_stack+0x33/0x68
[   11.434003 ]  ? depot_save_stack+0x1c7/0x37f
[   11.434733 ]  ? deref_stack_reg+0x83/0xbb
[   11.435407 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.436366 ]  ? debug_show_all_locks+0x155/0x155
[   11.437175 ]  ? __save_stack_trace+0x6f/0xdc
[   11.437894 ]  ? on_stack+0x33/0x68
[   11.438485 ]  ? on_stack+0x33/0x68
[   11.439065 ]  ? stack_access_ok+0xd/0x39
[   11.439718 ]  ? deref_stack_reg+0x83/0xbb
[   11.440409 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.441368 ]  ? __orc_find+0x53/0x91
[   11.441994 ]  ? ret_from_fork+0x39/0x50
[   11.442658 ]  ? ret_from_fork+0x39/0x50
[   11.443318 ]  ? unwind_next_frame+0x7cc/0x80f
[   11.444077 ]  ? lock_release+0x2fa/0x334
[   11.444727 ]  ? lock_downgrade+0x282/0x282
[   11.445426 ]  ? depot_save_stack+0x1c7/0x37f
[   11.446138 ]  ? lock_acquire+0xa1/0xd0
[   11.446779 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.447505 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.448364 ]  ? depot_save_stack+0x33b/0x37f
[   11.449063 ]  ? save_stack+0x9a/0xa3
[   11.449645 ]  ? __kasan_slab_free+0x10e/0x130
[   11.450370 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.451136 ]  ? kfree+0x99/0x11f
[   11.451664 ]  ? list_sort_test+0x2f4/0x32d
[   11.452335 ]  ? do_one_initcall+0xc0/0x1bf
[   11.453004 ]  ? kernel_init+0x7/0xf4
[   11.453598 ]  ? ret_from_fork+0x3a/0x50
[   11.454229 ]  ? save_stack+0x9a/0xa3
[   11.454810 ]  ? check+0xcb/0xfc
[   11.455328 ]  ? cmp+0x2a/0x32
[   11.455812 ]  ? merge+0xcf/0x10e
[   11.456344 ]  ? lcm_not_zero+0x1f/0x1f
[   11.456965 ]  ? lock_release+0x2fa/0x334
[   11.457610 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   11.458445 ]  ? lock_acquire+0xa1/0xd0
[   11.459061 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.459750 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.460553 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.461349 ]  ? quarantine_put+0x13d/0x15b
[   11.462029 ]  ? loglevel+0xb6/0xb6
[   11.462581 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.463363 ]  ? list_sort_test+0x2f4/0x32d
[   11.464034 ]  ? kfree+0x99/0x11f
[   11.464561 ]  ? list_sort_test+0x2f4/0x32d
[   11.465231 ]  ? cmp+0x32/0x32
[   11.465716 ]  ? list_sort_test+0x32d/0x32d
[   11.466387 ]  ? set_debug_rodata+0xc/0xc
[   11.467046 ]  do_one_initcall+0xc0/0x1bf
[   11.467687 ]  ? start_kernel+0x59c/0x59c
[   11.468331 ]  ? lock_downgrade+0x282/0x282
[   11.469002 ]  kernel_init_freeable+0x189/0x21a
[   11.469721 ]  ? rest_init+0xa5/0xa5
[   11.470309 ]  kernel_init+0x7/0xf4
[   11.470865 ]  ? rest_init+0xa5/0xa5
[   11.471443 ]  ret_from_fork+0x3a/0x50
[   11.472044 ] test_overflow: vmalloc detected saturation
[   11.850257 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6000c0(GFP_KERNEL), nodemask=(null)
[   11.851662 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   11.852850 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   11.853886 ] Call Trace:
[   11.854220 ]  warn_alloc+0x13c/0x20a
[   11.854668 ]  ? zone_watermark_ok_safe+0x72/0x72
[   11.855316 ]  ? lock_acquire+0xa1/0xd0
[   11.855813 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.856367 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.857002 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.857599 ]  __vmalloc_node_range+0x2dc/0x2f0
[   11.858155 ]  ? test_module_init+0x23e8/0x27f6
[   11.858756 ]  __vmalloc_node+0x25/0x2a
[   11.859264 ]  ? test_module_init+0x240c/0x27f6
[   11.859817 ]  test_module_init+0x240c/0x27f6
[   11.860361 ]  ? list_sort_test+0x32d/0x32d
[   11.860863 ]  ? __save_stack_trace+0xb9/0xdc
[   11.861398 ]  ? __lock_acquire+0xf5/0x1475
[   11.862049 ]  ? on_stack+0x33/0x68
[   11.862680 ]  ? depot_save_stack+0x1c7/0x37f
[   11.863273 ]  ? deref_stack_reg+0x83/0xbb
[   11.863786 ]  ? __lock_acquire+0xf5/0x1475
[   11.864304 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.865011 ]  ? get_page_from_freelist+0x5c1/0xbed
[   11.865722 ]  ? debug_show_all_locks+0x155/0x155
[   11.866511 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   11.867323 ]  ? debug_show_all_locks+0x155/0x155
[   11.868113 ]  ? __lock_acquire+0xf5/0x1475
[   11.868812 ]  ? on_stack+0x33/0x68
[   11.869393 ]  ? depot_save_stack+0x1c7/0x37f
[   11.870130 ]  ? deref_stack_reg+0x83/0xbb
[   11.870814 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.871776 ]  ? debug_show_all_locks+0x155/0x155
[   11.872491 ]  ? __save_stack_trace+0x6f/0xdc
[   11.873027 ]  ? on_stack+0x33/0x68
[   11.873457 ]  ? on_stack+0x33/0x68
[   11.873877 ]  ? stack_access_ok+0xd/0x39
[   11.874384 ]  ? deref_stack_reg+0x83/0xbb
[   11.874872 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.875674 ]  ? __orc_find+0x53/0x91
[   11.876138 ]  ? ret_from_fork+0x39/0x50
[   11.876607 ]  ? ret_from_fork+0x39/0x50
[   11.877097 ]  ? unwind_next_frame+0x7cc/0x80f
[   11.877631 ]  ? lock_release+0x2fa/0x334
[   11.878121 ]  ? lock_downgrade+0x282/0x282
[   11.878895 ]  ? depot_save_stack+0x1c7/0x37f
[   11.879686 ]  ? lock_acquire+0xa1/0xd0
[   11.880363 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.881099 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.881945 ]  ? depot_save_stack+0x33b/0x37f
[   11.882668 ]  ? save_stack+0x9a/0xa3
[   11.883269 ]  ? __kasan_slab_free+0x10e/0x130
[   11.884023 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.884806 ]  ? kfree+0x99/0x11f
[   11.885367 ]  ? list_sort_test+0x2f4/0x32d
[   11.886063 ]  ? do_one_initcall+0xc0/0x1bf
[   11.886772 ]  ? kernel_init+0x7/0xf4
[   11.887391 ]  ? ret_from_fork+0x3a/0x50
[   11.888047 ]  ? save_stack+0x9a/0xa3
[   11.888665 ]  ? check+0xcb/0xfc
[   11.889195 ]  ? cmp+0x2a/0x32
[   11.889714 ]  ? merge+0xcf/0x10e
[   11.890303 ]  ? lcm_not_zero+0x1f/0x1f
[   11.890946 ]  ? lock_release+0x2fa/0x334
[   11.891633 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   11.892488 ]  ? lock_acquire+0xa1/0xd0
[   11.893130 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.893844 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.894685 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.895518 ]  ? quarantine_put+0x13d/0x15b
[   11.896223 ]  ? loglevel+0xb6/0xb6
[   11.896817 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.897613 ]  ? list_sort_test+0x2f4/0x32d
[   11.898295 ]  ? kfree+0x99/0x11f
[   11.898839 ]  ? list_sort_test+0x2f4/0x32d
[   11.899541 ]  ? cmp+0x32/0x32
[   11.900070 ]  ? list_sort_test+0x32d/0x32d
[   11.900758 ]  ? set_debug_rodata+0xc/0xc
[   11.901434 ]  do_one_initcall+0xc0/0x1bf
[   11.902097 ]  ? start_kernel+0x59c/0x59c
[   11.902762 ]  ? lock_downgrade+0x282/0x282
[   11.903483 ]  kernel_init_freeable+0x189/0x21a
[   11.904234 ]  ? rest_init+0xa5/0xa5
[   11.904821 ]  kernel_init+0x7/0xf4
[   11.905409 ]  ? rest_init+0xa5/0xa5
[   11.905993 ]  ret_from_fork+0x3a/0x50
[   11.906601 ] warn_alloc_show_mem: 4 callbacks suppressed
[   11.906608 ] Mem-Info:
[   11.907926 ] active_anon:0 inactive_anon:0 isolated_anon:0
[   11.907926 ]  active_file:0 inactive_file:0 isolated_file:0
[   11.907926 ]  unevictable:5115 dirty:0 writeback:0 unstable:0
[   11.907926 ]  slab_reclaimable:566 slab_unreclaimable:9194
[   11.907926 ]  mapped:0 shmem:0 pagetables:0 bounce:0
[   11.907926 ]  free:75001 free_pcp:178 free_cma:0
[   11.913125 ] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:20460kB isolated(anon):0kB
isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
unstable:0kB all_unreclaimable? no
[   11.918589 ] DMA32 free:300004kB min:2404kB low:3004kB high:3604kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:20460kB writepending:0kB present:523712kB managed:365140kB
mlocked:0kB kernel_stack:1408kB pagetables:0kB bounce:0kB free_pcp:712kB
local_pcp:712kB free_cma:0kB
[   11.923151 ] lowmem_reserve[]: 0 0 0
[   11.923699 ] DMA32: 5*4kB (UM) 6*8kB (ME) 2*16kB (M) 4*32kB (ME)
4*64kB (M) 4*128kB (M) 2*256kB (UE) 3*512kB (UME) 4*1024kB (ME) 3*2048kB
(M) 70*4096kB (M) = 300004kB
[   11.925600 ] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[   11.926639 ] 5129 total pagecache pages
[   11.927127 ] 130928 pages RAM
[   11.927507 ] 0 pages HighMem/MovableOnly
[   11.928007 ] 39643 pages reserved
[   11.928434 ] 0 pages hwpoisoned
[   11.928818 ] test_overflow: vmalloc_node detected saturation
[   11.929747 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null)
[   11.931219 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   11.932458 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   11.933887 ] Call Trace:
[   11.934348 ]  warn_alloc+0x13c/0x20a
[   11.934952 ]  ? zone_watermark_ok_safe+0x72/0x72
[   11.935746 ]  ? lock_acquire+0xa1/0xd0
[   11.936379 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.937123 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.937952 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.938773 ]  __vmalloc_node_range+0x2dc/0x2f0
[   11.939526 ]  ? test_module_init+0x24af/0x27f6
[   11.940295 ]  __vmalloc_node+0x25/0x2a
[   11.940937 ]  ? test_module_init+0x24d0/0x27f6
[   11.941678 ]  test_module_init+0x24d0/0x27f6
[   11.942396 ]  ? list_sort_test+0x32d/0x32d
[   11.943093 ]  ? __save_stack_trace+0xb9/0xdc
[   11.943813 ]  ? __lock_acquire+0xf5/0x1475
[   11.944514 ]  ? on_stack+0x33/0x68
[   11.945094 ]  ? depot_save_stack+0x1c7/0x37f
[   11.945817 ]  ? deref_stack_reg+0x83/0xbb
[   11.946518 ]  ? __lock_acquire+0xf5/0x1475
[   11.947224 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.948189 ]  ? get_page_from_freelist+0x5c1/0xbed
[   11.948980 ]  ? debug_show_all_locks+0x155/0x155
[   11.949748 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   11.950570 ]  ? debug_show_all_locks+0x155/0x155
[   11.951352 ]  ? __lock_acquire+0xf5/0x1475
[   11.952054 ]  ? on_stack+0x33/0x68
[   11.952621 ]  ? depot_save_stack+0x1c7/0x37f
[   11.953330 ]  ? deref_stack_reg+0x83/0xbb
[   11.954035 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.954990 ]  ? debug_show_all_locks+0x155/0x155
[   11.955767 ]  ? __save_stack_trace+0x6f/0xdc
[   11.956484 ]  ? on_stack+0x33/0x68
[   11.957075 ]  ? on_stack+0x33/0x68
[   11.957644 ]  ? stack_access_ok+0xd/0x39
[   11.958304 ]  ? deref_stack_reg+0x83/0xbb
[   11.959003 ]  ? __read_once_size_nocheck+0x7/0x7
[   11.959937 ]  ? __orc_find+0x53/0x91
[   11.960568 ]  ? ret_from_fork+0x39/0x50
[   11.961221 ]  ? ret_from_fork+0x39/0x50
[   11.961870 ]  ? unwind_next_frame+0x7cc/0x80f
[   11.962607 ]  ? lock_release+0x2fa/0x334
[   11.963268 ]  ? lock_downgrade+0x282/0x282
[   11.963962 ]  ? depot_save_stack+0x1c7/0x37f
[   11.964689 ]  ? lock_acquire+0xa1/0xd0
[   11.965336 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.966064 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   11.966921 ]  ? depot_save_stack+0x33b/0x37f
[   11.967637 ]  ? save_stack+0x9a/0xa3
[   11.968243 ]  ? __kasan_slab_free+0x10e/0x130
[   11.968966 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.969748 ]  ? kfree+0x99/0x11f
[   11.970323 ]  ? list_sort_test+0x2f4/0x32d
[   11.971019 ]  ? do_one_initcall+0xc0/0x1bf
[   11.971720 ]  ? kernel_init+0x7/0xf4
[   11.972325 ]  ? ret_from_fork+0x3a/0x50
[   11.972968 ]  ? save_stack+0x9a/0xa3
[   11.973588 ]  ? check+0xcb/0xfc
[   11.974133 ]  ? cmp+0x2a/0x32
[   11.974674 ]  ? merge+0xcf/0x10e
[   11.975248 ]  ? lcm_not_zero+0x1f/0x1f
[   11.975979 ]  ? lock_release+0x2fa/0x334
[   11.976753 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   11.977656 ]  ? lock_acquire+0xa1/0xd0
[   11.978253 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   11.978923 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.979697 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   11.980426 ]  ? quarantine_put+0x13d/0x15b
[   11.980928 ]  ? loglevel+0xb6/0xb6
[   11.981356 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   11.981928 ]  ? list_sort_test+0x2f4/0x32d
[   11.982659 ]  ? kfree+0x99/0x11f
[   11.983229 ]  ? list_sort_test+0x2f4/0x32d
[   11.983951 ]  ? cmp+0x32/0x32
[   11.984511 ]  ? list_sort_test+0x32d/0x32d
[   11.985259 ]  ? set_debug_rodata+0xc/0xc
[   11.985962 ]  do_one_initcall+0xc0/0x1bf
[   11.986661 ]  ? start_kernel+0x59c/0x59c
[   11.987386 ]  ? lock_downgrade+0x282/0x282
[   11.988158 ]  kernel_init_freeable+0x189/0x21a
[   11.988985 ]  ? rest_init+0xa5/0xa5
[   11.989617 ]  kernel_init+0x7/0xf4
[   11.990272 ]  ? rest_init+0xa5/0xa5
[   11.990917 ]  ret_from_fork+0x3a/0x50
[   11.991589 ] test_overflow: vzalloc detected saturation
[   11.992759 ] swapper: vmalloc: allocation failure:
18446744073709551615 bytes, mode:0x6080c0(GFP_KERNEL|__GFP_ZERO),
nodemask=(null)
[   11.994923 ] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.18.0-00024-g0a38563 #1
[   11.996478 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   11.998044 ] Call Trace:
[   11.998508 ]  warn_alloc+0x13c/0x20a
[   11.999176 ]  ? zone_watermark_ok_safe+0x72/0x72
[   12.000021 ]  ? lock_acquire+0xa1/0xd0
[   12.000693 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   12.001472 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   12.002364 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   12.003188 ]  __vmalloc_node_range+0x2dc/0x2f0
[   12.003948 ]  ? test_module_init+0x2579/0x27f6
[   12.004704 ]  __vmalloc_node+0x25/0x2a
[   12.005347 ]  ? test_module_init+0x259d/0x27f6
[   12.006100 ]  test_module_init+0x259d/0x27f6
[   12.006835 ]  ? list_sort_test+0x32d/0x32d
[   12.007531 ]  ? __save_stack_trace+0xb9/0xdc
[   12.008250 ]  ? __lock_acquire+0xf5/0x1475
[   12.008947 ]  ? on_stack+0x33/0x68
[   12.009526 ]  ? depot_save_stack+0x1c7/0x37f
[   12.010265 ]  ? deref_stack_reg+0x83/0xbb
[   12.010938 ]  ? __lock_acquire+0xf5/0x1475
[   12.011632 ]  ? __read_once_size_nocheck+0x7/0x7
[   12.012504 ]  ? get_page_from_freelist+0x5c1/0xbed
[   12.013144 ]  ? debug_show_all_locks+0x155/0x155
[   12.013929 ]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   12.014728 ]  ? debug_show_all_locks+0x155/0x155
[   12.015529 ]  ? __lock_acquire+0xf5/0x1475
[   12.016219 ]  ? depot_save_stack+0x1c7/0x37f
[   12.016931 ]  ? deref_stack_reg+0x83/0xbb
[   12.017627 ]  ? __read_once_size_nocheck+0x7/0x7
[   12.018582 ]  ? debug_show_all_locks+0x155/0x155
[   12.019375 ]  ? __save_stack_trace+0x6f/0xdc
[   12.020109 ]  ? on_stack+0x33/0x68
[   12.020677 ]  ? on_stack+0x33/0x68
[   12.021255 ]  ? stack_access_ok+0xd/0x39
[   12.021910 ]  ? deref_stack_reg+0x83/0xbb
[   12.022605 ]  ? __read_once_size_nocheck+0x7/0x7
[   12.023589 ]  ? __orc_find+0x53/0x91
[   12.024192 ]  ? ret_from_fork+0x39/0x50
[   12.024841 ]  ? ret_from_fork+0x39/0x50
[   12.025496 ]  ? unwind_next_frame+0x7cc/0x80f
[   12.026229 ]  ? lock_release+0x2fa/0x334
[   12.026904 ]  ? lock_downgrade+0x282/0x282
[   12.027602 ]  ? depot_save_stack+0x1c7/0x37f
[   12.028315 ]  ? lock_acquire+0xa1/0xd0
[   12.028950 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   12.029548 ]  ? _raw_spin_unlock_irqrestore+0x45/0x4e
[   12.030187 ]  ? depot_save_stack+0x33b/0x37f
[   12.030712 ]  ? save_stack+0x9a/0xa3
[   12.031161 ]  ? __kasan_slab_free+0x10e/0x130
[   12.031690 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   12.032296 ]  ? kfree+0x99/0x11f
[   12.032692 ]  ? list_sort_test+0x2f4/0x32d
[   12.033197 ]  ? do_one_initcall+0xc0/0x1bf
[   12.033707 ]  ? kernel_init+0x7/0xf4
[   12.034150 ]  ? ret_from_fork+0x3a/0x50
[   12.034619 ]  ? save_stack+0x9a/0xa3
[   12.035063 ]  ? check+0xcb/0xfc
[   12.035448 ]  ? cmp+0x2a/0x32
[   12.035866 ]  ? merge+0xcf/0x10e
[   12.036420 ]  ? lcm_not_zero+0x1f/0x1f
[   12.037086 ]  ? lock_release+0x2fa/0x334
[   12.037752 ]  ? __debug_check_no_obj_freed+0x89/0x1c5
[   12.038606 ]  ? lock_acquire+0xa1/0xd0
[   12.039266 ]  ? do_raw_spin_unlock+0xb2/0xbd
[   12.039996 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   12.040832 ]  ? trace_hardirqs_on_caller+0x11/0x242
[   12.041663 ]  ? quarantine_put+0x13d/0x15b
[   12.042353 ]  ? loglevel+0xb6/0xb6
[   12.042926 ]  ? slab_free_freelist_hook+0xa2/0xf8
[   12.043746 ]  ? list_sort_test+0x2f4/0x32d
[   12.044438 ]  ? kfree+0x99/0x11f
[   12.044994 ]  ? list_sort_test+0x2f4/0x32d
[   12.045675 ]  ? cmp+0x32/0x32
[   12.046183 ]  ? list_sort_test+0x32d/0x32d
[   12.046890 ]  ? set_debug_rodata+0xc/0xc
[   12.047554 ]  do_one_initcall+0xc0/0x1bf
[   12.048205 ]  ? start_kernel+0x59c/0x59c
[   12.048862 ]  ? lock_downgrade+0x282/0x282
[   12.049547 ]  kernel_init_freeable+0x189/0x21a
[   12.050312 ]  ? rest_init+0xa5/0xa5
[   12.050907 ]  kernel_init+0x7/0xf4
[   12.051479 ]  ? rest_init+0xa5/0xa5
[   12.052077 ]  ret_from_fork+0x3a/0x50
[   12.052685 ] test_overflow: vzalloc_node detected saturation
[   12.053722 ] test_overflow: devm_kmalloc detected saturation
[   12.054695 ] test_overflow: devm_kzalloc detected saturation
[   12.055966 ] test_overflow: all tests passed
[   12.057677 ] Running rhashtable test nelem=8, max_size=0, shrinking=0

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 57361846b52bc686112da6ca5368d11210796804 v4.18 --
git bisect good bbd60bffaf780464298cb7a39852f7f1065f1726  # 14:29  G     11     0   11  11  Merge tag 'mmc-v4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 6f7948f566bf423ddf5ff58dc0198afcf37c0b64  # 14:57  G     10     0   10  12  Merge tag 'upstream-4.19-rc1' of git://git.infradead.org/linux-ubifs
git bisect good d207ea8e74ff45be0838afa12bdd2492fa9dc8bc  # 15:20  G     11     0   11  11  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 9f8f16c86e4d9e2afcbdcd6045981c4d9129450e  # 15:35  B      0    11   27   2  Merge tag 'mtd/for-4.19-rc2' of git://git.infradead.org/linux-mtd
git bisect  bad 3f16503b7d2274ac8cbab11163047ac0b4c66cfe  # 15:55  B      0     8   22   0  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect  bad b933d6ebf2d367647af870441341f76242259898  # 16:18  B      0     3   17   0  Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good c4726e774ed27680c418e138234dfd2b8e1e89ac  # 16:54  G     10     0   10  10  Merge tag 'gcc-plugins-v4.19-rc1-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad aba16dc5cf9318b4e0fe92f8261779cd9f1d2d77  # 17:35  B      0     6   20   0  Merge branch 'ida-4.19' of git://git.infradead.org/users/willy/linux-dax
git bisect good b3fa64170e21393b5790be89ab16cdfe1f5bddbc  # 18:42  G     11     0   11  11  ppc: Convert mmu context allocation to new IDA API
git bisect good 8ab8ba38d48867aac01812e18f48fc9173ccd400  # 19:34  G     11     0   11  11  ida: Start new test_ida module
git bisect  bad 5c78b0b1ebe16fbae39a1cada79ab067965828f5  # 20:15  B      0    11   29   4  test_ida: Convert check_ida_conv to new API
git bisect  bad 0a3856392cff1542170b5bc37211c9a21fd0c3f6  # 20:57  B      0    11   26   1  test_ida: Move ida_check_leaf
git bisect good 06b01113664feda7647962008e901fa540ecbf6f  # 21:43  G     11     0   11  13  idr-test: Convert ida_check_nomem to new API
# first bad commit: [0a3856392cff1542170b5bc37211c9a21fd0c3f6] test_ida: Move ida_check_leaf
git bisect good 06b01113664feda7647962008e901fa540ecbf6f  # 21:48  G     32     0   32  46  idr-test: Convert ida_check_nomem to new API
# extra tests with debug options
git bisect  bad 0a3856392cff1542170b5bc37211c9a21fd0c3f6  # 22:22  B      0     8   22   0  test_ida: Move ida_check_leaf
# extra tests on HEAD of linux-devel/devel-hourly-2018090604
git bisect  bad a1fed24822c11bdfd48f34f1ac9646d6088a0e72  # 22:23  B      0    24   41   0  0day head guard for 'devel-hourly-2018090604'
# extra tests on tree/branch linus/master
git bisect  bad b36fdc6853a38a6f8749897a33435635019e0647  # 22:55  B      0    11   25   0  Merge tag 'gpio-v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
# extra tests on tree/branch linux-next/master
git bisect  bad 509d1f0c294a88b57b1becefbe17587d1fb714b1  # 23:24  B      0    11   27   2  Add linux-next specific files for 20180906

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--MW5yreqqjyrRcusr
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-26:20180906205717:x86_64-randconfig-s3-09060646:4.18.0-00024-g0a38563:1.gz"
Content-Transfer-Encoding: base64

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
SgYs7XXYUzr5HxIDbDdq/vEayT+6d3GHjqV8Ob/dk4S7XcOln8TA6XjX++jYiTa0WUQHjPGA
BR3eo6a5uN7aKqNDx1vLGKUkSBjjT5PcTi+vP8+kWxY9quo0jejg2P64BKWa4hr9Hu3k5nOY
4nHXMtvQdO6Kq/KbdKcpnShkOUUkUO52kI5qOmogUITnUh26pmAymbCT64tT6h/66M0H9Kmj
Xm4PLSdd7m/nN7OLqy9TpnMd79szVU7XEXRq9P/26fAwJIv7/wuP7+EJHT3e0jpZoCl5Cd0t
j9VmdRFE5ZRxa9LL7KDtRWW+uNKoPf+pdz0MJIbZI5EHuZsBTdtMoG4h0eT5j6K0KLxNkxte
8TjdprjQ+EyJFf9EH46njWZ7Qg4Wyg0f4CXrXUnnkwgdmW6fwCHD3x7BGYx6GMo7dguje8p6
mV3y797L/Pl2xrrPXmaQc52npeb4evTab0/yQFYbpdI9XIY86AHoQjpDhitq42EC/eT0CD20
9ewTXkOnxhh8SIYa6JfJ5nTz6X7+tt1bowfrlwwb6GkljGeaHvpQf4LtF4u4kuct9prdNnW3
qTENwn5F5RWKvawOrrcXV1RIvZdgGRRkPI9TDJ3UHgsfsyhcRWxMFzyO2beRrh/hAfKbEf6e
0c92SIzZmUy+7PMQ23boYhQE5uPuBNYTYEM8AW6PwhEwfwLsko2DgI1XgMXTEv8FsCejeSCw
eM+mcDi32jY23xUYxqLRAFvvCmzqXgtsvyswXljVADuvjQo+sPMc26HrehDYfQ3YHArs0o4P
AXt9YAp62gMeOtxgbaAA7wjsv2cbu5xcBAh48a7AhowhjcDBa21sDGwK15RhVRE4fNcSW47R
NkX0rsCOQbFdEXj5rsAunQ5EYP6u/Bjv9m7YJufvCswdo+k8brwrsDCMZrjxd+XHnum045i/
Kz/2QAZp2/hd+bGH11w3wO/Kjz2PzgwQsPOOwELHa9d/kFiCZ1LilO69Bpm2nKo8nGLHQR4d
AyzpU6OXRNGIIYnLJK6SDIotDklCJolekoX+xJBkyiRTJQkdmSIkWTLJ6iVZliyGLZNslWRS
ZCpIcmSS00uymiRXJrkqyWqpPJnk9ZIsy5X1auqs1E+h23QJKSa2te5V26ZLJDHRaBJ7zeWQ
4oqJTaPwXqugY6RMbJqF99rFbfuANw3Dey3jWj1J99UPC7M0mihKz8KoByffvnfGLNB/VkEy
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

--MW5yreqqjyrRcusr
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-vm-ivb41-1G-2:20180906214751:x86_64-randconfig-s3-09060646:4.18.0-00023-g06b0111:1.gz"
Content-Transfer-Encoding: base64

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

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vp-26:20180906205717:x86_64-randconfig-s3-09060646:4.18.0-00024-g0a38563:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.18.0-00024-g0a38563"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.18.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_PROFILING=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
CONFIG_FREEZER=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MQ_DEFAULT=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_UNSTRIPED is not set
# CONFIG_DM_CRYPT is not set
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_THIN_PROVISIONING=y
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_QL=y
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_DELAY=y
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=y
# CONFIG_DM_VERITY_FEC is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_DM_INTEGRITY is not set
CONFIG_DM_ZONED=y
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_TWL4030=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PXRC=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_GTCO=y
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
# CONFIG_TOUCHSCREEN_USB_3M is not set
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
# CONFIG_TOUCHSCREEN_USB_DMC_TSC10 is not set
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
# CONFIG_TOUCHSCREEN_USB_GOTOP is not set
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
# CONFIG_TOUCHSCREEN_USB_E2I is not set
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SUR40 is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DLN2 is not set
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_MAX8925_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
CONFIG_BATTERY_RX51=y
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
# CONFIG_TWL4030_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=y
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_GSPCA is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
# CONFIG_USB_S2255 is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
# CONFIG_VIDEO_PVRUSB2_DVB is not set
CONFIG_VIDEO_HDPVR=y
# CONFIG_VIDEO_USBVISION is not set
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
# CONFIG_VIDEO_AU0828_V4L2 is not set
CONFIG_VIDEO_AU0828_RC=y
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB=y
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=y
CONFIG_DVB_USB_A800=y
CONFIG_DVB_USB_DIBUSB_MB=y
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=y
CONFIG_DVB_USB_DIB0700=y
# CONFIG_DVB_USB_UMT_010 is not set
# CONFIG_DVB_USB_CXUSB is not set
# CONFIG_DVB_USB_M920X is not set
CONFIG_DVB_USB_DIGITV=y
CONFIG_DVB_USB_VP7045=y
# CONFIG_DVB_USB_VP702X is not set
# CONFIG_DVB_USB_GP8PSK is not set
CONFIG_DVB_USB_NOVA_T_USB2=y
CONFIG_DVB_USB_TTUSB2=y
CONFIG_DVB_USB_DTT200U=y
CONFIG_DVB_USB_OPERA1=y
# CONFIG_DVB_USB_AF9005 is not set
CONFIG_DVB_USB_PCTV452E=y
CONFIG_DVB_USB_DW2102=y
CONFIG_DVB_USB_CINERGY_T2=y
CONFIG_DVB_USB_DTV5100=y
# CONFIG_DVB_USB_FRIIO is not set
# CONFIG_DVB_USB_AZ6027 is not set
CONFIG_DVB_USB_TECHNISAT_USB2=y
CONFIG_DVB_USB_V2=y
CONFIG_DVB_USB_AF9015=y
CONFIG_DVB_USB_AF9035=y
CONFIG_DVB_USB_ANYSEE=y
CONFIG_DVB_USB_AU6610=y
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
# CONFIG_DVB_USB_EC168 is not set
CONFIG_DVB_USB_GL861=y
CONFIG_DVB_USB_LME2510=y
CONFIG_DVB_USB_MXL111SF=y
# CONFIG_DVB_USB_RTL28XXU is not set
CONFIG_DVB_USB_DVBSKY=y
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_DVB=y
CONFIG_VIDEO_EM28XX_RC=y

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
CONFIG_USB_HACKRF=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_VIDEO_SH_VEU=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y
CONFIG_SMS_SIANO_DEBUGFS=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_WM8775=y

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP5150=y

#
# Video and audio decoders
#
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_MT9V011=y

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_MN88472=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_MT312=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_DRXD=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_AF9013=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_TDA10023=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_RAVE_SP is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
CONFIG_HID_GT683R=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=y
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_PCI=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
# CONFIG_UWB_I1480U is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_AB3100 is not set
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
# CONFIG_PANEL is not set
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
# CONFIG_BMA180 is not set
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DLN2_ADC=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_STX104 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
# CONFIG_VIPERBOARD_ADC is not set

#
# Analog Front Ends
#

#
# Amplifiers
#

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_VZ89X=y
# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_CIO_DAC is not set
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_SENSORS_HMC5843_I2C is not set

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
CONFIG_SRF08=y

#
# Resolver to digital converters
#

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=y
CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_RAVE_SP_EEPROM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
# CONFIG_KASAN_EXTRA is not set
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_OVERFLOW=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=y
CONFIG_TEST_IDA=y
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
# CONFIG_DOUBLEFAULT is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=y
CONFIG_CRYPTO_MORUS640_SSE2=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_MORUS1280_GLUE=y
CONFIG_CRYPTO_MORUS1280_SSE2=y
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA1_MB=y
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--MW5yreqqjyrRcusr--
