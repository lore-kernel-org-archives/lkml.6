Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC1C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242632084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfASMjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:39:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:51604 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfASMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:39:04 -0500
Received: by mail-io1-f70.google.com with SMTP id q207so12603653iod.18
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 04:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r7gOP4bNDPBf6bl5xeX0sRu21gpcHftUToL7apB9pKg=;
        b=mXtX626zIoHVwWiHF3NuZPdMKAsWhkw730QBrGI3PjLCnaOtdyovw63Ip6WrXgd3Bh
         8LExE0d51YQmLpsP047GZCWO73mNv4alr8DWFCBggh7B33iUZ/7Euqz3Mq2RTph6FTKC
         KVH0Bh0uaQMvlIl6IMJECzzQ0n7ZVuu4HIbjoLw+ROW5sjBvsujZm9t+BUPlepOfQ3HF
         Ixs3aaSAtsTiu5ilvVER1I3lxxlllqIxfnxUqU/hOw0c5Hw8k6nP9XucZEPFhsmO6XyX
         nWzc3wyPTgkr0NLyiBiDCBAe+DTQw7TPGqRVKTJdyOQlhTKjYx+ng3sHxoU/gWJsNT3X
         F/+Q==
X-Gm-Message-State: AJcUukchQsAC0FVlFl1Kb/DRkTjmpMA9gpHZu3b/QcRyxdGGUsKHY3c/
        tSnjm0hb/2tfqHydzkVlSrvj3ohE8PmDJ/vGRQadvsalaww0
X-Google-Smtp-Source: ALg8bN5zBrBpKpD/jCOQJFYn9D22vzp2U3vSm0C8j1yoULrVdX9pBnlc88uj2LnxNZ92gt+mDFpmjeA7xgX88tlngfmHlqHmyF6i
MIME-Version: 1.0
X-Received: by 2002:a24:6852:: with SMTP id v79mr14598164itb.29.1547901543048;
 Sat, 19 Jan 2019 04:39:03 -0800 (PST)
Date:   Sat, 19 Jan 2019 04:39:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ef2bf057fcee913@google.com>
Subject: INFO: rcu detected stall in rw_verify_area
From:   syzbot <syzbot+3d95205bfac60602a727@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9673b4aa71ca Add linux-next specific files for 20190118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c2097f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4086e03c3128165
dashboard link: https://syzkaller.appspot.com/bug?extid=3d95205bfac60602a727
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a02f6f400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c4dc28c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d95205bfac60602a727@syzkaller.appspotmail.com

hrtimer: interrupt took 39380 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=5593, q=4)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4295058157-4295047654), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor570 R  running task    23848  7948   7931 0x00000000
Call Trace:
  <IRQ>
  sched_show_task kernel/sched/core.c:5296 [inline]
  sched_show_task.cold+0x271/0x2d3 kernel/sched/core.c:5271
  print_other_cpu_stall.cold+0x7f2/0x8bb kernel/rcu/tree.c:1324
  check_cpu_stall kernel/rcu/tree.c:1452 [inline]
  rcu_pending kernel/rcu/tree.c:3114 [inline]
  rcu_sched_clock_irq+0xf36/0x1380 kernel/rcu/tree.c:2555
  update_process_times+0x32/0x80 kernel/time/timer.c:1635
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:161
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x3a7/0x1050 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x26/0x50 kernel/kcov.c:101
Code: 46 df ff ff 55 48 89 e5 48 8b 75 08 65 48 8b 04 25 40 ee 01 00 65 8b  
15 a8 b4 7f 7e 81 e2 00 01 1f 00 75 2b 8b 90 e0 12 00 00 <83> fa 02 75 20  
48 8b 88 e8 12 00 00 8b 80 e4 12 00 00 48 8b 11 48
RSP: 0018:ffff88808d0bf460 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888092ba00c0 RBX: ffff888097e1bc80 RCX: ffffffff835a5f5c
RDX: 0000000000000000 RSI: ffffffff835a5bf6 RDI: 0000000000000005
RBP: ffff88808d0bf460 R08: ffff888092ba00c0 R09: ffffed1015cc5b90
R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff88821bc94bb0
R13: ffff88821bc94bb0 R14: ffff8880a3586958 R15: ffff88808d0bf5f0
  aa_file_perm+0x226/0x1180 security/apparmor/file.c:615
  common_file_perm+0x1cb/0x820 security/apparmor/lsm.c:459
  apparmor_file_permission+0x25/0x30 security/apparmor/lsm.c:472
  security_file_permission+0x7e/0x320 security/security.c:1326
  rw_verify_area+0x110/0x360 fs/read_write.c:391
  do_iter_write+0x100/0x610 fs/read_write.c:951
  vfs_iter_write+0x77/0xb0 fs/read_write.c:969
  iter_file_splice_write+0x885/0xfc0 fs/splice.c:749
  do_splice_from fs/splice.c:851 [inline]
  direct_splice_actor+0x126/0x1a0 fs/splice.c:1023
  splice_direct_to_actor+0x3be/0x9d0 fs/splice.c:978
  do_splice_direct+0x2c7/0x420 fs/splice.c:1066
  do_sendfile+0x61a/0xe60 fs/read_write.c:1436
  __do_sys_sendfile64 fs/read_write.c:1491 [inline]
  __se_sys_sendfile64 fs/read_write.c:1483 [inline]
  __x64_sys_sendfile64+0x15a/0x240 fs/read_write.c:1483
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a19
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc79f06bda8 EFLAGS: 00000297 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000446a19
RDX: 0000000020000380 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000006dcc30 R08: 0000000000000000 R09: 0000000000000000
R10: 00008080fffffffe R11: 0000000000000297 R12: 00000000006dcc3c
R13: 00008080fffffffe R14: 00007fc79f06c9c0 R15: 00000000006dcd2c
rcu: rcu_preempt kthread starved for 10583 jiffies! g5593 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    25832    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2834 [inline]
  __schedule+0x897/0x1e60 kernel/sched/core.c:3475
  schedule+0xfe/0x350 kernel/sched/core.c:3519
  schedule_timeout+0x14a/0x250 kernel/time/timer.c:1803
  rcu_gp_fqs_loop+0x6d4/0x980 kernel/rcu/tree.c:1982
  rcu_gp_kthread+0x2bb/0xc10 kernel/rcu/tree.c:2139
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
sched: RT throttling activated


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
