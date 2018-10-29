Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B70C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF65B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF65B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeJ2S14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:27:56 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:53505 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbeJ2S14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:27:56 -0400
Received: by mail-it1-f200.google.com with SMTP id f79-v6so8937804ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8FT4cEW7VV4LHx2UPHr5/Cr6dAbs0BeFYMDeAiAND6w=;
        b=iwQpkEI3Rplm9m9HJH//ZcGEIUvyfNa2ffbrfhIT8jrHMdwJ4TE9aa4h3y+WcqlqAz
         EEn5qmn9fBDj4XfTbczQfb/ExY7+Vz40yNHJJgYWz8oSjQ1qn8iXqIzPSt7aH4e3FMNf
         Rk0RheSk/gNQX/G2oQ65eX9peC4dN5Swrpfn9QJbAx0FQ9Gr/o/i/hQB4yJDErkTamIK
         tf7Zpls5gh3nDe/bAy6OstM/QrNJy92goYq2Lk+0o5gpElM3NASdbpegcgbrGubACYZZ
         JyxV8vWifjangjBaDEUtNOMUrZcqIib5JIUC4CcjZR2zIKHE2N+hVTFV16pLE8gyu3QP
         O0+Q==
X-Gm-Message-State: AGRZ1gKNPMl19BVbTg7iUY4ZUh8N+ehm4RToX/qytB3G2JmElOApr2Il
        kV/Hm/a9jyByc3FxSlxQNruAFIxQhDAHsd/BC06qfg534u7a
X-Google-Smtp-Source: AJdET5cIRhGYmWRj27QRooa8Yg1iQyBQOnkfGpJxzFWBXmxDAO1j22/o9POdqE1IDUx1N5OI7/rZBJf9D2bgsKwvtblDWTPjIZop
MIME-Version: 1.0
X-Received: by 2002:a24:c3:: with SMTP id 186-v6mr8277600ita.39.1540806003408;
 Mon, 29 Oct 2018 02:40:03 -0700 (PDT)
Date:   Mon, 29 Oct 2018 02:40:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080601805795ada2e@google.com>
Subject: INFO: task hung in vivid_stop_generating_vid_cap
From:   syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1608ccf5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ddc97ab84fb1ff2a
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com

VMExit: intr_info=00000000 errcode=00000000 ilen=00000003
         reason=80000021 qualification=0000000000000003
IDTVectoring: info=00000000 errcode=00000000
TSC Offset = 0xfffffe6382838c64
EPT pointer = 0x00000001c4f5101e
INFO: task syz-executor4:791 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc8-next-20181019+ #99
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor4   D23272   791   5784 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3480
  schedule+0xfe/0x460 kernel/sched/core.c:3524
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
  kthread_stop+0x1a4/0x8f0 kernel/kthread.c:550
  vivid_stop_generating_vid_cap+0x2bc/0x93b  
drivers/media/platform/vivid/vivid-kthread-cap.c:919
  vid_cap_stop_streaming+0x8d/0xe0  
drivers/media/platform/vivid/vivid-vid-cap.c:259
  __vb2_queue_cancel+0x171/0xca0  
drivers/media/common/videobuf2/videobuf2-core.c:1668
  vb2_core_streamoff+0x60/0x140  
drivers/media/common/videobuf2/videobuf2-core.c:1804
  __vb2_cleanup_fileio+0x73/0x160  
drivers/media/common/videobuf2/videobuf2-core.c:2325
  vb2_core_queue_release+0x1e/0x80  
drivers/media/common/videobuf2/videobuf2-core.c:2052
  vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:672  
[inline]
  _vb2_fop_release+0x1d2/0x2b0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:843
  vb2_fop_release+0x77/0xc0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:857
  vivid_fop_release+0x18e/0x440 drivers/media/platform/vivid/vivid-core.c:474
  v4l2_release+0xfb/0x1a0 drivers/media/v4l2-core/v4l2-dev.c:448
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 4c 89 f6 48 89 c7 48 89 ca 48 89 4c 24 10 4c 89 54 24 08 e8 b1 a3 ff  
ff 48 8b 4c 24 10 41 c6 04 0f 00 4c 8b 7c 24 28 4c 8b 54 <24> 08 45 0f b6  
37 e9 db fc ff ff 0f 1f 40 00 41 80 f8 29 74 7f ba
RSP: 002b:00007ffebf8f0810 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000411021
RDX: 0000001b2ca20000 RSI: 0000000000730430 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000030c04255 R09: 0000000030c04259
R10: 00007ffebf8f0740 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000447 R15: 0000000000000004

Showing all locks held in the system:
1 lock held by khungtaskd/1008:
  #0: 00000000b994d395 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
1 lock held by rsyslogd/5554:
  #0: 0000000064483821 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5644:
  #0: 0000000088b7a22a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000003463365c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5645:
  #0: 00000000b07a05bf (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000accbc122 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5646:
  #0: 000000003b71eb89 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e3b18d3f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5647:
  #0: 00000000c8f2c425 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000646fd3b6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5648:
  #0: 000000004a4ae0cc (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000d9aa1576 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5649:
  #0: 000000001d616490 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000865e3bcf (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5650:
  #0: 00000000c8214d1d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000782baf35 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1008 Comm: khungtaskd Not tainted 4.19.0-rc8-next-20181019+ #99
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x1050 kernel/hung_task.c:265
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:57


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
