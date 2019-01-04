Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E74C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF55C21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfADJ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:27:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:52203 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfADJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:27:03 -0500
Received: by mail-it1-f200.google.com with SMTP id b14so534948itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=x/pjvUGS+Z1h8jZWINExGUPei1FYW0Ls1tAPGI3H9es=;
        b=SD1eYRWAQ9j/zVzCNi+/Q9dvnZO9CBFLsxl9I8FZarG+lpjbpBhn0AfaZVM2Hgvy5r
         m8s2ANNFcvZ02lxY1GyXN9S/3JbMX6J6icKjkHEIfHb1lmRi0MtKJN8IRtEZ7332eBPB
         k9a0Zq/liE54MN9Exa6I9XAEDdH4p22fPSr2+nRtTL2D9v23x94hXrgttyUgUbEJFGoI
         liRJcTli4bANdUPXknoMDzJz97+mQh1CY2ZJ+1Eq8b859LjJ3B6RHbzEmh8YsJwPS2RG
         2syN+NlpqDXo0pojHDJliJUrAA2aaUjL4RvdZ16UoeAz7Kxs1NhgcFNprx+L+0FBKtKF
         YESA==
X-Gm-Message-State: AJcUukdGdEZnd/gW7xYmNe2iAu2aA46xSCsw1CDdScTUDEUUrcf2YfY1
        U+8a6f8akeLkcU5X6nESe/yU27NCs05J7xfQqq0+cC5FuM4l
X-Google-Smtp-Source: ALg8bN5BE58ryNHUaIdMWphqbx076XMjfyIl5pWqmWiESo4haaWyyX4CFzuFYxbApcIY1IGHcjAahSesOsBV4zn28qfhHA5yITbw
MIME-Version: 1.0
X-Received: by 2002:a6b:e519:: with SMTP id y25mr27940927ioc.36.1546594022271;
 Fri, 04 Jan 2019 01:27:02 -0800 (PST)
Date:   Fri, 04 Jan 2019 01:27:02 -0800
In-Reply-To: <0000000000003692760578e651dd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f34dd057e9e7b2a@google.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
From:   syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1303e2bb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_dec  
include/asm-generic/atomic-instrumented.h:127 [inline]
BUG: KASAN: use-after-free in hci_sock_release+0x154/0x3c0  
net/bluetooth/hci_sock.c:873
Write of size 4 at addr ffff888098651620 by task syz-executor472/8899

CPU: 1 PID: 8899 Comm: syz-executor472 Not tainted 4.20.0+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_write+0x14/0x20 mm/kasan/common.c:106
  atomic_dec include/asm-generic/atomic-instrumented.h:127 [inline]
  hci_sock_release+0x154/0x3c0 net/bluetooth/hci_sock.c:873
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1141
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446419
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff91cfd4da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00000000006dbc28 RCX: 0000000000446419
RDX: 0000000000446419 RSI: 0000000000446419 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 6368762f7665642f R14: 00007ff91cfd59c0 R15: 00000000006dbd2c

Allocated by task 8889:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  kmem_cache_alloc_trace+0x151/0x760 mm/slab.c:3607
  kmalloc include/linux/slab.h:545 [inline]
  kzalloc include/linux/slab.h:740 [inline]
  hci_alloc_dev+0x148/0x21a0 net/bluetooth/hci_core.c:3116
  __vhci_create_device+0x101/0x5a0 drivers/bluetooth/hci_vhci.c:114
  vhci_create_device drivers/bluetooth/hci_vhci.c:163 [inline]
  vhci_get_user drivers/bluetooth/hci_vhci.c:219 [inline]
  vhci_write+0x2d0/0x470 drivers/bluetooth/hci_vhci.c:299
  call_write_iter include/linux/fs.h:1862 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x764/0xb40 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8888:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
kobject: 'rfkill320' (00000000e0cb8fff): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci4/rfkill320'
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  bt_host_release+0x19/0x30 net/bluetooth/hci_sysfs.c:86
  device_release+0x7d/0x210 drivers/base/core.c:919
  kobject_cleanup lib/kobject.c:662 [inline]
  kobject_release lib/kobject.c:691 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
  put_device+0x20/0x30 drivers/base/core.c:2060
  hci_free_dev+0x19/0x20 net/bluetooth/hci_core.c:3208
  vhci_release+0x7e/0xf0 drivers/bluetooth/hci_vhci.c:355
kobject: 'rfkill313' (00000000d3ffb8c5): kobject_uevent_env
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
kobject: 'rfkill313' (00000000d3ffb8c5): fill_kobj_path: path  
= '/devices/virtual/bluetooth/hci2/rfkill313'
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880986505c0
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4192 bytes inside of
  8192-byte region [ffff8880986505c0, ffff8880986525c0)
The buggy address belongs to the page:
kobject: 'rfkill313' (00000000d3ffb8c5): kobject_cleanup, parent            
(null)
page:ffffea0002619400 count:1 mapcount:0 mapping:ffff88812c3f2080 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0002616508 ffffea0002302f08 ffff88812c3f2080
raw: 0000000000000000 ffff8880986505c0 0000000100000001 0000000000000000
kobject: 'rfkill313' (00000000d3ffb8c5): calling ktype release
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098651500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888098651580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
kobject: 'rfkill313': free name
> ffff888098651600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff888098651680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888098651700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

