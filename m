Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E99A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfAKP5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:57:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:40901 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfAKP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:57:04 -0500
Received: by mail-it1-f198.google.com with SMTP id 135so1868590itk.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IKdybMznxGej5G3wTR0XRGA6U9dFeu1vOFc5tE0yRg4=;
        b=rUQT0Dy7q7a+A64ymy9/FoChfInw6i6zUpWK0jQ/kgemjFhOOtAwGpjDzHMhKgDG4p
         tXFiRCkvh9Wt1CCp/CGvkHzoh3IzxsYKmkYy7mSyxO+qgTRWyZuV+jDPh+QZhtJwhSP5
         BQ6nKm0e4yPXASxEMmtn0gsg95sK1gz51v+pf8EuacJ/kAXjHIVdTvL5P2SoLzMBZPs+
         DJElHaukhz3HMUdorB0BKqb/It7Vt0BbKoMxTcT6R4W4UVvpiUaJvGljSONfFb9AIef4
         i/lD0zZ15BKO4D2mACbHzKVNibye9RlTpPWdl16hywuHyPNqu+VGOFmIR2DnrElx2qbY
         Y3hA==
X-Gm-Message-State: AJcUukdPhFJ9NV1FfWTScM5dX71isGjambdxo0azTlAgXKGZztZcyQqS
        X0z7EbhJ0TVLtc2JdQOpPYjNQKgUivZh6g40KGtpFqHAYrQf
X-Google-Smtp-Source: ALg8bN4Oo+dG2ghYavH9w9X36Yk2ibT/323CM6dGmNcZGmOflI6dt1a1sQGY+UKW3Msu5IGawJ+BxgLqC0Lgz2M701ei2Y9SU7ie
MIME-Version: 1.0
X-Received: by 2002:a24:5948:: with SMTP id p69mr455509itb.21.1547222223234;
 Fri, 11 Jan 2019 07:57:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:57:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000131d4057f30bf14@google.com>
Subject: WARNING: refcount bug in xfrm_policy_bysel_ctx
From:   syzbot <syzbot+8a6a21b4254f25f2ee66@syzkaller.appspotmail.com>
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

HEAD commit:    b19bce0335e2 net: ethernet: mediatek: fix warning in phy_s..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=168e0b9f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=8a6a21b4254f25f2ee66
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a6a21b4254f25f2ee66@syzkaller.appspotmail.com

netlink: 104 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 104 bytes leftover after parsing attributes in process  
`syz-executor4'.
------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 0 PID: 25457 at lib/refcount.c:153 refcount_inc_checked  
lib/refcount.c:153 [inline]
WARNING: CPU: 0 PID: 25457 at lib/refcount.c:153  
refcount_inc_checked+0x61/0x70 lib/refcount.c:151
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 25457 Comm: syz-executor4 Not tainted 4.20.0+ #16
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
RIP: 0010:refcount_inc_checked lib/refcount.c:153 [inline]
RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:151
Code: 1d 8a 37 c8 06 31 ff 89 de e8 1b 27 f2 fd 84 db 75 dd e8 d2 25 f2 fd  
48 c7 c7 e0 97 81 88 c6 05 6a 37 c8 06 01 e8 0f 7d bb fd <0f> 0b eb c1 90  
66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49
RSP: 0018:ffff88806d877138 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000bf9d000
RDX: 000000000001d827 RSI: ffffffff816849b6 RDI: 0000000000000005
RBP: ffff88806d877148 R08: ffff8880608260c0 R09: ffff888060826988
R10: ffff8880608260c0 R11: 0000000000000000 R12: ffff88806a024520
R13: ffff888087287c00 R14: ffff88806d8772d0 R15: 0000000000000004
  xfrm_pol_hold include/net/xfrm.h:838 [inline]
  xfrm_policy_bysel_ctx+0x1c9/0x1020 net/xfrm/xfrm_policy.c:1679
  xfrm_get_policy+0x67b/0x1160 net/xfrm/xfrm_user.c:1887
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
RSP: 002b:00007f6d47b19c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000006
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6d47b1a6d4
R13: 00000000004c5394 R14: 00000000004d8e30 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
