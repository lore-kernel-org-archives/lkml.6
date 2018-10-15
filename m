Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A1C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27FA2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27FA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeJOPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:50:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42778 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeJOPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:50:13 -0400
Received: by mail-io1-f71.google.com with SMTP id m7-v6so18098917iop.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1plPgQSz5GHl1h07r+ETy93hqxBs5pa8nexOwXF2bAo=;
        b=WWP/jJh/6PqJu7LGyqfYSg4yCaTbASkVsdonmSk8uyEBqfdHC2a4ulxvdH+z5a6geB
         b6042QNh8iacdWufSK0JyFmBzk6GNUil7M9TOnXeAoXD1XW9ASgj0cXDZCQZhBVgxgn7
         h7IDHox/30Sd4ogJpqHjSwhW4SZx9Ycb9uUwYdW+TVF7TIX/HLLLuttoapLmVq7Pei0t
         ISVw8XE0JeyxU2+h0kfbhaAbIykzk7zdd8e2pTtHPcAhpw4h4+9sW5NFqMLVObOAsHtq
         yBSmO2M5ijH7/JbznU1k8CN7rnnFM7GmwS2VOZds6/53EfR6e8yQesSYj3chLhUBA+9R
         Opyg==
X-Gm-Message-State: ABuFfohVHUUD9f4Wk3f0jXJog2Jg2Bj/7dC+RD2hpQROqvnR9bfuoJb+
        XQXm0eys8+dFo3QofHz3OQ5nMHHj/1wEt8m/XlSh3Wvxkf7L
X-Google-Smtp-Source: ACcGV61Nw03KQ0JjXk6KJEV9pX1e8LRQdnI6IB0DMeTZCM+MkMAXJ6zKpJ5/IbhB+NEvdhTswipnzECGZ1sVhtiqKG7JHCNLdDhF
MIME-Version: 1.0
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr12478802iod.3.1539590762491;
 Mon, 15 Oct 2018 01:06:02 -0700 (PDT)
Date:   Mon, 15 Oct 2018 01:06:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f82d805783fe8ce@google.com>
Subject: INFO: task hung in genl_rcv_msg
From:   syzbot <syzbot+c3b90a95b2d6bd4f29b1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bab5c80b2110 Merge tag 'armsoc-fixes-4.19' of git://git.ke..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15462c41400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=c3b90a95b2d6bd4f29b1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135e41a5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c3b90a95b2d6bd4f29b1@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
INFO: task syz-executor0:6925 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #140
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D24952  6925   5376 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_rcv_msg+0x13a/0x168 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007f805f83dc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f805f83e6d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff
INFO: task syz-executor5:6923 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #140
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor5   D24952  6923   5384 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_rcv_msg+0x13a/0x168 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007f00193a4c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f00193a56d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff
INFO: task syz-executor1:6930 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #140
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D24952  6930   5377 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_rcv_msg+0x13a/0x168 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007fc5ec984c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc5ec9856d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff
INFO: task syz-executor2:6940 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #140
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor2   D24952  6940   5382 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_rcv_msg+0x13a/0x168 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007f988ec35c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f988ec366d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff
INFO: task syz-executor3:6942 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc7+ #140
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D23080  6942   5380 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0xbe7/0x1700 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  genl_lock net/netlink/genetlink.c:33 [inline]
  genl_rcv_msg+0x13a/0x168 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: Bad RIP value.
RSP: 002b:00007f8ef4a35c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8ef4a366d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/982:
  #0: 000000000bcea75c (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4435
1 lock held by rsyslogd/5240:
  #0: 00000000baacc0ba (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5329:
  #0: 00000000da399000 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000078f6766 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5330:
  #0: 000000006658d2ab (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000a4e55645 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5331:
  #0: 00000000f3b48bf4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e44b615e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5332:
  #0: 00000000005368f9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000717606d2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5333:
  #0: 000000008f6095e9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000cbfa8653 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5334:
  #0: 00000000a7e4496b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e3981645 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5335:
  #0: 000000009ff3ef1e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000004c38513e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
4 locks held by syz-executor4/6919:
2 locks held by syz-executor0/6925:
  #0: 00000000455a9b7b (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624
2 locks held by syz-executor5/6923:
  #0: 00000000455a9b7b (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624
2 locks held by syz-executor1/6930:
  #0: 00000000455a9b7b (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624
2 locks held by syz-executor2/6940:
  #0: 00000000455a9b7b (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624
2 locks held by syz-executor3/6942:
  #0: 00000000455a9b7b (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 00000000f78598ee (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 982 Comm: khungtaskd Not tainted 4.19.0-rc7+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb3e/0x1050 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.662  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 6919 Comm: syz-executor4 Not tainted 4.19.0-rc7+ #140
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__rhashtable_lookup include/linux/rhashtable.h:481 [inline]
RIP: 0010:rhashtable_lookup include/linux/rhashtable.h:516 [inline]
RIP: 0010:rhashtable_lookup_fast include/linux/rhashtable.h:542 [inline]
RIP: 0010:tipc_sk_lookup+0x99e/0xff0 net/tipc/socket.c:2698
Code: 85 2b 06 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 03 4b  
06 fa 0f b6 05 9c 06 76 02 31 ff 89 c6 88 85 d0 fd ff ff <e8> bd 4b 06 fa  
0f b6 85 d0 fd ff ff 84 c0 0f 85 74 fc ff ff e8 d9
RSP: 0018:ffff8801cecde8c8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8801cecdeb18 RCX: ffffffff87788ad8
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8801cecdeb40 R08: ffff8801ce884040 R09: 1ffffffff1273965
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: ffff8801c89b2a00
R13: dffffc0000000000 R14: 0000000000000092 R15: 0000000000000001
FS:  00007fc2cfef9700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001bc63a000 CR4: 00000000001406f0
Call Trace:
  tipc_nl_publ_dump+0x22d/0xf9c net/tipc/socket.c:3502
  __tipc_nl_compat_dumpit.isra.11+0x25d/0xb50 net/tipc/netlink_compat.c:196
  tipc_nl_compat_publ_dump net/tipc/netlink_compat.c:925 [inline]
  tipc_nl_compat_sk_dump+0x88e/0xc50 net/tipc/netlink_compat.c:973
  __tipc_nl_compat_dumpit.isra.11+0x389/0xb50 net/tipc/netlink_compat.c:205
  tipc_nl_compat_dumpit+0x1f4/0x440 net/tipc/netlink_compat.c:270
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1147 [inline]
  tipc_nl_compat_recv+0x12b3/0x19a0 net/tipc/netlink_compat.c:1210
  genl_family_rcv_msg+0x8a9/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc2cfef8c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000006
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc2cfef96d4
R13: 00000000004c387d R14: 00000000004d56d0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
