Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032821925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfBOQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:37:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:51272 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfBOQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:37:04 -0500
Received: by mail-it1-f198.google.com with SMTP id r85so16620372itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kl6JM2GHeB1Q0ks4RYSeuqJL3U45gykCORj6keUl4Sc=;
        b=Uf0ycMm8qe4zpyeS9MSRVjOQ//fifnf+qE4BqBlHQpcpXIRrx60okzWSms5nzLj0XF
         SBG5VhbpO5f115TbAFinIFLA2P5ojEv4D2IcoGXLnE0gJi7a1NflXZ7/O+oRJLWbl2b4
         gJMoWPAytdB+13yAkTYKYR03I03JsCAD7qXtGz0kcRAmeDa0EOX2UVbYRm16y5mUJogn
         Ekrc4UE5XOmg/kBsm3fLQLBrZI61KJRw5QLj4afqxFIXcL/EL6qTVFLqSP7SzHOuEwhl
         umzzhTt82Zt8DhtI34HUooen9l6rAL86F4+Ns2KNF/QNCRHhN8S9FtscR+bxAIjiQd5x
         IJqA==
X-Gm-Message-State: AHQUAuZCryfD1L4imgw2mVywAo5zCBQG09KwBdVtBJ2CPddsJk2Cw5Rx
        ax/VtHdk258ex6xNHghvSu10dWUaO8QPTY6oNJaTIRnUArkD
X-Google-Smtp-Source: AHgI3IbGv85Bb+v0NjSWzcT08BH90+G4TbzDUAnKgWbiTuCb7NlOJ7rR8qZNDCVmH6dh4GMcHKMfsLDzoeCiwiVtjlBRkp4vTobh
MIME-Version: 1.0
X-Received: by 2002:a6b:6b09:: with SMTP id g9mr7668902ioc.22.1550248623489;
 Fri, 15 Feb 2019 08:37:03 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:37:03 -0800
In-Reply-To: <0000000000000655c0057cd141f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008447a10581f162b3@google.com>
Subject: Re: WARNING: locking bug in __queue_work
From:   syzbot <syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cb5b020a8d38 Revert "exec: load_script: don't blindly trun..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b68c8f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=6174a6c5eba4b3cdd606
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11635d24c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f2ed58c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com

Own node identity ac1414aa, cluster identity 4711
New replicast peer: 172.20.20.187
Enabled bearer <udp:syz1>, priority 10
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 7892 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7892 Comm: syz-executor432 Not tainted 5.0.0-rc6+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Code: 8b 1d 69 a5 05 08 45 85 db 0f 85 d6 f4 ff ff 48 c7 c6 e0 a3 6b 87 48  
c7 c7 40 78 6b 87 44 89 9c 24 98 00 00 00 e8 df 29 ec ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 af f4 ff ff 8b 3d dc 67 fe 08 85
RSP: 0018:ffff8880a5467250 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 00000000339133e8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815a9266 RDI: ffffed1014a8ce3c
RBP: ffff8880a5467418 R08: ffff888092346380 R09: fffffbfff1133341
R10: fffffbfff1133340 R11: ffffffff88999a03 R12: ffff888092346c40
R13: ffff888092346c4a R14: 00000000339133e8 R15: ffff888092346380
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0x23d/0x1180 kernel/workqueue.c:1437
  __queue_delayed_work+0x1d6/0x270 kernel/workqueue.c:1542
  mod_delayed_work_on+0xd8/0x200 kernel/workqueue.c:1616
  mod_delayed_work include/linux/workqueue.h:542 [inline]
  addrconf_mod_dad_work+0x3f/0xa0 net/ipv6/addrconf.c:328
  addrconf_dad_start+0x76/0xb0 net/ipv6/addrconf.c:3976
  inet6_addr_add+0x4e4/0x970 net/ipv6/addrconf.c:2930
  inet6_rtm_newaddr+0xb9f/0x14c0 net/ipv6/addrconf.c:4757
  rtnetlink_rcv_msg+0x465/0xb00 net/core/rtnetlink.c:5130
  netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5148
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  __sys_sendto+0x262/0x380 net/socket.c:1786
  __do_sys_sendto net/socket.c:1798 [inline]
  __se_sys_sendto net/socket.c:1794 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1794
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x404073
Code: ff 0f 83 d0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00  
83 3d 1d 1f 3f 00 00 75 17 49 89 ca b8 2c 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 a1 0a 00 00 c3 48 83 ec 08 e8 57 01 00 00
RSP: 002b:00000000007efa18 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000404073
RDX: 0000000000000040 RSI: 00000000007f0070 RDI: 0000000000000003
RBP: 00000000007efa80 R08: 00000000007efa20 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00000000004abc6c R14: 0000000000000000 R15: 0000000000000006
Kernel Offset: disabled
Rebooting in 86400 seconds..

