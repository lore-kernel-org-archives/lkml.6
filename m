Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74441C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF3F21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLaICF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:02:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:51654 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLaICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:02:04 -0500
Received: by mail-it1-f199.google.com with SMTP id b14so7240019itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=70O4whXVZ7B1GEqqhYOaoV0QX3bXH4GoMbMpUK9Fvq8=;
        b=ivz9All5Vq1GK7y83sDGYDUuNHdD6seMl/uE6FiDl3wj5dJhYcC2jhEyPnUxRjhS3+
         cMyKBMlKSlkXZRqJ42rsnXCv0J1h6rLlNiMSgVZFdBbuTug6HjeUvgdZS4tB3PG6PIeK
         5CoT4c4NR5KjpAIiYXvnIIM3IFspWW3K9+1JHo/z2mCHThAARacTZtGzSQ0KL2nQRTS8
         e+KigR5SvpfVxgOzXM9ZGa4njZSITCgj0JAXQMAObC5U/xwc4FkK1ty3NthaIP4gOTdM
         MjQxVEO8xR3JWrIO0J3xs4gZohEPZ8gLmYgjmGkg4pgUfqNWL8Z4csjl4RzWs9k7p8hH
         W3BA==
X-Gm-Message-State: AJcUukeHR6wZeKbXqZ2PgvsRjkXx0S+2CF66CGHKENdRk0P8woeOwYOz
        5rpiA4y6dMr9dfKLWGt7C3zNHojihfNhA4dBDaMsevtXt0Vo
X-Google-Smtp-Source: ALg8bN7uPzSQI99d4p+0JnxmCptLnWqhdKdj/CDYcKgbW637WIv8GQJP2BIrH8JwFxagt/iRfuNnO2u6t1bB5JUKeYK1ub+L1bHr
MIME-Version: 1.0
X-Received: by 2002:a6b:d11a:: with SMTP id l26mr24719547iob.34.1546243323550;
 Mon, 31 Dec 2018 00:02:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 00:02:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000966a8057e4cd467@google.com>
Subject: general protection fault in xfrm_policy_lookup_bytype
From:   syzbot <syzbot+80f2c1182f5bf39e5208@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90cadbbf341d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1018bf67400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9a32c9a4aef9af7
dashboard link: https://syzkaller.appspot.com/bug?extid=80f2c1182f5bf39e5208
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+80f2c1182f5bf39e5208@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25894 Comm: syz-executor0 Not tainted 4.20.0-rc7+ #361
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2019 [inline]
RIP: 0010:xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2053 [inline]
RIP: 0010:xfrm_policy_lookup_bytype+0xc1b/0xe70 net/xfrm/xfrm_policy.c:2113
Code: 7f fe ff ff e8 f6 59 c1 fa 4d 89 e6 49 83 ee 08 0f 84 6d fe ff ff e8  
e4 59 c1 fa 49 8d bc 24 ac 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 14 28  
48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
kobject: 'loop1' (0000000000151e1f): kobject_uevent_env
RSP: 0018:ffff8880ae606ba8 EFLAGS: 00010203
RAX: 0000000020000015 RBX: 0000000000000000 RCX: ffffffff86bd011c
RDX: 0000000000000100 RSI: ffffffff86bd013c RDI: 00000001000000ac
RBP: ffff8880ae606e60 R08: ffff88809e8c4400 R09: 0000000000000000
kobject: 'loop1' (0000000000151e1f): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
R10: 0000000000000000 R11: ffff88809e8c4400 R12: 0000000100000000
R13: dffffc0000000000 R14: 00000000fffffff8 R15: 00000000ffffffff
FS:  00007f6c92e5d700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cd730 CR3: 00000000a5cf0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  xfrm_policy_lookup+0x7e/0x80 net/xfrm/xfrm_policy.c:2145
  __xfrm_policy_check+0x14f0/0x2c40 net/xfrm/xfrm_policy.c:3354
  __xfrm_policy_check2 include/net/xfrm.h:1170 [inline]
  xfrm_policy_check include/net/xfrm.h:1175 [inline]
  xfrm6_policy_check include/net/xfrm.h:1185 [inline]
  ip6_protocol_deliver_rcu+0x8e9/0x1940 net/ipv6/ip6_input.c:391
  ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:434
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:443
  ip6_mc_input+0x514/0x11c0 net/ipv6/ip6_input.c:537
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ipv6_rcv+0x115/0x640 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5083
  process_backlog+0x217/0x760 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x7c5/0x1950 net/core/dev.c:6412
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1027
  </IRQ>
  do_softirq.part.13+0x126/0x160 kernel/softirq.c:337
  do_softirq+0x19/0x20 kernel/softirq.c:340
  netif_rx_ni+0x521/0x870 net/core/dev.c:4569
  dev_loopback_xmit+0x287/0x8c0 net/core/dev.c:3576
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_finish_output2+0x193a/0x2930 net/ipv6/ip6_output.c:84
  ip6_finish_output+0x583/0xc50 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip6_output+0x232/0x9d0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  ip6_local_out+0xc5/0x1b0 net/ipv6/output_core.c:176
  ip6_send_skb+0xbc/0x340 net/ipv6/ip6_output.c:1727
  ip6_push_pending_frames+0xc5/0xf0 net/ipv6/ip6_output.c:1747
  l2tp_ip6_push_pending_frames net/l2tp/l2tp_ip6.c:482 [inline]
  l2tp_ip6_sendmsg+0x1d04/0x2190 net/l2tp/l2tp_ip6.c:643
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4579b9
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6c92e5cc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004579b9
RDX: 0000000000000000 RSI: 00000000200014c0 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6c92e5d6d4
R13: 00000000004c4d3b R14: 00000000004d84a8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 5178ef7fa63f0d3d ]---
RIP: 0010:__xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2019 [inline]
RIP: 0010:xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2053 [inline]
RIP: 0010:xfrm_policy_lookup_bytype+0xc1b/0xe70 net/xfrm/xfrm_policy.c:2113
Code: 7f fe ff ff e8 f6 59 c1 fa 4d 89 e6 49 83 ee 08 0f 84 6d fe ff ff e8  
e4 59 c1 fa 49 8d bc 24 ac 00 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 14 28  
48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85
RSP: 0018:ffff8880ae606ba8 EFLAGS: 00010203
RAX: 0000000020000015 RBX: 0000000000000000 RCX: ffffffff86bd011c
RDX: 0000000000000100 RSI: ffffffff86bd013c RDI: 00000001000000ac
RBP: ffff8880ae606e60 R08: ffff88809e8c4400 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88809e8c4400 R12: 0000000100000000
R13: dffffc0000000000 R14: 00000000fffffff8 R15: 00000000ffffffff
FS:  00007f6c92e5d700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cd730 CR3: 00000000a5cf0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
