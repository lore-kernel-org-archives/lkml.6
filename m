Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64997C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3872054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfBKVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:53:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:33315 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfBKVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:53:04 -0500
Received: by mail-it1-f198.google.com with SMTP id b192so1159912itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6LqorY6/YwXp0Y+5BVVCA+j4J7GxvOdTERQYd3ArPrQ=;
        b=Funmc8TDC7ctDzb94/SIdcXyYuQwVJcRKgH4sIQUtXM5Yh1IiDiHMWcHVxVXKR+76p
         f4QV5GsSK56sPsTa3ENR7ErzaRth/e6uxwntznVWoGX3rENlmzb1oyt57pXMCOVY/QcD
         RoPZ+g9E/kINW8plG5ing6NlCg0xNp1usa7YLSilsp70T7xY6pvkThzssT3jHkjyY3vd
         +0VoWjTJAun/Q/XQqODZ+gfxWjjI7/2GKrYwYhHwnT5JPoPFBknSfc9uvrzS7iyErFI9
         gYesqILFV8JcbOZf3HdMjpyRcC/cGjL8GET5qJ3T3p/ONgKexabJhPB09JiSjCNj4AMI
         ER6Q==
X-Gm-Message-State: AHQUAuapFK+yBulzbGmYW4H0WB/fuKXJrr9PEVe0Bl279lByUOUxNgQo
        TEU+wpG3kqCwm3De+oHKGhNb73g4yADd4m25ubbFt9x3Omp5
X-Google-Smtp-Source: AHgI3IYzim2S5nzHUIxeVGnws5On5jO83B48mjCCHq6V2WwcmOt2rZWy0gN1/66rlpCuXuYMF2yVVV4fZFKeHwATUf8nRlTrVgNM
MIME-Version: 1.0
X-Received: by 2002:a6b:f215:: with SMTP id q21mr274203ioh.25.1549921983113;
 Mon, 11 Feb 2019 13:53:03 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:53:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bb1540581a55575@google.com>
Subject: KMSAN: uninit-value in hsr_register_frame_in
From:   syzbot <syzbot+b8152ab439b9c5174ffd@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, davem@davemloft.net, glider@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fa1981bee40f kmsan: fix defconfig build
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=12c53624c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9737ec5618f82
dashboard link: https://syzkaller.appspot.com/bug?extid=b8152ab439b9c5174ffd
compiler:       clang version 8.0.0 (trunk 350509)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a4f787400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1797e960c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b8152ab439b9c5174ffd@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): hsr0: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KMSAN: uninit-value in hsr_register_frame_in+0x12c/0x200  
net/hsr/hsr_framereg.c:318
CPU: 0 PID: 10753 Comm: syz-executor132 Not tainted 5.0.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  hsr_register_frame_in+0x12c/0x200 net/hsr/hsr_framereg.c:318
  hsr_forward_skb+0xd64/0x2e30 net/hsr/hsr_forward.c:372
  hsr_dev_xmit+0xf8/0x160 net/hsr/hsr_device.c:243
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x604/0xc40 net/core/dev.c:3294
  __dev_queue_xmit+0x2e48/0x3b80 net/core/dev.c:3864
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3897
  packet_snd net/packet/af_packet.c:2932 [inline]
  packet_sendmsg+0x79bb/0x9760 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x8c4/0xac0 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1796
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x441869
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffa42c7de8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441869
RDX: 000000000000000e RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000004a8fb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402db0
R13: 0000000000402e40 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_save_stack mm/kmsan/kmsan.c:220 [inline]
  kmsan_internal_chain_origin+0x134/0x230 mm/kmsan/kmsan.c:426
  __msan_chain_origin+0x70/0xe0 mm/kmsan/kmsan_instr.c:200
  hsr_add_node net/hsr/hsr_framereg.c:152 [inline]
  hsr_get_node+0xc94/0xe10 net/hsr/hsr_framereg.c:198
  hsr_fill_frame_info net/hsr/hsr_forward.c:327 [inline]
  hsr_forward_skb+0x7e9/0x2e30 net/hsr/hsr_forward.c:370
  hsr_dev_xmit+0xf8/0x160 net/hsr/hsr_device.c:243
  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x604/0xc40 net/core/dev.c:3294
  __dev_queue_xmit+0x2e48/0x3b80 net/core/dev.c:3864
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3897
  packet_snd net/packet/af_packet.c:2932 [inline]
  packet_sendmsg+0x79bb/0x9760 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x8c4/0xac0 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1796
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2754 [inline]
  __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4377
  __kmalloc_reserve net/core/skbuff.c:140 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1012 [inline]
  alloc_skb_with_frags+0x1c7/0xac0 net/core/skbuff.c:5288
  sock_alloc_send_pskb+0xafd/0x10a0 net/core/sock.c:2091
  packet_alloc_skb net/packet/af_packet.c:2783 [inline]
  packet_snd net/packet/af_packet.c:2876 [inline]
  packet_sendmsg+0x6881/0x9760 net/packet/af_packet.c:2957
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  __sys_sendto+0x8c4/0xac0 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto+0x107/0x130 net/socket.c:1796
  __x64_sys_sendto+0x6e/0x90 net/socket.c:1796
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
