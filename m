Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37412C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3733218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfABLgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:36:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:55428 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfABLgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:36:05 -0500
Received: by mail-it1-f199.google.com with SMTP id j3so32886649itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MXmDgYnD5vhY7VnxcK+lvh/RF8zEPtKYkgL8Hy7d2SY=;
        b=KIl3gTVxftvV6uIUz39HpAaVc6mASnUiIvSFh6vrDLmC3nn/7UwcjE7JgQqe/us/Xb
         uMseG0YhM4apvph+b1/16NIyKc8zCHUbyUNuDbzoxmjIq0FZ0bH3/7Xz7/0BiJ7To1gJ
         vgmtkhvIBybpIBfC6XA3LcoS9ezO48bPVj9RoZ3o3TbqYBj8y+LlAtyEwaBidoxPnUuW
         fWuY9TRzLToyR+9zw60ec6+EbTID0APNfyTMCDAzzaqjziRFK2+kLnaTOUpaGvCGtpax
         MNbEQUjoGnaa9DuBULQLQpvc+gC4kPMKEBFPg4CG7OcUVaUeDB625jnGwI/0kfwwkulS
         m2Kw==
X-Gm-Message-State: AA+aEWb3JjbdDllSMRh+OSypSuzP0AG+BNDBTLTE5yIojOhkfSGQJbi1
        0tdtkInRU9IcwurYYZHJmZFW4/BTJ7Kvmyk13pmNzCiASIXS
X-Google-Smtp-Source: AFSGD/XKqc/lFvwDRWTIKTOnm6GUn9cxDWUTyt+Y6TIZlBN8tStNCftIo4LEcAcMqVWUp1Zxc3QyUZOw+VT3NqFchXnG+MgHKBgo
MIME-Version: 1.0
X-Received: by 2002:a24:e4cf:: with SMTP id o198mr31968201ith.20.1546428963826;
 Wed, 02 Jan 2019 03:36:03 -0800 (PST)
Date:   Wed, 02 Jan 2019 03:36:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f35c6057e780d36@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in setup_kmem_cache_node
From:   syzbot <syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    903b77c63167 Merge tag 'linux-kselftest-4.21-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133428e3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53a2f2aa0b1f7606
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ed4ec679652b4fd4e4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com

BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
#PF error: [WRITE]
PGD 8b2a5067 P4D 8b2a5067 PUD a53ed067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16188 Comm: syz-executor4 Not tainted 4.20.0+ #174
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:init_arraycache mm/slab.c:562 [inline]
RIP: 0010:__alloc_alien_cache mm/slab.c:669 [inline]
RIP: 0010:alloc_alien_cache mm/slab.c:689 [inline]
RIP: 0010:setup_kmem_cache_node+0x1ed/0x400 mm/slab.c:910
Code: 63 48 63 c3 48 0f a3 05 59 9c 72 08 73 56 8b 75 b8 4d 8d 2c c6 44 89  
e2 48 8b 7d a8 e8 fc e9 ff ff 48 83 f8 c8 49 89 c7 74 17 <c7> 40 38 00 00  
00 00 8b 45 b0 41 89 47 3c b8 0d f0 ad ba 49 89 47
RSP: 0018:ffff88804e827318 EFLAGS: 00010213
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000006000c0
RDX: 00000000000000a8 RSI: 0000000000000000 RDI: ffff88812c3f0040
RBP: ffff88804e827378 R08: ffff888054cc86c0 R09: ffffed1015ce5b8f
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 0000000000000000
R13: ffff888095642648 R14: ffff888095642640 R15: 0000000000000000
FS:  00007f6fef838700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 000000005034d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  setup_kmem_cache_nodes mm/slab.c:3819 [inline]
  __do_tune_cpucache+0x165/0x220 mm/slab.c:3889
  do_tune_cpucache+0x25/0xd0 mm/slab.c:3898
  enable_cpucache+0x3e/0xd0 mm/slab.c:3979
  setup_cpu_cache+0xd4/0x1e0 mm/slab.c:1821
  __kmem_cache_create+0x191/0x230 mm/slab.c:2134
  create_cache+0xcd/0x1f0 mm/slab_common.c:391
  kmem_cache_create_usercopy+0x18a/0x240 mm/slab_common.c:487
  p9_client_create+0x986/0x1674 net/9p/client.c:1054
  v9fs_session_init+0x217/0x1bb0 fs/9p/v9fs.c:421
  v9fs_mount+0x7c/0x8f0 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x31d fs/super.c:1261
kobject: 'loop1' (000000003afcedd0): kobject_uevent_env
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
kobject: 'loop1' (000000003afcedd0): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2469 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2801
kobject: 'loop2' (00000000108c69f3): kobject_uevent_env
kobject: 'loop2' (00000000108c69f3): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  ksys_mount+0x12d/0x140 fs/namespace.c:3017
  __do_sys_mount fs/namespace.c:3031 [inline]
  __se_sys_mount fs/namespace.c:3028 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3028
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4579b9
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6fef837c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6fef837c90 RCX: 00000000004579b9
RDX: 0000000020000000 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 000000000073bf00 R08: 0000000020000240 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6fef8386d4
R13: 00000000004c369b R14: 00000000004d61f8 R15: 0000000000000005
Modules linked in:
CR2: 0000000000000038
---[ end trace c630b12329ae5f74 ]---
RIP: 0010:init_arraycache mm/slab.c:562 [inline]
RIP: 0010:__alloc_alien_cache mm/slab.c:669 [inline]
RIP: 0010:alloc_alien_cache mm/slab.c:689 [inline]
RIP: 0010:setup_kmem_cache_node+0x1ed/0x400 mm/slab.c:910
kobject: 'loop3' (00000000e06f18ba): kobject_uevent_env
Code: 63 48 63 c3 48 0f a3 05 59 9c 72 08 73 56 8b 75 b8 4d 8d 2c c6 44 89  
e2 48 8b 7d a8 e8 fc e9 ff ff 48 83 f8 c8 49 89 c7 74 17 <c7> 40 38 00 00  
00 00 8b 45 b0 41 89 47 3c b8 0d f0 ad ba 49 89 47
kobject: 'loop3' (00000000e06f18ba): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RSP: 0018:ffff88804e827318 EFLAGS: 00010213
kobject: 'loop5' (00000000bc6ae381): kobject_uevent_env
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000006000c0
kobject: 'loop5' (00000000bc6ae381): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RDX: 00000000000000a8 RSI: 0000000000000000 RDI: ffff88812c3f0040
kobject: 'loop3' (00000000e06f18ba): kobject_uevent_env
kobject: 'loop3' (00000000e06f18ba): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RBP: ffff88804e827378 R08: ffff888054cc86c0 R09: ffffed1015ce5b8f
kobject: 'loop1' (000000003afcedd0): kobject_uevent_env
R10: ffffed1015ce5b8f R11: ffff8880ae72dc7b R12: 0000000000000000
kobject: 'loop1' (000000003afcedd0): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
R13: ffff888095642648 R14: ffff888095642640 R15: 0000000000000000
FS:  00007f6fef838700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 000000005034d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
