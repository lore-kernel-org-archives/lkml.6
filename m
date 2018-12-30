Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F9C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E4F20855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeL3KlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:41:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46443 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeL3KlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 05:41:05 -0500
Received: by mail-io1-f70.google.com with SMTP id o22so29897265iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 02:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kBqTrjasau4xoUCu21xpi2dsDxPrqLi4YhZVqK52WHg=;
        b=maYO8h3SRdvhS9gHNI2rVMqslU+ZMkGMX1Y+1iI7X54xr45kdzHFD9OioWTOtlpH0w
         KMRH4IaGb1on4NbOzQvadmmgHt6BqvVYxkW8XWwlGH1J1qFvUsvegaM0K5CBocRfjK0Y
         TkA6LhKIXMJeG4Kq/TIHHAxuw+5HtQt/LJjo8UvUIel4ZS1QnEj6hH5FB3TXCNPSy0Ea
         D2x7I+S4EGKxzquXe0uDuLyDx5lfJnZVnVJRSBWPcZWipkUPOy//z+y2IyBatHpb155R
         PSZwk1014ps2NqJFXW6Z0GhL4A0S6yh9U1qQBejMO2YsgxdMtijt+mBAaRhamlocc4I/
         mVfQ==
X-Gm-Message-State: AA+aEWbwONl7TKxyfxpWoikaQbuKob0qEirzA8dCcqIMwaLDG+ZFblDG
        +Dcn/xGU6iTnLUpJLwBT4l4tXhzgp92VN6kIU0UOHM6X3H0M
X-Google-Smtp-Source: AFSGD/Vto96UPxAZ3JoBGg0R/t7IMmGdpJ6RwDFttoNwZ8s+Zfx53ItlTCU/KKsOjFZIB02lgDp8pvLdzqGUN9lT+tcBzzjEtKBk
MIME-Version: 1.0
X-Received: by 2002:a02:97da:: with SMTP id v26mr26384594jaj.1.1546166463925;
 Sun, 30 Dec 2018 02:41:03 -0800 (PST)
Date:   Sun, 30 Dec 2018 02:41:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d89413057e3aeec2@google.com>
Subject: WARNING in batadv_is_on_batman_iface
From:   syzbot <syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d8924c0d76aa Merge tag 'devprop-4.21-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122a373f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
dashboard link: https://syzkaller.appspot.com/bug?extid=c764de0fcfadca9a8595
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd1d67400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
------------[ cut here ]------------
Cannot find parent device
WARNING: CPU: 1 PID: 9391 at net/batman-adv/hard-interface.c:182  
batadv_is_on_batman_iface+0x3ef/0x460 net/batman-adv/hard-interface.c:182
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9391 Comm: syz-executor2 Not tainted 4.20.0+ #388
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:batadv_is_on_batman_iface+0x3ef/0x460  
net/batman-adv/hard-interface.c:182
Code: 8b 45 d0 48 89 45 c0 e9 f5 fe ff ff 4c 89 ff e8 67 f7 03 fa e9 f4 fc  
ff ff e8 2d ec c0 f9 48 c7 c7 00 16 d6 88 e8 b1 9f 8a f9 <0f> 0b eb b7 e8  
68 f7 03 fa e9 3e fc ff ff 48 8b 7d c0 e8 5a f7 03
RSP: 0018:ffff8881d31e68b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881d78d0ec0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164e075 RDI: 0000000000000006
RBP: ffff8881d31e6900 R08: ffff8881b0d9c040 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881b0d9c040 R12: 0000000000000000
R13: ffff8881bd630140 R14: 00000000447eea95 R15: ffff8881d78d0fc8
  batadv_is_valid_iface net/batman-adv/hard-interface.c:205 [inline]
  batadv_hardif_add_interface net/batman-adv/hard-interface.c:917 [inline]
  batadv_hard_if_event+0x944/0x11e0 net/batman-adv/hard-interface.c:1041
  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93
  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1733
  call_netdevice_notifiers net/core/dev.c:1751 [inline]
  register_netdevice+0xb98/0x10f0 net/core/dev.c:8570
  ip6gre_newlink_common.isra.29+0x165/0x3c0 net/ipv6/ip6_gre.c:1948
  ip6gre_newlink+0x353/0x9b0 net/ipv6/ip6_gre.c:1981
  rtnl_newlink+0xf08/0x1da0 net/core/rtnetlink.c:3175
  rtnetlink_rcv_msg+0x46a/0xc20 net/core/rtnetlink.c:4950
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4968
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
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd848638c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457759
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd8486396d4
R13: 00000000004c49f1 R14: 00000000004d80d0 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
