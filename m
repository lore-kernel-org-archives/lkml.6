Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E3BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDB2208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDB2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeG0OeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:34:08 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:36217 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeG0Odz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:33:55 -0400
Received: by mail-it0-f70.google.com with SMTP id m185-v6so5292256itm.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2N9DMv24efF5ZrKgieSujxTr85hicunYrxRghaHVjEI=;
        b=Sh7vRBIkjCHcPB4VVMBUtk6k2GUZcv6cEGObgFH3ahzVO+0HguSPPtVyIR3pLI6/Ra
         Cc1lojBkmlRhBYCCtkh3WzW9682b3w4Sbflbz0mFqHqSv2r/szs9Nm9ncd9uO1XnrabO
         oOcWA3zX/H5JivyJHFhvwdE72ox/hl6tTqgj2WbZrHzOsD96ZGoJdEFnhPejwt2uyg1Q
         vtdjmDMl2Ra46rLja0n9G+q0WuB2Y4oxEdlASEvEWtPHf3JhIa5juv8dwgaJOm1M7zFf
         Vji2lnBwMvHoQCU5WrSlOupyfq9F1zLdwrOQ5JbQubLY7ZOV+URN0ex05fi6REm4VNqM
         qyxw==
X-Gm-Message-State: AOUpUlFTx8J/N9J8e7Z+15eneJG0qbVhjS8klcbswQTy83PdxKYDXOgF
        tOWZhtUfr0HXYxeoCr3pQxLKAxeP4tT2OPVUWW/i8oMFzIj0
X-Google-Smtp-Source: AAOMgpeJI9gRkWKZWCRbAU36jc7TSEbbDEjkMWbWcpzVI6jngyBAg6c8425x5IvBJj7mhI9Sofvna5VK8dVO/8tFyStQqr4Re+1N
MIME-Version: 1.0
X-Received: by 2002:a24:6253:: with SMTP id d80-v6mr2963900itc.23.1532697122101;
 Fri, 27 Jul 2018 06:12:02 -0700 (PDT)
Date:   Fri, 27 Jul 2018 06:12:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082e3a90571fadb4c@google.com>
Subject: KMSAN: uninit-value in sit_tunnel_xmit
From:   syzbot <syzbot+782ee96f9147673d8822@syzkaller.appspotmail.com>
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

HEAD commit:    d1c2a46a46f6 kmsan: update LLVM/Clang patches to r337583.
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=17d4570c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31cf75cbffdedb44
dashboard link: https://syzkaller.appspot.com/bug?extid=782ee96f9147673d8822
compiler:       clang version 7.0.0 (trunk 334104)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+782ee96f9147673d8822@syzkaller.appspotmail.com

IPVS: Scheduler module ip_vs_mh not found
==================================================================
BUG: KMSAN: uninit-value in __ipv6_prefix_equal64_half  
include/net/ipv6.h:522 [inline]
BUG: KMSAN: uninit-value in ipv6_prefix_equal include/net/ipv6.h:539  
[inline]
BUG: KMSAN: uninit-value in check_6rd net/ipv6/sit.c:771 [inline]
BUG: KMSAN: uninit-value in try_6rd net/ipv6/sit.c:805 [inline]
BUG: KMSAN: uninit-value in ipip6_tunnel_xmit net/ipv6/sit.c:865 [inline]
BUG: KMSAN: uninit-value in sit_tunnel_xmit+0x1ad3/0x3b00  
net/ipv6/sit.c:1029
CPU: 0 PID: 7135 Comm: syz-executor4 Not tainted 4.18.0-rc5+ #29
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1e0 lib/dump_stack.c:113
  kmsan_report+0x195/0x2c0 mm/kmsan/kmsan.c:982
  __msan_warning+0x7d/0xe0 mm/kmsan/kmsan_instr.c:645
IPVS: Scheduler module ip_vs_mh not found
  __ipv6_prefix_equal64_half include/net/ipv6.h:522 [inline]
  ipv6_prefix_equal include/net/ipv6.h:539 [inline]
  check_6rd net/ipv6/sit.c:771 [inline]
  try_6rd net/ipv6/sit.c:805 [inline]
  ipip6_tunnel_xmit net/ipv6/sit.c:865 [inline]
  sit_tunnel_xmit+0x1ad3/0x3b00 net/ipv6/sit.c:1029
  __netdev_start_xmit include/linux/netdevice.h:4148 [inline]
  netdev_start_xmit include/linux/netdevice.h:4157 [inline]
  xmit_one net/core/dev.c:3034 [inline]
  dev_hard_start_xmit+0x60f/0xcc0 net/core/dev.c:3050
  __dev_queue_xmit+0x3060/0x3c70 net/core/dev.c:3569
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3602
  packet_snd net/packet/af_packet.c:2919 [inline]
  packet_sendmsg+0x8469/0x9010 net/packet/af_packet.c:2944
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg net/socket.c:651 [inline]
  ___sys_sendmsg+0xed9/0x1350 net/socket.c:2125
  __sys_sendmsg net/socket.c:2163 [inline]
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x3b0/0x520 net/socket.c:2170
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f68d21b1c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f68d21b26d4 RCX: 0000000000455ab9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c1066 R14: 00000000004d16c8 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xc8/0x1d0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0xa1/0x120 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2720 [inline]
  __kmalloc_node_track_caller+0xb48/0x11d0 mm/slub.c:4353
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cb/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  alloc_skb_with_frags+0x1e6/0xb80 net/core/skbuff.c:5271
  sock_alloc_send_pskb+0xb59/0x11e0 net/core/sock.c:2095
  packet_alloc_skb net/packet/af_packet.c:2776 [inline]
  packet_snd net/packet/af_packet.c:2867 [inline]
  packet_sendmsg+0x68cb/0x9010 net/packet/af_packet.c:2944
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg net/socket.c:651 [inline]
  ___sys_sendmsg+0xed9/0x1350 net/socket.c:2125
  __sys_sendmsg net/socket.c:2163 [inline]
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x3b0/0x520 net/socket.c:2170
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
