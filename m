Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJ3CCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:02:34 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:40207 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3CCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:02:34 -0400
Received: by mail-it1-f198.google.com with SMTP id y144-v6so1638609itc.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o4zOmkNWWcfW9EvA4Y+n8wUO8cTkXYeuQYdkorrzKfw=;
        b=kauhM67XpDWT+RYKMg8EyvWl1dXz0sULpVp7R3r/x8tCfkVIA+a4MVwtgJR0OQqFJP
         lqyNKLP5vt9JsZIo8ZMTiHuXGJds506Nn5Tpy2aYDFda+2C+7VA6S1DG5nZm/ye8psZH
         x1H642KVZ+f4AnP6Tbb7RuGQpeCbhVjOyhWEdRTg82aYADZ+g5OAGCnYjvoKIlfBTCnc
         a5KdI7IsGvd9gF9SpT2UhyW+J3g11JUuTesBc/3JgP0i6dpLnQuFioPDE93qcyCpZj9K
         Z/hjxR6/YRhoqvrjRxQ/YuL/7SZToVpTp8VKZ8fNK3c+cfC7g+Wu4+KKnvkIfoci9Tzi
         zsRQ==
X-Gm-Message-State: AGRZ1gKBNirqIFOJ4HBXkKpq3PkzkzzGbREwAi5SwWcCM7QTv5LHPpzs
        Mh6AVBptUBJVdiY8BQ4hHkwdBLDo2andnt+4hwFqixiTYGZ6
X-Google-Smtp-Source: AJdET5eIBblS8mKI4S+yTC6pPryXFiIEeW7FvxL7GaT5ycNmNn7F/1zd6vh5qeevHekbuqNAyr3wFJLUlx6Gc5cnnoooKDF9UPbl
MIME-Version: 1.0
X-Received: by 2002:a24:7c8b:: with SMTP id a133-v6mr4350632itd.9.1540833183831;
 Mon, 29 Oct 2018 10:13:03 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:13:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000949c7a0579612eb3@google.com>
Subject: divide error in vivid_vid_cap_s_dv_timings
From:   syzbot <syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com>
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

HEAD commit:    b179f0826c6a Add linux-next specific files for 20181029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175ea9c5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b2b22387bad67fc
dashboard link: https://syzkaller.appspot.com/bug?extid=57c3d83d71187054d56f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor5'.
CPU: 0 PID: 26335 Comm: syz-executor2 Not tainted 4.19.0-next-20181029+ #100
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:valid_cvt_gtf_timings  
drivers/media/platform/vivid/vivid-vid-cap.c:1633 [inline]
RIP: 0010:vivid_vid_cap_s_dv_timings+0x60e/0x11e0  
drivers/media/platform/vivid/vivid-vid-cap.c:1664
Code: c6 84 c9 0f 95 c1 40 84 ce 0f 85 ce 0a 00 00 83 e0 07 38 c2 0f 9e c1  
84 d2 0f 95 c0 84 c1 0f 85 b9 0a 00 00 48 8b 43 14 31 d2 <41> f7 f7 48 ba  
00 00 00 00 00 fc ff df 4c 8d 7b 40 89 85 64 ff ff
RSP: 0018:ffff880180caf630 EFLAGS: 00010246
RAX: 0000000002000000 RBX: ffff8801ce323700 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801ce323714
RBP: ffff880180caf6f0 R08: 0000000000000001 R09: ffffed003971a024
R10: ffffed003971a024 R11: ffff8801cb8d0123 R12: ffff8801cb8d0080
R13: 1ffff10030195ecd R14: 0000000000000000 R15: 0000000000000000
FS:  00007f3d49d6e700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000727e4c CR3: 00000001d9174000 CR4: 00000000001426f0
Call Trace:
  vidioc_s_dv_timings+0xa4/0xc0 drivers/media/platform/vivid/vivid-core.c:323
  v4l_stub_s_dv_timings+0x4f/0x60 drivers/media/v4l2-core/v4l2-ioctl.c:2581
  __video_do_ioctl+0x519/0xf00 drivers/media/v4l2-core/v4l2-ioctl.c:2833
kobject: 'loop5' (00000000a1276308): kobject_uevent_env
  video_usercopy+0x5c1/0x1750 drivers/media/v4l2-core/v4l2-ioctl.c:3013
kobject: 'loop5' (00000000a1276308): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor5'.
kobject: 'loop5' (00000000a1276308): kobject_uevent_env
  video_ioctl2+0x2c/0x33 drivers/media/v4l2-core/v4l2-ioctl.c:3057
  v4l2_ioctl+0x154/0x1b0 drivers/media/v4l2-core/v4l2-dev.c:364
kobject: 'loop5' (00000000a1276308): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:688
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor5'.
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:705
  __do_sys_ioctl fs/ioctl.c:712 [inline]
  __se_sys_ioctl fs/ioctl.c:710 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:710
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'loop5' (00000000a1276308): kobject_uevent_env
kobject: 'loop5' (00000000a1276308): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
netlink: 20 bytes leftover after parsing attributes in process  
`syz-executor5'.
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3d49d6dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000020000040 RSI: 00000000c0845657 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3d49d6e6d4
kobject: 'loop5' (00000000a1276308): kobject_uevent_env
R13: 00000000004c1e32 R14: 00000000004d2e40 R15: 00000000ffffffff
Modules linked in:
---[ end trace c59f37d57fa3eae0 ]---
kobject: 'loop5' (00000000a1276308): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RIP: 0010:valid_cvt_gtf_timings  
drivers/media/platform/vivid/vivid-vid-cap.c:1633 [inline]
RIP: 0010:vivid_vid_cap_s_dv_timings+0x60e/0x11e0  
drivers/media/platform/vivid/vivid-vid-cap.c:1664
kobject: 'loop4' (00000000e1a0902a): kobject_uevent_env
kobject: 'loop4' (00000000e1a0902a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Code: c6 84 c9 0f 95 c1 40 84 ce 0f 85 ce 0a 00 00 83 e0 07 38 c2 0f 9e c1  
84 d2 0f 95 c0 84 c1 0f 85 b9 0a 00 00 48 8b 43 14 31 d2 <41> f7 f7 48 ba  
00 00 00 00 00 fc ff df 4c 8d 7b 40 89 85 64 ff ff
kobject: 'loop5' (00000000a1276308): kobject_uevent_env
kobject: 'kvm' (0000000010b8511c): kobject_uevent_env
kobject: 'kvm' (0000000010b8511c): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop5' (00000000a1276308): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RSP: 0018:ffff880180caf630 EFLAGS: 00010246
RAX: 0000000002000000 RBX: ffff8801ce323700 RCX: 0000000000000001
kobject: 'loop1' (00000000c8fe2913): kobject_uevent_env
kobject: 'kvm' (0000000010b8511c): kobject_uevent_env
kobject: 'loop1' (00000000c8fe2913): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801ce323714
kobject: 'kvm' (0000000010b8511c): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (0000000010b8511c): kobject_uevent_env
kobject: 'kvm' (0000000010b8511c): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
RBP: ffff880180caf6f0 R08: 0000000000000001 R09: ffffed003971a024
kobject: 'kvm' (0000000010b8511c): kobject_uevent_env
kobject: 'kvm' (0000000010b8511c): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
R10: ffffed003971a024 R11: ffff8801cb8d0123 R12: ffff8801cb8d0080
R13: 1ffff10030195ecd R14: 0000000000000000 R15: 0000000000000000
FS:  00007f3d49d6e700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
kobject: 'loop4' (00000000e1a0902a): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop4' (00000000e1a0902a): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
CR2: 00007fd3f654b000 CR3: 00000001d9174000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
