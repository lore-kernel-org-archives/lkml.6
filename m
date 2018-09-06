Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FDE20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FDE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeIFVfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:35:25 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:41322 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeIFVfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:35:25 -0400
Received: by mail-it0-f71.google.com with SMTP id w132-v6so13045542ita.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i5SPC8qS98PeCJ8gi54OY8xyETlxjJaQDw7sIuuNgg8=;
        b=LEWbVZEDCrZo+mgKgjH1fWQ5l7w94sMmhn32xA6PtlGhC1m5zyjKREPPEsgVTywXep
         IQ2NoE+UtZPWnRbdKl+qMETtFXwu0c9NpGbycuEyxz3xot/bbPYM6PdK6qomzr1l+m2P
         UCquuaZBNtnv3kNa7jG2U+U6DuFA4ABx0Y52O8vpG1BIF1cmYMT9rDzc6V31tRylM9b4
         VDPXBzkN8mZF+WHP800JthwNylQkcMh0jb9JhkyuRwPhEj64wbBf2YXwESei7NGP60Uv
         70vTNJwNKkX0f//aA3t+by4sgGmlGf1vQ32wpBWNlT40I/QsiqQ6qkaY8F70ViwvTIaF
         ZYrQ==
X-Gm-Message-State: APzg51DDQu8PWIFtP/C6JCLqGvkoacBZIPclceIy7zqWSYTEDTepNS2+
        5u5nXvpoIANvGB5t7Qlq4VdzOiPpxDl5j3YnUlcuTl1XsKfb
X-Google-Smtp-Source: ANB0VdaILy9lZl34dXvxf8swCN5w4/QGtkr1mD5B3L1guXPJI7mHqCJbBbDKoREV+njCfz3DWPOLGcRhUlYTfs3RVy1nW3l94kQu
MIME-Version: 1.0
X-Received: by 2002:a6b:d210:: with SMTP id q16-v6mr2813269iob.137.1536253142216;
 Thu, 06 Sep 2018 09:59:02 -0700 (PDT)
Date:   Thu, 06 Sep 2018 09:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3c499057536ce86@google.com>
Subject: INFO: task hung in usb_bulk_msg
From:   syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, joe@perches.com, johan@kernel.org,
        kai.heng.feng@canonical.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143a64d1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9564cd177daf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com

INFO: task syz-executor3:10234 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc2+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D23224 10234   7516 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion_timeout+0x45f/0x960 kernel/sched/completion.c:155
  usb_start_wait_urb+0x18b/0x360 drivers/usb/core/message.c:62
  usb_bulk_msg+0x22e/0x550 drivers/usb/core/message.c:253
  proc_bulk+0x590/0xaa0 drivers/usb/core/devio.c:1193
  usbdev_do_ioctl+0x19fc/0x3b30 drivers/usb/core/devio.c:2401
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2551
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
Code: Bad RIP value.
RSP: 002b:00007f408a01ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f408a01f6d4 RCX: 0000000000457099
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cebc0 R14: 00000000004c503e R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/792:
  #0: 00000000935370f1 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
1 lock held by rsyslogd/4545:
2 locks held by getty/4666:
  #0: 000000001c78bb1f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000fd476690 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4667:
  #0: 000000003636bd05 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000080b0e131 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4668:
  #0: 00000000784da20e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000f35d11ec (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4669:
  #0: 0000000050e62864 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000013be2de2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4670:
  #0: 0000000076405ad8 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000006c5d932d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4671:
  #0: 00000000a94de6ea (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000004906f867 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4672:
  #0: 00000000664d51ab (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000cdc5bd8f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 792 Comm: khungtaskd Not tainted 4.19.0-rc2+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x48/0x88 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x1040 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc2+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wrmsr arch/x86/include/asm/msr.h:105 [inline]
RIP: 0010:native_apic_msr_eoi_write+0xf/0x20 arch/x86/include/asm/apic.h:214
Code: ff ff e9 13 ff ff ff e8 9f 8f 87 00 e9 de fe ff ff e8 35 58 13 00 90  
90 90 90 90 55 31 c0 b9 0b 08 00 00 89 c2 48 89 e5 0f 30 <5d> c3 0f 1f 44  
00 00 66 2e 0f 1f 84 00 00 00 00 00 c3 0f 1f 44 00
RSP: 0018:ffff8801db107e90 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 1ffff1003b620fd4 RCX: 000000000000080b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000b0
RBP: ffff8801db107e90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff87f2d300
R13: ffff8801db107fc0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001b7c96000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  apic_eoi arch/x86/include/asm/apic.h:402 [inline]
  ack_APIC_irq arch/x86/include/asm/apic.h:448 [inline]
  smp_reschedule_interrupt+0xe4/0x5e0 arch/x86/kernel/smp.c:262
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:888
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
Code: c7 48 89 45 d8 e8 fa fc e4 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8  
e9 fc e4 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffff8801d9f27c30 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
RAX: dffffc0000000000 RBX: 1ffff1003b3e4f8a RCX: 0000000000000000
RDX: 1ffffffff10237c8 RSI: 0000000000000001 RDI: ffffffff8811be40
RBP: ffff8801d9f27c30 R08: ffff8801d9f1a380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801d9f27cf0 R14: 0000000000000001 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x580 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:271
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
