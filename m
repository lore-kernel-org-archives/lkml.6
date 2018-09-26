Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4618AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35CB21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35CB21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeI0C6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:58:49 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54804 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0C6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:58:49 -0400
Received: by mail-io1-f69.google.com with SMTP id l24-v6so395703iok.21
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 13:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3vL6KqOmq6DLj9udmlTKgGHcRuNKZzGuxwNy7lxeXUs=;
        b=quc1O6nEDfw284VaHsqRuW/Q0in9qux9YfxD/5YwX1P35OgAvdkrlBDzsUDzV4Sg9U
         yuYfT3s4tTj+CgFAPzTI46y+jUM57ttyo6TJI0cBwgBr674hGyrgPkM4aWDPLQXRuHNy
         MqlHqxLVOvEcWL8e5Q6U66NZCYs6quEWaE4RlVLqyB3A9oFW8yCnz2KtQ7FQB8q76wSP
         Q2VVrQjoF3McgkKEEcZZJGr0l9Aqv/GFpYwQnqSjzwocKx6OIkx9IpDYsXO99knsDjZR
         K9DdgHUyHIsPEcz61WkiHiGsNR9/KZRgQQAEKx0tiey6FfopTzfCxzvCn39hflyEz9XQ
         x6MA==
X-Gm-Message-State: ABuFfoj8UdrhE4EzxM/693k02TatjzUIo6SLyALDLnjhXG4eSDxWCzTQ
        QaBlWMUwYqys37XMontdEYLe2A/JgRLPh+LvmsBZ7giPTLJe
X-Google-Smtp-Source: ACcGV61WEslp68YrVBs9Yw68xsAg6E66xVvtbcRjEylxuyozBBXmyWsIbHYDSDGOKbJtRV1r7QbcSAGiMG5j1X9bvoIV/fU77Eoz
MIME-Version: 1.0
X-Received: by 2002:a24:f902:: with SMTP id l2-v6mr5426102ith.4.1537994644302;
 Wed, 26 Sep 2018 13:44:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 13:44:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070c1950576cc48aa@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in blk_mq_map_swqueue
From:   syzbot <syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b239c6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
dashboard link: https://syzkaller.appspot.com/bug?extid=83e8cbe702263932d9d4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1057591a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ad9f69400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a429
RDX: 0000000000000002 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007f2a2bb33d80 R14: ffffffffffffffff R15: 0000000000000005
BUG: unable to handle kernel NULL pointer dereference at 0000000000000118
PGD 1cdc72067 P4D 1cdc72067 PUD 1cdeb4067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5498 Comm: syz-executor702 Not tainted 4.19.0-rc5+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpumask_set_cpu include/linux/cpumask.h:311 [inline]
RIP: 0010:blk_mq_map_swqueue+0x29c/0xa70 block/blk-mq.c:2336
Code: 80 3c 1a 00 0f 85 fa 06 00 00 44 89 ee bf 3f 00 00 00 4d 8b 24 24 e8  
33 01 03 fe 41 83 fd 3f 0f 87 1c 05 00 00 e8 14 00 03 fe <f0> 4d 0f ab b4  
24 18 01 00 00 49 8d bc 24 74 01 00 00 48 89 fa 48
RSP: 0018:ffff8801cedaf4e0 EFLAGS: 00010293
RAX: ffff8801c4f80400 RBX: dffffc0000000000 RCX: ffffffff837be3fd
RDX: 0000000000000000 RSI: ffffffff837be40c RDI: 0000000000000005
RBP: ffff8801cedaf550 R08: ffff8801c4f80400 R09: 0000000000000000
R10: ffffed003a31dff0 R11: ffff8801d18eff83 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: ffff8801d1fd7000
FS:  00007f2a2bb34700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000118 CR3: 00000001c55c5000 CR4: 00000000001406f0
Call Trace:
  blk_mq_queue_reinit block/blk-mq.c:2675 [inline]
  __blk_mq_update_nr_hw_queues block/blk-mq.c:2994 [inline]
  blk_mq_update_nr_hw_queues+0xb2a/0xe50 block/blk-mq.c:3008
  nbd_start_device+0x1d2/0xcd0 drivers/block/nbd.c:1154
  nbd_start_device_ioctl drivers/block/nbd.c:1195 [inline]
  __nbd_ioctl drivers/block/nbd.c:1266 [inline]
  nbd_ioctl+0x6af/0xd40 drivers/block/nbd.c:1306
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x9ac/0x2010 block/ioctl.c:601
  block_ioctl+0xee/0x130 fs/block_dev.c:1883
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a429
Code: e8 ac b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2a2bb33d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 000000000044a429
RDX: 0000000000000002 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007f2a2bb33d80 R14: ffffffffffffffff R15: 0000000000000005
Modules linked in:
CR2: 0000000000000118
---[ end trace cca4d386a05f3868 ]---
RIP: 0010:cpumask_set_cpu include/linux/cpumask.h:311 [inline]
RIP: 0010:blk_mq_map_swqueue+0x29c/0xa70 block/blk-mq.c:2336
Code: 80 3c 1a 00 0f 85 fa 06 00 00 44 89 ee bf 3f 00 00 00 4d 8b 24 24 e8  
33 01 03 fe 41 83 fd 3f 0f 87 1c 05 00 00 e8 14 00 03 fe <f0> 4d 0f ab b4  
24 18 01 00 00 49 8d bc 24 74 01 00 00 48 89 fa 48
RSP: 0018:ffff8801cedaf4e0 EFLAGS: 00010293
RAX: ffff8801c4f80400 RBX: dffffc0000000000 RCX: ffffffff837be3fd
RDX: 0000000000000000 RSI: ffffffff837be40c RDI: 0000000000000005
RBP: ffff8801cedaf550 R08: ffff8801c4f80400 R09: 0000000000000000
R10: ffffed003a31dff0 R11: ffff8801d18eff83 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: ffff8801d1fd7000
FS:  00007f2a2bb34700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000118 CR3: 00000001c55c5000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
