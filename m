Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F6E21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfADQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:37:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41542 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfADQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:37:05 -0500
Received: by mail-io1-f69.google.com with SMTP id a12so14780195iok.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ht50NUkspLgmqdwSaUq91DbtND7ykXVZfHrxCkpNxpo=;
        b=N+mb+A8Zv/zeou0pceFFKt70h/K+/DYVixvauj7yC4uFztWIaL5hE1dZJj11zhNv8W
         bjhkbt5hzFX3vJnXOwWbNS7i5EqBqY/WqICtqkKZBQf4XxfGABlvT4HnCxUbDLab6AV6
         uQJyaTtIPda2W/rcVrFHhSuF8YM8yPnepVQ5NNEhRITI36KRnxcY/rcxzR/uK58/RCea
         NCVyeyFpAZ1buAX9hETU9RkHvVOnhkoWZx0Eh+abqaidrnWiU/p3HdfkBDXiwFQ5X29h
         6oB2uVXHBvqR1AJ4QzPjOUfcUbo29kX9WHtPaJvL8HRKqhjUDjVrMH1aHK0IjYQ1IRhO
         7AmA==
X-Gm-Message-State: AA+aEWb7cZOvaJyHwQjqY4abMEvXI6Ii+vgODx+M+55Zggojq+AqV66i
        Rcu4bT/ZbbMeFIPFDg2YdivijYTu0sEEHA60uaL5DrIck8VD
X-Google-Smtp-Source: AFSGD/V95FaRA5IN1AxcIDDCDPcCfSTIAEGy//gfEybDLe6POooFaW+uMr4/OeR6DO62GY6lLTrvpRn/0AhT9lJPxsthMeEGuNb5
MIME-Version: 1.0
X-Received: by 2002:a02:8ca9:: with SMTP id f38mr40779531jak.14.1546619823911;
 Fri, 04 Jan 2019 08:37:03 -0800 (PST)
Date:   Fri, 04 Jan 2019 08:37:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034ffe6057ea47da2@google.com>
Subject: WARNING in xfrm_policy_insert_list
From:   syzbot <syzbot+25c4e5e89a6ce4bf7e9a@syzkaller.appspotmail.com>
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

HEAD commit:    c5ee066333eb ipv6: Consider sk_bound_dev_if when binding a..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11e796d7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=25c4e5e89a6ce4bf7e9a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+25c4e5e89a6ce4bf7e9a@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 17048 at net/xfrm/xfrm_policy.c:1537  
xfrm_policy_insert_list+0x4ec/0xfb0 net/xfrm/xfrm_policy.c:1537
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 17048 Comm: syz-executor5 Not tainted 4.20.0+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x589 kernel/panic.c:189
  __warn.cold+0x20/0x4b kernel/panic.c:544
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:xfrm_policy_insert_list+0x4ec/0xfb0 net/xfrm/xfrm_policy.c:1537
Code: 14 20 48 89 f8 83 e0 07 83 c0 03 38 d0 0f 8c 23 fd ff ff 84 d2 0f 84  
1b fd ff ff e8 ae d8 03 fb e9 11 fd ff ff e8 24 90 c0 fa <0f> 0b 48 8b 85  
40 ff ff ff 0f b6 10 48 8b 85 48 ff ff ff 83 e0 07
RSP: 0018:ffff88805811f130 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffff88808509a480 RCX: ffffc9000fe8d000
RDX: 000000000000058a RSI: ffffffff86c115ec RDI: ffff88808509a6a0
RBP: ffff88805811f230 R08: ffff888091c7c4c0 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  xfrm_policy_inexact_insert+0x155/0xda0 net/xfrm/xfrm_policy.c:1195
  xfrm_policy_insert+0x623/0x910 net/xfrm/xfrm_policy.c:1570
  xfrm_add_policy+0x2a1/0x6c0 net/xfrm/xfrm_user.c:1657
  xfrm_user_rcv_msg+0x458/0x8d0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x70/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6e0aa54c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e0aa556d4
R13: 00000000004c5223 R14: 00000000004d8ae8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
