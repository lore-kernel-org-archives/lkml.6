Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35EC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfANRDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:03:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:60148 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:03:05 -0500
Received: by mail-it1-f200.google.com with SMTP id t143so149565itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6055W/Z0ZYAVes941wKhELyr0ynZLpeKL56q4keySdE=;
        b=BvMYE6Ph3nGGWVSQR2UYuj2iV9b1EvLdYg7ObfqxWjbMaF9mXZ/cUfHQwTbH9S4Mj+
         2A9IRMgMer3KP+mk7Viycli96NEj+HDUzcF8COodoANXl06zS+6fg8tbyBNKDujMOlSs
         XXGNEQBzlzYxY1gxoA+GMPqKTGzFW2u1BGh4TUjWB5Q5EKVx5MuR4+FrBCWwQq4Jb830
         LT1rPUAmu/xUQ14bTVcKAZKe7TgNxKzN4CzKNal951cYaHuEUcIYJrqfMZTzZMpsdTq+
         Rzca7fnGn5oDHkeTEayd/ha6NQ74QiBwtiU2nMnufMWxns+GE7SGI62xXmGLaF4Ky/Fz
         txiA==
X-Gm-Message-State: AJcUukcpfcUyX8Dl1kupkUV8Fr5sBz4KRrrw67b/gGaEedZkpj9BmARs
        TBKfpZIveohovQnrzSJy/GcDF9fv+xAi3qBEdUvlcQ7b082b
X-Google-Smtp-Source: ALg8bN4qH+eRhafGIpM42fJ+lex/5qpT/7u67LEyw2D+KAEENKsmTm90HieeM5MYM7oFAMvNSTXcVPABsAaixW6AGIX98kbh1W3b
MIME-Version: 1.0
X-Received: by 2002:a02:2b18:: with SMTP id h24mr9677344jaa.7.1547485383850;
 Mon, 14 Jan 2019 09:03:03 -0800 (PST)
Date:   Mon, 14 Jan 2019 09:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000998547057f6e046f@google.com>
Subject: general protection fault in hci_uart_write_work
From:   syzbot <syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6b529fb0a3ea Merge tag 'for-5.0-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1366fa30c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=257790c15bcdef6fe00c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134d5107400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15760b4f400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
Bluetooth: Invalid header checksum
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Bluetooth: Can't allocate HCI device
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.0.0-rc1+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events hci_uart_write_work
RIP: 0010:hci_uart_write_work+0x1b6/0x710 drivers/bluetooth/hci_ldisc.c:180
Code: 0f 85 6a 04 00 00 49 8b b4 24 c8 00 00 00 4c 89 ef e8 3e a8 96 02 89  
c6 48 8b 45 d0 48 8d b8 5c 10 00 00 48 89 f8 48 c1 e8 03 <0f> b6 14 18 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 1d
RSP: 0018:ffff8880a95c7960 EFLAGS: 00010203
RAX: 000000000000020b RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000000105c
RBP: ffff8880a95c79e0 R08: 0000000000000006 R09: ffff8880a95b8e88
R10: ffff8880a95b85c0 R11: 0000000000000000 R12: ffff888087c2b5c0
R13: ffff88808e0775c0 R14: ffff888096c7b868 R15: ffff888087c2b630
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 00000000978b1000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 5bffc9ea5ce29536 ]---
RIP: 0010:hci_uart_write_work+0x1b6/0x710 drivers/bluetooth/hci_ldisc.c:180
Code: 0f 85 6a 04 00 00 49 8b b4 24 c8 00 00 00 4c 89 ef e8 3e a8 96 02 89  
c6 48 8b 45 d0 48 8d b8 5c 10 00 00 48 89 f8 48 c1 e8 03 <0f> b6 14 18 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 1d
RSP: 0018:ffff8880a95c7960 EFLAGS: 00010203
RAX: 000000000000020b RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000000105c
RBP: ffff8880a95c79e0 R08: 0000000000000006 R09: ffff8880a95b8e88
R10: ffff8880a95b85c0 R11: 0000000000000000 R12: ffff888087c2b5c0
R13: ffff88808e0775c0 R14: ffff888096c7b868 R15: ffff888087c2b630
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 0000000009871000 CR4: 00000000001406e0
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
