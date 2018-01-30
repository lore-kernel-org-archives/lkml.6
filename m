Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeA3WRa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:17:30 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:40140 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeA3WR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:17:29 -0500
X-Google-Smtp-Source: AH8x227QqL1yp5fZo3VacQoEBucyOZFMXh/yXgL3WWl1P41f24hoFKObxeWw8VH9zj6ieof66D8JMA==
Date: Tue, 30 Jan 2018 14:17:25 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+08fe8c108447c50502fb24ece28b71ebd8bd4f4f@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 inet6_fill_ifinfo
Message-ID: <20180130221725.ctui7i3xtr7sna2o@gmail.com>
References: <94eb2c19de601695020560acc57d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c19de601695020560acc57d@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2017 at 11:54:00PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> BUG: unable to handle kernel NULL pointer dereference at 000000000000022c
> IP: inet6_fill_ifinfo+0x8e/0x2c0 net/ipv6/addrconf.c:5357
> PGD 1dffd8067 P4D 1dffd8067 PUD 1dc705067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 27870 Comm: syz-executor2 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:inet6_fill_ifinfo+0x8e/0x2c0 net/ipv6/addrconf.c:5357
> RSP: 0018:ffffc90000f53ae0 EFLAGS: 00010216
> RAX: 000000000000000a RBX: ffff88021433b300 RCX: ffffffff8224ba71
> RDX: 0000000000000818 RSI: ffffc9000457f000 RDI: 0000000000000000
> RBP: ffffc90000f53b18 R08: 0000000000000010 R09: ffff8801dac27ae0
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8801dfaf5c00 R14: ffff8801dac27ac0 R15: 0000000000000002
> FS:  00007f0fb6e3b700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000022c CR3: 0000000213560000 CR4: 00000000001406f0
> DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  inet6_dump_ifinfo+0x1ea/0x2d0 net/ipv6/addrconf.c:5411
>  netlink_dump+0x14e/0x360 net/netlink/af_netlink.c:2222
>  __netlink_dump_start+0x1bb/0x210 net/netlink/af_netlink.c:2319
>  netlink_dump_start include/linux/netlink.h:214 [inline]
>  rtnetlink_rcv_msg+0x44f/0x5d0 net/core/rtnetlink.c:4485
>  netlink_rcv_skb+0x92/0x160 net/netlink/af_netlink.c:2441
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4540
>  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
>  netlink_unicast+0x1d4/0x290 net/netlink/af_netlink.c:1334
>  netlink_sendmsg+0x345/0x470 net/netlink/af_netlink.c:1897
>  sock_sendmsg_nosec net/socket.c:636 [inline]
>  sock_sendmsg+0x51/0x70 net/socket.c:646
>  SYSC_sendto+0x17f/0x1d0 net/socket.c:1727
>  SyS_sendto+0x40/0x50 net/socket.c:1695
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f0fb6e3ac58 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452a39
> RDX: 0000000000000012 RSI: 0000000020919000 RDI: 0000000000000013
> RBP: 0000000000000553 R08: 0000000020000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f6068
> R13: 00000000ffffffff R14: 00007f0fb6e3b6d4 R15: 0000000000000000
> Code: b8 10 00 00 00 48 89 df e8 d0 b2 ee ff 48 85 c0 49 89 c6 0f 84 c5 01
> 00 00 e8 cf e8 06 ff b8 0a 00 00 00 4c 89 e7 66 41 89 46 10 <41> 0f b7 84 24
> 2c 02 00 00 66 41 89 46 12 41 8b 84 24 08 01 00
> RIP: inet6_fill_ifinfo+0x8e/0x2c0 net/ipv6/addrconf.c:5357 RSP:
> ffffc90000f53ae0
> CR2: 000000000000022c
> ---[ end trace bb449c11e1e11a3c ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
