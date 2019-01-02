Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09967C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30A0218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfABKbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:31:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:40146 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfABKbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:31:05 -0500
Received: by mail-it1-f199.google.com with SMTP id 135so35677998itk.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NVqSBQFFNxfWmjALEBkB0QX5+yqmf84HzRKtmC4AMmA=;
        b=drB56NMG+mS+K4JUgRhiqzjTDU0Kzefde7rE4v+B/9Q0aR4JRdqsz7SINMWFdrMWZY
         wYnYH0VvnlmyimlqrOHqNLzf/QMH90REMuTlwXjTgZUBiiE0G7pdtv3CX31h7kZE0rLD
         j3nbO/3S5Mfh5o2Ep9UuaCluGN21txGoBrsK/J1wktzDTiRdoyOyd/MiAgDzlwQKodiS
         TqrLKTwh1UlQUMyFuH5rKwJF+x3SVLOMsdd79xJ14/ZKXaItQ8HGgQsgQ9j5a5W8JDrr
         F7ZpfALueKVGInr7bVg/KmXrBXvSkDPAEciEyylsr2pIwasf9xxrw35PfWQa/zNxtdLt
         zsdQ==
X-Gm-Message-State: AA+aEWb7Hg/q5/Kt/Exuhs0gFWZES77Rp7z8Jij9SWt5MFflVCp+KRvN
        9RvJoNgAOWFqxknM0l4XbS8zkJHP3MK6XIu0BdzR/mgsN0vn
X-Google-Smtp-Source: AFSGD/UX+V8xg95Iz9Do55RvrJH3QB/a2pBgG0RW3+eafg4SbRePjmDOxTBJmImHkq7TMaN0X28KqmOa34lpA+Jba2yuCCmvd6TF
MIME-Version: 1.0
X-Received: by 2002:a24:f986:: with SMTP id l128mr31821922ith.5.1546425064197;
 Wed, 02 Jan 2019 02:31:04 -0800 (PST)
Date:   Wed, 02 Jan 2019 02:31:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f94c1057e772431@google.com>
Subject: WARNING in hsr_forward_skb
From:   syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10abf757400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
------------[ cut here ]------------
HSR: VLAN not yet supported
WARNING: CPU: 0 PID: 8203 at net/hsr/hsr_forward.c:336 hsr_fill_frame_info  
net/hsr/hsr_forward.c:336 [inline]
WARNING: CPU: 0 PID: 8203 at net/hsr/hsr_forward.c:336  
hsr_forward_skb+0x2196/0x28a0 net/hsr/hsr_forward.c:370
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8203 Comm: syz-executor112 Not tainted 4.20.0+ #175
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
RIP: 0010:hsr_fill_frame_info net/hsr/hsr_forward.c:336 [inline]
RIP: 0010:hsr_forward_skb+0x2196/0x28a0 net/hsr/hsr_forward.c:370
Code: e7 e8 9e 2a ff ff e9 8f f3 ff ff 48 89 85 b0 fe ff ff e8 8d d5 95 f9  
48 c7 c7 a0 0e fa 88 c6 05 25 bc 4a 02 01 e8 0a 1b 5f f9 <0f> 0b 48 8b 85  
a8 fe ff ff 48 b9 00 00 00 00 00 fc ff df 48 89 c2
RSP: 0018:ffff8880a6ae6b28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88808486b580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81683f55 RDI: 0000000000000006
RBP: ffff8880a6ae6cb8 R08: ffff8880a8b28100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88808e274400 R14: ffff88808486b636 R15: ffff8880a6ae6c90
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
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2116
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2211
  __do_sys_sendmmsg net/socket.c:2240 [inline]
  __se_sys_sendmmsg net/socket.c:2237 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2237
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4418a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdeaf8c9e8 EFLAGS: 00000213 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00000000004418a9
RDX: 0000000000000300 RSI: 0000000020008a80 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffdeaf8ca30
R13: 00007ffdeaf8ca20 R14: 0000000000000000 R15: 0000000000000000
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
