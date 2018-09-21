Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C17ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A225221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbeIUOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:44:54 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45384 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUOoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:44:54 -0400
Received: by mail-io1-f69.google.com with SMTP id o4-v6so19054539iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GmhRUqJ5Q2yuHnKV4bAYHa3Ogg2FPVj0jny9qwVgus4=;
        b=thxczI2z05t4/tKPFR6AlMnff7WZzD8d0uIv+mRkinK2NosEVsHDYMZtSBSvEOFhvh
         c/lnK6PhTtAdcve+ItrxPWJ5UOE8uSD7sAvCV+ua8rRyLWPMRFUSdar2hFjyeQEzsFrl
         dS3nwD6qG3o8RExCj48Hr4lffW02hMvVOdDxkdTOSmFkqYzqsM5WX3rVAd3o85Uwaidk
         9tnsq6Is5FcaC7mhociXBYm7Aafnun3WEdmLgDDiikl2lsBWFDljOs5IVl2khBoeHh5l
         LfYWT3iznUGIWLtrr3XZEDGioKF0nO/tEkwKWnmIVG06gNhaxxSFe/tncW0ldXpQ0RyL
         lR/g==
X-Gm-Message-State: APzg51Ax2VX1eeXojvEiRdOOPRLNcVr3jCMKcL9D0JQCDe8sw+5Mr4P9
        IwPEFJ6M5sTduAT59iDtr07FxomI/LCOPZXqK+79U5qSROfr
X-Google-Smtp-Source: ANB0VdYSWasAxaM8JDcgeB6SVbFo66jEVDtWjGsUxggXAhTdFk2dPFlz6/k8PrZTwFcjBrP/Ak3JqmG0fAMO/M21qEKF5JRXflCJ
MIME-Version: 1.0
X-Received: by 2002:a6b:7319:: with SMTP id e25-v6mr30831358ioh.98.1537520222197;
 Fri, 21 Sep 2018 01:57:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 01:57:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000addf6005765dd2c6@google.com>
Subject: WARNING in sysfs_remove_group (2)
From:   syzbot <syzbot+34cbd0f790e5ab87f63b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ee0d11400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=34cbd0f790e5ab87f63b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+34cbd0f790e5ab87f63b@syzkaller.appspotmail.com

kobject_add_internal failed for rfkill10 (error: -2 parent: hci1)
------------[ cut here ]------------
sysfs group 'power' not found for kobject 'hci1'
WARNING: CPU: 1 PID: 11200 at fs/sysfs/group.c:255  
sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:253
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 11200 Comm: syz-executor3 Not tainted 4.19.0-rc4+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
kobject: 'loop2' (00000000c60b67bc): kobject_uevent_env
  panic+0x238/0x4e7 kernel/panic.c:184
kobject: 'loop2' (00000000c60b67bc): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:253
Code: 48 89 d9 49 8b 55 00 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c  
01 00 75 41 48 8b 33 48 c7 c7 20 5d 18 88 e8 a5 07 50 ff <0f> 0b eb 92 e8  
ec 81 c9 ff e9 d0 fe ff ff 48 89 df e8 df 81 c9 ff
RSP: 0018:ffff88019993f550 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff885f83c0 RCX: ffffc90005079000
RDX: 000000000001f3e2 RSI: ffffffff8164fd15 RDI: 0000000000000005
RBP: ffff88019993f578 R08: ffff880195688140 R09: ffffed003b5e4fe8
R10: ffffed003b5e4fe8 R11: ffff8801daf27f47 R12: 0000000000000000
R13: ffff8801d2636990 R14: ffffffff885f8960 R15: 0000000000000000
  dpm_sysfs_remove+0x58/0x60 drivers/base/power/sysfs.c:734
  device_del+0x118/0xb70 drivers/base/core.c:2054
  hci_unregister_dev+0x3c2/0xbf0 net/bluetooth/hci_core.c:3290
  vhci_release+0x76/0xf0 drivers/bluetooth/hci_vhci.c:354
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  get_signal+0x155e/0x1980 kernel/signal.c:2343
  do_signal+0x9c/0x21e0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
kobject: 'loop0' (0000000011f4c275): kobject_uevent_env
RIP: 0033:0x457679
kobject: 'loop0' (0000000011f4c275): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa1ca1b9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000000002 RBX: 00007fa1ca1ba6d4 RCX: 0000000000457679
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d8628 R14: 00000000004c51dd R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
