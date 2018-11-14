Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F20CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707BE223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707BE223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeKNRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:20:07 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:41057 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKNRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:20:06 -0500
Received: by mail-it1-f197.google.com with SMTP id s195-v6so19882807itc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y/yWg3YYGycwr3bmHMHa6kV/M3YgU5C4ix25R3xyHjM=;
        b=EnJtqJ2UIT/K7KoVBt0IHFjMJnhVdERXQ0p9UxI0YJMs7OnVhwrt06UkSqvvXRgWDz
         zkUw00gs5B8nozQfICGW6iVnvETOXBfp6e6vbzVYd7Z7kzdniqO05G6IA8dYkEKEpO8G
         2lwQ8kmTPIusUrkkBMvj6qsuHG4YjKxxTBFLPM4onDHh77BtMVeml4YJ9ROATY+rV06U
         khHsV+XpvJ3dW4a/QnwQuHLEeoNi9zg5m0UlOebmI8sZQCWoXixzL5FUZZMbz4huRA57
         hkYXux5XWQ+9R1bW3moMPsExTbRIXpL0v6sELEN+hwwS4krkJ9ny0PA1gooN2D/kxTdD
         XxWw==
X-Gm-Message-State: AGRZ1gJ4hGfBvWm9onVRmMLX7veD3j2GTupr4jgN+pOXXQu3nbC8exoc
        RXLN0pWl5PlkKNxnzmYHtWCbO5FBUgqrd8QQ9yFppRO1a3xX
X-Google-Smtp-Source: AJdET5fu8AlgtZKiN43cqDmRdnxUh75ea8ZBjEWcgcQi/eEGE0iEWo8c9W4jp6AAoFSjqYHsXd03X8FpSSGG1yr95VIR/ZHwxNkm
MIME-Version: 1.0
X-Received: by 2002:a24:4597:: with SMTP id c23mr748646itd.20.1542179887212;
 Tue, 13 Nov 2018 23:18:07 -0800 (PST)
Date:   Tue, 13 Nov 2018 23:18:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b7456057a9abc57@google.com>
Subject: kernel BUG at mm/slab.c:LINE! (3)
From:   syzbot <syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3e536cff3424 net: phy: check if advertising is zero using ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f95b83400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=2182db487a523d86bf34
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d46d5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6a225400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH)
------------[ cut here ]------------
kernel BUG at mm/slab.c:4425!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: -642842048 Comm: ksoftirqd/0 Not tainted 4.20.0-rc2+ #294
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
Code: 48 c7 c7 15 73 12 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
15 73 12 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 d0 73
RSP: 0018:ffff8881d9af0030 EFLAGS: 00010093
RAX: 00000000000a57eb RBX: 1ffff1103b35e00d RCX: 000000000000000c
RDX: ffff8881d9af0240 RSI: 0000000000000002 RDI: ffff8881d9af01d8
RBP: ffff8881d9af0030 R08: ffff8881d9af0240 R09: ffff8881da970180
R10: 000000004afd69e7 R11: 0000000000000000 R12: ffff8881d9af01d8
R13: 0000000000000002 R14: ffffea000766bc00 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 00000001bb987000 CR4: 00000000001406f0
Call Trace:
Modules linked in:
---[ end trace 1c9eb38e9e38ee03 ]---
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
Code: 48 c7 c7 15 73 12 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
15 73 12 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 d0 73
RSP: 0018:ffff8881d9af0030 EFLAGS: 00010093
RAX: 00000000000a57eb RBX: 1ffff1103b35e00d RCX: 000000000000000c
RDX: ffff8881d9af0240 RSI: 0000000000000002 RDI: ffff8881d9af01d8
RBP: ffff8881d9af0030 R08: ffff8881d9af0240 R09: ffff8881da970180
R10: 000000004afd69e7 R11: 0000000000000000 R12: ffff8881d9af01d8
R13: 0000000000000002 R14: ffffea000766bc00 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000068 CR3: 00000001bb987000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
