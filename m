Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C1D222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfBPHBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:01:08 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:59563 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfBPHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:01:07 -0500
Received: by mail-it1-f200.google.com with SMTP id m136so18524236ita.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4C+nfYlU1NCOf8mPm1TSOage9tXMIjfAAt357Vv1KWc=;
        b=Mraujw4HQeFKKsP0vAR1Sjx70/sJ7rdmbmpviyOXOR2xUd20ANpminyCql+ivC3Q/Y
         iHkvGEAw9eJGZ21phe5mYQceF8rUrn9UU6RcXj5wijL7NgsTK3cDG+7cUccf+xDniwUA
         3InJnSS1/ysfivE+E0ZhcRPtBEExYyvtEuC/N3zL3Xl8JMxoFXpA2veE9QwqRjFwFRQF
         HPn2XghWyeTBP9c+9ahulMC2sXSh3IegNzlwoFuiE08X3QbQsjoKoFnHQ17S6Cn2KSnY
         exPh33IhimaSehV/ccPuMOZ5L44OX5aYDP/Dlzl+O3uJlKB4qcFjUFX+hwMbO+BiH6OF
         +t3w==
X-Gm-Message-State: AHQUAuZ2eVldHQ716VpKWeSeLC9QKqSSQOUH6nX6CdWOMEMPrKbHnt6F
        eK7s/lAp/fgghhdbL7e3QkQFV29By85Kdr6m32qIwTubK5Bp
X-Google-Smtp-Source: AHgI3IZKKhasNpx1OhiKiH1r+3VVhlbwhGMUqaePDNwCDP4XbeKYo7OOefqPLH+u/1HtBVQnVMwIhAFcJaI30MryFNSAiPOOUfsU
MIME-Version: 1.0
X-Received: by 2002:a24:7454:: with SMTP id o81mr7706919itc.33.1550300466248;
 Fri, 15 Feb 2019 23:01:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 23:01:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000960cb60581fd746d@google.com>
Subject: general protection fault in rt_cache_valid
From:   syzbot <syzbot+0290d2290a607e035ba1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1582bc30c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=0290d2290a607e035ba1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0290d2290a607e035ba1@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2230 Comm: syz-executor0 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rt_cache_valid+0x85/0x250 net/ipv4/route.c:1510
Code: 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 34 92 f1 fa 48 85 db 74 4a e8  
2a 92 f1 fa 48 8d 7b 3a 4c 8d 75 d8 48 89 f8 48 c1 e8 03 <42> 0f b6 14 28  
48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85
kobject: 'loop3' (000000002d125388): kobject_uevent_env
RSP: 0018:ffff88809b24e0a8 EFLAGS: 00010207
RAX: 0000000000000024 RBX: 00000000000000eb RCX: ffffc90005df9000
RDX: 00000000000016a8 RSI: ffffffff869013e6 RDI: 0000000000000125
RBP: ffff88809b24e130 R08: ffff88806586e0c0 R09: ffffed1015ce5b90
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 1ffff11013649c15
R13: dffffc0000000000 R14: ffff88809b24e108 R15: 0000000000000000
FS:  00007f9fa034d700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33722000 CR3: 000000008512a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __mkroute_output net/ipv4/route.c:2260 [inline]
  ip_route_output_key_hash_rcu+0x952/0x3470 net/ipv4/route.c:2492
kobject: 'loop3' (000000002d125388): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000a20c7830): kobject_uevent_env
  ip_route_output_key_hash+0x25d/0x400 net/ipv4/route.c:2321
kobject: 'loop5' (00000000a20c7830): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  icmp_route_lookup.constprop.0+0x458/0x18e0 net/ipv4/icmp.c:489
kobject: 'loop2' (000000009de45ca1): kobject_uevent_env
  icmp_send+0x12eb/0x1bc0 net/ipv4/icmp.c:714
kobject: 'loop2' (000000009de45ca1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  ipv4_link_failure+0x2c/0x210 net/ipv4/route.c:1187
  dst_link_failure include/net/dst.h:427 [inline]
  vti_xmit net/ipv4/ip_vti.c:229 [inline]
  vti_tunnel_xmit+0x85a/0x1730 net/ipv4/ip_vti.c:264
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x261/0xc70 net/core/dev.c:3294
kobject: 'loop2' (000000009de45ca1): kobject_uevent_env
kobject: 'loop2' (000000009de45ca1): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  __dev_queue_xmit+0x2f8a/0x3a60 net/core/dev.c:3864
kobject: 'loop1' (00000000f4ea9cf1): kobject_uevent_env
kobject: 'loop1' (00000000f4ea9cf1): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3897
  neigh_direct_output+0x16/0x20 net/core/neighbour.c:1511
kobject: 'loop1' (00000000f4ea9cf1): kobject_uevent_env
  neigh_output include/net/neighbour.h:508 [inline]
  ip_finish_output2+0xa35/0x1a00 net/ipv4/ip_output.c:229
kobject: 'loop1' (00000000f4ea9cf1): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  ip_finish_output+0x7e4/0xf60 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_output+0x226/0x880 net/ipv4/ip_output.c:405
  dst_output include/net/dst.h:444 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  udp_send_skb.isra.0+0x6b2/0x1160 net/ipv4/udp.c:891
  udp_sendmsg+0x2902/0x3a40 net/ipv4/udp.c:1178
  udpv6_sendmsg+0x1843/0x3550 net/ipv6/udp.c:1279
kobject: 'loop4' (000000007ece3fce): kobject_uevent_env
kobject: 'loop4' (000000007ece3fce): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  inet_sendmsg+0x1af/0x740 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x409/0x910 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6f0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9fa034cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457ec9
RDX: 00000000000004ff RSI: 00000000200092c0 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
kobject: 'loop4' (000000007ece3fce): kobject_uevent_env
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9fa034d6d4
R13: 00000000004c4ce5 R14: 00000000004d85d8 R15: 00000000ffffffff
Modules linked in:
---[ end trace bf211f6e476e0c45 ]---
RIP: 0010:rt_cache_valid+0x85/0x250 net/ipv4/route.c:1510
kobject: 'loop4' (000000007ece3fce): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Code: 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 34 92 f1 fa 48 85 db 74 4a e8  
2a 92 f1 fa 48 8d 7b 3a 4c 8d 75 d8 48 89 f8 48 c1 e8 03 <42> 0f b6 14 28  
48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffff88809b24e0a8 EFLAGS: 00010207
RAX: 0000000000000024 RBX: 00000000000000eb RCX: ffffc90005df9000
RDX: 00000000000016a8 RSI: ffffffff869013e6 RDI: 0000000000000125
RBP: ffff88809b24e130 R08: ffff88806586e0c0 R09: ffffed1015ce5b90
kobject: 'loop5' (00000000a20c7830): kobject_uevent_env
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 1ffff11013649c15
R13: dffffc0000000000 R14: ffff88809b24e108 R15: 0000000000000000
FS:  00007f9fa034d700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
kobject: 'loop5' (00000000a20c7830): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33722000 CR3: 000000008512a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
