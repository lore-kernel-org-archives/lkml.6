Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C235C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B4204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfAGHyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:54:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:56439 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfAGHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:54:04 -0500
Received: by mail-it1-f198.google.com with SMTP id x3so6531818itb.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 23:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FTUlPXJciqbFcRhh7J7/3a06hNyV70+mcMgpxB8F9u0=;
        b=GiDwbN7w2q9R7Z1VYQ5einuxpm7407dAw99zGAiXjJeP1Qu1oIPRlnaYBWBHbWY/fg
         1bbHFlLTx5ePEltV3ZPEqsAv3Drtd+PjS/0pdwOFCHnrNc3a+44Wd+aKU5IwwlSg/0qs
         wE4TFgvmPtj2abiJs2MKtYeZ8bqMFNy3J2sEaNEmOXGMd5yS41HY5ixOC74oGXjIQyqH
         fUWrf+YhN+SMtm0gRA38SDg215FgA9GY0RbuvxVu7vHm0HRP0PwYZKWiG+5hYlK3Z7N9
         z4S2SJZUtKcLiJGJRcpnLdBJcdb5/jBBeoaCcy3TQS+foBSxJoN5NrlOMsZr7D31xqq0
         XldA==
X-Gm-Message-State: AJcUukcmXFS4i5LI1lal0uYZJMAImLH80Z/1yu4+v8x2vZrN4YkF8y7z
        mb6+z5h1DClN62xbuqIIZ2mLJPyLq2Qk/MhOCJnXU0K9kCXr
X-Google-Smtp-Source: ALg8bN7CNwiEZtpK7sr2IlAwYKZGlwuYo4txZ4TZ4YiO7Uu0FUk0Ohk5EzEbjAtGtcY0TVZ+NsYQ2kMaJ4ftm/2Foq5fAwbEGKxO
MIME-Version: 1.0
X-Received: by 2002:a5d:9683:: with SMTP id m3mr31915451ion.28.1546847643263;
 Sun, 06 Jan 2019 23:54:03 -0800 (PST)
Date:   Sun, 06 Jan 2019 23:54:03 -0800
In-Reply-To: <0000000000005f1f37057d4b7d95@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c6b32057ed9888f@google.com>
Subject: Re: KMSAN: uninit-value in tipc_nl_compat_link_set (2)
From:   syzbot <syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    11587f6ee534 kmsan: remove pr_err
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=114c539b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8a62a4eb8ea3e9f
dashboard link: https://syzkaller.appspot.com/bug?extid=d78b8a29241a195aefb8
compiler:       clang version 8.0.0 (trunk 350161)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173b7180c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262adab400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:486
CPU: 1 PID: 9306 Comm: syz-executor172 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
  strlen+0x3b/0xa0 lib/string.c:486
  nla_put_string include/net/netlink.h:1154 [inline]
  __tipc_nl_compat_link_set net/tipc/netlink_compat.c:708 [inline]
  tipc_nl_compat_link_set+0x929/0x1220 net/tipc/netlink_compat.c:744
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
RIP: 0033:0x440e29
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff7fdb6888 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440e29
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000001fb6880 R11: 0000000000000213 R12: 0000000000012572
R13: 0000000000401e00 R14: 0000000000000000 R15: 0000000000000000

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

