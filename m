Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeA3WAU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:00:20 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:52143 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753738AbeA3WAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:00:18 -0500
X-Google-Smtp-Source: AH8x224vn4s05WmtXcBjDy5ydtpp6bWyZwmoFivlVE4H3Y2Q7SzzYF+VNSrI6Pxl/69kkQVd2b6dtA==
Date: Tue, 30 Jan 2018 14:00:14 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+cfb122c1b99a24b6336a748a8adf89afc80902fc@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 addrconf_notify
Message-ID: <20180130220014.qbbstyxkab2crtn5@gmail.com>
References: <001a113fae289562e00560b6be13@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113fae289562e00560b6be13@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 11:48:01AM -0800, syzbot wrote:
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
> ALSA: seq fatal error: cannot create timer (-22)
> device syz2 entered promiscuous mode
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: addrconf_permanent_addr net/ipv6/addrconf.c:3351 [inline]
> IP: addrconf_notify+0x7df/0xd50 net/ipv6/addrconf.c:3422
> PGD 1fad11067 P4D 1fad11067 PUD 1fad7a067 PMD 0
> Oops: 0000 [#1] SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 15171 Comm: syz-executor2 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:addrconf_permanent_addr net/ipv6/addrconf.c:3351 [inline]
> RIP: 0010:addrconf_notify+0x7df/0xd50 net/ipv6/addrconf.c:3422
> RSP: 0018:ffffc90000d63b80 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8801fa41a000 RCX: ffff8801faddd808
> RDX: 00000000000000ff RSI: 000000002811d9a2 RDI: ffff8801faddd968
> RBP: ffffc90000d63c00 R08: 0000000000000001 R09: 0000000000000004
> R10: ffffc90000d63af0 R11: 0000000000000004 R12: 0000000000000001
> R13: ffff8801faddd800 R14: 0000000000000000 R15: ffff8801faddd800
> FS:  00007f4373896700(0000) GS:ffff88021fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000002143c4001 CR4: 00000000001606f0
> DR0: 0000000020000008 DR1: 0000000020000000 DR2: 0000000020000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  notifier_call_chain+0x41/0xc0 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x32/0x60 net/core/dev.c:1679
>  call_netdevice_notifiers net/core/dev.c:1697 [inline]
>  __dev_notify_flags+0x75/0x130 net/core/dev.c:6874
>  dev_change_flags+0x5e/0x70 net/core/dev.c:6910
>  devinet_ioctl+0x77b/0x930 net/ipv4/devinet.c:1083
>  inet_ioctl+0xda/0x130 net/ipv4/af_inet.c:902
>  sock_do_ioctl+0x2c/0x60 net/socket.c:964
>  sock_ioctl+0x211/0x320 net/socket.c:1061
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0xaf/0x840 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452a09
> RSP: 002b:00007f4373895c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452a09
> RDX: 000000002062ffe0 RSI: 0000000000008914 RDI: 0000000000000013
> RBP: 00000000000002eb R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f16a8
> R13: 00000000ffffffff R14: 00007f43738966d4 R15: 0000000000000000
> Code: 85 ed 0f 84 f4 00 00 00 e8 ff 3a 06 ff 49 8d 85 68 01 00 00 48 89 c7
> 48 89 45 a8 e8 0c 9f 37 00 49 8b 45 08 4c 89 e9 48 83 c1 08 <48> 8b 38 48 39
> c1 4c 8d a8 c8 fe ff ff 4c 8d a7 c8 fe ff ff 0f
> RIP: addrconf_permanent_addr net/ipv6/addrconf.c:3351 [inline] RSP:
> ffffc90000d63b80
> RIP: addrconf_notify+0x7df/0xd50 net/ipv6/addrconf.c:3422 RSP:
> ffffc90000d63b80
> CR2: 0000000000000000
> ---[ end trace ebbf2e3971cab1b5 ]---

Invalidating this bug since it hasn't been seen again, and it was reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next (so this crash was possibly caused by slab
corruption elsewhere).

#syz invalid
