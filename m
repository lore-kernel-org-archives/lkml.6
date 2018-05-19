Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeESMfE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:35:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:53265 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeESMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:35:02 -0400
X-Google-Smtp-Source: AB8JxZoTgaZQUhLnJU5g9rivBPfnUGRDNaHy9CxzDTscifMEUbjRjZj30P7jIRGCBcBBhn54vruS7G6CyGH69bpI/pRPIyoJXlFx
MIME-Version: 1.0
Date: Sat, 19 May 2018 05:35:01 -0700
In-Reply-To: <000000000000506bcd056c8a91d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020e574056c8e4cf2@google.com>
Subject: Re: WARNING in xfrm6_tunnel_net_exit (2)
From: syzbot <syzbot+e9aebef558e3ed673934@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    eb38401c779d net: stmmac: Populate missing callbacks in HW..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1233a827800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
dashboard link: https://syzkaller.appspot.com/bug?extid=e9aebef558e3ed673934
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1547dbcf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132307cf800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9aebef558e3ed673934@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 1 PID: 44 at net/ipv6/xfrm6_tunnel.c:348  
xfrm6_tunnel_net_exit+0x2df/0x510 net/ipv6/xfrm6_tunnel.c:348
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 44 Comm: kworker/u4:2 Not tainted 4.17.0-rc4+ #52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:xfrm6_tunnel_net_exit+0x2df/0x510 net/ipv6/xfrm6_tunnel.c:348
RSP: 0018:ffff8801d95273d8 EFLAGS: 00010293
RAX: ffff8801d955c380 RBX: ffff8801b03399f8 RCX: ffffffff86925525
RDX: 0000000000000000 RSI: ffffffff8692552f RDI: 0000000000000007
RBP: ffff8801d95274f8 R08: ffff8801d955c380 R09: 0000000000000006
R10: ffff8801d955c380 R11: 0000000000000000 R12: 00000000000000ff
R13: ffffed003b2a4e82 R14: ffff8801d95274d0 R15: ffff8801b3e25780
  ops_exit_list.isra.7+0xb0/0x160 net/core/net_namespace.c:152
  cleanup_net+0x51d/0xb20 net/core/net_namespace.c:523
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
