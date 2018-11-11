Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85759C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbeKLJcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:32:23 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:38894 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbeKLJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:32:22 -0500
Received: by mail-io1-f71.google.com with SMTP id w22-v6so8499817ioc.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yf2tcRty7lS/BMq1smZO+3n3NTuXSpN6mMj6UZYPp8s=;
        b=goa5M45QYmXzFKzN1fZxG/fUrKMsda7n0HC9Fcdp1anq5Tz81ChgQ5/onaX0aBe7i2
         y8/rTBJjLv4BP2yomsxA6dOwAn3y3PuJDLd8rti4ds8DNv+/w4E0fj0e/aboqB4c/ICN
         LWtVdI61HNE7eSVzaZmGmxGxBIqHD6GvswgCknNLbU3J5skWM8zrFaMXFOGZt3c36ght
         2OZxkrpRvNyWl7l3cw8OVRUrpJ1Weh0Dx46Q5HrptbKsMaJ4zT/j605s5IeNS2uXZfAA
         ZlhscW9SZo2wt2l0EKAmbmb6RprFDeW3kzYpwJ35eSVyF0067PqHQ8kIkN5ztN/Xm+D4
         b22Q==
X-Gm-Message-State: AGRZ1gKULk7yBRFNem8xPSWB/s5ykjAhtuGtbU2hsxHAQbrr6X4pbVms
        JGGMRQL0wXvFKmn2/mgLsUP7MQR1tTvxwKPmlgjk3vFph3l+
X-Google-Smtp-Source: AJdET5cNCBiwlHLzmBGwNcg0vGswyQFaeA3/bddrdkd17HQc9G0FNK76Ws2hL/3EuVfAhzsa2Y6bWv/SQ9LAgegzEqOEHlG1mRBl
MIME-Version: 1.0
X-Received: by 2002:a24:59d1:: with SMTP id p200-v6mr9147477itb.10.1541979723571;
 Sun, 11 Nov 2018 15:42:03 -0800 (PST)
Date:   Sun, 11 Nov 2018 15:42:03 -0800
In-Reply-To: <00000000000014008b057a598671@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acaa9e057a6c21c6@google.com>
Subject: Re: general protection fault in vb2_mmap
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c7654d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=52e5bf0ebfa66092937a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1492dfbd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d6e6d5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+52e5bf0ebfa66092937a@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6333 Comm: syz-executor804 Not tainted  
4.20.0-rc1-next-20181109+ #110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__find_plane_by_offset  
drivers/media/common/videobuf2/videobuf2-core.c:2006 [inline]
RIP: 0010:vb2_mmap+0x23c/0x6f0  
drivers/media/common/videobuf2/videobuf2-core.c:2128
Code: 80 3c 10 00 0f 85 1b 04 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45  
b8 48 8b 00 48 8d 78 14 48 89 45 d0 48 89 f8 48 c1 e8 03 <0f> b6 14 08 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 fa
RSP: 0018:ffff8801c111f7d0 EFLAGS: 00010203
RAX: 0000000000000002 RBX: 000000000000000a RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffffff854c01c0 RDI: 0000000000000014
RBP: ffff8801c111f820 R08: ffff8801c23e8400 R09: ffffed0039c39966
R10: ffffed0039c39966 R11: ffff8801ce1ccb37 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000020a00000 R15: ffff8801cb777268
FS:  00000000020b8880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000001b531c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vb2_fop_mmap+0x4b/0x70 drivers/media/common/videobuf2/videobuf2-v4l2.c:999
  v4l2_mmap+0x153/0x200 drivers/media/v4l2-core/v4l2-dev.c:401
  call_mmap include/linux/fs.h:1872 [inline]
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
RIP: 0033:0x444c09
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff3df375f8 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444c09
RDX: 00000000ffffffff RSI: 0000000000600000 RDI: 0000000020a00000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000020a00000
R10: 0000000000000011 R11: 0000000000000212 R12: 000000000000977e
R13: 0000000000401f50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace eab0c06c6f6dccfa ]---
RIP: 0010:__find_plane_by_offset  
drivers/media/common/videobuf2/videobuf2-core.c:2006 [inline]
RIP: 0010:vb2_mmap+0x23c/0x6f0  
drivers/media/common/videobuf2/videobuf2-core.c:2128
Code: 80 3c 10 00 0f 85 1b 04 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b 45  
b8 48 8b 00 48 8d 78 14 48 89 45 d0 48 89 f8 48 c1 e8 03 <0f> b6 14 08 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 fa
RSP: 0018:ffff8801c111f7d0 EFLAGS: 00010203
RAX: 0000000000000002 RBX: 000000000000000a RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffffff854c01c0 RDI: 0000000000000014
RBP: ffff8801c111f820 R08: ffff8801c23e8400 R09: ffffed0039c39966
R10: ffffed0039c39966 R11: ffff8801ce1ccb37 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000020a00000 R15: ffff8801cb777268
FS:  00000000020b8880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000414ca0 CR3: 00000001b531c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

