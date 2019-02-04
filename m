Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3672C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F93B2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfBDQnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:43:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:35685 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfBDQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:43:04 -0500
Received: by mail-it1-f199.google.com with SMTP id v188so747691ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=re1YU5O9KdNA/G1iB7AA+KPR4zLDTcKq4DdGCjFBkCg=;
        b=JtNFSOmYOam+TDNs+FRWXe282VZAGB2ezx/uDDoneU0pSOGsSDhYT7ErA1qDqohgRK
         lpKZyG3oxub6PpjkLNhP5kSzqRTBrmlVwfB41v4itghZeBYNefihTGfvxeDZ+8ITQtdw
         LuOsfa8Shym2t0buvhFrMznOYAp1/1+Wxk8gBkJ2ejWlR5CTZqSd5ejJ2HSgZnQ/JeOO
         eaZKBHn31+BDBZHHFz8s/cM3kfEATOHs1xXIzPfl+nFEv/KTNSw/SeRq9TNhXgb3ynJw
         xrUweAeupiOAzeLD8b0pJiK6uYb0wOfpxJ9mNjpklp+W4BmkoH8ySfWWoxd1dJn8HRUV
         YcMA==
X-Gm-Message-State: AHQUAuY/fuTSZIOJvW004kJJhbTHkcbCeG+9B1rcB2Cd+imJiQshv/SI
        RIeQlaa+wqunXTaczxcKXCK4NRQdf0ZHdQUWjGm+NcrUWYQj
X-Google-Smtp-Source: AHgI3IZ/HEShA2YzLqMX1WFJ+PbDC6gJPOjp3vnWatfaOzqz6uRJYbq3/W+Nkmu/O0fwK5CBPOjEd6/Rv9X/4aeDPEkcNYnGU5lM
MIME-Version: 1.0
X-Received: by 2002:a02:97da:: with SMTP id v26mr146691jaj.1.1549298583590;
 Mon, 04 Feb 2019 08:43:03 -0800 (PST)
Date:   Mon, 04 Feb 2019 08:43:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9e68e0581142f19@google.com>
Subject: general protection fault in skb_put
From:   syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>
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

HEAD commit:    dc4c89997735 Add linux-next specific files for 20190201
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=120a50b0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
dashboard link: https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 21 Comm: kworker/u4:1 Not tainted 5.0.0-rc4-next-20190201 #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:skb_put+0x35/0x1d0 net/core/skbuff.c:1698
Code: 89 f5 41 54 49 89 fc 53 4d 8d b4 24 b8 00 00 00 48 83 ec 08 e8 2c 6a  
01 fc 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4c
RSP: 0018:ffff8880a99cfb28 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880969a9280 RCX: ffffffff84ef8fa3
RDX: 0000000000000017 RSI: ffffffff856e9164 RDI: 0000000000000000
RBP: ffff8880a99cfb58 R08: ffff8880a99c0580 R09: ffffed1015d25bc0
R10: ffffed1015d25bbf R11: ffff8880ae92ddfb R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000000b8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b4adc CR3: 000000008e053000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  skb_put_data include/linux/skbuff.h:2138 [inline]
  bcsp_unslip_one_byte drivers/bluetooth/hci_bcsp.c:451 [inline]
  bcsp_recv+0x98f/0x13a0 drivers/bluetooth/hci_bcsp.c:612
  hci_uart_tty_receive+0x22b/0x530 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x228/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2257
  worker_thread+0x98/0xe40 kernel/workqueue.c:2403
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 6643b2336de1f8b1 ]---
RIP: 0010:skb_put+0x35/0x1d0 net/core/skbuff.c:1698
Code: 89 f5 41 54 49 89 fc 53 4d 8d b4 24 b8 00 00 00 48 83 ec 08 e8 2c 6a  
01 fc 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 4c
RSP: 0018:ffff8880a99cfb28 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880969a9280 RCX: ffffffff84ef8fa3
RDX: 0000000000000017 RSI: ffffffff856e9164 RDI: 0000000000000000
RBP: ffff8880a99cfb58 R08: ffff8880a99c0580 R09: ffffed1015d25bc0
R10: ffffed1015d25bbf R11: ffff8880ae92ddfb R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000000b8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b4adc CR3: 000000008e053000 CR4: 00000000001406e0
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
