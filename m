Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19650C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDCF20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDCF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeLLLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:11:06 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:34862 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeLLLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:11:05 -0500
Received: by mail-it1-f199.google.com with SMTP id c128so5522361itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XufK6quOoWzwFJwLdozniholK6OQtdOnUksa+3LB5HM=;
        b=IT5mHnwXUsj8CljkgmJ4c0fBD6i38mkHIJ6CZhKt/ddSMRFp9XqhARAK/AJU04DmwP
         bzdXs5rWryF3P4AKfhEij5g8kRka1Nan27pmJ7p5m7iD2400M190J1HVFb/8D2mPEy8t
         9OTwNzUmOGengnJX2OOuWNwif1A+skWhQn3PDhIVRO3FxXQArKK0+ETW9kniJEgJLecN
         amKElWKZseUjtrj5oVIo7SZrMYHHI2DLdK9OKqqh6pSla2ytWjS4ZjH0iqIdWfeGFnyd
         +3CW41fYBZMMTShd7FxcgE9u780DFhJ4tBR2vG8eh4O8w/eXQpyStqz4GG+zF/RmSJSX
         DJJQ==
X-Gm-Message-State: AA+aEWaTpViwikyq8CFJciayVeFY8ODkKs2zN92WfBlxAinLAiWp18lD
        n2J2bdhTqnntTp5dNZkVgMSbCLcXM8FB2oKvLGaKeclEHfgY
X-Google-Smtp-Source: AFSGD/Wit8rXwmxKf/2Kh99AMF+2N/GdGTbsQZauzIbaysX4O/bw4B6fPSjh/PZXlx/uirjMCPJs5MyAIjHQTQgDQc789pni8bVC
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr4705504itu.3.1544613064494;
 Wed, 12 Dec 2018 03:11:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 03:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000655c0057cd141f1@google.com>
Subject: WARNING: locking bug in __queue_work
From:   syzbot <syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com>
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

HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b32705400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=6174a6c5eba4b3cdd606
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cff7d5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6174a6c5eba4b3cdd606@syzkaller.appspotmail.com

Enabled bearer <udp:syz1>, priority 10
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 7613 at kernel/locking/lockdep.c:3318  
__lock_acquire+0x1615/0x4c20 kernel/locking/lockdep.c:3318
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7613 Comm: ip Not tainted 4.20.0-rc6+ #371
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x1615/0x4c20 kernel/locking/lockdep.c:3318
Code: 00 00 8b 05 9d f2 b4 08 85 c0 89 84 24 98 00 00 00 0f 85 90 f3 ff ff  
48 c7 c6 40 67 2b 88 48 c7 c7 a0 3c 2b 88 e8 cb 66 e7 ff <0f> 0b e9 81 f3  
ff ff 48 c7 c2 e0 97 0f 8b 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8881d220eaf0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000066c3d2bf RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165e495 RDI: 0000000000000006
RBP: ffff8881d220ee78 R08: ffff8881afa064c0 R09: fffffbfff12b2314
R10: fffffbfff12b2314 R11: ffffffff895918a3 R12: 0000000000000001
R13: 0000000066c3d2bf R14: ffff8881afa06d8a R15: ffff8881afa06d68
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __queue_work+0x2ff/0x1440 kernel/workqueue.c:1417
  __queue_delayed_work+0x29f/0x380 kernel/workqueue.c:1522
  mod_delayed_work_on+0xe3/0x260 kernel/workqueue.c:1596
  mod_delayed_work include/linux/workqueue.h:542 [inline]
  addrconf_mod_dad_work+0x3b/0x90 net/ipv6/addrconf.c:328
  addrconf_dad_start+0x73/0xa0 net/ipv6/addrconf.c:3976
  inet6_addr_add+0x5c2/0x980 net/ipv6/addrconf.c:2930
  inet6_rtm_newaddr+0x1201/0x1b90 net/ipv6/addrconf.c:4757
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
RIP: 0033:0x7f22c194e320
Code: 02 48 83 c8 ff eb 8d 48 8b 05 14 7b 2a 00 f7 da 64 89 10 48 83 c8 ff  
eb c9 90 83 3d d5 d2 2a 00 00 75 10 b8 2e 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e ba 00 00 48 89 04 24
RSP: 002b:00007fffc0b2be98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fffc0b30301 RCX: 00007f22c194e320
RDX: 0000000000000000 RSI: 00007fffc0b2bed0 RDI: 0000000000000003
RBP: 00007fffc0b2bed0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000005c102fb3
R13: 0000000000000000 R14: 00000000006395c0 R15: 0000000000000000
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
