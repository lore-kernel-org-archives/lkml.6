Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A8FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA921852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfA3LUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:20:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:50321 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3LUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:20:04 -0500
Received: by mail-io1-f69.google.com with SMTP id p4so19025845iod.17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RXe4VR9lmrhV4CyCQT2QOQgaFt4yTakvoU9lkhzZiFI=;
        b=n2xFzdoGI+i2GCxC72QqPl3LLYSZB7NpF1UuAvXcijJOnH3w7IxLFibY0AzvluqhVc
         QEoIusUmW1k4WrJtc8RE9f051/ASV46CiVkfka2rnWwdRNcdzgc6mqBwNbQ7C3cDoBg8
         PxsTJK3tNb7moVjhIAljBJJTjr9ySmUinJ2B29K5sMO0F3EDmDx+CE37Dle5Nh92zejq
         TD44JlX4v4RBGkRohTqP/S36lW9bRpSXClMT1Qlcamz2wO2eFIn0rD56zASlvwk/TlCt
         VeeKNTz1LINkPWkAlOASVKbsxn+9NylHPRQCyDg5YthReSURKjxd+IwDudvfPzFozbUL
         uV2w==
X-Gm-Message-State: AHQUAubfbCRlfo2yvMds1JQWK+fWHtt1nBMWpG1DTygmwchI2wMRhm0H
        TndazE6CSxiyqpbyXXEc2rGlXBxLOZEdFKXTHRVsu8QaJwHx
X-Google-Smtp-Source: AHgI3IYbLrIaDXHq6JYMaQa5RwGaOjO3LPZ3NjdaICQpdpshypJg/U791rY1XKoUVsxci3R5e2sO9HHrBy7yHcnwV+sgQTmSlsgJ
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr5841487iod.9.1548847203288;
 Wed, 30 Jan 2019 03:20:03 -0800 (PST)
Date:   Wed, 30 Jan 2019 03:20:03 -0800
In-Reply-To: <00000000000081e6cc0580aa76a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d0d740580ab1771@google.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
From:   syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>
To:     axboe@fb.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=116209ef400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bdea98c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16390850c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffffffffffffea
#PF error: [normal kernel read fault]
PGD 9874067 P4D 9874067 PUD 9876067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7985 Comm: syz-executor249 Not tainted 5.0.0-rc4-next-20190130  
#22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fast_dput fs/dcache.c:700 [inline]
RIP: 0010:dput+0x11e/0x790 fs/dcache.c:819
Code: e8 97 2e a8 ff 45 84 ed 0f 84 e2 03 00 00 e8 49 2d a8 ff 4c 89 e0 48  
c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e f7 04 00 00 <45> 8b 2c 24 4d  
8d bc 24 80 00 00 00 31 ff 41 83 e5 08 44 89 ee e8
RSP: 0018:ffff88808bc57740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81d9effa
RDX: 0000000000000000 RSI: ffffffff81d9ec07 RDI: 0000000000000001
RBP: ffff88808bc577d8 R08: ffff888090abc500 R09: ffffed1015cc5b80
R10: ffffed1015cc5b7f R11: ffff8880ae62dbfb R12: ffffffffffffffea
R13: 0000000000000001 R14: 1ffff1101178aeea R15: ffff88808bc578a0
FS:  0000000001144880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffea CR3: 00000000946ec000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_blk_trace_setup+0x8e9/0xdb0 kernel/trace/blktrace.c:561
  __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:577
  blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:716
  blkdev_ioctl+0x141/0x2120 block/ioctl.c:591
  block_ioctl+0xee/0x130 fs/block_dev.c:1914
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440139
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffa5cab9f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440139
RDX: 00000000200002c0 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004019c0
R13: 0000000000401a50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: ffffffffffffffea
---[ end trace 9fd433d20871e341 ]---
RIP: 0010:fast_dput fs/dcache.c:700 [inline]
RIP: 0010:dput+0x11e/0x790 fs/dcache.c:819
Code: e8 97 2e a8 ff 45 84 ed 0f 84 e2 03 00 00 e8 49 2d a8 ff 4c 89 e0 48  
c1 e8 03 0f b6 04 18 84 c0 74 08 3c 03 0f 8e f7 04 00 00 <45> 8b 2c 24 4d  
8d bc 24 80 00 00 00 31 ff 41 83 e5 08 44 89 ee e8
RSP: 0018:ffff88808bc57740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81d9effa
RDX: 0000000000000000 RSI: ffffffff81d9ec07 RDI: 0000000000000001
RBP: ffff88808bc577d8 R08: ffff888090abc500 R09: ffffed1015cc5b80
R10: ffffed1015cc5b7f R11: ffff8880ae62dbfb R12: ffffffffffffffea
R13: 0000000000000001 R14: 1ffff1101178aeea R15: ffff88808bc578a0
FS:  0000000001144880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffea CR3: 00000000946ec000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

