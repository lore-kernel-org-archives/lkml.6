Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EED5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C082175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C082175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeHMPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:17:10 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:40602 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeHMPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:17:09 -0400
Received: by mail-it0-f71.google.com with SMTP id p132-v6so9131781itp.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uBMacUy7CULG2sq4WYh41YKkokPOK4ZIHUm0wMYTVNM=;
        b=trUocJ1YNGIGTbs1my7mlAzUc7T+MJT9BhUs+zyTS8jzdV41BYuquICgrijZbBeWfu
         lKHCyz2K/8Q5H7I+xDhCykgyCmy2JuoBtFabsFhgiDKnruS0q630eFYHbEaLGxWDf3Pl
         NuHV98UQ47txE3kWdFww7Y4+rMnOCfWYaOAkkMFUmxAHBFbtNG62zSyTFGvPsZkTE83E
         lPgXzpCoi3GA5hpVyhbdAmRu5BpmPYUwcg6Wgw0OxVAZx7XO11m2PxVl0TjArvmeGMMe
         mbUUVQbAF4fXwqvfzfT8cSpEqrRWoakwJGBVufBZbYy6kIxgPoF2V7MvxpaBUApuibJT
         yEsA==
X-Gm-Message-State: AOUpUlHPRZbitIphKtH8sDmePIoEObG5aUd1uUjPP/RgoZl0MT1BIa7G
        714ZTrLAMXiEhJwUAmnBckkW+fwxVfcR8eN8Qzudy45THS9n
X-Google-Smtp-Source: AA+uWPzg63JEwt5KsShcftHY20VDu9LJBw7wPP4ZsaoTHw0mBNCZFhlo6lrh23s6RsO8gmU9nQMRi/ro/RSBIdDZb7Vj6THftSb4
MIME-Version: 1.0
X-Received: by 2002:a6b:6908:: with SMTP id e8-v6mr8365908ioc.124.1534163703704;
 Mon, 13 Aug 2018 05:35:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 05:35:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009637a6057350529b@google.com>
Subject: possible deadlock in flush_work (3)
From:   syzbot <syzbot+a8371264572a6872b8a3@syzkaller.appspotmail.com>
To:     christian.brauner@ubuntu.com, davem@davemloft.net,
        dsahern@gmail.com, fw@strlen.de, jbenc@redhat.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d6dd6431591b Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e800aa400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=a8371264572a6872b8a3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a8371264572a6872b8a3@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device bond0

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc8+ #185 Not tainted
------------------------------------------------------
syz-executor2/6421 is trying to acquire lock:
00000000209b4e4b ((wq_completion)bond_dev->name){+.+.}, at:  
start_flush_work kernel/workqueue.c:2888 [inline]
00000000209b4e4b ((wq_completion)bond_dev->name){+.+.}, at:  
flush_work+0x4b8/0x900 kernel/workqueue.c:2917

but task is already holding lock:
00000000f0f3d47a (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rtnl_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:757 [inline]
        __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:77
        bond_netdev_notify drivers/net/bonding/bond_main.c:1310 [inline]
        bond_netdev_notify_work+0x44/0xd0  
drivers/net/bonding/bond_main.c:1320
        process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
        worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
        kthread+0x345/0x410 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

-> #1 ((work_completion)(&(&nnw->work)->work)){+.+.}:
        process_one_work+0xc0b/0x1ba0 kernel/workqueue.c:2129
        worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
        kthread+0x345/0x410 kernel/kthread.c:246
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

-> #0 ((wq_completion)bond_dev->name){+.+.}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        start_flush_work kernel/workqueue.c:2889 [inline]
        flush_work+0x4dd/0x900 kernel/workqueue.c:2917
        __cancel_work_timer+0x4bd/0x830 kernel/workqueue.c:2989
        cancel_delayed_work_sync+0x1a/0x20 kernel/workqueue.c:3121
        bond_work_cancel_all drivers/net/bonding/bond_main.c:3318 [inline]
        bond_close+0x1b/0x130 drivers/net/bonding/bond_main.c:3381
        __dev_close_many+0x21e/0x380 net/core/dev.c:1476
        __dev_close net/core/dev.c:1488 [inline]
        __dev_change_flags+0x38d/0x9c0 net/core/dev.c:6989
        dev_change_flags+0x89/0x150 net/core/dev.c:7060
        dev_ifsioc+0x84f/0xb30 net/core/dev_ioctl.c:237
        dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:493
        sock_do_ioctl+0x1d3/0x3e0 net/socket.c:993
        sock_ioctl+0x30d/0x680 net/socket.c:1094
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:500 [inline]
        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
        __do_sys_ioctl fs/ioctl.c:708 [inline]
        __se_sys_ioctl fs/ioctl.c:706 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (wq_completion)bond_dev->name --> (work_completion)(&(&nnw->work)->work)  
--> rtnl_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(rtnl_mutex);
                                lock((work_completion)(&(&nnw->work)->work));
                                lock(rtnl_mutex);
   lock((wq_completion)bond_dev->name);

  *** DEADLOCK ***

1 lock held by syz-executor2/6421:
  #0: 00000000f0f3d47a (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77

stack backtrace:
CPU: 0 PID: 6421 Comm: syz-executor2 Not tainted 4.18.0-rc8+ #185
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.57+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  start_flush_work kernel/workqueue.c:2889 [inline]
  flush_work+0x4dd/0x900 kernel/workqueue.c:2917
  __cancel_work_timer+0x4bd/0x830 kernel/workqueue.c:2989
  cancel_delayed_work_sync+0x1a/0x20 kernel/workqueue.c:3121
  bond_work_cancel_all drivers/net/bonding/bond_main.c:3318 [inline]
  bond_close+0x1b/0x130 drivers/net/bonding/bond_main.c:3381
  __dev_close_many+0x21e/0x380 net/core/dev.c:1476
  __dev_close net/core/dev.c:1488 [inline]
  __dev_change_flags+0x38d/0x9c0 net/core/dev.c:6989
  dev_change_flags+0x89/0x150 net/core/dev.c:7060
  dev_ifsioc+0x84f/0xb30 net/core/dev_ioctl.c:237
  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:493
  sock_do_ioctl+0x1d3/0x3e0 net/socket.c:993
kernel msg: ebtables bug: please report to author: Wrong nr of counters
  sock_ioctl+0x30d/0x680 net/socket.c:1094
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fee7b2ccc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fee7b2cd6d4 RCX: 0000000000457089
RDX: 0000000020000140 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d19e0 R14: 00000000004c7454 R15: 0000000000000000
8021q: adding VLAN 0 to HW filter on device bond0
(unnamed net_device) (uninitialized): option miimon: invalid value  
(18446744073709551615)
(unnamed net_device) (uninitialized): option miimon: allowed values 0 -  
2147483647
(unnamed net_device) (uninitialized): option miimon: invalid value  
(18446744073709551615)
(unnamed net_device) (uninitialized): option miimon: allowed values 0 -  
2147483647
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
device bond0 left promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device bond0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
