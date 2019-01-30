Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFD9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D1920989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbfA3SxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:53:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42993 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3SxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:53:05 -0500
Received: by mail-io1-f70.google.com with SMTP id a2so402956ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vOcTGncngWsW3rYNwCIuTM9LGApBnxFnXzN6J6+oUhs=;
        b=awqdrF5A6qdZK3wvOPo7wFq3SDnlKdfhQIqRD/yL3Ic2jyLcXhLSCMTv2LUO1FuBmR
         bXvaqwrailtewADUBP9FVBsgQ0cB12beMehB8GWyWVsFJuUPeTmm3SodzwTF5yKwJmmo
         L+S6paiHbBcL6qWF3Aeha5/x4jf7VD2b8qFAOKrC3em5pLNNlcgbV9EomC61ldHhopYL
         J6jzCGhMlZ6XR3Yn8Qmnxl4ssgOdxXkChKyrBo1cDlHhtIWwWuzyF6cagTfQzyxztW3t
         46UGbhXLNp4AUG/flUAnskFXyHZCV4T6VSyDLMenxWXZOxDSJ7QG2o39lgEn4XArgPpB
         84qQ==
X-Gm-Message-State: AHQUAub+4LIA5Usynb89nsx3uK0PxXcslw8XBykZHBU9DkdHzR1s6adW
        HZ/AE5DFwafNJPIUP//mI/nSjbz7Z5kbYxyYqLaNZFDDLEWP
X-Google-Smtp-Source: AHgI3IYFlHfHT+zxkK36+K8SMD4wyVONsEmq4kUDAjArdvgqM9LEr8aPa6iX93I9tSmuLGl/PU1/wEf8QneavaPksulUOJlNU2dN
MIME-Version: 1.0
X-Received: by 2002:a6b:f614:: with SMTP id n20mr7145355ioh.15.1548874383934;
 Wed, 30 Jan 2019 10:53:03 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:53:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074cbc30580b16bc3@google.com>
Subject: general protection fault in relay_open_buf
From:   syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiggers@google.com,
        jrdr.linux@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12cf10df400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=16c3a70e1e9b29346c43
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13266698c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715bb64c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8092 Comm: syz-executor405 Not tainted 5.0.0-rc4-next-20190130  
#22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]
RIP: 0010:relay_open_buf.part.0+0x7cb/0xb40 kernel/relay.c:458
Code: c1 ea 03 80 3c 02 00 0f 85 4c 03 00 00 49 8d 7d 58 4d 89 ac 24 90 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1b 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff888088897670 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88809f2b3080 RCX: 1ffff110110c6919
RDX: 0000000000000008 RSI: ffffffff81833b80 RDI: 0000000000000047
RBP: ffff8880888976e8 R08: 0000000000000006 R09: ffff8880886348c8
R10: ffff888088634000 R11: 0000000000000000 R12: ffff88809f5ef580
R13: ffffffffffffffef R14: 0000000000000000 R15: 0000000000000000
FS:  00000000021c4880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000000a4ccd000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  relay_open_buf kernel/relay.c:447 [inline]
  relay_open kernel/relay.c:597 [inline]
  relay_open+0x5f3/0xaf0 kernel/relay.c:561
  do_blk_trace_setup+0x50d/0xdb0 kernel/trace/blktrace.c:532
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
RIP: 0033:0x444af9
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd22903da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000444af9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 000000000000d8fa R08: 00000000021c4880 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000401e60
R13: 0000000000401ef0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d79fd6b85e15805c ]---
RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]
RIP: 0010:relay_open_buf.part.0+0x7cb/0xb40 kernel/relay.c:458
Code: c1 ea 03 80 3c 02 00 0f 85 4c 03 00 00 49 8d 7d 58 4d 89 ac 24 90 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1b 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff888088897670 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffff88809f2b3080 RCX: 1ffff110110c6919
RDX: 0000000000000008 RSI: ffffffff81833b80 RDI: 0000000000000047
RBP: ffff8880888976e8 R08: 0000000000000006 R09: ffff8880886348c8
R10: ffff888088634000 R11: 0000000000000000 R12: ffff88809f5ef580
R13: ffffffffffffffef R14: 0000000000000000 R15: 0000000000000000
FS:  00000000021c4880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000000a4ccd000 CR4: 00000000001406f0
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
