Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C6C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ECD21756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha+/wjLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ECD21756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHMSW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:22:29 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35808 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeHMSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:22:29 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so14659383itf.0;
        Mon, 13 Aug 2018 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nMnNjL7680fVUHJeUlb6P+ksXzTUU6kWH4UzxK+Myp0=;
        b=ha+/wjLlEONsrypjF/cJba8gfzw2uEql7aBRns6Kz0LwYkdT+ZHGLQcjJqdbvVS0Oa
         wgv2EJpzCbajuv4k5uTYm3retW08g0RSAv75kH76amdmQ04+j7e3RdOkVjeyTK3xrefl
         N0StOrCYk77Nxgb+/jCOvzR3cuszLAT3d2QvbMI1XLVuBQOV9LuLB6D15pMYvP9pscgW
         2rWUMAEozq6ih2pGvLroZZC/qqG3cN/9qX6RxFpCLWw210Q7QuP/jWnMuKvF0SmaENyM
         ODmoSoPEL4BBJPAXHREA6bqvZLtwbGRPNEMoMs/JKnE6u/sILouJwHUCFSigy3l6n7Y6
         2aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nMnNjL7680fVUHJeUlb6P+ksXzTUU6kWH4UzxK+Myp0=;
        b=oeDq5qvK7KbWMyAgsp5aLNTRE2fA3lHV95gXk3gcndWirawITGT997G/exmeuU1Qzy
         xtzEB3ax4jqltdIWbhhR7OIpHSKspruky9fmAbDYkY6/QUKPnVDXQFWuS8aFaXX+sev/
         ZNss6/tP+WghFSVZTueEg7v47UmN4XM+rBd5Uj8hsofNGTOafT+PI9wLUx54vgVWblSM
         ssne69ePSIiKhHCkaMpTjV0/aloYHqL9pQWHxy4tZl5mp5JqhdYCnQM3JWEHJ//sIuaV
         jbGWArbClpyDUvuhYXCzinX7kvhcyOVCxnIUPz79ka6YZAniZgM0pFCwxeRBw7uhP4bd
         KuNw==
X-Gm-Message-State: AOUpUlEnHhlvdPmxXt3yCqEHcBnwPPwPh5xlaK1vPJRVjcb7EN/oF0Bj
        5HOU1d3kMYsvsRY7nb6ZwpobVqTp2HUTs4AIkdw=
X-Google-Smtp-Source: AA+uWPyt2p0c8i3+JKdjNXq7C1mHZ/XvJPVdxnnxiablUXcOb94LoJPTF/+Fd3krGAY/zEIuxUz4cA/fc14Y8yrxKlI=
X-Received: by 2002:a02:c00b:: with SMTP id y11-v6mr15061202jai.32.1534174783802;
 Mon, 13 Aug 2018 08:39:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d192:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 08:39:43
 -0700 (PDT)
In-Reply-To: <0000000000009637a6057350529b@google.com>
References: <0000000000009637a6057350529b@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 13 Aug 2018 23:39:43 +0800
Message-ID: <CADvbK_dbHepqO4Op0H96PZq8Q17qF5PoHijiqV-nqduaPNE0jw@mail.gmail.com>
Subject: Re: possible deadlock in flush_work (3)
To:     syzbot <syzbot+a8371264572a6872b8a3@syzkaller.appspotmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        davem <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Moni Shoua <monis@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 8:35 PM, syzbot
<syzbot+a8371264572a6872b8a3@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d6dd6431591b Merge branch 'fixes' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e800aa400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
> dashboard link: https://syzkaller.appspot.com/bug?extid=a8371264572a6872b8a3
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a8371264572a6872b8a3@syzkaller.appspotmail.com
>
> 8021q: adding VLAN 0 to HW filter on device bond0
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.18.0-rc8+ #185 Not tainted
> ------------------------------------------------------
> syz-executor2/6421 is trying to acquire lock:
> 00000000209b4e4b ((wq_completion)bond_dev->name){+.+.}, at: start_flush_work
> kernel/workqueue.c:2888 [inline]
> 00000000209b4e4b ((wq_completion)bond_dev->name){+.+.}, at:
> flush_work+0x4b8/0x900 kernel/workqueue.c:2917
>
> but task is already holding lock:
> 00000000f0f3d47a (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:77
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (rtnl_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:757 [inline]
>        __mutex_lock+0x176/0x1820 kernel/locking/mutex.c:894
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:909
>        rtnl_lock+0x17/0x20 net/core/rtnetlink.c:77
>        bond_netdev_notify drivers/net/bonding/bond_main.c:1310 [inline]
>        bond_netdev_notify_work+0x44/0xd0
> drivers/net/bonding/bond_main.c:1320
>        process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
>        worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>        kthread+0x345/0x410 kernel/kthread.c:246
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> -> #1 ((work_completion)(&(&nnw->work)->work)){+.+.}:
>        process_one_work+0xc0b/0x1ba0 kernel/workqueue.c:2129
>        worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>        kthread+0x345/0x410 kernel/kthread.c:246
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> -> #0 ((wq_completion)bond_dev->name){+.+.}:
>        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>        start_flush_work kernel/workqueue.c:2889 [inline]
>        flush_work+0x4dd/0x900 kernel/workqueue.c:2917
>        __cancel_work_timer+0x4bd/0x830 kernel/workqueue.c:2989
>        cancel_delayed_work_sync+0x1a/0x20 kernel/workqueue.c:3121
>        bond_work_cancel_all drivers/net/bonding/bond_main.c:3318 [inline]
>        bond_close+0x1b/0x130 drivers/net/bonding/bond_main.c:3381
>        __dev_close_many+0x21e/0x380 net/core/dev.c:1476
>        __dev_close net/core/dev.c:1488 [inline]
>        __dev_change_flags+0x38d/0x9c0 net/core/dev.c:6989
>        dev_change_flags+0x89/0x150 net/core/dev.c:7060
>        dev_ifsioc+0x84f/0xb30 net/core/dev_ioctl.c:237
>        dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:493
>        sock_do_ioctl+0x1d3/0x3e0 net/socket.c:993
>        sock_ioctl+0x30d/0x680 net/socket.c:1094
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:500 [inline]
>        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
>        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>        __do_sys_ioctl fs/ioctl.c:708 [inline]
>        __se_sys_ioctl fs/ioctl.c:706 [inline]
>        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>   (wq_completion)bond_dev->name --> (work_completion)(&(&nnw->work)->work)
> --> rtnl_mutex
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock((work_completion)(&(&nnw->work)->work));
>                                lock(rtnl_mutex);
>   lock((wq_completion)bond_dev->name);
nnw->work is queuing up into bond->wq, so it seems bond_netdev_notify()
should have used rtnl_trylock() instead of rtnl_lock(), as do other
delayed_work handlers in bond->wq.

>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor2/6421:
>  #0: 00000000f0f3d47a (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:77
>
> stack backtrace:
> CPU: 0 PID: 6421 Comm: syz-executor2 Not tainted 4.18.0-rc8+ #185
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.57+0x1bd/0x27d
> kernel/locking/lockdep.c:1227
>  check_prev_add kernel/locking/lockdep.c:1867 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
>  validate_chain kernel/locking/lockdep.c:2421 [inline]
>  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
>  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>  start_flush_work kernel/workqueue.c:2889 [inline]
>  flush_work+0x4dd/0x900 kernel/workqueue.c:2917
>  __cancel_work_timer+0x4bd/0x830 kernel/workqueue.c:2989
>  cancel_delayed_work_sync+0x1a/0x20 kernel/workqueue.c:3121
>  bond_work_cancel_all drivers/net/bonding/bond_main.c:3318 [inline]
>  bond_close+0x1b/0x130 drivers/net/bonding/bond_main.c:3381
>  __dev_close_many+0x21e/0x380 net/core/dev.c:1476
>  __dev_close net/core/dev.c:1488 [inline]
>  __dev_change_flags+0x38d/0x9c0 net/core/dev.c:6989
>  dev_change_flags+0x89/0x150 net/core/dev.c:7060
>  dev_ifsioc+0x84f/0xb30 net/core/dev_ioctl.c:237
>  dev_ioctl+0x1b5/0xcc0 net/core/dev_ioctl.c:493
>  sock_do_ioctl+0x1d3/0x3e0 net/socket.c:993
> kernel msg: ebtables bug: please report to author: Wrong nr of counters
>  sock_ioctl+0x30d/0x680 net/socket.c:1094
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457089
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fee7b2ccc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fee7b2cd6d4 RCX: 0000000000457089
> RDX: 0000000020000140 RSI: 0000000000008914 RDI: 0000000000000004
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004d19e0 R14: 00000000004c7454 R15: 0000000000000000
> 8021q: adding VLAN 0 to HW filter on device bond0
> (unnamed net_device) (uninitialized): option miimon: invalid value
> (18446744073709551615)
> (unnamed net_device) (uninitialized): option miimon: allowed values 0 -
> 2147483647
> (unnamed net_device) (uninitialized): option miimon: invalid value
> (18446744073709551615)
> (unnamed net_device) (uninitialized): option miimon: allowed values 0 -
> 2147483647
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> device bond0 left promiscuous mode
> IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
> 8021q: adding VLAN 0 to HW filter on device bond0
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
