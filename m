Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDYDuF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:50:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:56793 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDYDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:50:03 -0400
X-Google-Smtp-Source: AB8JxZqb6aErXPWM9CeVpzwE5zw0fCZ9ULV/pyP3dwG++HZyV7zLCFUmuN9VM3jmdMZFXgrc6LNmvpjWTP/JYxIEztMyPLyJ9oJI
MIME-Version: 1.0
Date: Tue, 24 Apr 2018 20:50:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a0fe4056aa42a56@google.com>
Subject: WARNING: kernel stack regs has bad value
From: syzbot <syzbot+4529a1346c0a67500ab9@syzkaller.appspotmail.com>
To: adobriyan@gmail.com, akpm@linux-foundation.org, gs051095@gmail.com,
        lauraa@codeaurora.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mingo@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
24cac7009cb1b211f1c793ecb6a462c03dc35818 (Tue Apr 24 21:16:40 2018 +0000)
Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4529a1346c0a67500ab9

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5707297623900160
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4674478248296448
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5189967202484224
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=7043958930931867332
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4529a1346c0a67500ab9@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

         (ptrval): 0000000000440d69 (0x440d69)
         (ptrval): 0000000000000033 (0x33)
         (ptrval): 0000000000000246 (0x246)
         (ptrval): 00007ffca6a2bae8 (0x7ffca6a2bae8)
         (ptrval): 000000000000002b (0x2b)
WARNING: kernel stack regs at         (ptrval) in syz-executor366:4507 has  
bad 'bp' value         (ptrval)

================================
WARNING: inconsistent lock state
4.17.0-rc2+ #15 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
sshd/4505 [HC1[1]:SC0[0]:HE0:SE1] takes:
         (ptrval) (fs_reclaim){?.+.}, at:  
fs_reclaim_acquire.part.82+0x0/0x30 mm/page_alloc.c:463
{HARDIRQ-ON-W} state was registered at:
   lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
   fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
   fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
   slab_pre_alloc_hook mm/slab.h:418 [inline]
   slab_alloc_node mm/slab.c:3299 [inline]
   kmem_cache_alloc_node_trace+0x39/0x770 mm/slab.c:3661
   kmalloc_node include/linux/slab.h:550 [inline]
   kzalloc_node include/linux/slab.h:712 [inline]
   alloc_worker+0xbd/0x2e0 kernel/workqueue.c:1704
   init_rescuer.part.25+0x1f/0x190 kernel/workqueue.c:4000
   init_rescuer kernel/workqueue.c:3997 [inline]
   workqueue_init+0x51f/0x7d0 kernel/workqueue.c:5732
   kernel_init_freeable+0x2ad/0x58e init/main.c:1115
   kernel_init+0x11/0x1b3 init/main.c:1053
   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
irq event stamp: 688138
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
read_seqcount_begin include/linux/seqlock.h:164 [inline]
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
ktime_get_ts64+0x405/0x510 kernel/time/timekeeping.c:850
hardirqs last disabled at (688138): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (688130): [<ffffffff85d601e2>] spin_unlock_bh  
include/linux/spinlock.h:355 [inline]
softirqs last  enabled at (688130): [<ffffffff85d601e2>]  
release_sock+0x1e2/0x2b0 net/core/sock.c:2861
softirqs last disabled at (688128): [<ffffffff85d60074>] spin_lock_bh  
include/linux/spinlock.h:315 [inline]
softirqs last disabled at (688128): [<ffffffff85d60074>]  
release_sock+0x74/0x2b0 net/core/sock.c:2848

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(fs_reclaim);
   <Interrupt>
     lock(fs_reclaim);

  *** DEADLOCK ***

no locks held by sshd/4505.

stack backtrace:
CPU: 0 PID: 4505 Comm: sshd Not tainted 4.17.0-rc2+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_usage_bug.cold.59+0x320/0x41a kernel/locking/lockdep.c:2542
  valid_state kernel/locking/lockdep.c:2555 [inline]
  mark_lock_irq kernel/locking/lockdep.c:2749 [inline]
  mark_lock+0x1034/0x19e0 kernel/locking/lockdep.c:3147
  mark_irqflags kernel/locking/lockdep.c:3022 [inline]
  __lock_acquire+0x1595/0x5140 kernel/locking/lockdep.c:3388
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  fs_reclaim_acquire.part.82+0x24/0x30 mm/page_alloc.c:3739
  fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
  slab_pre_alloc_hook mm/slab.h:418 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x45/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_interrupt_randomness+0x494/0x860 drivers/char/random.c:1254
  handle_irq_event_percpu+0xf9/0x1c0 kernel/irq/handle.c:191
  handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
  handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
  generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
  handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0xf/0x20 kernel/kcov.c:194
RSP: 0018:ffff8801cf7f7a30 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd5
RAX: dffffc0000000000 RBX: 00007ffffffff000 RCX: ffffffff81bdcde5
RDX: 00007ffffffff000 RSI: ffffffffffffffff RDI: 0000000000000007
RBP: ffff8801cf7f7a30 R08: ffff8801b3c78600 R09: ffffed003b5c46c2
R10: 0000000000000003 R11: 0000000000000000 R12: ffffffff87f9ef20
R13: 000000000000000a R14: ffff8801cf7f7ba8 R15: 000055f253dfead0
  __might_fault+0x55/0x1e0 mm/memory.c:4548
  _copy_from_user+0x30/0x150 lib/usercopy.c:10
  copy_from_user include/linux/uaccess.h:147 [inline]
  get_fd_set fs/select.c:367 [inline]
  core_sys_select+0x3e2/0xb60 fs/select.c:647
  kern_select+0x1b7/0x250 fs/select.c:696
  __do_sys_select fs/select.c:705 [inline]
  __se_sys_select fs/select.c:702 [inline]
  __x64_sys_select+0xbe/0x150 fs/select.c:702
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7337a51dd3
RSP: 002b:00007fffa0a9c698 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007fffa0a9c720 RCX: 00007f7337a51dd3
RDX: 000055f253dfeab0 RSI: 000055f253dfead0 RDI: 000000000000000c
RBP: 000055f2539298dc R08: 00007fffa0a9c6c0 R09: 0101010101010101
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffa0a9c728
R13: 0000000000000000 R14: 00007fffa0a9c718 R15: 00007fffa0a9c71c
BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 4505, name: sshd
INFO: lockdep is turned off.
irq event stamp: 688138
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
seqcount_lockdep_reader_access include/linux/seqlock.h:83 [inline]
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
read_seqcount_begin include/linux/seqlock.h:164 [inline]
hardirqs last  enabled at (688137): [<ffffffff816878c5>]  
ktime_get_ts64+0x405/0x510 kernel/time/timekeeping.c:850
hardirqs last disabled at (688138): [<ffffffff87800905>]  
interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (688130): [<ffffffff85d601e2>] spin_unlock_bh  
include/linux/spinlock.h:355 [inline]
softirqs last  enabled at (688130): [<ffffffff85d601e2>]  
release_sock+0x1e2/0x2b0 net/core/sock.c:2861
softirqs last disabled at (688128): [<ffffffff85d60074>] spin_lock_bh  
include/linux/spinlock.h:315 [inline]
softirqs last disabled at (688128): [<ffffffff85d60074>]  
release_sock+0x74/0x2b0 net/core/sock.c:2848
CPU: 0 PID: 4505 Comm: sshd Not tainted 4.17.0-rc2+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  ___might_sleep.cold.87+0x11f/0x13a kernel/sched/core.c:6188
  __might_sleep+0x95/0x190 kernel/sched/core.c:6141
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x2b9/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  numa_crng_init drivers/char/random.c:798 [inline]
  crng_reseed+0x427/0x920 drivers/char/random.c:923
  credit_entropy_bits+0x98d/0xa30 drivers/char/random.c:708
  add_interrupt_randomness+0x494/0x860 drivers/char/random.c:1254
  handle_irq_event_percpu+0xf9/0x1c0 kernel/irq/handle.c:191
  handle_irq_event+0xa7/0x135 kernel/irq/handle.c:206
  handle_edge_irq+0x20f/0x870 kernel/irq/chip.c:791
  generic_handle_irq_desc include/linux/irqdesc.h:159 [inline]
  handle_irq+0x18c/0x2e7 arch/x86/kernel/irq_64.c:77
  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0xf/0x20 kernel/kcov.c:194
RSP: 0018:ffff8801cf7f7a30 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd5
RAX: dffffc0000000000 RBX: 00007ffffffff000 RCX: ffffffff81bdcde5
RDX: 00007ffffffff000 RSI: ffffffffffffffff RDI: 0000000000000007
RBP: ffff8801cf7f7a30 R08: ffff8801b3c78600 R09: ffffed003b5c46c2
R10: 0000000000000003 R11: 0000000000000000 R12: ffffffff87f9ef20
R13: 000000000000000a R14: ffff8801cf7f7ba8 R15: 000055f253dfead0
  __might_fault+0x55/0x1e0 mm/memory.c:4548
  _copy_from_user+0x30/0x150 lib/usercopy.c:10
  copy_from_user include/linux/uaccess.h:147 [inline]
  get_fd_set fs/select.c:367 [inline]
  core_sys_select+0x3e2/0xb60 fs/select.c:647
  kern_select+0x1b7/0x250 fs/select.c:696
  __do_sys_select fs/select.c:705 [inline]
  __se_sys_select fs/select.c:702 [inline]
  __x64_sys_select+0xbe/0x150 fs/select.c:702
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7337a51dd3
RSP: 002b:00007fffa0a9c698 EFLAGS: 00000246 ORIG_RAX: 0000000000000017
RAX: ffffffffffffffda RBX: 00007fffa0a9c720 RCX: 00007f7337a51dd3
RDX: 000055f253dfeab0 RSI: 000055f253dfead0 RDI: 000000000000000c
RBP: 000055f2539298dc R08: 00007fffa0a9c6c0 R09: 0101010101010101
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffa0a9c728
R13: 0000000000000000 R14: 00007fffa0a9c718 R15: 00007fffa0a9c71c
random: crng init done


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
