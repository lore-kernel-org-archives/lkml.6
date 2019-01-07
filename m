Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEACB2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfAGNrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:47:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:46764 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfAGNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:47:06 -0500
Received: by mail-io1-f70.google.com with SMTP id o22so289609iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 05:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nEoBg9cz2eoFXXFHVo4xDFlDrQCFDjEXyuZqzifgFgI=;
        b=MxqKebSMBHSO1MWM8rdUeVhmG+aGRXyqD7tv2Radg07Hwz6fpNF1iX0msBL3FkFpmI
         yeM9xXkFS3utN2EaeMk14TQNZwckI4MycdNnLW9ecRhCcmEGJlrKq1Ho8np8uGLtAcCT
         Phix4D58Gv7nWUFlSFrSS7v56HOKAR67bcV7t2aPYAScdeZ8emqiOjHjZsFJL9oMhzhc
         rsp+hOdxaPXwAC0Ba48zbZax+8sM5cNUO+3Qj6uVdI0H5xZowjqJZ3XL6sN9eLsNMHaz
         CdiV/BzJlLFptf5weT1CfKZrlXyqTUds9IiZEMOVuaUZrX0Zz2vAJm1c4W1nZiqVmVrd
         ht+A==
X-Gm-Message-State: AJcUukcCatn4ndgOhUp6EIIbgrrvGwMaGjMVSGrGN0OvLujGhjhLc/rB
        W4HJQGUo1GDfxRCb4/SU1EBMOwOV4KzdEtQ3KYTUMpJVDaz8
X-Google-Smtp-Source: ALg8bN4+ZOLLr+hvtWwot5Pv5DDaMoDnzT0zOTrEz9mewV0TYDMom6onbueJ9OjXzINsWqU5PboXEP69WCwvxmA0PbpUrHu9VVMb
MIME-Version: 1.0
X-Received: by 2002:a24:5f49:: with SMTP id r70mr9062416itb.22.1546868824241;
 Mon, 07 Jan 2019 05:47:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 05:47:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb7033057ede764e@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_link_reset_stats
From:   syzbot <syzbot+e01d94b5a4c266be6e4c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ba10281f9e5 Fix comment style, NFC
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10b4c3bf400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a62a4eb8ea3e9f
dashboard link: https://syzkaller.appspot.com/bug?extid=e01d94b5a4c266be6e4c
compiler:       clang version 8.0.0 (trunk 350161)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13527dbf400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e01d94b5a4c266be6e4c@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
==================================================================
BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:486
CPU: 1 PID: 11057 Comm: syz-executor0 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:295
  strlen+0x3b/0xa0 lib/string.c:486
  nla_put_string include/net/netlink.h:1154 [inline]
  tipc_nl_compat_link_reset_stats+0x1f0/0x360 net/tipc/netlink_compat.c:760
  __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
  tipc_nl_compat_doit+0x3aa/0xaf0 net/tipc/netlink_compat.c:344
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1107 [inline]
  tipc_nl_compat_recv+0x14d7/0x2760 net/tipc/netlink_compat.c:1210
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x444/0x640 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0xf40/0x1020 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2557338c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f25573396d4
R13: 00000000004cb478 R14: 00000000004d86c8 R15: 00000000ffffffff

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2759 [inline]
  __kmalloc_node_track_caller+0xe18/0x1030 mm/slub.c:4383
  __kmalloc_reserve net/core/skbuff.c:137 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:205
  alloc_skb include/linux/skbuff.h:998 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
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
