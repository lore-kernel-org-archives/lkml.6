Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D9320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D9320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeIKKvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:51:42 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:46569 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeIKKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:51:41 -0400
Received: by mail-io0-f198.google.com with SMTP id f4-v6so2839625ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 22:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MPZc0GrYP6LMJCtDLI7zWaOtu32frKyLvZ+93VQGqoE=;
        b=jeWQ4cOITCP1fKnNfzt5SIGezEE2wMLOhNolUR6TUsLyjOjbILY4qbY2xR7MY9Hmwy
         SflfIviH+CUAOhBhz9sZrCuR9IgrFyCrD84ADChbtI/A5NrJBuAqI9zvMB4g6yQhthHz
         p5zSoFE8pd+htv2W6Lls/gu/345301IojlpTOhpoUBmkQ3Xz6q4424FnUZORIsi+KgyR
         4oj72xNbqSDS++SYkRHVq2ApKb85zQxanUbsUG+7Dsuzi2YzIhkCvDKwUDsF3ul7FZnb
         XT+xV3ali7veGXpREazTXYXQ3qdi/DJaTwE3UXNYGMHag+KxfmsCSXbamCIxWiIE+xHr
         AiWQ==
X-Gm-Message-State: APzg51CmYc4937T73w0iDKKaeQibuAOXzj5qfjySvuivYy5Q5oA9XT7z
        19CoSU+fPLOGzCxg7+apK/Rgmvvoc3m3og/c8fHMqh6/UOo3
X-Google-Smtp-Source: ANB0VdZ+o29Kg99csDZd/DBOITPmMRCEqsy6FnCFxzaodDriEUdyHVfUWwduJI0MGianBLz9LtwDTs6xzU361k59o2IWGvCRsP8T
MIME-Version: 1.0
X-Received: by 2002:a02:9d3d:: with SMTP id n58-v6mr20384333jak.58.1536645243385;
 Mon, 10 Sep 2018 22:54:03 -0700 (PDT)
Date:   Mon, 10 Sep 2018 22:54:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0d794057592192b@google.com>
Subject: INFO: rcu detected stall in kvm_vcpu_ioctl
From:   syzbot <syzbot+e9b1e8f574404b6e4ed3@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1666429e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=e9b1e8f574404b6e4ed3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9b1e8f574404b6e4ed3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=45997, q=77)
rcu: All QSes seen, last rcu_preempt kthread activity 10502  
(4294979638-4294969136), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor7   R  running task    22096 16667   5475 0x00000000
Call Trace:
  <IRQ>
  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x0/0x20 kernel/kcov.c:183
Code: a6 fe ff ff 5d c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7 bf 03 00 00 00 48  
89 e5 48 8b 4d 08 e8 88 fe ff ff 5d c3 66 0f 1f 44 00 00 <55> 89 f2 89 fe  
bf 05 00 00 00 48 89 e5 48 8b 4d 08 e8 6a fe ff ff
RSP: 0018:ffff88019baf7858 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff88019ef30700 RCX: ffffc90001ed4000
RDX: 0000000000040000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88019baf78d8 R08: ffff8801bd9ea700 R09: 1ffffffff12b43cd
R10: ffff88019baf7860 R11: ffff8801dae23993 R12: 0000000000000000
R13: 0000000000000007 R14: 0000000000000007 R15: dffffc0000000000
  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8361215c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f83612166d4 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10502 jiffies! g45997 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    22872    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
sched: RT throttling activated


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
