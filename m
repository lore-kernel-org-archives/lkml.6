Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B0ECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070F4208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070F4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeIPU4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:56:22 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:44990 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeIPU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:56:22 -0400
Received: by mail-it0-f69.google.com with SMTP id b124-v6so9978236itb.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 08:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NxwtCvkZKdhJXD9rKEfExo3jzZ0RHOWsTefA74PZtqo=;
        b=nzXU7QdsPA5+nZrEkpkwIyOLUH612bMnSGuidFMlsnu86SaxYI27evh+Hwn4YeB2AN
         GcePqT4ksasiSlMr/EJM5UL6AzBg1BT/vzqFDlAQPAN+jMu99Dq9RAvO1VqjZ5X/J0ch
         ZbYZ3FQDpcR2KbJrgqdyt60zK1hQbQWT9F3PdHfo2nGHfXpSs2ZjD/XDHOyDWB9QBKjJ
         iZU0DFwVSgKDziX/PuInxJ1x5ZlmE/m2Zr/7dH2Z1Fc+etoNGtyRtuJcllyJSkkP0DCH
         efLHBNo9BWF07uK3nl2GKcIUs03gvFjcMGhN/l4KMCaibIIz9XtNq5ECJrTizLrWfKSy
         /YpA==
X-Gm-Message-State: APzg51DH1QpKbZNhJ5gUINC6i4OVyjZonZkg4PRq6pNZ4X+0nNMmLllo
        +9kZoSfAG07VcKZjViF5YZxsn9PpWTmhZ+0RctdBzl6R8/gm
X-Google-Smtp-Source: ANB0VdYnCxa7E/pQ5RqY4L1Y9cM/pVIHn/vigGSq4DJDzOZPFv7/92JLHhrxHMqlZimszPI2XSReirhHQLLqcMeA2HOsEAIGUxU7
MIME-Version: 1.0
X-Received: by 2002:a02:97a2:: with SMTP id s31-v6mr15982580jaj.45.1537111983345;
 Sun, 16 Sep 2018 08:33:03 -0700 (PDT)
Date:   Sun, 16 Sep 2018 08:33:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf6bd30575fec528@google.com>
Subject: general protection fault in kernfs_add_one
From:   syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5e335542de83 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a1f2ae400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=db1637662f412ac0d556
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a66c11400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1346c771400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com

kobject_add_internal failed for hci2 (error: -2 parent: bluetooth)
Bluetooth: Can't register HCI device
Bluetooth: Can't register HCI device
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
kobject: 'hci5' (00000000943cb5fb): kobject_cleanup, parent           (null)
CPU: 0 PID: 6716 Comm: syz-executor469 Not tainted 4.19.0-rc3+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kernfs_add_one+0x342/0x4d0 fs/kernfs/dir.c:812
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 49 01 00 00 48 b8 00 00 00 00  
00 fc ff df 4d 8b 6d 70 49 8d 7d 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 16 01 00 00 45 8b 6d 08 31 ff
kobject: 'rfkill1319' (00000000969d6091): kobject_uevent_env
RSP: 0018:ffff8801bc5df588 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801ba043380 RCX: ffffffff87bea6d7
RDX: 0000000000000001 RSI: ffffffff81f7f9ca RDI: 0000000000000008
RBP: ffff8801bc5df5d0 R08: fffffbfff12d121d R09: fffffbfff12d121c
R10: fffffbfff12d121c R11: ffffffff896890e7 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001901880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
kobject: 'rfkill1320' (000000000f2f7b02): kobject_add_internal:  
parent: 'hci4', set: 'devices'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e5ce5a000 CR3: 00000001bb73b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kobject: 'hci5' (00000000943cb5fb): calling ktype release
  kernfs_create_dir_ns+0xf6/0x160 fs/kernfs/dir.c:1031
  sysfs_create_dir_ns+0x19b/0x340 fs/sysfs/dir.c:58
kobject: 'rfkill1319' (00000000969d6091): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2/rfkill1319'
  create_dir lib/kobject.c:88 [inline]
  kobject_add_internal+0x440/0xb60 lib/kobject.c:247
kobject: 'hci5': free name
  kobject_add_varg lib/kobject.c:382 [inline]
  kobject_add+0x13f/0x1b0 lib/kobject.c:426
kobject: 'rfkill1320' (000000000f2f7b02): kobject_uevent_env
  device_add+0x3e2/0x17f0 drivers/base/core.c:1879
kobject: 'rfkill1320' (000000000f2f7b02): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4/rfkill1320'
kobject: 'rfkill1319' (00000000969d6091): kobject_cleanup, parent            
(null)
  hci_register_dev+0x3e6/0xb80 net/bluetooth/hci_core.c:3196
kobject: 'rfkill1320' (000000000f2f7b02): kobject_uevent_env
  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
kobject: 'hci1' (000000005b9ca8c2): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1807 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
kobject: 'rfkill1319' (00000000969d6091): calling ktype release
kobject: 'rfkill1320' (000000000f2f7b02): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4/rfkill1320'
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
kobject: 'hci1' (000000005b9ca8c2): kobject_uevent_env
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'hci1' (000000005b9ca8c2): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
kobject: 'rfkill1319': free name
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440e49
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'hci2' (00000000156e1c6f): kobject_uevent_env
RSP: 002b:00007fff32bcc918 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440e49
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000001901880 R11: 0000000000000213 R12: 0000000000013465
kobject: 'rfkill1321' (00000000bd6cc24c): kobject_add_internal:  
parent: 'hci1', set: 'devices'
R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
kobject: 'hci3' (00000000c8669077): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'hci2' (00000000156e1c6f): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2'
kobject: 'hci5' (0000000076c884f7): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'hci2' (00000000156e1c6f): kobject_cleanup, parent           (null)
kobject: 'rfkill1321' (00000000bd6cc24c): kobject_uevent_env
kobject: 'hci2' (00000000156e1c6f): calling ktype release
kobject: 'hci5' (0000000076c884f7): kobject_uevent_env
kobject: 'hci2': free name
kobject: 'rfkill1321' (00000000bd6cc24c): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1/rfkill1321'
---[ end trace 984285625d9f4992 ]---
kobject: 'hci5' (0000000076c884f7): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci5'
kobject: 'hci2' (0000000016287cb9): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'hci3' (00000000c8669077): kobject_uevent_env
RIP: 0010:kernfs_add_one+0x342/0x4d0 fs/kernfs/dir.c:812
kobject: 'hci3' (00000000c8669077): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci3'
kobject: 'hci2' (0000000016287cb9): kobject_uevent_env
kobject: 'rfkill1320' (000000000f2f7b02): kobject_cleanup, parent            
(null)
kobject: 'hci2' (0000000016287cb9): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2'
kobject: 'rfkill1321' (00000000bd6cc24c): kobject_uevent_env
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 49 01 00 00 48 b8 00 00 00 00  
00 fc ff df 4d 8b 6d 70 49 8d 7d 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 16 01 00 00 45 8b 6d 08 31 ff
kobject: 'rfkill1322' (00000000876a5655): kobject_add_internal:  
parent: 'hci5', set: 'devices'
RSP: 0018:ffff8801bc5df588 EFLAGS: 00010202
kobject: 'rfkill1321' (00000000bd6cc24c): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1/rfkill1321'
kobject: 'rfkill1320' (000000000f2f7b02): calling ktype release
RAX: dffffc0000000000 RBX: ffff8801ba043380 RCX: ffffffff87bea6d7
kobject: 'rfkill1322' (00000000876a5655): kobject_uevent_env
RDX: 0000000000000001 RSI: ffffffff81f7f9ca RDI: 0000000000000008
kobject: 'rfkill1320': free name
kobject: 'rfkill1322' (00000000876a5655): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci5/rfkill1322'
kobject: 'hci4' (0000000004abaebf): kobject_uevent_env
RBP: ffff8801bc5df5d0 R08: fffffbfff12d121d R09: fffffbfff12d121c
kobject: 'hci4' (0000000004abaebf): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4'
R10: fffffbfff12d121c R11: ffffffff896890e7 R12: 0000000000000000
kobject: 'hci4' (0000000004abaebf): kobject_cleanup, parent           (null)
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
kobject: 'rfkill1322' (00000000876a5655): kobject_uevent_env
FS:  0000000001901880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
kobject: 'rfkill1322' (00000000876a5655): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci5/rfkill1322'
kobject: 'rfkill1323' (000000001d9583a0): kobject_add_internal:  
parent: 'hci2', set: 'devices'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'rfkill1323' (000000001d9583a0): kobject_uevent_env
CR2: 00007f5e5ce5a000 CR3: 00000001bb73b000 CR4: 00000000001406e0
kobject: 'hci4' (0000000004abaebf): calling ktype release
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'rfkill1323' (000000001d9583a0): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2/rfkill1323'
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: 'hci4': free name


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
