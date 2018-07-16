Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E15ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619F120873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619F120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeGPGYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:24:46 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:60373 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeGPGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:24:46 -0400
Received: by mail-it0-f70.google.com with SMTP id a10-v6so4019718itc.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 22:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qQ6EahEjQPBk77jfxiCJPLwjXu1Hn1X1APuwfCkAbeM=;
        b=Gb6smTySOZ7CaH0RVGqDAjNqRj8kkCPcsltphcaFp6xMia14CUQrSCqoJtpSLnZ8Uy
         OsOnM1+qQ9VtvlmHZ3kBKZGE8bJOFo4hDPUfa23hhJHnycCQD5WhkmCfgSihYKCeYdn9
         5EwI6fraB5Zh9EWAYN8cbKNGeMyPej1aDnd0zRo491V1w85Q5wzz/yCVr9sAeO2qSB1U
         8AFwp3kAkYeYceOQzytCo8GkoEZoDU2k7FKFZeRelPuU/g8JOwMa7OZZ3FYYApH1v/se
         6OkvBNZ4fn2FVd7o2Xd4FCpLd9AOk+y3BBo1Zs5XCornQRN3Yg4ebl9tiou99aS+e+gr
         8FDg==
X-Gm-Message-State: AOUpUlF43c3cqiKl84hcglE4GNksPNaaslcCgU8WuL7Q3BJRA/hbp613
        4N2ZD0GLRU12Y1LduLGY3SGrxFYFMHMbpkD3FnEX76/PdGQF
X-Google-Smtp-Source: AAOMgpd85W3kv3PHsLrT5yi+nzJJciFlCIP71eZEwJW8vbgrTe/AStNHOewfQ/nkYAgE57Ls30ySX5MzTcK4/DLxxd5FJXOjv0ee
MIME-Version: 1.0
X-Received: by 2002:a02:3f2c:: with SMTP id d44-v6mr6952449jaa.60.1531720743147;
 Sun, 15 Jul 2018 22:59:03 -0700 (PDT)
Date:   Sun, 15 Jul 2018 22:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca61cd0571178677@google.com>
Subject: BUG: corrupted list in p9_read_work
From:   syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    37b5dca2898d Merge tag 'rtc-4.18-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b3e770400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=2222c34dc40b515f30dc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com

list_del corruption, ffff8801931d8e28->next is LIST_POISON1  
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:47!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 27 Comm: kworker/0:2 Not tainted 4.18.0-rc4+ #148
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_read_work
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 60 68 1a 88 e8 ba 69 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 00 68 1a 88 e8 a6 69 02 fe <0f> 0b 48 89 de  
48 c7 c7 20 69 1a 88 e8 95 69 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801d94575b0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8801931d8e28 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801d94575c8 R08: ffff8801d9448700 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801931d8e00 R15: ffff8801996f7a10
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e4e7e0000 CR3: 00000001aeeae000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  p9_read_work+0xa29/0x1060 net/9p/trans_fd.c:375
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 4e7d7b3b542c6c1e ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x58 lib/list_debug.c:45
Code: 02 fe 0f 0b 4c 89 e2 48 89 de 48 c7 c7 60 68 1a 88 e8 ba 69 02 fe 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 00 68 1a 88 e8 a6 69 02 fe <0f> 0b 48 89 de  
48 c7 c7 20 69 1a 88 e8 95 69 02 fe 0f 0b 48 89 de
RSP: 0018:ffff8801d94575b0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8801931d8e28 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801d94575c8 R08: ffff8801d9448700 R09: ffffed003b5c4fc0
R10: ffffed003b5c4fc0 R11: ffff8801dae27e07 R12: dead000000000200
R13: dead000000000100 R14: ffff8801931d8e00 R15: ffff8801996f7a10
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e4e7e0000 CR3: 00000001aeeae000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
