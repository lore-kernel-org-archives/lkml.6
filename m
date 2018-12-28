Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D020869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeL1TvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:51:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:36398 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbeL1TvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:51:04 -0500
Received: by mail-it1-f198.google.com with SMTP id w15so26304969ita.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vO+sy5ajdT1RB/SBCsLDHsVtjeChrmgh8EMOQPPpINo=;
        b=SVm6kNRUP2MrriV9lj4hGD7vg8lLFgFO2x0sx9RGumVTVTL7VqB9nvS4MCEWpMUy3X
         ZjOlUK+jsiQnZUZ+ZxxTtFidhhGPJ988H5XK4ibM2gGppaBnTKuzt2LPi7OFvI3Uy/lt
         pRR7d7xvHgoSpDFhBgTMriWk1Hw+M1qtL+JxHT4+a8GdY3SSbNCI+7U8afYIFI5O9/aq
         M5TxuhtW546PfpkVIt5k9y/sk0ocB6Y0FC9FgzPDhusN1oJTwL7Ijl83b9zrBK8r7/gX
         a9wegQSTXn2MlO+GPYHjtDZQSmfXsDVu1Sk0s0l9aQvnL/1VttqLM+p0S0VDQ3PjZIK8
         fvKg==
X-Gm-Message-State: AA+aEWa+xVxC94awqoYGOtDX9O/buSfILQwZ7fBxipCVdIRCNd9Zl+ji
        cZB+qzaPBC87N0zSHq01glgx2vgiIJ+QwvAS3QV+zZkj0/ic
X-Google-Smtp-Source: AFSGD/VJJMJuzC2al3sNU1u/OYbpTlAWPbF9wCQJTIyery/BazQuuGyW2BbvMV6P1MXqfXEyWoHrOfYqShOs2+88jZ5FHLFlG59Q
MIME-Version: 1.0
X-Received: by 2002:a24:f986:: with SMTP id l128mr21121565ith.5.1546026663644;
 Fri, 28 Dec 2018 11:51:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000199a53057e1a62ff@google.com>
Subject: general protection fault in ax25cmp
From:   syzbot <syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d8924c0d76aa Merge tag 'devprop-4.21-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145051dd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
dashboard link: https://syzkaller.appspot.com/bug?extid=1a2c456a1ea08fa5b5f7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1683ae57400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1410f3af400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1a2c456a1ea08fa5b5f7@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2660 Comm: aoe_tx0 Not tainted 4.20.0+ #388
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48 89 75  
c8 e8 ff 46 7f fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
RSP: 0018:ffff8881ce3cf3c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8881c5a59800 RCX: 0000000000000001
RDX: 0000000000000007 RSI: ffffffff86ff11d1 RDI: 0000000000000017
RBP: ffff8881ce3cf400 R08: ffffed1039c79e70 R09: ffffed1039c79e6f
R10: ffffed1039c79e6f R11: 0000000000000003 R12: ffff8881c5a59808
R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe5864d7d4 CR3: 000000000946a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rose_route_frame+0x2d6/0x19b0 net/rose/rose_route.c:885
  rose_xmit+0x8e/0x180 net/rose/rose_dev.c:110
  __netdev_start_xmit include/linux/netdevice.h:4356 [inline]
  netdev_start_xmit include/linux/netdevice.h:4365 [inline]
  xmit_one net/core/dev.c:3257 [inline]
  dev_hard_start_xmit+0x295/0xc90 net/core/dev.c:3273
  __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3843
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3876
  tx+0x77/0xd0 drivers/block/aoe/aoenet.c:63
  kthread+0x296/0x4a0 drivers/block/aoe/aoecmd.c:1248
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 623634688d1951e4 ]---
RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48 89 75  
c8 e8 ff 46 7f fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
RSP: 0018:ffff8881ce3cf3c8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8881c5a59800 RCX: 0000000000000001
RDX: 0000000000000007 RSI: ffffffff86ff11d1 RDI: 0000000000000017
RBP: ffff8881ce3cf400 R08: ffffed1039c79e70 R09: ffffed1039c79e6f
R10: ffffed1039c79e6f R11: 0000000000000003 R12: ffff8881c5a59808
R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe5864d7d4 CR3: 000000000946a000 CR4: 00000000001406e0
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
