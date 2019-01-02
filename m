Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C76BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfABKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:51:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56481 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfABKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:51:04 -0500
Received: by mail-io1-f69.google.com with SMTP id x2so35286140ioa.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G1WkJnuBbVPXqkl5b3USafcgkt1yFk4a4tFbqFeX9+w=;
        b=UiSQpuyIgWS/RLnkRyAhKNuqNLVTT2jzXsBAWF2NZm+tUUsjyxwz6jmS/Y3gCxYViV
         3U+GSJpnwI0UcJkIMFejplUKXB8DyfN2PCGyqzWUhlNd1Kvvcmetl0xG/Hmi2OYqM018
         bPwXlHEw8GlimGAtAaE+7jXEk4zaYAdHJFSErcbJcnoYCuwUovt5x5TIm1+cObz0XYpI
         hHnEzUZDsdTC0lCQ/yHHK2mQUw3+XK/NAPjJL47+Fx5KRh3bxqgUqQWuOqO1uF6L6XK/
         9Ts72DrAZTYmOdbfK8vrUct+86i740Q/tbjl7BVnHk2hU1BhNkq6Fm7hpBF4I3YdTB03
         JSTA==
X-Gm-Message-State: AJcUukfYnMpJx1sarmi85XT5mT7t5p/RZcDOYDUtYvVMLAQZ7nggSLSo
        crSCRwkCBgdnirgVXv/188vRprer1BChtrs0tez5SIVCRXNC
X-Google-Smtp-Source: ALg8bN6j7XgXduAsIwAibKlC7m730uQ8EeLEjeJX+vRiF29bf0KBlII+5KnU9gAtI66eczMZUbRPAKoMObswmLww34avLmgQrsGo
MIME-Version: 1.0
X-Received: by 2002:a6b:b4cc:: with SMTP id d195mr41552165iof.39.1546426263475;
 Wed, 02 Jan 2019 02:51:03 -0800 (PST)
Date:   Wed, 02 Jan 2019 02:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b1a1d057e776c92@google.com>
Subject: WARNING in hsr_addr_subst_dest
From:   syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fcd2e7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
------------[ cut here ]------------
hsr_addr_subst_dest: Unknown node
WARNING: CPU: 1 PID: 7814 at net/hsr/hsr_framereg.c:301  
hsr_addr_subst_dest+0x6c7/0x850 net/hsr/hsr_framereg.c:301
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7814 Comm: syz-executor962 Not tainted 4.20.0+ #396
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55f kernel/panic.c:189
  __warn.cold.8+0x20/0x52 kernel/panic.c:544
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:hsr_addr_subst_dest+0x6c7/0x850 net/hsr/hsr_framereg.c:301
Code: bf dc 5f f9 0f 0b e9 ad fd ff ff e8 23 97 96 f9 48 c7 c6 20 fc f9 88  
48 c7 c7 e0 fb f9 88 c6 05 ac 7d 4b 02 01 e8 99 dc 5f f9 <0f> 0b e9 87 fd  
ff ff 48 89 cf e8 2a 7b da f9 e9 e7 f9 ff ff 48 89
RSP: 0018:ffff8880a0e9ec60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81683f55 RDI: 0000000000000005
RBP: ffff8880a0e9ed78 R08: ffff888090ed6580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888086d356a0 R14: ffffed10141d3da2 R15: ffff888086d356a0
  hsr_xmit net/hsr/hsr_forward.c:230 [inline]
  hsr_forward_do net/hsr/hsr_forward.c:295 [inline]
  hsr_forward_skb+0x1e68/0x28a0 net/hsr/hsr_forward.c:373
  hsr_dev_xmit+0x71/0xa0 net/hsr/hsr_device.c:243
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x286/0xc80 net/core/dev.c:3294
  __dev_queue_xmit+0x2f62/0x3ac0 net/core/dev.c:3864
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3897
  packet_snd net/packet/af_packet.c:2932 [inline]
  packet_sendmsg+0x298a/0x6ad0 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x442129
Code: e8 4c 06 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffb6839fa8 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442129
RDX: 0000000000000011 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000216 R12: 0000000000000000
R13: 00007fffb6839ff0 R14: 0000000000000000 R15: 0000000000000000
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
