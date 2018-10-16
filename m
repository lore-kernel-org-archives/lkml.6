Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAF5208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAF5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJPNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:50:52 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:35292 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeJPNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:50:52 -0400
Received: by mail-it1-f197.google.com with SMTP id p73-v6so24966274itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 23:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J+viKE2N33n24w4PMvug6p2BNLKZsHS4/6WUdLxzECA=;
        b=NZKhXdXURAtQSP2U5iQjaBj/dVtqAjYVNEZBVdFvingt4xb2MA+MHrv4U9ta9JamGN
         JBcwigBbDTKgfB5pulU/wwICj3j+VG366goeaJpq381ABd/Y4M7yNEHERDvpeaAwFWco
         B7/KwVJFOHndK48xndkI508yKWTthp/QGrt3JVPL5okQoQTlIJKpSfFn4NEBUut3VN4P
         TeyQdIavSKxMvqU8CVFMY6oqPkVSHtTS9SLmGJJSeaXy7GD4O257TqB4rqsLSLtTsfUq
         BxdlTf9bWru2u2WfBnxVVRXeWFUeU3qS3ciHhcyilE4evj7/a5wwydNFHnak7F+5Y+Cp
         sbBw==
X-Gm-Message-State: ABuFfoh4S3aVagK2/YwRvX6YuBmVUdr4z71vFqwHFkFD5WWY8MOXgBID
        zHKJ4aXuys95c0YmtTiGAL02ii0pxY/uxW0x1usvFDr+00fc
X-Google-Smtp-Source: ACcGV629e5RJTP7wxMwY0NQA3a+BFG3tmaAPLUjyiUYJKn6AEYAOyf7EQCU205IEdiZ6iArZd1+qwzUPWR757ALCXMJP+8kmgVIr
MIME-Version: 1.0
X-Received: by 2002:a6b:3709:: with SMTP id e9-v6mr15389928ioa.8.1539669723557;
 Mon, 15 Oct 2018 23:02:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 23:02:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1be430578524a20@google.com>
Subject: INFO: task hung in evdev_release
From:   syzbot <syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9dcd936c5312 Merge tag 'for-4.19/dm-fixes-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1285436e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=a979743610b4755d4d57
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fcd826400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com

team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
kworker/dying (307) used greatest stack depth: 14800 bytes left
INFO: task syz-executor0:17271 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D19016 17271  15650 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  evdev_release+0x8a/0x1e0 drivers/input/evdev.c:477
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad7/0x2610 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2513
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457519
Code: 44 0f 7f 41 b0 f3 44 0f 7f 49 c0 f3 44 0f 7f 51 d0 f3 44 0f 7f 59 e0  
f3 44 0f 7f 61 f0 c3 48 89 f8 f3 0f 6f 2e f3 0f 6f 76 10 <48> 01 df f3 0f  
6f 7e 20 f3 44 0f 6f 46 30 4c 8d 57 e0 49 89 fb f3
RSP: 002b:00007f6cd89eccf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bfa8 RCX: 0000000000457519
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000072bfa8
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000072bfac
R13: 00007ffda1adeb1f R14: 00007f6cd89ed9c0 R15: 0000000000000001
INFO: task syz-executor1:19103 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D23568 19103  17558 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  evdev_close_device drivers/input/evdev.c:447 [inline]
  evdev_release+0xfe/0x1e0 drivers/input/evdev.c:488
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410ff1
Code: 30 48 89 4c 24 10 e8 8e 09 00 00 48 8b 44 24 28 48 89 04 24 48 8b 44  
24 30 48 89 44 24 08 e8 36 5d 04 00 48 8b 6c 24 18 48 83 <c4> 20 c3 cc cc  
cc cc cc cc cc cc cc cc cc cc 64 48 8b 0c 25 f8 ff
RSP: 002b:00007ffe35943940 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000410ff1
RDX: 0000000000000000 RSI: 0000000000730488 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffe35943870 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 000000000000000e R15: 0000000000000001
INFO: task syz-executor2:19141 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #55
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor2   D23568 19141  18263 0x00000006
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  evdev_close_device drivers/input/evdev.c:447 [inline]
  evdev_release+0xfe/0x1e0 drivers/input/evdev.c:488
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x155e/0x1980 kernel/signal.c:2343
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410ff1
Code: 30 48 89 4c 24 10 e8 8e 09 00 00 48 8b 44 24 28 48 89 04 24 48 8b 44  
24 30 48 89 44 24 08 e8 36 5d 04 00 48 8b 6c 24 18 48 83 <c4> 20 c3 cc cc  
cc cc cc cc cc cc cc cc cc cc 64 48 8b 0c 25 f8 ff
RSP: 002b:00007ffd4fba6dd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000410ff1
RDX: 0000000000000000 RSI: 0000000000730488 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd4fba6d00 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000009 R15: 0000000000000002
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 983 Comm: khungtaskd Not tainted 4.19.0-rc7+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb3e/0x1050 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tick_nohz_update_jiffies kernel/time/tick-sched.c:502 [inline]
RIP: 0010:tick_nohz_irq_enter kernel/time/tick-sched.c:1232 [inline]
RIP: 0010:tick_irq_enter+0x279/0x3e0 kernel/time/tick-sched.c:1249
Code: 00 0f 84 02 01 00 00 e8 35 98 0d 00 48 89 df 57 9d 0f 1f 44 00 00 e8  
d6 a6 13 00 e8 21 98 0d 00 e8 cc c1 0d 00 e9 1e fe ff ff <e8> 12 98 0d 00  
e8 9d 16 1c 02 31 c9 4c 89 f2 48 89 de 89 c7 e8 2e
RSP: 0018:ffff8801daf07c98 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffff8801daf26460 RCX: ffffffff81713bf5
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff8801daf07cc8 R08: ffff8801d9b103c0 R09: 000000000000000a
R10: fffffbfff145fa09 R11: 0000000000000001 R12: 0000000000000017
R13: ffff8801daf264ac R14: 000000deb5875cd2 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001bf8a0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  irq_enter+0xbd/0xe0 kernel/softirq.c:353
  scheduler_ipi+0x3d0/0xad0 kernel/sched/core.c:1770
  smp_reschedule_interrupt+0x109/0x650 arch/x86/kernel/smp.c:278
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:888
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 63 eb 11 fa 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 52 eb 11 fa eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffff8801d9b1fc30 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
RAX: dffffc0000000000 RBX: 1ffff1003b363f8a RCX: ffffffff8184e1ca
RDX: 1ffffffff1263e54 RSI: ffffffff8184e1e4 RDI: ffffffff8931f2a0
RBP: ffff8801d9b1fc30 R08: ffff8801d9b103c0 R09: ffffed003b5e4732
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: ffff8801d9b1fcf0
R13: ffffffff89f3bee0 R14: 0000000000000000 R15: 0000000000000001
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  start_secondary+0x447/0x5f0 arch/x86/kernel/smpboot.c:271
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
