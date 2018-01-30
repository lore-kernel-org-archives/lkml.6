Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeA3WCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:02:48 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:40182 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeA3WCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:02:41 -0500
X-Google-Smtp-Source: AH8x224yWEvf94io72HcaPKvYFFiICl08K9B3RAvKC12BGyI6Z9pGRsg2YhhJrKHCX2J906fm1dFYg==
Date: Tue, 30 Jan 2018 14:02:38 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+6a425d205c027ee88b47080736e77c7816897f57@syzkaller.appspotmail.com>
Cc: adobriyan@gmail.com, davem@davemloft.net, dsa@cumulusnetworks.com,
        elena.reshetova@intel.com, fw@strlen.de, idosch@mellanox.com,
        ihrachys@redhat.com, ishkamiel@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, sowmini.varadhan@oracle.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 neigh_fill_info
Message-ID: <20180130220238.7xdwtyh27a5uywjw@gmail.com>
References: <001a1149750af26eec0560b5ce78@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1149750af26eec0560b5ce78@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 10:41:00AM -0800, syzbot wrote:
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
> netlink: 3 bytes leftover after parsing attributes in process
> `syz-executor5'.
> netlink: 3 bytes leftover after parsing attributes in process
> `syz-executor5'.
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> sock: process `syz-executor4' is using obsolete getsockopt SO_BSDCOMPAT
> IP: neigh_fill_info+0xe6/0x460 net/core/neighbour.c:2218
> PGD 1dece0067 P4D 1dece0067 PUD 1dc5b9067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 25561 Comm: syz-executor5 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:neigh_fill_info+0xe6/0x460 net/core/neighbour.c:2218
> RSP: 0018:ffffc90000eaf9d0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff88021568b000 RCX: ffff88021568b288
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff880215753800
> RBP: ffffc90000eafa40 R08: 000000000000000c R09: ffff88020ff500b4
> R10: ffffc90000eaf9d8 R11: 0000000000000002 R12: ffff88020ff50098
> R13: 0000000093fffff7 R14: 000000000000001c R15: ffff880215753800
> FS:  00007f91a7086700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000001df751000 CR4: 00000000001426f0
> DR0: 0000000020000008 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000030602
> Call Trace:
>  neigh_dump_table net/core/neighbour.c:2350 [inline]
>  neigh_dump_info+0x532/0x9d0 net/core/neighbour.c:2438
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
>  sock_write_iter+0xa4/0x100 net/socket.c:915
>  call_write_iter include/linux/fs.h:1776 [inline]
>  new_sync_write fs/read_write.c:469 [inline]
>  __vfs_write+0x15b/0x1e0 fs/read_write.c:482
>  vfs_write+0xf0/0x230 fs/read_write.c:544
>  SYSC_write fs/read_write.c:589 [inline]
>  SyS_write+0x57/0xd0 fs/read_write.c:581
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a39
> RSP: 002b:00007f91a7085c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f91a7086700 RCX: 0000000000452a39
> RDX: 000000000000001f RSI: 000000002083a000 RDI: 0000000000000017
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
> R13: 0000000000a6f7ff R14: 00007f91a70869c0 R15: 0000000000000000
> Code: 14 01 00 00 41 88 44 24 1a 0f b6 83 16 01 00 00 41 88 44 24 1b 48 8b
> 83 80 02 00 00 8b 80 08 01 00 00 41 89 44 24 14 48 8b 43 08 <8b> 50 08 e8 c2
> e3 68 ff 85 c0 0f 85 5d 02 00 00 4c 8d 73 28 e8
> RIP: neigh_fill_info+0xe6/0x460 net/core/neighbour.c:2218 RSP:
> ffffc90000eaf9d0
> CR2: 0000000000000008
> ---[ end trace fd0910621fa1f590 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
