Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13692C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B619A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B619A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeHWSFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:05:01 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:38248 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeHWSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:05:01 -0400
Received: by mail-io0-f199.google.com with SMTP id n17-v6so4475095ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NOJiCCbcX4ZBNxYsZlEhg43Px94Bigmdsh0gMySenjc=;
        b=Y+4+xw5qEOMwRo5ZTde07qS2XlL7L+ijd0SS57m4DzWZwEY5isElnB0V/SJ5mirW3d
         xTIXTJTap079Fjd9e7CGYREu5rW8tfHecnaX+7k3v56Ms2KAZf3CRprQtBNvUSaIcnTQ
         pQV6pPWZvEmJwQ4hhTs26E/vmoeO176N7trBaI8mC6OKmEUrCYpPnEmWkaZq/jSjCM24
         3AMwUdF2kwkUUSTfZjELFW/1ZNBqyFq+D3GTaqYv4IWDn4TNnuBzvihGIqLaoGK0a5Zs
         trTnnc2okeZDCtsDZzSy5Xsb/vxXahcSwQDnZrdB0ElJYyZAoYTRFHcjuOAzmCp3i2Z6
         EGPw==
X-Gm-Message-State: APzg51Dx69QFJzBE0Aq10DDOhf0fIipgfN14JXzzk2qu4KAn0yJGZIM4
        fAfEyb7FhLq9I/fBZ5d01Y4gzwytZrLMfzFLg/an6orxeLu3
X-Google-Smtp-Source: ANB0VdZrHWY/X0Tyy6Z4uKNW8oRVZNlnsP9IJv3spzwD5vbuQjh/ik30maYM2R9xRHvL0qkLHHwTEli7uKTSYyiL1T0f2ip3weC+
MIME-Version: 1.0
X-Received: by 2002:a6b:7319:: with SMTP id e25-v6mr4553063ioh.98.1535034903496;
 Thu, 23 Aug 2018 07:35:03 -0700 (PDT)
Date:   Thu, 23 Aug 2018 07:35:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002414d905741b2a38@google.com>
Subject: INFO: rcu detected stall in mousedev_write
From:   syzbot <syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    899fbc33fd77 Merge tag 'platform-drivers-x86-v4.19-1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a98c0a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e408e8a7bf8306cb
dashboard link: https://syzkaller.appspot.com/bug?extid=9436b02171ac0894d33e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com

rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	1-....: (104999 ticks this GP) idle=19e/1/0x4000000000000002  
softirq=112269/112269 fqs=19579
rcu: 	 (t=105000 jiffies g=225813 q=1973)
NMI backtrace for cpu 1
CPU: 1 PID: 21558 Comm: syz-executor5 Not tainted 4.18.0+ #203
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x48/0x88 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:162 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1340
  print_cpu_stall.cold.78+0x2fb/0x59c kernel/rcu/tree.c:1478
  check_cpu_stall kernel/rcu/tree.c:1550 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xd4a/0x15a0 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0xff0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x16d/0x6a0 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:793 [inline]
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168  
[inline]
RIP: 0010:_raw_spin_unlock_irq+0x56/0x70 kernel/locking/spinlock.c:192
Code: f1 87 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00  
75 1d 48 83 3d db 98 3d 01 00 74 11 fb 66 0f 1f 44 00 00 <65> ff 0d a3 c9  
4d 79 5b 5d c3 0f 0b e8 09 8f 07 fb eb dc 0f 1f 80
RSP: 0018:ffff88018eb8faf8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffff8801bff42be8 RCX: 0000000000000000
RDX: 1ffffffff0fe379f RSI: 0000000000000001 RDI: ffffffff87f1bcf8
RBP: ffff88018eb8fb00 R08: ffff88018d902000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000c6c5ef
R13: dffffc0000000000 R14: 0000000000c6c5ef R15: ffff8801bff42be8
  spin_unlock_irq include/linux/spinlock.h:379 [inline]
  mousedev_write+0x19d/0x840 drivers/input/mousedev.c:709
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0d92208c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0d922096d4 RCX: 0000000000457089
RDX: 00000000ffffffd1 RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7088 R14: 00000000004ca379 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
