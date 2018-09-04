Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C387C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3913D20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3913D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeIDMO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:14:59 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:46224 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeIDMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:14:59 -0400
Received: by mail-io0-f198.google.com with SMTP id f4-v6so2526367ioh.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 00:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b8KbKCNygD1+p5hzXiFp7NgIdn1VJLDZD51KDw6dzbE=;
        b=G1AAMKyFW4klqhWPKDx74ktLkDyZFMMdlzXMuNH6O4TtUJUh+UQOkUa/Yp6HKh3mbt
         EWLe59u7MQWQHPDoSY85vezhCqC4IxtHWnMAQNqzUvo4TSV4FWtMimAIgUJItul/S0ZH
         Y0Ga0r1RXhavVWKcP4fUq16w2U/Sh50pzwZFisfxxIC+PYu4ZsZjVT8mkqNthUF8ETtm
         O2QC04cha6EON3b+LQDO/RWUZBvMGFGDTDiyW2ynRb/qWItHWZlgKRQMHmIdWJ2UrehO
         DwgeQzr445wTW8c/+pSFuwN0pSVb+R8+Vs3QSGgiEfOsnuIEpFO8vhe+fyHkq5Nhbj/6
         8WxQ==
X-Gm-Message-State: APzg51B4R2z+w5GvvWve+7kzMUkADYwNPuCCU0ohbYdLXR+TfEv+gk4n
        55gHcoPuIs6RXwzECvLDvV4KONE0ntUjYg/dkNznExIMz1uY
X-Google-Smtp-Source: ANB0VdYVzuhQNqImq51Xlgkme0Ld7H34eEG3sGJX2SflM7wELCHaLZGL+UlQUz9axBWd+1gqfEuvBwl3+bB3/qcDWBp7CKZzeVKX
MIME-Version: 1.0
X-Received: by 2002:a02:c89:: with SMTP id 9-v6mr13389168jan.52.1536047462808;
 Tue, 04 Sep 2018 00:51:02 -0700 (PDT)
Date:   Tue, 04 Sep 2018 00:51:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006105bf057506ebb9@google.com>
Subject: divide error in nbd_ioctl
From:   syzbot <syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    217c3e019675 disable stringop truncation warnings for now
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13665da6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=25dbecbec1e62c6b0dd4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e910a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169dfe0a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
divide error: 0000 [#1] SMP KASAN
CPU: 0 PID: 4667 Comm: syz-executor024 Not tainted 4.19.0-rc1+ #216
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x9cd/0x2030 block/ioctl.c:601
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
RIP: 0033:0x443d29
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe343644d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
RDX: 0000000000000000 RSI: 000000000000ab01 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401a30
R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 25c60c4714d4e2ee ]---
RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
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
