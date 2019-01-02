Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4023F21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfABJBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:01:07 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42653 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfABJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:01:06 -0500
Received: by mail-io1-f71.google.com with SMTP id a2so4583844ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vnSvBHnDvnjKy1V5T3iMSuAgOZki3ThpZ2UVSaPKn4g=;
        b=O5BpNtZ5zlArGjPQH+cLRVofwgmkG0WnVWlHwPh+83SemYLIVkgDHrkNr7GEWGZJMj
         KJb5/9BeM5lLcU9uangw+LqcmpaMzqr7rilEhpkLFTiWwRPs+N1kIqsQNLwrRPNrwL2V
         ErNLXi7QsxglKdLdNQ/32EaRrX9aphlAr5mK6GiAGPmIZazb9yguK9EdMtYpA0Y6JrYz
         lVEbb90ytWS/c56ZNWbH6LCOYlZmzmrJTX0MOQnIH1yrgrIghf6Ch+RVCWPo/4V+21UX
         eHhxMpjb4XyepyzV1aqmsguCrD+fRBYsMTZqNosI4i0vmxs76Z187qn1DmrfWE8jxu+A
         ZOWw==
X-Gm-Message-State: AJcUukcNj2OCZxA3F1YqyYlyr6EAF7BuFGcCdMaczPtBbrwlGEExL97O
        ZwwRyK3DGLEqJK2Nxqb3u0WWvtre8CUMY6nEN/XK6fo679Xe
X-Google-Smtp-Source: ALg8bN6phlXwCbeMHe/h9+IXiv7YOD7jO8OwRYDw/X5diXbbHaOLm0nw6tgNzxB2eZ84ikwip3LYJoPk2QVk14FQdr79JTWvr2o6
MIME-Version: 1.0
X-Received: by 2002:a24:2543:: with SMTP id g64mr13547504itg.20.1546419664981;
 Wed, 02 Jan 2019 01:01:04 -0800 (PST)
Date:   Wed, 02 Jan 2019 01:01:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce1573057e75e2bf@google.com>
Subject: BUG: unable to handle kernel paging request in h4_recv_buf
From:   syzbot <syzbot+017a32f149406df32703@syzkaller.appspotmail.com>
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

HEAD commit:    28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a063fd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
dashboard link: https://syzkaller.appspot.com/bug?extid=017a32f149406df32703
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d654d7400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174483fd400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com

Bluetooth: hci0: sending frame failed (-49)
Bluetooth: hci0: command 0x1001 tx timeout
Bluetooth: hci0: sending frame failed (-49)
Bluetooth: hci0: command 0x1009 tx timeout
Bluetooth: hci0: Frame reassembly failed (-84)
BUG: unable to handle kernel paging request at ffffffffffffffd6
#PF error: [normal kernel read fault]
PGD 9871067 P4D 9871067 PUD 9873067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 4.20.0+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:h4_recv_buf+0x1ea/0xda0 drivers/bluetooth/hci_h4.c:211
Code: b6 14 10 48 89 c8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d7 0a 00  
00 48 ba 00 00 00 00 00 fc ff df 48 8b 45 d0 4c 8d 60 70 <0f> b7 58 2a 4c  
89 e0 48 c1 e8 03 0f b6 04 10 84 c0 74 08 3c 03 0f
RSP: 0018:ffff8880a945f6c0 EFLAGS: 00010246
RAX: ffffffffffffffac RBX: 0000000000000000 RCX: ffffffffffffffd6
RDX: dffffc0000000000 RSI: ffffffff85883972 RDI: 0000000000000005
RBP: ffff8880a945f748 R08: ffff8880a944e1c0 R09: 0000000000000003
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 000000000000001c
R13: ffff88808c9fea40 R14: ffff8880829e76e0 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000098164000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  h4_recv+0xe4/0x200 drivers/bluetooth/hci_h4.c:131
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x114/0x190 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x3b2/0x590 drivers/tty/tty_buffer.c:533
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: ffffffffffffffd6
---[ end trace 6acbbb9f58ccf0f7 ]---
RIP: 0010:h4_recv_buf+0x1ea/0xda0 drivers/bluetooth/hci_h4.c:211
Code: b6 14 10 48 89 c8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d7 0a 00  
00 48 ba 00 00 00 00 00 fc ff df 48 8b 45 d0 4c 8d 60 70 <0f> b7 58 2a 4c  
89 e0 48 c1 e8 03 0f b6 04 10 84 c0 74 08 3c 03 0f
RSP: 0018:ffff8880a945f6c0 EFLAGS: 00010246
RAX: ffffffffffffffac RBX: 0000000000000000 RCX: ffffffffffffffd6
RDX: dffffc0000000000 RSI: ffffffff85883972 RDI: 0000000000000005
RBP: ffff8880a945f748 R08: ffff8880a944e1c0 R09: 0000000000000003
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 000000000000001c
R13: ffff88808c9fea40 R14: ffff8880829e76e0 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000098164000 CR4: 00000000001406e0
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
