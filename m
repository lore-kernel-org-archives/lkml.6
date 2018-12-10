Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A45C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CB920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLJFlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:41:07 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:47060 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeLJFlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:41:06 -0500
Received: by mail-io1-f69.google.com with SMTP id n25so10477963iog.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 21:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rUxYaTXcYK7s1pzNlrbKUUc5vmVnmcZUY614ZLM5Klk=;
        b=HZ6k3uDatiJ+HKDjyKVJgjExvpghOi3mr0HBg+mqojM8s3bVUGxy1C2seS5fhEM2p4
         X/baHvHhDCqV8OVtDps3XaxVwvM65VyZ7hV/gmnLMrM/QmFaW3iRkudJ5d76QiHJNz+p
         O7EgibdlHB+vANU+xpq+9/IQYyGBCTiw3pnpUYVv6RbG56v+Htat3GxcAnFCCKzFuY2i
         HPb4TS6RAJbMxjUzfNZtJfKs80aZQxsQ93xaFspzBDB2RRY2DcXkUcdlJ/26mJJzetyX
         9trhOvubn1+HXnMWoQX9C7ECUiiHCupGpWsBFMExa8JEV/lssTwV9HKlo2HT4Bdk+9Rz
         E2xw==
X-Gm-Message-State: AA+aEWarGCuETNnsvzr+ogOoyM9+0A59kHExLc7NNyZazH4UHsERo/Z+
        5I1BFHbOUbtkVPZ4ekHaeNE+owx1zi13uOeFasW1KfV/kjv9
X-Google-Smtp-Source: AFSGD/WmtI80xFfaiD3sKWGyjxXE6/t+fMC8WPNcytJdG3VFITqp+3p4eV7GyN+ku8mowqXPsRp2WvlNS177lr8R6gBjdnO3Wa17
MIME-Version: 1.0
X-Received: by 2002:a24:7381:: with SMTP id y123mr8636978itb.32.1544420465137;
 Sun, 09 Dec 2018 21:41:05 -0800 (PST)
Date:   Sun, 09 Dec 2018 21:41:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003560d6057ca46992@google.com>
Subject: BUG: corrupted list in neigh_mark_dead
From:   syzbot <syzbot+6cc2fd1d3bdd2e007363@syzkaller.appspotmail.com>
To:     christian@brauner.io, davem@davemloft.net, dsahern@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com, w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    83af01ba1c2d Merge branch 'tc-testing-next'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14cea3f5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ecefa8a6e10719
dashboard link: https://syzkaller.appspot.com/bug?extid=6cc2fd1d3bdd2e007363
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141032db400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150bb3d5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6cc2fd1d3bdd2e007363@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff8881b4412b70, but was  
ffff8881d5d58ff0
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 2770 Comm: kworker/0:2 Not tainted 4.20.0-rc4+ #333
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: d6 60 88 e8 b2 fd d1 fd 0f 0b 48 89 de 48 c7 c7 40 d8 60 88 e8 a1 fd  
d1 fd 0f 0b 48 89 de 48 c7 c7 e0 d7 60 88 e8 90 fd d1 fd <0f> 0b 48 89 d9  
48 c7 c7 a0 d8 60 88 e8 7f fd d1 fd 0f 0b 48 89 f1
RSP: 0018:ffff8881cda97440 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8881b4412b70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eae5 RDI: 0000000000000005
RBP: ffff8881cda97458 R08: ffff8881cdb4e400 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881bb333930
R13: ffff8881d13d62b0 R14: ffff8881cda97560 R15: 1ffff11039b52e94
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004155d0 CR3: 00000001c1769000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125
  neigh_periodic_work+0x89a/0xc30 net/core/neighbour.c:905
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 4c84591405102c9f ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: d6 60 88 e8 b2 fd d1 fd 0f 0b 48 89 de 48 c7 c7 40 d8 60 88 e8 a1 fd  
d1 fd 0f 0b 48 89 de 48 c7 c7 e0 d7 60 88 e8 90 fd d1 fd <0f> 0b 48 89 d9  
48 c7 c7 a0 d8 60 88 e8 7f fd d1 fd 0f 0b 48 89 f1
RSP: 0018:ffff8881cda97440 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff8881b4412b70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eae5 RDI: 0000000000000005
RBP: ffff8881cda97458 R08: ffff8881cdb4e400 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881bb333930
R13: ffff8881d13d62b0 R14: ffff8881cda97560 R15: 1ffff11039b52e94
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004155d0 CR3: 00000001c1769000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
