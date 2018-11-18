Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B37DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D582080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D582080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeKSFoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:44:10 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:56585 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeKSFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:44:10 -0500
Received: by mail-it1-f199.google.com with SMTP id m123-v6so5655653ite.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 11:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xckNjoI1N9Po7xSog+y6hmjguNeDoGCnvE26MxUqkTk=;
        b=hwu3Ka1S8cHCH0XJH58FnEzbdXW5gB3yNi9WXmOeMAv+fGvj4F+hARmzPDlxLrOmQE
         QLrUwcYpV9miYxuDiS9TIiGxj67XttwuvfKoSdj+U1X3VdwwRXsU67zDaS40xSnOi6u/
         XqWKQ58771hJzL6GVkJ5Kq+7SKynTRCMWtOrzUbhV4233YMpA+aIY836BjBhymcqXMHP
         GTwRpP0Kac+yFpDyDQQYFL4QUy8jgXR0qaD22rBE/B1O8QsmNu43dRFdH7iDWg8rVuc0
         /3c6dbW86tLuDY8qSCdyjMQ0Wc2sfIrsfRFI9TnhHJaY/W7EDqeBUj6cExWQRrV1vxK+
         akkA==
X-Gm-Message-State: AA+aEWZmtbKFokhDWHJRP0Q/sIcdr0HXZ8nfg0CTPLUyPRbnTHCT9mFc
        ywZUzvY3OMtyeo9faz93Pl5AtHB50Kwi5BqOw79+c4Hv70U+
X-Google-Smtp-Source: AFSGD/X1GBU91fvro9elyLNwJdr1d3vzKuAvamJ7Lxtx0V9A/8ZibGLkpOK/owy5W+ah9UCo0HWCWIJg/oFQ0fHk8JgapVp3Qjgx
MIME-Version: 1.0
X-Received: by 2002:a6b:6c14:: with SMTP id a20-v6mr10161581ioh.24.1542568983315;
 Sun, 18 Nov 2018 11:23:03 -0800 (PST)
Date:   Sun, 18 Nov 2018 11:23:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae11b057af5543f@google.com>
Subject: BUG: unable to handle kernel paging request in aead_geniv_alloc
From:   syzbot <syzbot+cd50d1708db841432d8a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9c549a6b0573 selftests: add explicit test for multiple con..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a46f7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=cd50d1708db841432d8a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd50d1708db841432d8a@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at fffffffffffffff0
PGD 946d067 P4D 946d067 PUD 946f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9032 Comm: cryptomgr_probe Not tainted 4.20.0-rc2+ #300
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'loop1' (00000000f780ed70): kobject_uevent_env
RIP: 0010:aead_geniv_alloc+0x2de/0x780 crypto/aead.c:240
Code: 00 00 fc ff df 49 8d 7c 24 f0 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89  
f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ea 03 00 00 <45> 8b 74 24 f0  
bf 07 00 00 00 48 c7 c3 ea ff ff ff 44 89 f6 e8 59
RSP: 0018:ffff8881946b7e40 EFLAGS: 00010246
kobject: 'loop1' (00000000f780ed70): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff835c1711
RDX: 0000000000000000 RSI: ffffffff835c171e RDI: fffffffffffffff0
RBP: ffff8881946b7e80 R08: ffff8881975da540 R09: ffffed10328d6fa3
R10: ffffed10328d6fa3 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8881d3ee66b0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff0 CR3: 000000019a8d0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  seqiv_aead_create crypto/seqiv.c:149 [inline]
  seqiv_create+0x99/0x290 crypto/seqiv.c:190
  cryptomgr_probe+0x6d/0x280 crypto/algboss.c:75
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: fffffffffffffff0
---[ end trace e6ac52e6f5849122 ]---
RIP: 0010:aead_geniv_alloc+0x2de/0x780 crypto/aead.c:240
Code: 00 00 fc ff df 49 8d 7c 24 f0 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89  
f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 ea 03 00 00 <45> 8b 74 24 f0  
bf 07 00 00 00 48 c7 c3 ea ff ff ff 44 89 f6 e8 59
RSP: 0018:ffff8881946b7e40 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff835c1711
RDX: 0000000000000000 RSI: ffffffff835c171e RDI: fffffffffffffff0
RBP: ffff8881946b7e80 R08: ffff8881975da540 R09: ffffed10328d6fa3
R10: ffffed10328d6fa3 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8881d3ee66b0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff0 CR3: 000000019a8d0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
