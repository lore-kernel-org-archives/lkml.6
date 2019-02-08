Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D12177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBHMGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:06:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:37125 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBHMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:06:04 -0500
Received: by mail-it1-f200.google.com with SMTP id t18so5493151itk.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uFHk7gqmsiwTVHv2xBQuMDNoFY8PTVtwS7Gn2BPD5xE=;
        b=gG8rRigNcAXVeijPudWusqjQ1hZF3HWc4YX+YztiiOib5sUf8iFqRR4A4lsQTJzK5E
         +184c0YfbqyToi+pAJ5aSCGCtIogOc5crpFvzkwiJx0gW+PnaQNag8Q1kmtyt1IknPgk
         AWJ+xwo8ALJSow9oaez5/L4CX6LgqyH9NILfIyT906pbZkgDN2/DK/W6MLOKdpeXx8aE
         Wij32h3fq36B6EqVodm45SkDj2ezIHdrSTNQJMquBoc9ej5rFqB+NKvLnU/MZm9UutIt
         kUbAyKui/2Lk+NqDCGH/0vBJUm73E2ufqPoz7a9lFCDjz0/1Hh9tn2PzKR78y9BPNLuk
         10gA==
X-Gm-Message-State: AHQUAubZlNbN2FO1pUkRP6NMp6WMQ4+cruH1gCQzGyto8ZEXz9si52cz
        oV2bflEHYVeSWehtK1m94Isj33d8Ve/o3KZXwpCA46vKndB8
X-Google-Smtp-Source: AHgI3IY5h/gHv9yhUuRPdEA02U4DisDvBrX7BewIO6VyWctYjynLZFOb6USxSbM7KnTg/iuXQkCTasyY3GMCK4/kALVJIEAmXoJv
MIME-Version: 1.0
X-Received: by 2002:a24:6504:: with SMTP id u4mr8991783itb.25.1549627563255;
 Fri, 08 Feb 2019 04:06:03 -0800 (PST)
Date:   Fri, 08 Feb 2019 04:06:03 -0800
In-Reply-To: <000000000000fa6a2c057e8b7064@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000713147058160c8d9@google.com>
Subject: Re: general protection fault in prepare_to_wait
From:   syzbot <syzbot+55f9d3e51d49e20b2ce5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ec7fd009e87c Merge branch 'ipv6-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc3d97400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=55f9d3e51d49e20b2ce5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16970150c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55f9d3e51d49e20b2ce5@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
8021q: adding VLAN 0 to HW filter on device batadv0
8021q: adding VLAN 0 to HW filter on device batadv0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7733 Comm: syz-executor3 Not tainted 5.0.0-rc4+ #67
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 25 9a 89 0f 84 03 f8
RSP: 0018:ffff888088fa7970 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000018
RBP: ffff888088fa7b40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000018
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888098fc60c0
FS:  00007f2176cc4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f763933ddb8 CR3: 0000000088560000 CR4: 00000000001406f0
Call Trace:
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
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2176cc3c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000073c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2176cc46d4
R13: 00000000004bdc10 R14: 00000000004cdea0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 82c8ff081ad12861 ]---
RIP: 0010:__lock_acquire+0x8df/0x4700 kernel/locking/lockdep.c:3215
Code: 28 00 00 00 0f 85 35 27 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 dc 27 00 00 49 81 3c 24 20 25 9a 89 0f 84 03 f8
RSP: 0018:ffff888088fa7970 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000018
RBP: ffff888088fa7b40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000018
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888098fc60c0
FS:  00007f2176cc4700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f763933ddb8 CR3: 0000000088560000 CR4: 00000000001406f0

