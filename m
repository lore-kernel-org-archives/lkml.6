Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4237821B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfBOFnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:43:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:54075 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfBOFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:43:05 -0500
Received: by mail-it1-f200.google.com with SMTP id i65so13187188ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6jNYw0T72ST0FtxhvkrdbTe9tp72k7Y6cPqgdslehrQ=;
        b=pjkuvQQQGA8Z4rBk3uXS5rhBEwWb6Oe/RrJew5pJD+/6vP62SASECJKoBAnfRytuhw
         3DQ+Qka3aSiL+gj4s41+OeMjd0PFGaGFJpGJv+08h//YxX+VLN14xgSJ8diQ0zwA1sR2
         /LQISsP8TTWl9y0WZvGbyFUn9rOnt7vdNJUtZXNlJxoQB7bney38tSSrmyFsw+OyYNgE
         c9RatOEglB9zKM1FWgNEtds3a7kGK9/Rgu9sqLCxMb0UNNq7H/Rb6YCC6mER5kbAVKn0
         F4CQHKxHRsZEOEV/WNfjTbQJpRu9KtXuFu5Mgz47395q4ZjAzvBDonTcYkDjd5MM05R0
         8DRA==
X-Gm-Message-State: AHQUAuYKkzOpl3kDSUWar1yR8rUBl0A4KFlU7tpepUd+KWvCwNk6rB5l
        lpfyvX2PoLRzAJWxFILaqlr6NObd5jYt7N+6b4uocpXpC7oI
X-Google-Smtp-Source: AHgI3Ia9koOUCdENUEQoFgSjbxT4AjHKGmN7PlG87pPYWM0w6Cfavj86cFjw5sxuDuTMwEOuIi1rOz1HHhgHfHP4hiOTefBKz+nM
MIME-Version: 1.0
X-Received: by 2002:a02:241e:: with SMTP id f30mr4526606jaa.11.1550209384076;
 Thu, 14 Feb 2019 21:43:04 -0800 (PST)
Date:   Thu, 14 Feb 2019 21:43:04 -0800
In-Reply-To: <000000000000fa6a2c057e8b7064@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa5e800581e83fa8@google.com>
Subject: Re: general protection fault in prepare_to_wait
From:   syzbot <syzbot+55f9d3e51d49e20b2ce5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    23e93c9b2cde Revert "gfs2: read journal in large chunks to..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e94014c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=55f9d3e51d49e20b2ce5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109c886cc00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ed20d0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55f9d3e51d49e20b2ce5@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_hsr: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
kasan: CONFIG_KASAN_INLINE enabled
8021q: adding VLAN 0 to HW filter on device batadv0
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7785 Comm: syz-executor295 Not tainted 5.0.0-rc6+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 25 9a 89 0f 84 03 f8
RSP: 0018:ffff888094c6f970 EFLAGS: 00010006
kobject: 'vlan0' (00000000d30c60ff): kobject_add_internal: parent: 'mesh',  
set: '<NULL>'
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000018
RBP: ffff888094c6fb40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000018
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88808c0f00c0
FS:  00007f9abeeec700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
8021q: adding VLAN 0 to HW filter on device batadv0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'vlan0' (00000000a54e32cc): kobject_add_internal: parent: 'mesh',  
set: '<NULL>'
CR2: 00000000004d0910 CR3: 00000000906d2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
8021q: adding VLAN 0 to HW filter on device batadv0
Call Trace:
kobject: 'vlan0' (0000000016be0e34): kobject_add_internal: parent: 'mesh',  
set: '<NULL>'
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:152
  prepare_to_wait+0x7c/0x300 kernel/sched/wait.c:230
  nr_accept+0x239/0x790 net/netrom/af_netrom.c:796
  __sys_accept4+0x350/0x6a0 net/socket.c:1588
  __do_sys_accept net/socket.c:1629 [inline]
  __se_sys_accept net/socket.c:1626 [inline]
  __x64_sys_accept+0x75/0xb0 net/socket.c:1626
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449489
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9abeeebcc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 00000000006dfc68 RCX: 0000000000449489
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006dfc60 R08: 00007f9abeeec700 R09: 0000000000000000
R10: 00007f9abeeec700 R11: 0000000000000246 R12: 00000000006dfc6c
R13: 00007ffe8979730f R14: 00007f9abeeec9c0 R15: 0000000000000002
Modules linked in:
---[ end trace 91ccd60fc619e2e6 ]---
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 25 9a 89 0f 84 03 f8
RSP: 0018:ffff888094c6f970 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000018
RBP: ffff888094c6fb40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000018
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88808c0f00c0
FS:  00007f9abeeec700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d0910 CR3: 00000000906d2000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

