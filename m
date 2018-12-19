Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A42C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7BF21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeLSJ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:27:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:38861 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeLSJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:27:04 -0500
Received: by mail-it1-f200.google.com with SMTP id m128so6609086itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3BBw2f8K05sKChscGmxds7Jjis7V5pbySIcSem7vvTc=;
        b=Hsdl+nfBWmntV7xYpqbTdZ3Obri+VfXPIkOoe3Xnqzr7Nk0L70kaxMKvwesf9YQdqF
         fTM0WJFcGYwKvv6wPJb9lmcx7s/L0KSOL+v5Xw90fNrMrsVREM6H/vSWikE52L41GA5o
         nJJFhRSO71ekQHrF4rI8BuM/TzxqgmKn1hPuY3f7OkaZ//spUSFi7jJbG96PbOtxKrHN
         l/+QEi9840smrkNSEGXOXhcuuLTDd5PWT4KNTTQI9aPmSRSicEFxkvYrlMixgNZzm3vr
         ZEUczg9AP9azZ0qeVMr7UBXayRTk1+J1x531nrA85rXFYRSyEnVycz3zla8gQRnRBndi
         P8Hw==
X-Gm-Message-State: AA+aEWboNNDCXmyTf17FfzJKki7gq2PxX53K8bWupCat7j+iIV2QV/4R
        omGU5e2brGFgi/zL3mw9dM1fOaNdvQBGvZDbL1QXarjwjK6o
X-Google-Smtp-Source: AFSGD/XoqFeJw8NjA1EuRmvqT0cqLlxW+3hd+obuI2W9ctLPq2lFfVi3WS1yU0oRaOY1wtHrByngLkBuq1UQ48rkC2GVJANhM+02
MIME-Version: 1.0
X-Received: by 2002:a02:3b2b:: with SMTP id c43mr16847167jaa.15.1545211623185;
 Wed, 19 Dec 2018 01:27:03 -0800 (PST)
Date:   Wed, 19 Dec 2018 01:27:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e728ec057d5c9d90@google.com>
Subject: INFO: rcu detected stall in sys_sendfile64
From:   syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ddfbab46539f Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b87fa3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=bcad772bbc241b4c6147
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13912ccd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145781db400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com

audit: type=1800 audit(1545177748.235:30): pid=5832 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10500 ticks this GP) idle=37e/1/0x4000000000000002  
softirq=6309/6309 fqs=5250
rcu: 	 (t=10502 jiffies g=4321 q=29)
NMI backtrace for cpu 1
CPU: 1 PID: 5987 Comm: syz-executor800 Not tainted 4.20.0-rc7+ #377
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.67+0x1f3/0x3c7 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xf3b/0x13f0 kernel/rcu/tree.c:2506
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x4b/0x50 kernel/kcov.c:111
Code: 90 d8 12 00 00 83 fa 02 75 20 48 8b 88 e0 12 00 00 8b 80 dc 12 00 00  
48 8b 11 48 83 c2 01 48 39 d0 76 07 48 89 34 d1 48 89 11 <5d> c3 0f 1f 00  
55 40 0f b6 d6 40 0f b6 f7 31 ff 48 89 e5 48 8b 4d
RSP: 0018:ffff8881c1e17988 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8881c2860200 RBX: 0000000000000004 RCX: ffffffff81ced656
RDX: 0000000000000000 RSI: ffffffff8344bfe8 RDI: ffff8881b4364cc0
RBP: ffff8881c1e17988 R08: ffff8881c2860200 R09: 0000000000000007
R10: 0000000000000000 R11: ffff8881c2860200 R12: ffff8881b4364cc0
R13: 0000000001237d36 R14: ffff8881b4364cc0 R15: 0000000000000004
  security_file_permission+0x18/0x220 security/security.c:886
  rw_verify_area+0x111/0x360 fs/read_write.c:391
  do_splice_to+0x8b/0x190 fs/splice.c:868
  splice_direct_to_actor+0x31c/0x9d0 fs/splice.c:957
  do_splice_direct+0x2d4/0x420 fs/splice.c:1066
  do_sendfile+0x62a/0xe20 fs/read_write.c:1439
  __do_sys_sendfile64 fs/read_write.c:1494 [inline]
  __se_sys_sendfile64 fs/read_write.c:1486 [inline]
  __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1486
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4400d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdd3e00e58 EFLAGS: 00000203 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004400d9
RDX: 0000000020000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00008080fffffffe R11: 0000000000000203 R12: 0000000000401960
R13: 00000000004019f0 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
