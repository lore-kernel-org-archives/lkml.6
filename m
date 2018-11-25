Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0210BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF21D2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF21D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKYWLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:11:55 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:36400 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeKYWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:11:54 -0500
Received: by mail-it1-f199.google.com with SMTP id p78-v6so19365376itb.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 03:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RLrAapg3vwEkhnS99bB0uQIWQNvgSAqPJ9XhqIL+u+c=;
        b=tzkaOKt5ZP/787lLH7+jqEcopbYTZ+JHkTY/5JVcdhmlORvggoU0oxAUBeGH/n3+gn
         LNyZInHReLfyC1gppqVmXYjO4Zn4VMqKnGDvuy8U9o4AX6ywkm8OhFDQG4ZSuzGOsFfb
         bIHBxz3Vm5vbJPQDEswD6zGyw8MwU/oIxtKf8qN/4duVi93hyp9jJvdfKqM6ylIIAaF8
         NF34GxU/q7HizGewKr1XzTmfdE+18nliHCO9slcw3WmMwyA0c2yq6lpKpU5N+xwjV09H
         OQmSpR9d71gqZ1uWE/wavkGj1ncilTuOQHtdDPbAbkldsRWLDUzrMvJOuOs0g5e1KTDP
         QyWA==
X-Gm-Message-State: AA+aEWaoCa9fbWPgRvOSuc1Rfi6AbwLD0Wr5UQgnScOLCW5lmC1JX5sF
        rMzZbVTeedfT5tD/aZvsISQuHb7gqjQ2LuiS8pJ6HsYj2XWL
X-Google-Smtp-Source: AFSGD/WpbbULngtiIwbtB21XQ+uY4OKiBoYA/rYoZjOT1gnzwd/5pGSO3/1Q4GDz80GbTygAlMYDAURzMCOBvXpVV+qOzPqFXonA
MIME-Version: 1.0
X-Received: by 2002:a5d:9801:: with SMTP id a1mr553192iol.31.1543144862118;
 Sun, 25 Nov 2018 03:21:02 -0800 (PST)
Date:   Sun, 25 Nov 2018 03:21:02 -0800
In-Reply-To: <000000000000addf6005765dd2c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057f850057b7b6946@google.com>
Subject: Re: WARNING in sysfs_remove_group (2)
From:   syzbot <syzbot+34cbd0f790e5ab87f63b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1659a62b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=34cbd0f790e5ab87f63b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dad1f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1211db83400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+34cbd0f790e5ab87f63b@syzkaller.appspotmail.com

kobject_add_internal failed for hci3 (error: -2 parent: bluetooth)
------------[ cut here ]------------
Bluetooth: Can't register HCI device
sysfs group 'power' not found for kobject 'hci0'
WARNING: CPU: 1 PID: 6615 at fs/sysfs/group.c:255  
sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:253
kobject: 'bluetooth' (0000000099b926db): kobject_add_internal:  
parent: 'virtual', set: '(null)'
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6615 Comm: syz-executor148 Not tainted 4.20.0-rc3+ #128
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
kobject: 'hci4' (00000000b7b152ea): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
kobject: 'hci3' (00000000de75fad9): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
kobject: 'hci4' (00000000b7b152ea): kobject_uevent_env
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:sysfs_remove_group+0x15b/0x1b0 fs/sysfs/group.c:253
kobject: 'hci1' (000000005f181f76): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
Code: 48 89 d9 49 8b 55 00 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c  
01 00 75 41 48 8b 33 48 c7 c7 a0 bb 37 88 e8 85 2e 4f ff <0f> 0b eb 92 e8  
3c 1d c9 ff e9 d0 fe ff ff 48 89 df e8 2f 1d c9 ff
RSP: 0018:ffff8881b01878b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff887c3640 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881b01878e0 R08: ffff8881abd72700 R09: ffffed103b5e3ef8
R10: ffffed103b5e3ef8 R11: ffff8881daf1f7c7 R12: 0000000000000000
R13: ffff8881abf02890 R14: ffffffff887c3be0 R15: ffff8881abf02880
  dpm_sysfs_add+0x1cf/0x210 drivers/base/power/sysfs.c:678
  device_add+0x8d8/0x18e0 drivers/base/core.c:1902
kobject: 'hci4' (00000000b7b152ea): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4'
kobject: 'hci5' (0000000072db0368): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
kobject: 'hci3' (00000000de75fad9): kobject_uevent_env
  hci_register_dev+0x3b3/0x9c0 net/bluetooth/hci_core.c:3261
kobject: 'hci1' (000000005f181f76): kobject_uevent_env
  __vhci_create_device+0x2c1/0x580 drivers/bluetooth/hci_vhci.c:139
kobject: 'hci5' (0000000072db0368): kobject_uevent_env
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2de/0x470 drivers/bluetooth/hci_vhci.c:299
kobject: 'hci1' (000000005f181f76): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci1'
  call_write_iter include/linux/fs.h:1857 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
kobject: 'hci2' (000000008e0439e5): kobject_add_internal:  
parent: 'bluetooth', set: 'devices'
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
kobject: 'hci3' (00000000de75fad9): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci3'
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kobject: 'rfkill466' (000000008955fb87): kobject_add_internal:  
parent: 'hci4', set: 'devices'
kobject: 'hci5' (0000000072db0368): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci5'
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440e49
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
kobject: 'rfkill466' (000000008955fb87): kobject_uevent_env
RSP: 002b:00007ffd93629a18 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440e49
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000ddb880 R11: 0000000000000213 R12: 000000000000ee45
kobject: 'hci2' (000000008e0439e5): kobject_uevent_env
R13: 0000000000401d70 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

