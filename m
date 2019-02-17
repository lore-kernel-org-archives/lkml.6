Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC3221B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfBQIKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:10:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:32977 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfBQIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:10:05 -0500
Received: by mail-it1-f200.google.com with SMTP id a184so8530264itc.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 00:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qqo3bkfcYnAX6Tq2ze082iuN8SMETmXsZf0ZCnnAAS4=;
        b=NgYPIGp0JuGGKAmD5F0dyzzB19+9/S99755Wun2SY6I9tR8k49wdvtf08LDhILjt4e
         aVpCZ/aF38123nxSwfhVmV46+A+T3zhBFcBrlaDlfoRmUxvAxBughqtSb0Dvsx7B3vTJ
         AZMtgksB7gi2ZgXtU/+RdrDdpsNPdj8k5AQ/nMTvt36semCqYJJMPt+pp2HIZe+tJAsD
         ofT/mb7mFjlYzTXZJKpacd047fgz/Ea2yeH1WNIAA57eieYLGIlSFCijETMdFhF8mD5k
         XW7TZmDdtN/SX38SoapgauBAH2Tm0MPdknTjpR6gns2B6wh/F98IWWt7wWvYZER9WO+q
         iHnA==
X-Gm-Message-State: AHQUAuZgLStkY73bP1prmUCBtLI5HkC8joZ3bWoOSUrdcHasLXpB1VtB
        HDYeiWWVzpE4DdYdc7agrzO8zQb99HaHYURPtgYu14bZQdCv
X-Google-Smtp-Source: AHgI3IZOTS6/MfVu6UHeDItYZ+ydjLZ2KhJSUa4wxZKGT8x1gm1+jijx820lEBcQKwe1ZevJU2iZVwRVJUxeks/4EjD/8TNwUSKN
MIME-Version: 1.0
X-Received: by 2002:a24:55c7:: with SMTP id e190mr10512193itb.30.1550391003671;
 Sun, 17 Feb 2019 00:10:03 -0800 (PST)
Date:   Sun, 17 Feb 2019 00:10:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009780e05821289ab@google.com>
Subject: INFO: task hung in __x64_sys_io_destroy
From:   syzbot <syzbot+2eb72911e1b5139da5e2@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2ff0ff2c23f Merge tag 'armsoc-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124fc133400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
dashboard link: https://syzkaller.appspot.com/bug?extid=2eb72911e1b5139da5e2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2eb72911e1b5139da5e2@syzkaller.appspotmail.com

overlayfs: filesystem on './file0' not supported as upperdir
INFO: task syz-executor3:24161 blocked for more than 140 seconds.
       Not tainted 4.19.0+ #96
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D18616 24161  22624 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_timeout+0x1cc/0x260 kernel/time/timer.c:1780
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x427/0x8a0 kernel/sched/completion.c:136
  __do_sys_io_destroy fs/aio.c:1376 [inline]
  __se_sys_io_destroy fs/aio.c:1354 [inline]
  __x64_sys_io_destroy+0x495/0x580 fs/aio.c:1354
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007f8cc0ff0c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000cf
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f8cc0fd0000
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8cc0ff16d4
R13: 00000000004be6fe R14: 00000000004ce5a0 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1008:
  #0: 000000005c912532 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
2 locks held by rsyslogd/5596:
  #0: 0000000083898e10 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
  #1: 00000000c175b53b (&rq->lock){-.-.}, at: rq_lock  
kernel/sched/sched.h:1126 [inline]
  #1: 00000000c175b53b (&rq->lock){-.-.}, at: __schedule+0x236/0x21d0  
kernel/sched/core.c:3410
2 locks held by getty/5686:
  #0: 000000005c9a0b0b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009740bc82 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5687:
  #0: 000000006d18a19c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000cecadd40 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5688:
  #0: 00000000742bdf36 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000046d0d657 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5689:
  #0: 0000000093d6282e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000ce5627fc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5690:
  #0: 000000000f40a3d3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009d7531af (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5691:
  #0: 000000008658f0ae (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000bb83ce86 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/5692:
  #0: 0000000048965eed (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000009c97b8b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by kworker/0:2/5844:
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at:  
__write_once_size include/linux/compiler.h:209 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000008d501078 ((wq_completion)"rcu_gp"){+.+.}, at:  
process_one_work+0xb43/0x1c40 kernel/workqueue.c:2124
  #1: 00000000f07e85de ((work_completion)(&rew.rew_work)){+.+.}, at:  
process_one_work+0xb9a/0x1c40 kernel/workqueue.c:2128
2 locks held by syz-executor4/28918:
  #0: 0000000087b067ba (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77
  #1: 0000000011363f05 (rcu_state.exp_mutex){+.+.}, at: exp_funnel_lock  
kernel/rcu/tree_exp.h:296 [inline]
  #1: 0000000011363f05 (rcu_state.exp_mutex){+.+.}, at:  
_synchronize_rcu_expedited.constprop.58+0x7c7/0x9d0  
kernel/rcu/tree_exp.h:620

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1008 Comm: khungtaskd Not tainted 4.19.0+ #96
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb51/0x1060 kernel/hung_task.c:289
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.157  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 6186 Comm: kworker/0:3 Not tainted 4.19.0+ #96
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events iterate_cleanup_work
RIP: 0010:validate_chain kernel/locking/lockdep.c:2317 [inline]
RIP: 0010:__lock_acquire+0x83a/0x4c20 kernel/locking/lockdep.c:3341
Code: 9c 24 90 00 00 00 e8 75 55 ff ff 4c 8b 9c 24 90 00 00 00 85 c0 0f 84  
4d 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 70 <48> c1 ea 03 0f  
b6 04 02 84 c0 74 08 3c 03 0f 8e 7e 30 00 00 41 8b
RSP: 0018:ffff880184e6eff0 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 00000000e4319ebe RCX: ffff8801bd9289c0
RDX: ffff8801bd928a30 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff880184e6f378 R08: ffff8801bd928a30 R09: 0000000000000008
R10: 0000000000000050 R11: ffff8801bd928140 R12: 0000000000000000
R13: 00000000b68d41b6 R14: d5eb58489abee074 R15: ffff8801bd928a10
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdceac5edb8 CR3: 00000001bdf05000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  nf_conntrack_lock+0x75/0x170 net/netfilter/nf_conntrack_core.c:95
  get_next_corpse net/netfilter/nf_conntrack_core.c:1878 [inline]
  nf_ct_iterate_cleanup+0x255/0x5e0 net/netfilter/nf_conntrack_core.c:1912
  nf_ct_iterate_cleanup_net+0x237/0x2d0  
net/netfilter/nf_conntrack_core.c:1997
  iterate_cleanup_work+0x48/0xe0  
net/ipv6/netfilter/nf_nat_masquerade_ipv6.c:113
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
