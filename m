Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B234C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FE6206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FE6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeIJMXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:23:43 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:51672 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeIJMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:23:43 -0400
Received: by mail-it0-f71.google.com with SMTP id q5-v6so39961423ith.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DigTXB/cmVtzl8DT54ZGr67piMDmjqsaCpcfMcFvFG8=;
        b=QhUTse8NxCab/USua7lHQnCPb/dMVXdTVf4Vbkv54VJ3VRL9rVWEspxc2jcc0gdju/
         JTA+a1ahsMwp4PykmbdGFY6Fa7xp0S7JxgHME8U0d0yhHub+gMaOuFD9BGfcqDHwqqlj
         M3NQ0e8UOM3xGj9gCLVQkuhxRsEzZRjEmm9ZgTnI+IDXrJicBlL1u6FaP2IsYE7xIcvW
         kO2f5CfO5voEhcmXDRWMdHzgmSj7xqoGnBiLOivKzhRIw11iJoRY6nNIU557Rx9nKgFi
         YsOzB5tlf4s3EmlVC1QYWay1mlnp2St1fyNW5gCP3n8JYW31noWxPYECIVaTXIgSPKoF
         7QRg==
X-Gm-Message-State: APzg51C1YyUtEVLgAH4F2kaK8LYiXsrwj1z4rbwS3uQxJ/YSxMC57HQF
        bvzlgSeuUvTmCYPFijS/AvhvZ1qB+iRiXMQMd5iKqNgMd5+z
X-Google-Smtp-Source: ANB0VdabY8HOTckydzVfyZxqsmWfhq+mcgLrGnA8vOlICbvi5tcnGGJrHSLo9SautYNJ0GHO5aSip2wt/IrWU2sFjAVh5YSdj2/v
MIME-Version: 1.0
X-Received: by 2002:a24:9192:: with SMTP id i140-v6mr16981021ite.39.1536564664014;
 Mon, 10 Sep 2018 00:31:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 00:31:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f921ae05757f567c@google.com>
Subject: WARNING in kernfs_get
From:   syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a5682765a2e Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1624858e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=3dcb532381f98c86aeb1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12657f0a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117728ae400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 5659 at fs/kernfs/dir.c:494  
kernfs_get.part.8+0x131/0x160 fs/kernfs/dir.c:494
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5659 Comm: syz-executor154 Not tainted 4.19.0-rc2+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:kernfs_get.part.8+0x131/0x160 fs/kernfs/dir.c:494
Code: 44 05 00 00 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 75 2f 48  
83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 df 1c 87 ff <0f> 0b eb b1 4c  
89 e7 e8 d3 83 ca ff eb 81 48 89 df e8 29 83 ca ff
RSP: 0018:ffff8801d892f500 EFLAGS: 00010293
RAX: ffff8801c5f56640 RBX: ffff8801c541b8c0 RCX: ffffffff81f7b391
kobject: 'bluetooth' (00000000076788a3): kobject_add_internal:  
parent: 'virtual', set: '(null)'
RDX: 0000000000000000 RSI: ffffffff81f7b3e1 RDI: 0000000000000005
RBP: ffff8801d892f588 R08: ffff8801c5f56640 R09: ffffed0038a83718
R10: ffffed0038a83718 R11: ffff8801c541b8c3 R12: 1ffff1003b125ea4
R13: 1ffff1003b125ea0 R14: 0000000000000000 R15: ffff8801d892f560
  kernfs_get fs/kernfs/dir.c:493 [inline]
  kernfs_new_node+0xb4/0x120 fs/kernfs/dir.c:698
  kernfs_create_dir_ns+0x4d/0x160 fs/kernfs/dir.c:1021
  sysfs_create_dir_ns+0x19b/0x340 fs/sysfs/dir.c:58
kobject: 'hci1' (000000003c3c3740): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  create_dir lib/kobject.c:88 [inline]
  kobject_add_internal+0x440/0xb60 lib/kobject.c:247
kobject: 'hci3' (00000000e8906dbf): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'hci3' (00000000e8906dbf): kobject_uevent_env
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x13f/0x1b0 lib/kobject.c:426
  device_add+0x3e2/0x17f0 drivers/base/core.c:1879
kobject: 'hci2' (000000009e3c3103): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  hci_register_dev+0x3e6/0xb80 net/bluetooth/hci_core.c:3196
kobject: 'hci2' (000000009e3c3103): kobject_uevent_env
  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1807 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
kobject: 'hci3' (00000000e8906dbf): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci3'
kobject: 'hci1' (000000003c3c3740): kobject_uevent_env
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
kobject: 'hci1' (000000003c3c3740): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'hci6': free name
kobject: 'rfkill160' (000000007e905e9b): kobject_add_internal:  
parent: 'hci3', set: 'devices'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440e49
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffce43766e8 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440e49
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000003
kobject: 'hci2' (000000009e3c3103): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2'
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 000000000075f880 R11: 0000000000000213 R12: 000000000000c1e3
R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
