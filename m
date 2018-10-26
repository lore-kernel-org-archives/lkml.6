Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E1ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAAE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAAE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJ0H05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:26:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44583 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbeJ0H04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:26:56 -0400
Received: by mail-io1-f69.google.com with SMTP id s15-v6so2318676iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cuxNWJy/QU5bXR4IoqgTdOiHEYSFp22IWMOv4bN4Yqw=;
        b=AUP2C94OGo7JWZqfIzZs/pZHjR9p5MNsnZQsPuN9Gi7hMPggprxyQnqtGPMLALHFNO
         opeYExoElRfraURzAAVC+LX8HJdVA+TXstJwPYU5VUvfTEJHSy4dwwdGuh6BjtByFL4p
         oVJFpSY8EPWDNZpjj+M5b1F4HyZ/dcqQpwc6GgVFDC9trRHwqcjyMQksLbYjwpqlKqyf
         Ta15DGYqMNmEn7oF/fQcE6MgUFnQCntVjQ9DkTGY84ndlbMQbubzu/Zev0YVNCROPveT
         E6ckc5StjBFoo8nUckJHM0V+/01bFs1Pkg7KPWowBg04MjkMxTHpmzTMRoUnkfa9VFC0
         QYgQ==
X-Gm-Message-State: AGRZ1gK3NudpellHwOi9w4IMTFFd61hVbaTBHwoGmoVZdeMCEfCJ0jG8
        305htSVk7l81m8KbzXzJGHzp/73aG873jCNDto/EB8ypTw8i
X-Google-Smtp-Source: AJdET5dxG4KtcIxoJRb8xTA1oybGMPSbI+n9CJtER7rFVHC1ADTIjS7Xd4cv4b6Us7eQZ8EMq7rtueVL/UlGrCvQWHsoH0D+FKIZ
MIME-Version: 1.0
X-Received: by 2002:a6b:6c14:: with SMTP id a20-v6mr1612199ioh.24.1540594084010;
 Fri, 26 Oct 2018 15:48:04 -0700 (PDT)
Date:   Fri, 26 Oct 2018 15:48:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ee1930579298398@google.com>
Subject: KMSAN: uninit-value in dev_mc_add_excl
From:   syzbot <syzbot+d53ab4e92a1db04110ff@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sunlw.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4bb25354f0b0 kmsan: unpoison pt_regs in do_nmi()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=11e4ae95400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36c582b1a617b1e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d53ab4e92a1db04110ff
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ac7c79400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbbf0d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d53ab4e92a1db04110ff@syzkaller.appspotmail.com

sshd (6129) used greatest stack depth: 53504 bytes left
==================================================================
BUG: KMSAN: uninit-value in memcmp+0x117/0x180 lib/string.c:863
CPU: 1 PID: 6214 Comm: syz-executor693 Not tainted 4.19.0-rc8+ #70
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x306/0x460 lib/dump_stack.c:113
  kmsan_report+0x1a2/0x2e0 mm/kmsan/kmsan.c:917
  __msan_warning+0x7c/0xe0 mm/kmsan/kmsan_instr.c:500
  memcmp+0x117/0x180 lib/string.c:863
  dev_mc_add_excl+0x165/0x770 net/core/dev_addr_lists.c:648
  ndo_dflt_fdb_add net/core/rtnetlink.c:3469 [inline]
  rtnl_fdb_add+0xe83/0x12a0 net/core/rtnetlink.c:3562
  rtnetlink_rcv_msg+0xa53/0x1590 net/core/rtnetlink.c:4730
  netlink_rcv_skb+0x394/0x640 net/netlink/af_netlink.c:2454
  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4748
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x166d/0x1720 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0x1391/0x1420 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440fd9
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe833197b8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440fd9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000010c7d
R13: 0000000000401fb0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:255 [inline]
  kmsan_internal_poison_shadow+0xc8/0x1d0 mm/kmsan/kmsan.c:180
  kmsan_kmalloc+0xa4/0x120 mm/kmsan/kmsan_hooks.c:104
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:113
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2727 [inline]
  __kmalloc_node_track_caller+0xb43/0x1400 mm/slub.c:4360
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x422/0xe90 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
  netlink_sendmsg+0xcaf/0x1420 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe47/0x1200 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x307/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xbe/0x100 arch/x86/entry/common.c:291
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
