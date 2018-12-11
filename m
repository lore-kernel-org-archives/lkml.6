Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E611C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002672084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002672084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeLKAlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:41:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:34569 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeLKAlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:41:05 -0500
Received: by mail-io1-f71.google.com with SMTP id y19so12888310ioq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l8j2mIhAnEkrN5lXG8UENM+g/gEwiNp9xNedHU5EGL8=;
        b=rawm93kHEgknWyrgLYNqBEarUPYtI2yrKpighONguZdZJ3kGYPFgtNZsmIuicVZqCd
         GKQE5fvk/DO8pyVZbBgdAE40ePIwA76OxMdlIGCbqOQprVjxOPnN0w13Wc6EjEcZwap5
         ZgVmJpqTeaDFHqO5JRE6Zf7SKFDskGIAgy9QvEevVQK0O77oj2dbpAcBXSMF/Un3g56V
         49NxkcTV/i/lvsBiybA2FyS4t+vV2rBBoZnkO8ZUI8/+MdNv3JukrewenmWjzojFLreJ
         uA+/Im4E+Gdh6UCNo0GqUZmdTAPMcjXVbfW9fl1thdmfJX8vcseg7v1yDqUOiEHTwKSC
         SxZw==
X-Gm-Message-State: AA+aEWZ1rusw2+1/7T+Ww3bCJ+9SXwY07I0SYNnTOUfqlIa+3lfsVtxh
        3NU6W4wc/SMdQnJ/5vnqZNyZxXEXrIivcoRhqcPbn9KCPG90
X-Google-Smtp-Source: AFSGD/UYOdsB/lHuqUEA0O6xfb+KGY8xfJtre6ZrIRbwDeGK7sBsaet63P7H3NH+ohzQOIW6do4Mza2gihrQAvmvXw9NmG//lEsJ
MIME-Version: 1.0
X-Received: by 2002:a24:6fd1:: with SMTP id x200mr436132itb.26.1544488863752;
 Mon, 10 Dec 2018 16:41:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:41:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001568af057cb456a8@google.com>
Subject: KMSAN: uninit-value in __inet6_bind
From:   syzbot <syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com>
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

HEAD commit:    3f06bda61398 kmsan: remove excessive KMSAN wrappers from a..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ca6b05400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
dashboard link: https://syzkaller.appspot.com/bug?extid=c56449ed3652e6720f30
compiler:       clang version 8.0.0 (trunk 348261)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c56449ed3652e6720f30@syzkaller.appspotmail.com

Started in network mode
Own node identity fe8000000000000000000000000000bb, cluster identity 4711
==================================================================
BUG: KMSAN: uninit-value in __inet6_bind+0xb72/0x1ad0  
net/ipv6/af_inet6.c:340
CPU: 0 PID: 8376 Comm: syz-executor3 Not tainted 4.20.0-rc5+ #111
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x284/0x3b0 lib/dump_stack.c:113
  kmsan_report+0x12d/0x290 mm/kmsan/kmsan.c:684
  __msan_warning+0x76/0xc0 mm/kmsan/kmsan_instr.c:316
  __inet6_bind+0xb72/0x1ad0 net/ipv6/af_inet6.c:340
  inet6_bind+0x27f/0x390 net/ipv6/af_inet6.c:441
  kernel_bind+0xc6/0xf0 net/socket.c:3230
  udp_sock_create6+0x2ee/0x890 net/ipv6/ip6_udp_tunnel.c:39
  udp_sock_create include/net/udp_tunnel.h:61 [inline]
  tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
  tipc_enable_bearer net/tipc/bearer.c:302 [inline]
  __tipc_nl_bearer_enable+0x1213/0x1da0 net/tipc/bearer.c:897
  tipc_nl_bearer_enable+0x6c/0xb0 net/tipc/bearer.c:905
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xfc5/0x10a0 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x1298/0x13e0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xdbc/0x11d0 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xcd/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457659
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f82ebc52c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457659
RDX: 0000000000000000 RSI: 00000000200008c0 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82ebc536d4
R13: 00000000004c421b R14: 00000000004d7160 R15: 00000000ffffffff

Local variable description: ----udp6_addr@udp_sock_create6
Variable was created at:
  udp_sock_create6+0x80/0x890 net/ipv6/ip6_udp_tunnel.c:17
  udp_sock_create include/net/udp_tunnel.h:61 [inline]
  tipc_udp_enable+0x166f/0x1d70 net/tipc/udp_media.c:742
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
