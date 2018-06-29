Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A2A257BF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A2A257BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeF2HfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:35:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:57570 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbeF2HfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:35:03 -0400
Received: by mail-it0-f70.google.com with SMTP id 13-v6so1072997itl.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mcyC56Flf4sGEh6kZOFTZrpUsbU9Ut1dNmifoHZp1jw=;
        b=Tg34kFLjjz37e43B8LOlzg3mVTK+sPJtK6KNzj544sbpmSlYtlKsH2S5ScSd8qNY91
         L0bcmRL35CqNVP4LTYQ4He3t58Vu9DMOJEQJAozAGNd14vMRHB3kealvAOdTIah1qfa/
         50qDW96DdL3QDLclQF9L8ZkYZ80YbVPVjMRVGOcJnvex8k2JX8LoD2zopQbx0T/LsTyY
         qe25K6oGu8EfhzmmJKnzr/7lnQyfUNWdvpujiCX1E5YN8FbazBdot80pyoJSUB0PmlbU
         Drzr4dxEL+byPjbCdBO7+SCuXSTkveUkwuLQpjsZIew+O6j2gUYumsorg72ayhSkqM9I
         2xLQ==
X-Gm-Message-State: APt69E0jShqBy529roMNhlPhVz2XdGP2FToDg7bXNHeo1mjBL/F6t6oJ
        EtKDSzNV3sYoMvKTsX9EZ2AD1BeclB/Jg6uQczgABmwWIFqM
X-Google-Smtp-Source: AAOMgpfG1B6BtFwXBOtNpaETB4GP15pCdGZ+1a6xEjcGZPS0JY1txfgtefyGmC8nY4YPOoknbzqIn1GLUN5BIsd0upNkr97Gu4cw
MIME-Version: 1.0
X-Received: by 2002:a6b:b9d4:: with SMTP id j203-v6mr5300750iof.84.1530257702408;
 Fri, 29 Jun 2018 00:35:02 -0700 (PDT)
Date:   Fri, 29 Jun 2018 00:35:02 -0700
In-Reply-To: <0000000000004a5d64056fc140c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c45ecf056fc2e26c@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in ep_item_poll
From:   syzbot <syzbot+57727883dbad76db2ef0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    90368a37fbbe Merge tag 'printk-for-4.18-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11edd588400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
dashboard link: https://syzkaller.appspot.com/bug?extid=57727883dbad76db2ef0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12e46d14400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16867eb0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57727883dbad76db2ef0@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1ab51a067 P4D 1ab51a067 PUD 1ab510067 PMD 0
Oops: 0010 [#1] SMP KASAN
CPU: 0 PID: 4552 Comm: syz-executor998 Not tainted 4.18.0-rc2+ #121
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801ab4ef568 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d4ff34c0 RCX: ffffffff85ec9112
RDX: ffff8801ab4ef7c0 RSI: ffff8801d4ff34c0 RDI: ffff8801ad3f3800
RBP: ffff8801ab4ef610 R08: ffff8801d9596180 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffff8801ab4ef7c0
R13: ffff8801ad3f3800 R14: ffffffff8818a920 R15: ffff8801ab414280
FS:  0000000000829880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001ab53c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfs_poll include/linux/poll.h:86 [inline]
  ep_item_poll.isra.14+0x15c/0x400 fs/eventpoll.c:887
  ep_insert+0x6c1/0x1c20 fs/eventpoll.c:1459
  __do_sys_epoll_ctl fs/eventpoll.c:2113 [inline]
  __se_sys_epoll_ctl fs/eventpoll.c:1999 [inline]
  __x64_sys_epoll_ctl+0xf00/0x10a0 fs/eventpoll.c:1999
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fce9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe5e985b48 EFLAGS: 00000217 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fce9
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000020000000 R11: 0000000000000217 R12: 0000000000401610
R13: 00000000004016a0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 1c1566da350a05d9 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff8801ab4ef568 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d4ff34c0 RCX: ffffffff85ec9112
RDX: ffff8801ab4ef7c0 RSI: ffff8801d4ff34c0 RDI: ffff8801ad3f3800
RBP: ffff8801ab4ef610 R08: ffff8801d9596180 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffff8801ab4ef7c0
R13: ffff8801ad3f3800 R14: ffffffff8818a920 R15: ffff8801ab414280
FS:  0000000000829880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001ab53c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

