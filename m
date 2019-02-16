Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6249222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfBPHBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:01:32 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:36651 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfBPHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:01:07 -0500
Received: by mail-it1-f200.google.com with SMTP id w15so20098429ita.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mk9GD/TOm69a0mjRXq46x3Jlf2w4hq3C0H9ayy01r4w=;
        b=WecLnlGyhkDQ7kSv1CADjX5Soy/aoATxvDHPdIHQKtAIN5kVvKW9u7xwUiTfREmqmc
         yQLgrnKnHdEJmTTJD5b4fHuw6ZVX7lBtmZNSMogtKM5kX+mxAzIBzaYmSbS+FS89X+zR
         rH3GYinLFndbLugvnxRxwEb1scW5KbHH0OfBz2pejfTMQ3u+FktZikUlynVRJanHoEO3
         51R0QlgzXmW6Y3gJusnxbQB5s4dWsIrKME6MqHp+K1pNzS7TFm3VoG/y4DmHCKiJVURv
         mOUFbQrRMe7lDS42hxdcrum9RMVhMMhOxSQlVVmVLAQ2K5gEFRf9m6qcWgERqzU06KDL
         R6dA==
X-Gm-Message-State: AHQUAuaqQ8rb5pShOKATbhGweficVDT8txC+zfOY2d9xJ8oB4ksw/E6I
        2LMRHTEfTOBZMa2ni4QoySY22Zv4fIsiemay51RhChZhDcs+
X-Google-Smtp-Source: AHgI3IZkPrG1rSGdvdjJLwKvrHNRTMFhZV/VZVbpJXbbn4hwuHjFS1K6qQMKB8377JBIw+A0fVLMwTCmcKfT0up7fijX8W8lmxhC
MIME-Version: 1.0
X-Received: by 2002:a05:660c:702:: with SMTP id l2mr7857454itk.38.1550300465828;
 Fri, 15 Feb 2019 23:01:05 -0800 (PST)
Date:   Fri, 15 Feb 2019 23:01:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f9c780581fd7417@google.com>
Subject: INFO: task hung in __flush_work
From:   syzbot <syzbot+aa0b64a57e300a1c6bcc@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a565c7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d41c8529d7e7362
dashboard link: https://syzkaller.appspot.com/bug?extid=aa0b64a57e300a1c6bcc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6629b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1222d29b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aa0b64a57e300a1c6bcc@syzkaller.appspotmail.com

TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
INFO: task syz-executor925:7871 blocked for more than 140 seconds.
       Not tainted 4.20.0-rc7+ #360
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor925 D19912  7871   7870 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
  __flush_work+0x59c/0x9b0 kernel/workqueue.c:2917
  __cancel_work_timer+0x4ba/0x820 kernel/workqueue.c:3004
  cancel_delayed_work_sync+0x1a/0x20 kernel/workqueue.c:3136
  tls_sw_free_resources_tx+0x1df/0xcf0 net/tls/tls_sw.c:1795
  tls_sk_proto_close+0x602/0x750 net/tls/tls_main.c:280
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x401010
Code: 01 f0 ff ff 0f 83 b0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d bd 16 2d 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 84 0a 00 00 c3 48 83 ec 08 e8 3a 01 00 00
RSP: 002b:00007ffec7856f48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000401010
RDX: 00000000e0ffffff RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f20
R13: 0000000000401fb0 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by kworker/0:0/5:
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:218 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000006d11dec0 ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 00000000ccfe6c9a  
((work_completion)(&(&sw_ctx_tx->tx_work.work)->work)){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128
1 lock held by khungtaskd/1014:
  #0: 00000000153ed952 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
1 lock held by rsyslogd/7757:
  #0: 0000000034b64696 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/7847:
  #0: 00000000d063ffb7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000045d4d183 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7848:
  #0: 00000000dda11696 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000a02eb135 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7849:
  #0: 0000000013f4e4e1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000f6bb4c99 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7850:
  #0: 00000000daef1117 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000229b8dfc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7851:
  #0: 000000005093d448 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000bca705ed (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7852:
  #0: 000000000f124289 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000a9adbb34 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/7853:
  #0: 0000000027476b58 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000007cc578ce (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by syz-executor925/7871:
  #0: 00000000997b6df5 (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 00000000997b6df5 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x8b/0x250 net/socket.c:578
  #1: 00000000af711cb5 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1502 [inline]
  #1: 00000000af711cb5 (sk_lock-AF_INET6){+.+.}, at:  
wait_on_pending_writer+0x27c/0x5b0 net/tls/tls_main.c:89

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1014 Comm: khungtaskd Not tainted 4.20.0-rc7+ #360
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1c2/0x22c lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb51/0x1060 kernel/hung_task.c:289
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:57


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
