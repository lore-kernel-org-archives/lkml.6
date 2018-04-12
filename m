Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeDLVCE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:02:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:54855 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeDLVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:02:02 -0400
X-Google-Smtp-Source: AIpwx4+UKuiZPc1a2BY//rdX+eGf5j/fve9ifojuVzBOJlJxrxp6WdQ0WgnFrramK4zB76f+5DcHFcQdoHM5n4uvUP8WBkYPpL65
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 14:02:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000237cc60569ad11c7@google.com>
Subject: INFO: rcu detected stall in d_walk
From: syzbot <syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3CL2AtY015957

Hello,

syzbot hit the following crash on upstream commit
c17b0aadb7d8f87de56a4a374a8131519c0f7422 (Thu Apr 12 16:15:48 2018 +0000)
Merge tag 'asm-generic' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=ae80b790eb412884ca77

So far this crash happened 3 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6595600812343296
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6204964946837504
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5012331448762368
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

EXT4-fs (sda1): Unrecognized mount option "�辭 
m��.2�-[)3i�~�r�����$S�%j�?�	����ƅ�|��1���>�[���2	 
H�s�no[�n�߲$��;��g�
�X��m�64"�N=�BM�Z��H��#����
)1{��^f��D�.`*�e��B�8H8��O�" or missing value
EXT4-fs (sda1): Unrecognized mount option "�辭 
m��.2�-[)3i�~�r�����$S�%j�?�	����ƅ�|��1���>�[���2	 
H�s�no[�n�߲$��;��g�
�X��m�64"�N=�BM�Z��H��#����
)1{��^f��D�.`*�e��B�8H8��O�" or missing value
INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 1, t=125007 jiffies, g=5317, c=5316, q=46)
All QSes seen, last rcu_sched kthread activity 125016  
(4295416981-4295291965), jiffies_till_next_fqs=3, root ->qsmask 0x0
syzkaller106625 R  running task    21976  4551   4549 0x00000008
Call Trace:
  <IRQ>
  sched_show_task.cold.87+0x27a/0x301 kernel/sched/core.c:5325
  print_other_cpu_stall.cold.79+0x92f/0x9d2 kernel/rcu/tree.c:1481
  check_cpu_stall.isra.61+0x706/0xf50 kernel/rcu/tree.c:1599
  __rcu_pending kernel/rcu/tree.c:3356 [inline]
  rcu_pending kernel/rcu/tree.c:3401 [inline]
  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:list_empty include/linux/list.h:203 [inline]
RIP: 0010:select_collect+0x175/0x5f0 fs/dcache.c:1465
RSP: 0018:ffff8801c79e78e8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801d95765c0 RBX: 1ffff10038f3cf20 RCX: ffffffff81c1ff94
RDX: 0000000000000000 RSI: ffffffff81c20025 RDI: ffff8801c79e7c08
RBP: ffff8801c79e79c8 R08: ffff8801d95765c0 R09: ffffed0034ffdec8
R10: ffffed0034ffdec8 R11: ffff8801a7fef643 R12: ffff8801c79e7bf0
R13: ffff8801a7fef5c0 R14: ffff8801c79e7bf8 R15: ffff8801c79e79a0
  d_walk+0x3c3/0xc80 fs/dcache.c:1276
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3850
  do_rmdir+0x523/0x610 fs/namei.c:3911
  SYSC_rmdir fs/namei.c:3929 [inline]
  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4423c7
RSP: 002b:00007ffe66511a38 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00000000004423c7
RDX: 0000000000000000 RSI: 00000000006d45f8 RDI: 00007ffe66513250
RBP: 00007ffe66513250 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000000a R11: 0000000000000207 R12: 0000000001a048a0
R13: 0000000000000000 R14: 000000000009880b R15: 00007ffe66512c48
rcu_sched kthread starved for 125589 jiffies! g5317 c5316 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23896     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411


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
