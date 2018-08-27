Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F77C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4085E208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085E208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeH1AvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:51:23 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:41932 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeH1AvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:51:22 -0400
Received: by mail-it0-f70.google.com with SMTP id w132-v6so249177ita.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8sMf76rRljaK2VTZ0khPDderZR1wib+CtvzJFJDm66w=;
        b=rFSnGGtRCHYqIJJYDxyLQNIpfM19MT9bLYEbY/JnCVEwRYEZ+B9UODqgFCGaw4WlOb
         RXIOLUdRqmw9gdtVrmUs1RgM4oxhZsBrmbDcmRxCFBC3rom53Dy1FiJx9NjMFUSpIY3F
         vxTG5oO5P4UUnNk4p0/n0O44wWfPIcMTXBe7zeVUaoYeenonwf3my1xdBrhwiZfhTBZ8
         7Mq39WGXIIEHuRbSrZgTV/TtfZemytWa75EOeLAqAbbRmZe7BJgURluB/6l1OP7fBiyw
         0u20luNG3LjjkOBwrdvtM5x/QaR2RBKgO+gIvnw2GtHzCA/Qmmkguj0TBQy2xnSMVs5D
         6yvA==
X-Gm-Message-State: APzg51Dqno+ElpHZQxaQ77GjFFca1krxfoJ/OJLPsrZuY6YnlBj7zZlH
        CGiOzGufPdM4Gh6w9TwYQsiQOxFKklOjUYME8oL6asnkEhIA
X-Google-Smtp-Source: ANB0VdZB8cu6RiM77DwKHUDSz12S5GGmWJ8RkiUNRJUmLjba0F7a0p+E+VgzL1kB3SBT1T1v02RDsYrcA0VX6+TKPLJZLPXB2vBC
MIME-Version: 1.0
X-Received: by 2002:a5e:8505:: with SMTP id i5-v6mr166782ioj.133.1535403784069;
 Mon, 27 Aug 2018 14:03:04 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:03:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022ee160574710d48@google.com>
Subject: INFO: task hung in snd_seq_ioctl
From:   syzbot <syzbot+b059d98be99f7b009662@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11bf156a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
dashboard link: https://syzkaller.appspot.com/bug?extid=b059d98be99f7b009662
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b059d98be99f7b009662@syzkaller.appspotmail.com

overlayfs: unrecognized mount option "/dev/snapshot" or missing value
overlayfs: unrecognized mount option "/dev/snapshot" or missing value
INFO: task syz-executor0:9532 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D25944  9532   9598 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_ioctl+0x221/0x440 sound/core/seq/seq_clientmgr.c:2137
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f01a1a09c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f01a1a0a6d4 RCX: 0000000000457089
RDX: 00000000200000c0 RSI: 00000000c08c5332 RDI: 0000000000000004
RBP: 0000000000930320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cffa0 R14: 00000000004bf048 R15: 0000000000000004

Showing all locks held in the system:
1 lock held by khungtaskd/775:
  #0: 00000000e99a49ba (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
1 lock held by rsyslogd/4337:
2 locks held by getty/4428:
  #0: 0000000057084618 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009ad3c5cd (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4429:
  #0: 00000000a879cc50 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000cec89b30 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4430:
  #0: 000000002f98cec0 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000a64abc28 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4431:
  #0: 000000001aa7e298 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000fc7196ae (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4432:
  #0: 000000001245086c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000053d9216f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4433:
  #0: 000000009dbd25fa (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000002c7d4de5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4434:
  #0: 00000000b1fc4e5b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000410ff32a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by kworker/0:2/4760:
1 lock held by syz-executor0/9471:
1 lock held by syz-executor0/9532:
  #0: 000000001c41a5c8 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_ioctl+0x221/0x440 sound/core/seq/seq_clientmgr.c:2137

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 775 Comm: khungtaskd Not tainted 4.18.0-next-20180824+ #47
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
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.031  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 9471 Comm: syz-executor0 Not tainted 4.18.0-next-20180824+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:trace_lock_acquire include/trace/events/lock.h:13 [inline]
RIP: 0010:lock_acquire+0x3cc/0x4f0 kernel/locking/lockdep.c:3900
Code: ff 0d 38 3e a2 7e e9 e0 fd ff ff 65 ff 05 2c 3e a2 7e 48 ba 00 00 00  
00 00 fc ff df 48 8d 45 98 48 c1 e8 03 48 01 d0 c6 00 00 <48> 8b 15 e5 5c  
27 07 48 89 55 98 c6 00 f8 e8 21 b8 06 00 85 c0 74
RSP: 0018:ffff8801db107a38 EFLAGS: 00000082
RAX: ffffed003b620f58 RBX: 1ffff1003b620f4c RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff88018d882afc
RBP: ffff8801db107b28 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed003b6246de R11: ffff8801db1236f3 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f01a1a8e700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001b29e9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x5e/0x80 kernel/locking/spinlock.c:160
  __run_hrtimer kernel/time/hrtimer.c:1400 [inline]
  __hrtimer_run_queues+0x443/0xff0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x16d/0x6a0 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa1/0xc0  
kernel/locking/spinlock.c:184
Code: 68 bc f1 87 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c  
02 00 75 21 48 83 3d 2e be 3a 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00 00  
eb bb 0f 0b 0f 0b e8 cf 10 05 fb eb 97 e8 c8 10 05
RSP: 0018:ffff88013d4c77b0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 1ffff10031b10564
RDX: 1ffffffff0fe378d RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffff88013d4c77c0 R08: ffff88018d882b00 R09: 0000000000000006
R10: ffff88018d8822c0 R11: 0000000000000000 R12: ffffffff8861fc20
R13: ffff8801b3d27780 R14: 0000000000000282 R15: ffffffff8a34a020
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  snd_seq_client_use_ptr+0x9e/0x3f0 sound/core/seq/seq_clientmgr.c:178
  snd_seq_dispatch_event+0xbf/0x650 sound/core/seq/seq_clientmgr.c:845
  snd_seq_check_queue.part.4+0x139/0x360 sound/core/seq/seq_queue.c:275
  snd_seq_check_queue sound/core/seq/seq_queue.c:255 [inline]
  snd_seq_enqueue_event+0x346/0x4d0 sound/core/seq/seq_queue.c:343
  snd_seq_client_enqueue_event+0x2a5/0x510 sound/core/seq/seq_clientmgr.c:957
  snd_seq_write+0x3f1/0x8d0 sound/core/seq/seq_clientmgr.c:1074
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
RSP: 002b:00007f01a1a8dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f01a1a8e6d4 RCX: 0000000000457089
RDX: 00000000ffffff76 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d78a8 R14: 00000000004ca886 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
