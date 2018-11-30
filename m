Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5238C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7AC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7AC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLAABQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:01:16 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:54572 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLAABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:01:15 -0500
Received: by mail-it1-f199.google.com with SMTP id v3so6664196itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 04:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vssgb/4CDnXQABP1jVuxutFRbcIJfS4WdJ4Hn0L1C5A=;
        b=YoYvGD9I0cBa1ljAgKfrW1VbPiURcyl+r4Rj1SFZ+K/R+ND6knoFT3/6GNQwXwdShA
         VyeGksvm32tf/tTW8yRKzgS3JIcPGB8OqGA0nhAGxde4SFI1fsNLGGo5bSQ0SBXCFJzf
         7QcsTczrTqziZ5ZI/GWjX6nMaI5LQQWlTOaUKkChzC6RTJNpZtkrwhSaGj2G8hRSQSCW
         LRhCnq9PuJ7XJM59a8MzIDoLzvh6uJVkJHI2HVO9CrPGfWYH0pNhtWxYCuzuChFB+a/n
         GmvL0Si8WOQ4HT6V2doWcy5rwiLCQBkzHA8JqvYV9bIF7LgftDZgTdh18bd61i8JrTnl
         LTsA==
X-Gm-Message-State: AA+aEWbdh3Tt/IqR+xFTSYoJ2hx1Qf1UKEX0bXGOCB5HQ4VAujVZqjuD
        Ny3kZCT1Ek8OQs3HEjYb6Kg4yKa5Ner9X+zTUawp+iKbkRyp
X-Google-Smtp-Source: AFSGD/WPJmfRRsuSktjIrZ63tE9uD01HZxHYxxuXG2Dd2bKpsTIP2U8ToaW9mptjxuHaxYfH26CiipgxtL/CpJF4t3LKuLAPHDHp
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr4033902ita.8.1543582322812;
 Fri, 30 Nov 2018 04:52:02 -0800 (PST)
Date:   Fri, 30 Nov 2018 04:52:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000874de057be144e8@google.com>
Subject: WARNING in fib6_add (2)
From:   syzbot <syzbot+60cc5bc1296c8afcf739@syzkaller.appspotmail.com>
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

HEAD commit:    528bff0cdb66 tools: bpftool: fix a bitfield pretty print i..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=12f29a93400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=60cc5bc1296c8afcf739
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+60cc5bc1296c8afcf739@syzkaller.appspotmail.com

IPv6: Can't replace route, no match found
netlink: 7 bytes leftover after parsing attributes in process  
`syz-executor1'.
IPv6: NLM_F_REPLACE set, but no existing node found!
WARNING: CPU: 1 PID: 28238 at net/ipv6/ip6_fib.c:1360  
fib6_add+0x1106/0x14c0 net/ipv6/ip6_fib.c:1360
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 28238 Comm: syz-executor5 Not tainted 4.20.0-rc3+ #92
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:fib6_add+0x1106/0x14c0 net/ipv6/ip6_fib.c:1360
Code: 08 49 8d bf a8 0c 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8d 03  
00 00 4d 8b bf a8 0c 00 00 e9 15 fd ff ff e8 6a aa 9f fa <0f> 0b 48 8b 95  
f0 fc ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea
RSP: 0018:ffff8881d22cee40 EFLAGS: 00010216
RAX: 0000000000040000 RBX: ffff8881d22cf590 RCX: ffffc90011a88000
RDX: 0000000000008f15 RSI: ffffffff86dfe086 RDI: ffff888189100920
RBP: ffff8881d22cf198 R08: ffff8881d8398580 R09: ffffed103a477e5d
R10: ffffed103a477e5d R11: ffff8881d23bf2ef R12: 00000000fffffffe
R13: ffff888189100900 R14: ffff8881b3c54080 R15: 0000000000000000
  __ip6_ins_rt+0x54/0x80 net/ipv6/route.c:1155
  ip6_route_multipath_add+0x94f/0x18b0 net/ipv6/route.c:4391
  inet6_rtm_newroute+0xe3/0x160 net/ipv6/route.c:4521
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4947
kobject: 'loop3' (000000001b475654): kobject_uevent_env
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4965
kobject: 'loop3' (000000001b475654): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
kobject: 'loop2' (000000002cda1b69): kobject_uevent_env
kobject: 'loop2' (000000002cda1b69): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9f096ccc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9f096cd6d4
R13: 00000000004c3f7d R14: 00000000004d6778 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
