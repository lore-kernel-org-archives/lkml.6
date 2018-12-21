Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235EB218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbeLUIiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:38:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42044 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbeLUIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:38:04 -0500
Received: by mail-io1-f69.google.com with SMTP id c10so554319iot.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PSgb5oNS3XvzkcYfgKkT1oZI77IABywP2awk8ua+Uw4=;
        b=Kf8E1wjEzDqewJ10Xdb+MebjZpvjLuVIqPOzX/bLsHMO27Yvo5HM9Em2Rcd39fzbAI
         Q42hR2Hy8rorMkOuPkhvOW6UZx22q7zH/3nDbT/lVLrB59i3/FIcgVhSH/X2WJ9FfeOQ
         bOoTLosBOLR77ZEMeuKKN05A9i9Fvb6yfkVdWw1982l16CzKNih1hMJQiqMcSCX/KEW+
         sv/JgaMzPIkIElI5LVs9mYGE9526irKebHXM5VAVmsc2n6EHrAYmKJLrrRBXwywtuENR
         xxu/QSbgz6RNx4HzVilY1PVzcsknAct1eLTnODggPnpWmOM7r5wyoNJKSE6HxLhFvwz6
         whZA==
X-Gm-Message-State: AJcUukfRUBCkxV+jU0h16nVHmfPcLL+MBCmP3k+0892vxTW5zbnocFsz
        0pJKRS5Tjwl8cwebwZZuEQNKKQcBzKow4wSUHR1rwcW7q3Sv
X-Google-Smtp-Source: AFSGD/ULMFw5V5T53OraKUCDaKQXubwC4a5dX74BhSuAXANjtuh0D+h8t15M5Ex4EbTv46NmmdJp5OYhNiUJ9qKiReAJfRYK/Ksc
MIME-Version: 1.0
X-Received: by 2002:a24:4c42:: with SMTP id a63mr1457831itb.40.1545381483310;
 Fri, 21 Dec 2018 00:38:03 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:38:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005afe60057d842aa4@google.com>
Subject: BUG: unable to handle kernel paging request in iptunnel_xmit
From:   syzbot <syzbot+61816a2458fec4918227@syzkaller.appspotmail.com>
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

HEAD commit:    d84e7bc0595a rds: Fix warning.
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14615435400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=61816a2458fec4918227
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+61816a2458fec4918227@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor4'.
ip_tunnel: non-ECT from 172.20.255.187 with TOS=0x3
Enabling of bearer <udp:syz1> rejected, already enabled
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor4'.
New replicast peer: 172.20.20.187
BUG: unable to handle kernel paging request at ffffde2071b70933
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 30871 Comm: syz-executor3 Not tainted 4.20.0-rc6+ #241
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:iptunnel_xmit_stats include/net/ip_tunnels.h:422 [inline]
RIP: 0010:iptunnel_xmit+0x795/0x9c0 net/ipv4/ip_tunnel_core.c:94
Code: e9 03 80 3c 11 00 0f 85 00 02 00 00 4c 03 24 c5 20 40 27 89 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 ea 01 00 00 49 8d 7c 24 10 48 63 db 48 b8 00 00
RSP: 0018:ffff8881569becd0 EFLAGS: 00010a06
kobject: 'loop4' (00000000a27d9137): kobject_uevent_env
RAX: dffffc0000000000 RBX: 00000000000000dc RCX: 1ffffffff124e805
kobject: 'loop4' (00000000a27d9137): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
RDX: 1fffe22071b70933 RSI: ffffffff83933588 RDI: ffff11038db84998
RBP: ffff8881569bed30 R08: ffff88818d334500 R09: ffffed103b5e5b5f
R10: ffffed103b5e5b5f R11: ffff8881daf2dafb R12: ffff11038db84980
R13: ffff8881bbe64ec0 R14: ffff8881baab7900 R15: ffff88818fbe8380
FS:  00007fef14ce2700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffde2071b70933 CR3: 00000001af822000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  udp_tunnel_xmit_skb+0x248/0x320 net/ipv4/udp_tunnel.c:182
  tipc_udp_xmit.isra.14+0xaaf/0xef0 net/tipc/udp_media.c:181
  tipc_udp_send_msg+0x391/0x670 net/tipc/udp_media.c:247
  tipc_bearer_xmit_skb+0x171/0x350 net/tipc/bearer.c:502
  tipc_enable_bearer+0xc5e/0xf10 net/tipc/bearer.c:327
kobject: 'loop2' (00000000d7ca5ab8): kobject_uevent_env
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
kobject: 'loop2' (00000000d7ca5ab8): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
kobject: 'loop1' (00000000c9d8a67f): kobject_uevent_env
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
kobject: 'loop1' (00000000c9d8a67f): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fef14ce1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000004
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fef14ce26d4
R13: 00000000004c4252 R14: 00000000004d71d0 R15: 00000000ffffffff
Modules linked in:
CR2: ffffde2071b70933
---[ end trace bf7dbdfd80cac9f4 ]---
RIP: 0010:iptunnel_xmit_stats include/net/ip_tunnels.h:422 [inline]
RIP: 0010:iptunnel_xmit+0x795/0x9c0 net/ipv4/ip_tunnel_core.c:94
Code: e9 03 80 3c 11 00 0f 85 00 02 00 00 4c 03 24 c5 20 40 27 89 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 ea 01 00 00 49 8d 7c 24 10 48 63 db 48 b8 00 00
RSP: 0018:ffff8881569becd0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 00000000000000dc RCX: 1ffffffff124e805
RDX: 1fffe22071b70933 RSI: ffffffff83933588 RDI: ffff11038db84998
RBP: ffff8881569bed30 R08: ffff88818d334500 R09: ffffed103b5e5b5f
R10: ffffed103b5e5b5f R11: ffff8881daf2dafb R12: ffff11038db84980
R13: ffff8881bbe64ec0 R14: ffff8881baab7900 R15: ffff88818fbe8380
FS:  00007fef14ce2700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffde2071b70933 CR3: 00000001af822000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
