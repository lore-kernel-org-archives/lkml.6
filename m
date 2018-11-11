Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603C0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271EE208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271EE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeKKLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:17:02 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:40743 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeKKLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:17:02 -0500
Received: by mail-it1-f197.google.com with SMTP id j71-v6so7359980ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 17:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=URjYjBq41p353+O7CpfnxIRpC/uaOiVZZ064+zm4oKQ=;
        b=V5GccoJRQkF6LB5wj/7zkq+wU9o0vyZxEq479c04O2m9T6cmgGdWq3qf2aIc55eNcN
         kLFIaciTn006PZ/dYZdAK/oppZofP1+XxxYYPrlfrCDdgnVYqPP14QiMsh/Z+ru6F82O
         rbMhQE+K4OfuwwPD4HtjHwou/p9nvydsmnshIEzYko4HlC5xq6SiYAZWAoHsJlxrL5Pj
         xOPdg0zRzK0l7hdYwEzoPV28RrWWpgOmxm6H21saFVK0Q9CeMeFlg4t/YsKu3Z+KAj52
         neXOfVOd6Hsmxp1wa/l0dZXVBrygpimhnQ361i75o2Rt2ttV0mv6BfQr4X75civr90/p
         yN1g==
X-Gm-Message-State: AGRZ1gJXZHZwpg5zat24XAiZkml7lxvY6YEBjKoE6aPjDvB62xvxodzy
        /Eh56HFURK1v4l76XIMId4fYdOhARXlotngPleSyp6GBVsQN
X-Google-Smtp-Source: AJdET5cgcnBWW4N32iuikBaeuZsU2SbMzQ7CORWJW9rQUhV5eCzbWES7w83K4ETgFq4/lB16/dhPaX1EV0WlftwW+thzEne24YA3
MIME-Version: 1.0
X-Received: by 2002:a24:1d0b:: with SMTP id 11-v6mr6351518itj.11.1541899803686;
 Sat, 10 Nov 2018 17:30:03 -0800 (PST)
Date:   Sat, 10 Nov 2018 17:30:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014008b057a598671@google.com>
Subject: general protection fault in vb2_mmap
From:   syzbot <syzbot+52e5bf0ebfa66092937a@syzkaller.appspotmail.com>
To:     kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, pawel@osciak.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ab6e1f378f54 Merge tag 'for-linus-4.20a-rc2-tag' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12937225400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=52e5bf0ebfa66092937a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+52e5bf0ebfa66092937a@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kernel msg: ebtables bug: please report to author: Unknown flag for bitmask
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 29513 Comm: syz-executor1 Not tainted 4.20.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__find_plane_by_offset  
drivers/media/common/videobuf2/videobuf2-core.c:2006 [inline]
RIP: 0010:vb2_mmap+0x23c/0x6f0  
drivers/media/common/videobuf2/videobuf2-core.c:2128
Code: 80 3c 10 00 0f 85 1b 04 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45  
b8 48 8b 00 48 8d 78 14 48 89 45 d0 48 89 f8 48 c1 e8 03 <0f> b6 14 08 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 fa
RSP: 0018:ffff8801c3cf77d0 EFLAGS: 00010203
RAX: 0000000000000002 RBX: 0000000000000009 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffffff854cca40 RDI: 0000000000000014
RBP: ffff8801c3cf7820 R08: ffff8801b8450000 R09: ffffed00372d17ae
R10: ffffed00372d17ae R11: ffff8801b968bd77 R12: 0000000000000000
R13: 0000000000000001 R14: 8000000000000000 R15: ffff8801cb757268
FS:  00007f3bbde14700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d8250 CR3: 00000001bfbea000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vb2_fop_mmap+0x4b/0x70 drivers/media/common/videobuf2/videobuf2-v4l2.c:999
  v4l2_mmap+0x153/0x200 drivers/media/v4l2-core/v4l2-dev.c:401
  call_mmap include/linux/fs.h:1862 [inline]
  mmap_region+0xe85/0x1cd0 mm/mmap.c:1786
  do_mmap+0xa22/0x1230 mm/mmap.c:1559
  do_mmap_pgoff include/linux/mm.h:2328 [inline]
  vm_mmap_pgoff+0x213/0x2c0 mm/util.c:350
  ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1609
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3bbde13c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457569
RDX: fffffffffffffffd RSI: 0000000000002000 RDI: 0000000020ffe000
RBP: 000000000072bf00 R08: 0000000000000004 R09: 8000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00007f3bbde146d4
R13: 00000000004c2a9d R14: 00000000004d41a0 R15: 00000000ffffffff
Modules linked in:
kobject: 'loop4' (0000000094f83e6a): kobject_uevent_env
kobject: 'loop4' (0000000094f83e6a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000259f5ee2): kobject_uevent_env
kobject: 'loop5' (00000000259f5ee2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000e3706587): kobject_uevent_env
kobject: 'loop2' (00000000e3706587): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
---[ end trace 54586c22ec4b9c3e ]---
RIP: 0010:__find_plane_by_offset  
drivers/media/common/videobuf2/videobuf2-core.c:2006 [inline]
RIP: 0010:vb2_mmap+0x23c/0x6f0  
drivers/media/common/videobuf2/videobuf2-core.c:2128
Code: 80 3c 10 00 0f 85 1b 04 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45  
b8 48 8b 00 48 8d 78 14 48 89 45 d0 48 89 f8 48 c1 e8 03 <0f> b6 14 08 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 fa
RSP: 0018:ffff8801c3cf77d0 EFLAGS: 00010203
RAX: 0000000000000002 RBX: 0000000000000009 RCX: dffffc0000000000
kobject: 'loop3' (0000000043f97857): kobject_uevent_env
kernel msg: ebtables bug: please report to author: Unknown flag for bitmask
RDX: dffffc0000000000 RSI: ffffffff854cca40 RDI: 0000000000000014
kobject: 'kvm' (000000006dd433cf): kobject_uevent_env
kernel msg: ebtables bug: please report to author: Unknown flag for bitmask
kobject: 'loop3' (0000000043f97857): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RBP: ffff8801c3cf7820 R08: ffff8801b8450000 R09: ffffed00372d17ae
R10: ffffed00372d17ae R11: ffff8801b968bd77 R12: 0000000000000000
kobject: 'loop2' (00000000e3706587): kobject_uevent_env
R13: 0000000000000001 R14: 8000000000000000 R15: ffff8801cb757268
kobject: 'loop2' (00000000e3706587): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (00000000259f5ee2): kobject_uevent_env
FS:  00007f3bbde14700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'kvm' (000000006dd433cf): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
CR2: 0000000000707158 CR3: 00000001bfbea000 CR4: 00000000001426e0
kobject: 'loop5' (00000000259f5ee2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
