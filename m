Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0084C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870AA20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfBUOyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:54:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42365 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBUOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:54:04 -0500
Received: by mail-io1-f70.google.com with SMTP id f10so1581880ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7Mfsl0pOD7hijo3ZX4ghJMDojQUtTjQ9H7NHgnJ1oy4=;
        b=ZmdYRqpQ8NOeDRfhjMf+7iLPfh1QE7vzokG3lAaW+bv6mmqQswEbjXk91x5ZxysOg3
         Ao2cqn4gAg4wPQEk0tP+HCKP6U2Jcp93AXw4qcdhXyhCHiS6L0J4fsjQGFECIgeihDRg
         8rbzi1eMh1JFFiO+XwlHqcALzW9IwYxZCc8CIZR8fjnmNhbfbMc9b1EHv8q3Dh3XExW/
         wjGGQsDBhaHSUDPrXX+GFNwPSHARJkUeuZp1ILCP3If9Q9p918BGwtZu10xoufy7m0qY
         TY5uC2URizxMaEe7DgpezP/+rTsZFWSCiCQL8Lfyi/dyQA9w69Wm73/AwJJBdsgovNgM
         tzoQ==
X-Gm-Message-State: AHQUAua0Z+LqWNVNvOfaqky7OfVi2ZLltLvEDMD25Vxz3lH6wm7YQehL
        ilpsEjEvHVDVu4ey8i9HQVM316uVlCq+qtPUMR0VW2hrZZiD
X-Google-Smtp-Source: AHgI3IaG2GGb/XtG97Xtk1Ic9BdhhWzHcYhhzZkGYIZrgyL23DgzHb3F5T32OW1fEWOiMi+RFdhdYEUKpUpP7+bRnG9GoHU0HDsC
MIME-Version: 1.0
X-Received: by 2002:a5d:8b47:: with SMTP id c7mr1864621iot.21.1550760843370;
 Thu, 21 Feb 2019 06:54:03 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:54:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000336578058268a553@google.com>
Subject: general protection fault in relay_switch_subbuf
From:   syzbot <syzbot+8e789999f280ccd6930f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiggers@google.com,
        jrdr.linux@gmail.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c04e2a780caf Merge tag 'fsnotify_for_v5.0-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133424c0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=8e789999f280ccd6930f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8e789999f280ccd6930f@syzkaller.appspotmail.com

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11600 Comm: syz-executor2 Not tainted 5.0.0-rc3+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:relay_switch_subbuf+0x27a/0xad0 kernel/relay.c:753
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e2 07 00 00 48 b8 00 00 00 00  
00 fc ff df 48 8b 4b 58 48 8d 79 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 c9 07 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff88805e3ef790 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88804bc7db40 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff8182d552 RDI: 0000000000000050
RBP: ffff88805e3ef850 R08: ffff8880637f0600 R09: fffffbfff133b0b1
R10: ffff88805e3ef850 R11: ffffffff899d8587 R12: 0000000000000000
R13: ffff8880a7e05e00 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f1fdbddd700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a50489 CR3: 00000000943a0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  relay_flush kernel/relay.c:881 [inline]
  relay_flush+0x1c4/0x280 kernel/relay.c:865
  __blk_trace_startstop.isra.0+0x28b/0x8b0 kernel/trace/blktrace.c:668
  blk_trace_ioctl+0x1c6/0x300 kernel/trace/blktrace.c:727
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
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1fdbddcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458099
RDX: 0000000000000000 RSI: 0000000000001275 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1fdbddd6d4
R13: 00000000004bf595 R14: 00000000004d0e88 R15: 00000000ffffffff
Modules linked in:
kobject: 'loop4' (000000005903bd4d): kobject_uevent_env
kobject: 'loop4' (000000005903bd4d): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
---[ end trace d4380d594e5099d1 ]---
RIP: 0010:relay_switch_subbuf+0x27a/0xad0 kernel/relay.c:753
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e2 07 00 00 48 b8 00 00 00 00  
00 fc ff df 48 8b 4b 58 48 8d 79 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 c9 07 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
kobject: 'loop0' (0000000083b22ec7): kobject_uevent_env
kobject: 'loop0' (0000000083b22ec7): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
Unknown ioctl 19304
kobject: 'loop3' (0000000050016e38): kobject_uevent_env
RSP: 0018:ffff88805e3ef790 EFLAGS: 00010206
kobject: 'loop3' (0000000050016e38): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RAX: dffffc0000000000 RBX: ffff88804bc7db40 RCX: 0000000000000000
kobject: 'loop1' (000000002962ffee): kobject_uevent_env
kobject: 'loop1' (000000002962ffee): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RDX: 000000000000000a RSI: ffffffff8182d552 RDI: 0000000000000050
kobject: 'loop4' (000000005903bd4d): kobject_uevent_env
kobject: 'loop4' (000000005903bd4d): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
RBP: ffff88805e3ef850 R08: ffff8880637f0600 R09: fffffbfff133b0b1
kobject: 'loop4' (000000005903bd4d): kobject_uevent_env
R10: ffff88805e3ef850 R11: ffffffff899d8587 R12: 0000000000000000
kobject: 'loop4' (000000005903bd4d): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
R13: ffff8880a7e05e00 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f1fdbddd700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000000943a0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
