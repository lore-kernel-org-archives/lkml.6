Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6663F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6663F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeK0R56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:57:58 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:57932 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeK0R56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:57:58 -0500
Received: by mail-it1-f200.google.com with SMTP id n124so302105itb.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3kBuP/Jn2G6r3hit2KxtJTWG9RdyOTMW6Vif2Nh//pc=;
        b=QAKdAcwtP2CSUW+ZKM8PmVSw2ERqioKaXU3ujsayAt9PZ6OSbD3CGFuxWMx+CIf0G5
         s5CHtYTupeY3oAM3qgmPRSOxqNJk07cCTvBhPTrdd8DnPjayZQsbUd1JVrpa75954hsY
         WLgWre4QOhduu5RH6niu9XxpPgmleiNyX1VA/5/BV7SS/yNlaeVpV2cmbofkCdekrUBI
         oPPVi3XEPgwZxgS9tr1b1Zp0/vsLVP6Kzcq+mlwMthPcKTaANHf7m2iwcnqHhv4sElDm
         pmHiX/g7PPyJDBFjVqPmlPsyfLgLeyNnMMdauMybKMaoDlqAr+J2g9UcksZgD1EGRPsf
         gpkw==
X-Gm-Message-State: AA+aEWbkC1S39ilF6KGmTTEauLr67swpQgVaBkYsOJ+GN6+njGCof78b
        zee2n2cSwZLsH9Ryr8Bn56LdhHKk66OgTlLR5nh8SdMCoMlt
X-Google-Smtp-Source: AFSGD/WbdzFVH+hymfo2JY7+P8WvXySSkuqvNkJ9MMVLtHmJMt/ROTtzsLhAu66PH4nd3IYvAQF4HtkzDO6sRGhlQR7N9WazGzXU
MIME-Version: 1.0
X-Received: by 2002:a02:3b6e:: with SMTP id i46mr9256849jaf.16.1543302064862;
 Mon, 26 Nov 2018 23:01:04 -0800 (PST)
Date:   Mon, 26 Nov 2018 23:01:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b7c64057ba003fb@google.com>
Subject: BUG: unable to handle kernel paging request in tpg_fill_plane_buffer
From:   syzbot <syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hverkuil@xs4all.nl, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6f8b52ba442c Merge tag 'hwmon-for-v4.20-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd354d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8212f63ea8ffaf3bfa
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffc90005b5c340
PGD 1da95a067 P4D 1da95a067 PUD 1da95b067 PMD 1c4863067 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5439 Comm: vivid-000-vid-c Not tainted 4.20.0-rc4+ #130
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memcpy_erms+0x6/0x10 arch/x86/lib/memcpy_64.S:54
Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3  
48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f  
80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
RSP: 0018:ffff888150467518 EFLAGS: 00010246
RAX: ffffc90005b5c340 RBX: 0000000000000080 RCX: 0000000000000080
RDX: 0000000000000080 RSI: ffffc90001da3000 RDI: ffffc90005b5c340
RBP: ffff888150467538 R08: fffff52000b6b878 R09: fffff52000b6b868
R10: fffff52000b6b877 R11: ffffc90005b5c3bf R12: ffffc90005b5c340
R13: ffffc90001da3000 R14: dffffc0000000000 R15: ffff8881cb2c5e50
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90005b5c340 CR3: 00000001846a4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  memcpy include/linux/string.h:352 [inline]
  tpg_fill_plane_pattern drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2382  
[inline]
  tpg_fill_plane_buffer+0x193f/0x44c0  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2481
  vivid_fillbuff+0x1d0d/0x68e0  
drivers/media/platform/vivid/vivid-kthread-cap.c:473
  vivid_thread_vid_cap_tick  
drivers/media/platform/vivid/vivid-kthread-cap.c:709 [inline]
  vivid_thread_vid_cap+0xbc1/0x2650  
drivers/media/platform/vivid/vivid-kthread-cap.c:813
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: ffffc90005b5c340
---[ end trace 22cabf1d47b26daf ]---
RIP: 0010:memcpy_erms+0x6/0x10 arch/x86/lib/memcpy_64.S:54
Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3  
48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f  
80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
RSP: 0018:ffff888150467518 EFLAGS: 00010246
RAX: ffffc90005b5c340 RBX: 0000000000000080 RCX: 0000000000000080
RDX: 0000000000000080 RSI: ffffc90001da3000 RDI: ffffc90005b5c340
RBP: ffff888150467538 R08: fffff52000b6b878 R09: fffff52000b6b868
R10: fffff52000b6b877 R11: ffffc90005b5c3bf R12: ffffc90005b5c340
R13: ffffc90001da3000 R14: dffffc0000000000 R15: ffff8881cb2c5e50
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90005b5c340 CR3: 00000001846a4000 CR4: 00000000001406f0
kobject: 'loop0' (00000000664d120c): kobject_uevent_env
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop0' (00000000664d120c): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
