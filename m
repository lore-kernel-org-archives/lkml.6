Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB1C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5CD2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBDGAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:00:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:50924 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfBDGAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:00:04 -0500
Received: by mail-it1-f198.google.com with SMTP id p66so13130079itc.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 22:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jFyrPeLhAE53Jw4I0Jjy5AStLG19i5w74wMYB2M3kTo=;
        b=YzNXXQmeetEqopHGZU12NrISJD82B+SbnSkZBCr2W8q1XQXok76veWaO60JflZtPHt
         SGmZ76CJzT6PnNMJB1nTMQokkq0FoVlbqASitXMHop8NcrmvOECZKHksACG7JL4znOxh
         NSrn0+DjIeBB8xClt0zGLTq12lAFtA0/OFbdPhnFQV2tfB93i/93Vk9344Ys9RB7GMuy
         WCQmjprP8faR7lk6ahC0gNGyZo5jJt+co3hndJHpPHXnOfPQJxXf80T5+Tjttr9mkCXz
         6vFvBDjX+9XYJN54KMhxiq8O25AERGbvxAIfH4k5ciwlfYMpBD+lagOLhZzLZ+FUHMIJ
         XTKg==
X-Gm-Message-State: AHQUAuYJ1hAlitZUGLJr/No87CUWO6d07JYl1N2xyaJADT+0tIMbFxhU
        k+YOsdy35BxLIKIXJtB+nwmgcIbEaBx7n1uYCIMvVACZ1CH/
X-Google-Smtp-Source: AHgI3IZu2dmYmDCt8QuFpADYujbZmtWsGTy92dB5cAYRUH1q74Rxflx7nP23SjSH7PEKZ+6ZN27wg3S4SU2mklRV7tolS/EBAoFe
MIME-Version: 1.0
X-Received: by 2002:a24:5f93:: with SMTP id r141mr16370523itb.4.1549260003526;
 Sun, 03 Feb 2019 22:00:03 -0800 (PST)
Date:   Sun, 03 Feb 2019 22:00:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ccf9905810b34a5@google.com>
Subject: divide error in vivid_thread_vid_cap
From:   syzbot <syzbot+75293f834026a7e97684@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    12491ed354d2 Merge tag 'devicetree-fixes-for-5.0-3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1328ae87400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=75293f834026a7e97684
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75293f834026a7e97684@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
kobject: 'tx-0' (0000000017161f7f): kobject_uevent_env
CPU: 0 PID: 23689 Comm: vivid-003-vid-c Not tainted 5.0.0-rc4+ #58
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vivid_cap_update_frame_period  
drivers/media/platform/vivid/vivid-kthread-cap.c:661 [inline]
RIP: 0010:vivid_thread_vid_cap+0x221/0x2840  
drivers/media/platform/vivid/vivid-kthread-cap.c:789
Code: 48 c1 e9 03 0f b6 0c 11 48 89 f2 48 69 c0 00 ca 9a 3b 83 c2 03 38 ca  
7c 08 84 c9 0f 85 f0 1e 00 00 41 8b 8f 24 64 00 00 31 d2 <48> f7 f1 49 89  
c4 48 89 c3 49 8d 87 28 64 00 00 48 89 c2 48 89 45
RSP: 0018:ffff88808b4afd68 EFLAGS: 00010246
kobject: 'tx-0' (0000000017161f7f): fill_kobj_path: path  
= '/devices/virtual/net/gre0/queues/tx-0'
RAX: 000000de5a6f8e00 RBX: 0000000100047b22 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: ffff88808b4aff00 R08: ffff88804862e1c0 R09: ffffffff89997008
R10: ffffffff89997010 R11: 0000000000000001 R12: 00000000fffffffc
R13: ffff8880a17e0500 R14: ffff88803e40f760 R15: ffff8882182b0140
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cdc90 CR3: 000000005d827000 CR4: 00000000001426f0
Call Trace:
kobject: 'gretap0' (00000000d7549098): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'loop2' (0000000094ed4ee4): kobject_uevent_env
kobject: 'loop2' (0000000094ed4ee4): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  kthread+0x357/0x430 kernel/kthread.c:246
kobject: 'gretap0' (00000000d7549098): kobject_uevent_env
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
kobject: 'gretap0' (00000000d7549098): fill_kobj_path: path  
= '/devices/virtual/net/gretap0'
---[ end trace bc5c8b25b64d768f ]---
kobject: 'loop1' (0000000032036b86): kobject_uevent_env
RIP: 0010:vivid_cap_update_frame_period  
drivers/media/platform/vivid/vivid-kthread-cap.c:661 [inline]
RIP: 0010:vivid_thread_vid_cap+0x221/0x2840  
drivers/media/platform/vivid/vivid-kthread-cap.c:789
kobject: 'loop1' (0000000032036b86): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
Code: 48 c1 e9 03 0f b6 0c 11 48 89 f2 48 69 c0 00 ca 9a 3b 83 c2 03 38 ca  
7c 08 84 c9 0f 85 f0 1e 00 00 41 8b 8f 24 64 00 00 31 d2 <48> f7 f1 49 89  
c4 48 89 c3 49 8d 87 28 64 00 00 48 89 c2 48 89 45
kobject: 'loop0' (00000000dd9927c3): kobject_uevent_env
RSP: 0018:ffff88808b4afd68 EFLAGS: 00010246
RAX: 000000de5a6f8e00 RBX: 0000000100047b22 RCX: 0000000000000000
kobject: 'queues' (000000007ed20666): kobject_add_internal:  
parent: 'gretap0', set: '<NULL>'
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: ffff88808b4aff00 R08: ffff88804862e1c0 R09: ffffffff89997008
kobject: 'loop0' (00000000dd9927c3): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
R10: ffffffff89997010 R11: 0000000000000001 R12: 00000000fffffffc
kobject: 'queues' (000000007ed20666): kobject_uevent_env
R13: ffff8880a17e0500 R14: ffff88803e40f760 R15: ffff8882182b0140
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
kobject: 'loop5' (00000000a41f9e79): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'queues' (000000007ed20666): kobject_uevent_env: filter function  
caused the event to drop!
CR2: 00000000004cdc90 CR3: 000000005d827000 CR4: 00000000001426f0
kobject: 'loop5' (00000000a41f9e79): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
