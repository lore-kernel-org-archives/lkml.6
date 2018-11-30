Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE30C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAD620863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAD620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLAJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:42:53 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44880 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeLAJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:42:52 -0500
Received: by mail-io1-f72.google.com with SMTP id v8so6873694ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u0aFYpOdQvlJuyg9JUjIWCoZjrDlWLHTxTGlgsxXrFM=;
        b=ZEL4/ZUtOnqzQc+a4hAVJ3dSsJ9WuovSSsKA9BdJO7VUuW1mgKn8zKc9oxx+Bfjixg
         spAWupezGgX0HqEXAEoGRtwoAq3CPWe87MEayvaZdBgLPkbIS6WgjpyB+ICbRZEdC+OA
         1RP2PXkkRR3Qnl7A3KsN85pX3Op8IvE940JXw3qu1yx3Tr+pU7L/HAiQW0UiHKQP3wDY
         V/KeyWRx/dtDQgL8YAygORrkAMKzzxZ6GnhL9UumFIbFN8X8wWCWIuFfa9+8Kx/e2tqD
         JPj+6GK/gXUedroFg2dQCnigr8Zl7e6UPH6f2er+L2XeV6UbYh6sbTObp9BduxSmoDfQ
         /TaQ==
X-Gm-Message-State: AA+aEWYZy204ui6K939MfzG6MNaeBfV/4k7TO06G44iUpGSx2cH2F5KN
        Ozy10IsqKBf10yHGtlJK38C4TSRMEuaGEqV9UbqTpPqik5VG
X-Google-Smtp-Source: AFSGD/Wv+nRKd6D6CVhQsT79R05nWPXxWMolr3m2IApix9eEYmsCBPGDPccftNji682SUPMKM7MHnph9AoIAW3fW4TDj396zGqiJ
MIME-Version: 1.0
X-Received: by 2002:a24:4597:: with SMTP id c23mr521864itd.20.1543617123415;
 Fri, 30 Nov 2018 14:32:03 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:32:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f8499057be95e1d@google.com>
Subject: INFO: task hung in vhost_net_stop_vq
From:   syzbot <syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ef78e5ec9214 ia64: export node_distance function
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175c2415400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=d21e6e297322a900c128
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141db34d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ef293400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d21e6e297322a900c128@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
INFO: task syz-executor251:6230 blocked for more than 140 seconds.
       Not tainted 4.20.0-rc4+ #132
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor251 D21080  6230   6229 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x8cf/0x21d0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xaff/0x16f0 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  vhost_net_stop_vq+0x2d/0x120 drivers/vhost/net.c:1306
  vhost_net_stop drivers/vhost/net.c:1320 [inline]
  vhost_net_release+0x5b/0x1d0 drivers/vhost/net.c:1352
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0xf86/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  __do_sys_exit_group kernel/exit.c:981 [inline]
  __se_sys_exit_group kernel/exit.c:979 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445338
Code: 72 6e 20 69 73 20 25 64 0a 00 72 65 67 65 78 3a 20 65 6e 64 20 73 65  
61 72 63 68 2c 20 66 6f 75 6e 64 20 25 64 0a 00 23 25 33 <2e> 33 64 00 5f  
00 5f 2e 00 31 30 30 00 31 30 31 00 31 30 32 00 31
RSP: 002b:00007ffd228e1cb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000445338
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004cd650 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00007ffd228e1d00 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006e1320 R14: 000000000000000a R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1019:
  #0: 00000000da98dfa9 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4379
1 lock held by rsyslogd/6077:
  #0: 00000000a7881970 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/6199:
  #0: 0000000051a5383e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e292e313 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6200:
  #0: 000000000155ff5f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000001a79dc08 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6201:
  #0: 0000000050da3a04 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000000068a427 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6202:
  #0: 000000004bd50c6d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000007dde2138 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6203:
  #0: 0000000054dc4f51 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000087e81f0c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6204:
  #0: 000000004f97fe78 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009af2a5dd (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
2 locks held by getty/6205:
  #0: 00000000cb15d6f6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000392a1db6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1e80 drivers/tty/n_tty.c:2154
1 lock held by syz-executor251/6230:
  #0: 000000009c6ae67f (&vq->mutex){+.+.}, at: vhost_net_stop_vq+0x2d/0x120  
drivers/vhost/net.c:1306
1 lock held by vhost-6470/6471:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1019 Comm: khungtaskd Not tainted 4.20.0-rc4+ #132
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb51/0x1060 kernel/hung_task.c:289
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6471 Comm: vhost-6470 Not tainted 4.20.0-rc4+ #132
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vhost_umem_interval_tree_iter_first drivers/vhost/vhost.c:53  
[inline]
RIP: 0010:iotlb_access_ok+0x4a3/0x600 drivers/vhost/vhost.c:1207
Code: ac 8d fb 4d 39 ec 0f 82 a1 00 00 00 e8 96 ab 8d fb 48 8b 45 b8 4c 8b  
60 08 49 8d 7c 24 28 48 89 f8 48 c1 e8 03 42 80 3c 38 00 <0f> 85 ef 00 00  
00 4d 8b 74 24 28 4d 89 ec 48 8b 7d c8 4c 89 f6 e8
RSP: 0018:ffff8881c263f950 EFLAGS: 00000246
RAX: 1ffff1103af365b5 RBX: ffff8881d79b2d80 RCX: ffffffff85f1df5c
RDX: 0000000000000000 RSI: ffffffff85f1df6a RDI: ffff8881d79b2da8
RBP: ffff8881c263f9c0 R08: ffff8881c024c500 R09: ffffed1034e2406d
R10: ffff8881c263f9f8 R11: ffff8881a712036f R12: ffff8881d79b2d80
R13: 0000000000000000 R14: 0000000000000010 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001d753a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vq_iotlb_prefetch+0x10e/0x230 drivers/vhost/vhost.c:1240
  handle_rx+0x292/0x1df0 drivers/vhost/net.c:1093
  handle_rx_net+0x19/0x20 drivers/vhost/net.c:1234
  vhost_worker+0x2ac/0x4c0 drivers/vhost/vhost.c:365
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
