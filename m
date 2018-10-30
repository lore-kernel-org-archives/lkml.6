Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F85AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135DB2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135DB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeJaHMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:12:20 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:40448 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeJaHMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:12:20 -0400
Received: by mail-it1-f197.google.com with SMTP id y144-v6so5987531itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZU+tpPzlCCAxeI3NALHfQeTD2HiOPKluY50KjZDyDmo=;
        b=pk8ll4Y/boCg5t791jr9mQ2jeOeu5wIUzll30alEo2XAaR4Ih/r+N4KvkbXS4eGxjm
         Fubn+L2Xw2AQWekUPU3Y/GQjGXBXR6PTjkRLPT+WoZcXxXBFDV657z7GeMh+gDJHWbUO
         KoTS48AFbj+PEB+Z317L5EabqIvh0BbgLmm0fIKrs7aGtTt7kq+6IEqJyXyqdYw/YOSQ
         qnVAnY6Bc+TOgQiD5LiTTGw3n4XDGtVS1qb2uKIbTevP6/SeCl1d4+Dhxdb1HVvua5oj
         0Vn7M2G1JiZnDfjw2su2prgWwExFKqfOHWczrPCTRTYjhCn+zjIYfxeU1JbQUNy6Fy82
         6Uew==
X-Gm-Message-State: AGRZ1gKd059SZJ0yBxivIRI02aOeG4dMNOtJ8h+iMrxi7/Dto/ycsIVk
        SA8vZYHIs4QCMWya0m19etGhUYuzspx3cwKO6hBXp5QyqeAd
X-Google-Smtp-Source: AJdET5dpU+sSUx6nAS+y8WFhHLaIO8+CHC2l2Cfjq1mV38mLHp0csY3QVwY+OskbC6elIFJ9rhuyFd7oD2mXLU+dQlNUUDE9cjAI
MIME-Version: 1.0
X-Received: by 2002:a24:6182:: with SMTP id s124-v6mr371217itc.16.1540937823522;
 Tue, 30 Oct 2018 15:17:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:17:03 -0700
In-Reply-To: <000000000000949c7a0579612eb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097b0940579798baa@google.com>
Subject: Re: divide error in vivid_vid_cap_s_dv_timings
From:   syzbot <syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6201f31a39f8 Add linux-next specific files for 20181030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178f6999400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
dashboard link: https://syzkaller.appspot.com/bug?extid=57c3d83d71187054d56f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c44dbd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15210599400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5676 Comm: syz-executor345 Not tainted 4.19.0-next-20181030+  
#101
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:valid_cvt_gtf_timings  
drivers/media/platform/vivid/vivid-vid-cap.c:1633 [inline]
RIP: 0010:vivid_vid_cap_s_dv_timings+0x60e/0x11e0  
drivers/media/platform/vivid/vivid-vid-cap.c:1664
Code: c6 84 c9 0f 95 c1 40 84 ce 0f 85 ce 0a 00 00 83 e0 07 38 c2 0f 9e c1  
84 d2 0f 95 c0 84 c1 0f 85 b9 0a 00 00 48 8b 43 14 31 d2 <41> f7 f7 48 ba  
00 00 00 00 00 fc ff df 4c 8d 7b 40 89 85 64 ff ff
RSP: 0018:ffff8801d80a7630 EFLAGS: 00010246
RAX: 0000000000d59f80 RBX: ffff8801d7a9e600 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801d7a9e614
RBP: ffff8801d80a76f0 R08: 0000000000000001 R09: ffffed0039694024
R10: ffffed0039694024 R11: ffff8801cb4a0123 R12: ffff8801cb4a0080
R13: 1ffff1003b014ecd R14: 0000000000000000 R15: 0000000000000000
FS:  000000000228d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000001d7948000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vidioc_s_dv_timings+0xa4/0xc0 drivers/media/platform/vivid/vivid-core.c:323
  v4l_stub_s_dv_timings+0x4f/0x60 drivers/media/v4l2-core/v4l2-ioctl.c:2581
  __video_do_ioctl+0x519/0xf00 drivers/media/v4l2-core/v4l2-ioctl.c:2833
  video_usercopy+0x5c1/0x1750 drivers/media/v4l2-core/v4l2-ioctl.c:3013
  video_ioctl2+0x2c/0x33 drivers/media/v4l2-core/v4l2-ioctl.c:3057
  v4l2_ioctl+0x154/0x1b0 drivers/media/v4l2-core/v4l2-dev.c:364
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:688
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:705
  __do_sys_ioctl fs/ioctl.c:712 [inline]
  __se_sys_ioctl fs/ioctl.c:710 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:710
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444c19
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffce23353f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c19
RDX: 0000000020000000 RSI: 00000000c0845657 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000ffff00000000 R09: 00000000004002e0
R10: 000000000000f8ff R11: 0000000000000213 R12: 000000000000c1b9
R13: 0000000000402010 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace eca9bbb7e84ba3e6 ]---
RIP: 0010:valid_cvt_gtf_timings  
drivers/media/platform/vivid/vivid-vid-cap.c:1633 [inline]
RIP: 0010:vivid_vid_cap_s_dv_timings+0x60e/0x11e0  
drivers/media/platform/vivid/vivid-vid-cap.c:1664
Code: c6 84 c9 0f 95 c1 40 84 ce 0f 85 ce 0a 00 00 83 e0 07 38 c2 0f 9e c1  
84 d2 0f 95 c0 84 c1 0f 85 b9 0a 00 00 48 8b 43 14 31 d2 <41> f7 f7 48 ba  
00 00 00 00 00 fc ff df 4c 8d 7b 40 89 85 64 ff ff
RSP: 0018:ffff8801d80a7630 EFLAGS: 00010246
RAX: 0000000000d59f80 RBX: ffff8801d7a9e600 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801d7a9e614
RBP: ffff8801d80a76f0 R08: 0000000000000001 R09: ffffed0039694024
R10: ffffed0039694024 R11: ffff8801cb4a0123 R12: ffff8801cb4a0080
R13: 1ffff1003b014ecd R14: 0000000000000000 R15: 0000000000000000
FS:  000000000228d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000001d7948000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

