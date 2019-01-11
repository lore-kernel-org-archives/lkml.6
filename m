Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5036520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfAKKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:09:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34396 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:09:04 -0500
Received: by mail-io1-f72.google.com with SMTP id q16so12611479ios.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l2n+yYz7K/evhePJL4HC5vJ+g3gvXTB0wDhljkPyNs8=;
        b=UpaFJIEFE0xVX5gkddYnPVe4PyCc6P90l3uWX5moIyfcBtjSQO7BLhEedFi7jESvCQ
         /87pXhOGQP9PhuQ+PXJfVSCwtEZxsfGQJuP30aTfmOm9HlIHFC5OOsQ0DkYH0ioSLuvF
         8DCy+ey6fKKSDYMlDe38CGijrKEzD0Lm2++l2RXxXigu5XG87fnqx11uy9FJLtxo4CmH
         X/EuD2NrD8WzMmc6/wE89ju9NPM9BmdkAO7bJ1dijy6DXOSqmRMMtBbQgtFCVp+PmI75
         6c4pO6tqHX+YauE3/6jnKy3Lpyj5lZe5I2Dtr0SWupygL7/jHeaUq3Nb1CBaDVPuyE9e
         NONA==
X-Gm-Message-State: AJcUukeaCW1vfR+AP2YHSj0HTnyC/hlGXsnfmUwoHuPcMAHzTlUUx6Ct
        XMeBPoDW8qamqioCNSP641ooJh4/yTJgiYEUaN/1Y7aCduLR
X-Google-Smtp-Source: ALg8bN5ImjhTgDbeHKLfk+km6BUmoHvjS57CZtA1nVhEeIJQCzmZchR5P5377UaghygLexQGFw+59ZKbSF9ArGwxd6SV1NxPtXwU
MIME-Version: 1.0
X-Received: by 2002:a5d:9057:: with SMTP id v23mr1966597ioq.6.1547201343479;
 Fri, 11 Jan 2019 02:09:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 02:09:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007966c6057f2be2aa@google.com>
Subject: INFO: task hung in genl_family_rcv_msg
From:   syzbot <syzbot+3863f23ed69a006cfa87@syzkaller.appspotmail.com>
To:     avagin@virtuozzo.com, davem@davemloft.net, keescook@chromium.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1bdbe2274920 Merge tag 'vfio-v5.0-rc2' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100dc607400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
dashboard link: https://syzkaller.appspot.com/bug?extid=3863f23ed69a006cfa87
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3863f23ed69a006cfa87@syzkaller.appspotmail.com

INFO: task syz-executor5:13532 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc1+ #19
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor5   D25192 13532   8541 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x897/0x1e60 kernel/sched/core.c:3472
  schedule+0xfe/0x350 kernel/sched/core.c:3516
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3574
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xa3b/0x1670 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_family_rcv_msg+0xec6/0x11a0 net/netlink/genetlink.c:550
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: Bad RIP value.
RSP: 002b:00007f9aad580c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9aad5816d4
R13: 00000000004c52f9 R14: 00000000004d8d58 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1040:
  #0: 0000000007c9c70b (rcu_read_lock){....}, at:  
debug_show_all_locks+0xc6/0x41d kernel/locking/lockdep.c:4389
1 lock held by rsyslogd/8364:
  #0: 00000000ccbb3d9d (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1b3/0x1f0  
fs/file.c:795
2 locks held by getty/8486:
  #0: 00000000da7bf077 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000002a145a49 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8487:
  #0: 000000005a9ea624 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000481e0684 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8488:
  #0: 00000000372aa326 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000001edb2f7b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8489:
  #0: 0000000042afc2f1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000039788daa (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8490:
  #0: 000000009f514e08 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000e7f16282 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8491:
  #0: 0000000096cc811b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000090b784c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
2 locks held by getty/8492:
  #0: 00000000b1aedf80 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000001005e743 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x30a/0x1eb0 drivers/tty/n_tty.c:2154
4 locks held by syz-executor1/13529:
2 locks held by syz-executor5/13532:
  #0: 0000000060a34b7c (cb_lock){++++}, at: genl_rcv+0x1a/0x40  
net/netlink/genetlink.c:636
  #1: 000000003d185120 (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 000000003d185120 (genl_mutex){+.+.}, at:  
genl_family_rcv_msg+0xec6/0x11a0 net/netlink/genetlink.c:550

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1040 Comm: khungtaskd Not tainted 5.0.0-rc1+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
  watchdog+0xbbb/0x1170 kernel/hung_task.c:287
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.554  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 13529 Comm: syz-executor1 Not tainted 5.0.0-rc1+ #19
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:net_generic include/net/netns/generic.h:45 [inline]
RIP: 0010:tipc_sk_lookup+0xb79/0xf80 net/tipc/socket.c:2783
Code: d3 f7 88 be 60 02 00 00 48 c7 c7 c0 d3 f7 88 c6 05 fa dc ab 02 01 e8  
24 4e b8 f9 e9 cb f5 ff ff e8 1c cd d5 f9 e8 b7 0a bf f9 <31> ff 41 89 c5  
89 c6 e8 8b ce d5 f9 45 85 ed 0f 85 4b f6 ff ff e8
RSP: 0018:ffff88804d7b6aa8 EFLAGS: 00000292
RAX: 0000000000000001 RBX: ffff8880928504c0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff88804d7b6c78 R08: ffff88809263a240 R09: ffffed1015cc5b90
R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: 0000000000000045
R13: 0000000000000000 R14: ffff88804d7b6c50 R15: ffff88804d7b6f20
FS:  00007f86b0907700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c41f9bce6f CR3: 00000000a0ec2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tipc_nl_publ_dump+0x209/0xf40 net/tipc/socket.c:3591
  __tipc_nl_compat_dumpit.isra.0+0x261/0xa80 net/tipc/netlink_compat.c:196
  tipc_nl_compat_publ_dump net/tipc/netlink_compat.c:927 [inline]
  tipc_nl_compat_sk_dump+0x6ac/0xd40 net/tipc/netlink_compat.c:978
  __tipc_nl_compat_dumpit.isra.0+0x383/0xa80 net/tipc/netlink_compat.c:205
  tipc_nl_compat_dumpit+0x1f4/0x440 net/tipc/netlink_compat.c:270
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1152 [inline]
  tipc_nl_compat_recv+0xed9/0x18b0 net/tipc/netlink_compat.c:1215
  genl_family_rcv_msg+0x80d/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:626
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  genl_rcv+0x29/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f86b0906c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000007
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86b09076d4
R13: 00000000004cb688 R14: 00000000004d8ab8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
