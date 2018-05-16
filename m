Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEPPf2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:35:28 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:50621 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEPPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:35:03 -0400
X-Google-Smtp-Source: AB8JxZoWsBxe41TDHELiJ7oUvKIui3kXcdqx3yUAbPMt+E2HEUKCetTNwn6NBhABSi9o7GgDGDz47FWWii7pZDciuR4Ew3x6dbei
MIME-Version: 1.0
Date: Wed, 16 May 2018 08:35:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006764b4056c5476d9@google.com>
Subject: kernel BUG at lib/string.c:LINE! (4)
From: syzbot <syzbot+aac887f77319868646df@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        wensong@linux-vs.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GFZj0L013209

Hello,

syzbot found the following crash on:

HEAD commit:    0b7d9978406f Merge branch 'Microsemi-Ocelot-Ethernet-switc..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e91017800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
dashboard link: https://syzkaller.appspot.com/bug?extid=aac887f77319868646df
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1665d637800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10517107800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aac887f77319868646df@syzkaller.appspotmail.com

IPVS: Unknown mcast interface: veth1_to�a����
IPVS: Unknown mcast interface: veth1_to�a����
IPVS: Unknown mcast interface: veth1_to�a����
detected buffer overflow in strlen
------------[ cut here ]------------
kernel BUG at lib/string.c:1052!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 373 Comm: syz-executor936 Not tainted 4.17.0-rc4+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fortify_panic+0x13/0x20 lib/string.c:1051
RSP: 0018:ffff8801c976f800 EFLAGS: 00010282
RAX: 0000000000000022 RBX: 0000000000000040 RCX: 0000000000000000
RDX: 0000000000000022 RSI: ffffffff8160f6f1 RDI: ffffed00392edef6
RBP: ffff8801c976f800 R08: ffff8801cf4c62c0 R09: ffffed003b5e4fb0
R10: ffffed003b5e4fb0 R11: ffff8801daf27d87 R12: ffff8801c976fa20
R13: ffff8801c976fae4 R14: ffff8801c976fae0 R15: 000000000000048b
FS:  00007fd99f75e700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 00000001d6843000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  strlen include/linux/string.h:270 [inline]
  strlcpy include/linux/string.h:293 [inline]
  do_ip_vs_set_ctl+0x31c/0x1d00 net/netfilter/ipvs/ip_vs_ctl.c:2388
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x7d/0xd0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0xd8/0xf0 net/ipv4/ip_sockglue.c:1253
  udp_setsockopt+0x62/0xa0 net/ipv4/udp.c:2487
  ipv6_setsockopt+0x149/0x170 net/ipv6/ipv6_sockglue.c:917
  tcp_setsockopt+0x93/0xe0 net/ipv4/tcp.c:3057
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3046
  __sys_setsockopt+0x1bd/0x390 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1911
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447369
RSP: 002b:00007fd99f75dda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00000000006e39e4 RCX: 0000000000447369
RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000018 R09: 0000000000000000
R10: 00000000200001c0 R11: 0000000000000246 R12: 00000000006e39e0
R13: 75a1ff93f0896195 R14: 6f745f3168746576 R15: 0000000000000001
Code: 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 48 89 df e8 d2 8f 48 fa eb  
de 55 48 89 fe 48 c7 c7 60 65 64 88 48 89 e5 e8 91 dd f3 f9 <0f> 0b 90 90  
90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56
RIP: fortify_panic+0x13/0x20 lib/string.c:1051 RSP: ffff8801c976f800
---[ end trace 624046f2d9af7702 ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
