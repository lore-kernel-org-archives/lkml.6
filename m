Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeDFHzD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:55:03 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:55811 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeDFHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:55:01 -0400
X-Google-Smtp-Source: AIpwx4905cdhD1KqB+pNKIoU77c9u2MwPoOdA4SSoRyqcbgiLICN55Bv0JOULKkmhW3/k5X6G7+WtFTIL+rQqkiFEElac5cXMDOl
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 00:55:01 -0700
In-Reply-To: <001a11479e32f4f8c50561f21514@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113de2d88b6ee10569295fc6@google.com>
Subject: Re: WARNING in xfrm6_tunnel_net_exit
From: syzbot <syzbot+777bf170a89e7b326405@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 (Sat Mar 31 01:52:36 2018 +0000)
kernel.h: Retain constant expression output for max()/min()
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=777bf170a89e7b326405

So far this crash happened 10982 times on linux-next, mmots, net-next,  
upstream.
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5399809707999232
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4550974920196096
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1647968177339044852
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+777bf170a89e7b326405@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 0 PID: 180 at net/ipv6/xfrm6_tunnel.c:345  
xfrm6_tunnel_net_exit+0x2c0/0x4f0 net/ipv6/xfrm6_tunnel.c:345
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 180 Comm: kworker/u4:4 Not tainted 4.16.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
  panic+0x22f/0x4de kernel/panic.c:183
  __warn.cold.8+0x163/0x1a3 kernel/panic.c:547
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1bc/0x470 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:991
RIP: 0010:xfrm6_tunnel_net_exit+0x2c0/0x4f0 net/ipv6/xfrm6_tunnel.c:345
RSP: 0018:ffff8801d96373d8 EFLAGS: 00010293
RAX: ffff8801d961c080 RBX: ffff8801b0e999a0 RCX: ffffffff866b08c6
RDX: 0000000000000000 RSI: ffffffff866b08d0 RDI: 0000000000000007
RBP: ffff8801d96374f8 R08: ffff8801d961c080 R09: ffffed003b6046c2
R10: 0000000000000003 R11: 0000000000000003 R12: 000000000000007c
R13: ffffed003b2c6e82 R14: ffff8801d96374d0 R15: ffff8801b6185f80
  ops_exit_list.isra.7+0xb0/0x160 net/core/net_namespace.c:152
  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
