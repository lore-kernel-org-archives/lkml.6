Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC0AC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E882C222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfBLTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:04:29 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:55083 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfBLTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:04:28 -0500
Received: by mail-it1-f197.google.com with SMTP id m196so6538599itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bg8keZyoBFaW9e6ndcmY+/jT5YAWt029ZRHt1l6Aghw=;
        b=QA9QQd6JnUYJLzGnx3Vo9zQIW3EyrCe5hma5ztcXNQ2+7XPqDOVx8SGllU5JWlb6hN
         Osyf4wU+cN4MiSsGO36XkX2becS0c0nVOXtNlDNBF0FmBNp7KuOgIgmh0F7l84zyFMRn
         TvXNK+VYI4OyubrAAn6q6vTr92JgbfceuFu6qEs7NuJ0tflk6RrvFkYU5HCICVm0c4hF
         QoSlcZ/tABS1mgoazicjmyyECSOWD/CjBNzH91BSBnS+Fgqvhi5aggxv+MYVgzFEVjAa
         +GtIEDSzdfYRhT0kuXUrEXcS1jb+NcSGtEl77cW45MwhTBo7FpI3mda05ngRdn4fkbsG
         gPnA==
X-Gm-Message-State: AHQUAuaGbWBqDGwjU/vmy5qG6aMuwcTHRWjkpohXFP7Ky18msK3LKI5C
        UnG2wNl7JAEmJP5Gee2H/+18BOJ1wZIeJAOfcqRrFSCW9ysZ
X-Google-Smtp-Source: AHgI3IasqKOvRbLNLyy0xV+VHVj5oSQ6kVuUt6Ehnh5UAQ30l1Yoz43mOE30UGn8QqCo+v9/Bb17fPun6H5Oql4KhlYTQYEpfHjM
MIME-Version: 1.0
X-Received: by 2002:a6b:b281:: with SMTP id b123mr3636223iof.39.1549998267538;
 Tue, 12 Feb 2019 11:04:27 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:04:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023a7e70581b71894@google.com>
Subject: general protection fault in idr_remove
From:   syzbot <syzbot+3d07f0ffd652af4f49e6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b5829453d81a Add linux-next specific files for 20190212
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1662de24c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4085ec231ef9027d
dashboard link: https://syzkaller.appspot.com/bug?extid=3d07f0ffd652af4f49e6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d07f0ffd652af4f49e6@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 16586 Comm: syz-executor.5 Not tainted 5.0.0-rc6-next-20190212  
#33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:idr_remove+0x28/0x60 lib/idr.c:153
Code: 40 00 55 48 89 e5 41 54 49 89 fc 53 48 89 f3 e8 9e a5 6f fa 49 8d 7c  
24 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 04 3c 03 7e 1a 41 8b 44 24 48 4c 89 e7 31 d2
RSP: 0018:ffff8880263c7820 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 00000000000180a4 RCX: ffffc90010870000
RDX: 000000000000020b RSI: ffffffff8700a952 RDI: 0000000000001058
RBP: ffff8880263c7830 R08: 1ffff11004c78ef5 R09: ffffed1004c78ef6
R10: ffffed1004c78ef5 R11: 0000000000000003 R12: 0000000000001010
R13: ffff88808eb137e0 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f1aa164c700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbc506316b CR3: 00000000a9547000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  kernfs_put fs/kernfs/dir.c:542 [inline]
  kernfs_put+0x342/0x600 fs/kernfs/dir.c:506
  kernfs_create_dir_ns+0x135/0x160 fs/kernfs/dir.c:1035
  sysfs_create_dir_ns+0x131/0x2a0 fs/sysfs/dir.c:59
  create_dir lib/kobject.c:88 [inline]
  kobject_add_internal lib/kobject.c:247 [inline]
  kobject_add_internal.cold+0xe5/0x5d4 lib/kobject.c:217
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x150/0x1c0 lib/kobject.c:426
  device_add+0x3d5/0x18a0 drivers/base/core.c:2070
  hci_register_dev+0x304/0x880 net/bluetooth/hci_core.c:3264
  __vhci_create_device+0x2d0/0x5a0 drivers/bluetooth/hci_vhci.c:139
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2d0/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1853 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x613/0x8e0 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1aa164bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1aa164c6d4
R13: 00000000004c6e80 R14: 00000000004dc6a0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 7fdd458eb72d2ee0 ]---
RIP: 0010:idr_remove+0x28/0x60 lib/idr.c:153
Code: 40 00 55 48 89 e5 41 54 49 89 fc 53 48 89 f3 e8 9e a5 6f fa 49 8d 7c  
24 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 04 3c 03 7e 1a 41 8b 44 24 48 4c 89 e7 31 d2
RSP: 0018:ffff8880263c7820 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 00000000000180a4 RCX: ffffc90010870000
RDX: 000000000000020b RSI: ffffffff8700a952 RDI: 0000000000001058
RBP: ffff8880263c7830 R08: 1ffff11004c78ef5 R09: ffffed1004c78ef6
R10: ffffed1004c78ef5 R11: 0000000000000003 R12: 0000000000001010
R13: ffff88808eb137e0 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f1aa164c700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbc506316b CR3: 00000000a9547000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
