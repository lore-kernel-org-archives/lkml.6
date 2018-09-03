Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2410BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB372077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB372077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeICWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:12:19 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:38731 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeICWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:12:18 -0400
Received: by mail-it0-f72.google.com with SMTP id h5-v6so1255452itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1+s+D+/35aNYYHfcvAZ5gYuv3mNevP3+LaHpwyawFRQ=;
        b=p6bWe2o6POjpo3V8aLlDy+ZOztkYb9RJCv5HBZ2l2XGZMGCgFbJV16H3o4gAaFxQ3L
         lxXizSl5mVz48Jz3iXHIqD7+VxjYYGCF8LfvSovQipw0qGIqIcyqF6WTY+q9xHwYBrvc
         usKTrVU5kBZjnBDLlSKVOsfwPPBfKj3aN515iJZnk5ZaGIddTRY2jjmslE/iO3gND3Dn
         bU6r4GMEVSo55Cz3X/UYCGt2uNGi/OLLVOBOOb+lRq4Ls6YbLFKKKT8Dx1KzPrtjcjbA
         eDM53rzbKHF2VZAc91yKjFUTrMVNJiz9W3G2WQB4NSgIcfgb/n9hvK7P3KM1GW1QVlRn
         IuKw==
X-Gm-Message-State: APzg51CbACgNHA5XgLnPlbMQnpPuRpb6E7xQkIqEk5ahvBURvjuF+pue
        kHUr2Mm9oipnKRkOfW8k2/NPqlQ72wqkGBT1iiJVnUij6gns
X-Google-Smtp-Source: ANB0VdYnXXY6rEOG421Lw/KSReI7ntK06GWhFdhfiHcEOYjQIdO+zChPuX3xyZZQGBnhacrIf2rgYWrYHw714JKEA5xKD1drkv9s
MIME-Version: 1.0
X-Received: by 2002:a24:39c2:: with SMTP id l185-v6mr4464289ita.51.1535997063969;
 Mon, 03 Sep 2018 10:51:03 -0700 (PDT)
Date:   Mon, 03 Sep 2018 10:51:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fbf690574fb2f26@google.com>
Subject: general protection fault in usb_find_alt_setting (2)
From:   syzbot <syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1046f0ea400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=19c3aaef85a89d451eac
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109ed296400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d890ca400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
usb usb1: usbfs: interface 0 claimed by hub while 'syz-executor177' sets  
config #0
usb usb1: usbfs: process 4640 (syz-executor177) did not claim interface 0  
before use
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4641 Comm: syz-executor177 Not tainted 4.19.0-rc1+ #215
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231
Code: 89 fb 48 83 ec 10 48 89 7d c8 89 55 d4 89 75 d0 e8 bd 0e 0b fd 48 8d  
7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 02 00 00
RSP: 0018:ffff8801ba7274a8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8476da79
RDX: 0000000000000000 RSI: ffffffff8471b1c3 RDI: 0000000000000004
RBP: ffff8801ba7274e0 R08: ffff8801bab5c400 R09: ffffed00374e4eb2
R10: ffffed00374e4eb4 R11: ffff8801ba7275a7 R12: 0000000000000000
R13: ffff8801ce48d500 R14: ffff8801bb55f840 R15: 0000000000000000
FS:  0000000001231880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000001baf94000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  check_ctrlrecip+0x1e6/0x320 drivers/usb/core/devio.c:828
  proc_control+0x151/0xef0 drivers/usb/core/devio.c:1074
  usbdev_do_ioctl+0x1eb4/0x3b30 drivers/usb/core/devio.c:2394
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2551
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444b19
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffffd7d0408 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000444b19
RDX: 0000000020000280 RSI: 00000000c0185500 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000004002e0
R10: 000000000000ffff R11: 0000000000000217 R12: 000000000000893f
R13: 0000000000401f10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace f80beb69e56f2f62 ]---
RIP: 0010:usb_find_alt_setting+0x38/0x310 drivers/usb/core/usb.c:231
Code: 89 fb 48 83 ec 10 48 89 7d c8 89 55 d4 89 75 d0 e8 bd 0e 0b fd 48 8d  
7b 04 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 86 02 00 00
RSP: 0018:ffff8801ba7274a8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8476da79
RDX: 0000000000000000 RSI: ffffffff8471b1c3 RDI: 0000000000000004
RBP: ffff8801ba7274e0 R08: ffff8801bab5c400 R09: ffffed00374e4eb2
R10: ffffed00374e4eb4 R11: ffff8801ba7275a7 R12: 0000000000000000
R13: ffff8801ce48d500 R14: ffff8801bb55f840 R15: 0000000000000000
FS:  0000000001231880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf090 CR3: 00000001baf94000 CR4: 00000000001406e0
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
