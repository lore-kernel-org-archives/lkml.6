Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A88208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A88208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403785AbeHGRPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:15:46 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:33847 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbeHGRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:15:46 -0400
Received: by mail-io0-f200.google.com with SMTP id f9-v6so12406853ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eNZcZ/LGgGeZbBhS9z8kZyRtAVAbt/WgD9D6vjkoVvk=;
        b=JWSLtpBJ7Sn2n2C++kUqhpl/AghZH717wbkjkGBhXheZqTNc0B2OijcqV08sKHj9Ij
         gVuI/HI0sXdh3ZT+T/x7w6YGlKDEeIGJjGHUYbXUaIpkIxqlf0xsjz9cXqem5Ibx+VNn
         /6qtYzhOvVG1jhdK5IM6z6L7C3iDDRPhiTXe47km5lrWAUwRGZ2yoji2LJvDVkbJO2JP
         41+nvyxWpRzuTjFgqbvh4XFVxZUPsAxTSrM7OPwvl10MuAnKGG6NA6CtK0YgdWuARzJT
         5dMiMApBCIGfa4b5qPOM4XfTyDmctcBin1sklu3msnHqOyaNpkB4R5fGGIsJkX717UQI
         NgmQ==
X-Gm-Message-State: AOUpUlH60/6F99w1gghUTdl8+m8IdckaG7sH2dOxEA4/jPO1HckHrKtt
        SqofTt4RGjHqZqSDQ2ZxV1DClv8PeaRw3qGQ2ipYuGjR4upp
X-Google-Smtp-Source: AA+uWPxX+YY5mNB64ULWPUtz2njVvYhLCajScgH/R51b0hl29anZhAojLnwPGAwpYfs3cmLvd+6bYDUTEwEoy9ehwf0iTyBd1Rl3
MIME-Version: 1.0
X-Received: by 2002:a6b:f019:: with SMTP id w25-v6mr966007ioc.31.1533654062155;
 Tue, 07 Aug 2018 08:01:02 -0700 (PDT)
Date:   Tue, 07 Aug 2018 08:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009551c40572d9a91e@google.com>
Subject: INFO: rcu detected stall in native_queued_spin_lock_slowpath
From:   syzbot <syzbot+0badcf87cb26aa6e5ea6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0585df468e8f Merge tag 'media/v4.18-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10edc89c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=0badcf87cb26aa6e5ea6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0badcf87cb26aa6e5ea6@syzkaller.appspotmail.com

INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 0, t=105007 jiffies, g=118924, c=118923, q=65)
All QSes seen, last rcu_sched kthread activity 105014  
(4295296700-4295191686), jiffies_till_next_fqs=3, root ->qsmask 0x0
syz-executor7   R  running task    23352 14084   4424 0x00000008
Call Trace:
  <IRQ>
  sched_show_task.cold.84+0x27a/0x301 kernel/sched/core.c:5324
  print_other_cpu_stall.cold.77+0x92f/0x9d2 kernel/rcu/tree.c:1441
  check_cpu_stall.isra.60+0x721/0xf70 kernel/rcu/tree.c:1559
  __rcu_pending kernel/rcu/tree.c:3244 [inline]
  rcu_pending kernel/rcu/tree.c:3291 [inline]
  rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1028 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1053
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:bytes_is_nonzero mm/kasan/kasan.c:167 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/kasan.c:184 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/kasan.c:241 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/kasan.c:257 [inline]
RIP: 0010:check_memory_region+0x121/0x1b0 mm/kasan/kasan.c:267
Code: 29 c0 e9 6c ff ff ff 4d 85 c0 74 ba 48 b8 01 00 00 00 00 fc ff df 4d  
01 c8 48 01 d8 41 80 39 00 74 08 e9 8c 00 00 00 48 89 d8 <4c> 39 c0 74 97  
80 38 00 48 8d 58 01 74 ef eb 87 4c 89 c0 49 39 c2
RSP: 0018:ffff88018fec7388 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffffed0039557a49 RBX: 1ffff10039557a48 RCX: ffffffff815faf29
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8801caabd240
RBP: ffff88018fec73a0 R08: ffffed0039557a49 R09: ffffed0039557a48
R10: ffffed0039557a48 R11: ffff8801caabd243 R12: ffffed0039557a49
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8801caabd240
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  virt_spin_lock arch/x86/include/asm/qspinlock.h:65 [inline]
  native_queued_spin_lock_slowpath+0x189/0x1200  
kernel/locking/qspinlock.c:305
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:674 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:32 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:88 [inline]
  do_raw_spin_lock+0x1a7/0x200 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:310 [inline]
  request_end+0x400/0xb20 fs/fuse/dev.c:382
  end_requests+0x296/0x460 fs/fuse/dev.c:2045
  fuse_dev_release+0x18c/0x2e0 fs/fuse/dev.c:2154
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456b29
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fae499f2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000030 RBX: 00007fae499f36d4 RCX: 0000000000456b29
RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000017
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d2b40 R14: 00000000004c7b8b R15: 0000000000000000
rcu_sched kthread starved for 105755 jiffies! g118924 c118923 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23688    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ec0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1801
  rcu_gp_kthread+0x717/0x1c90 kernel/rcu/tree.c:2179
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
