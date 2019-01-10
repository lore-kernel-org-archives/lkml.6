Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7CC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEBE20660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfAJOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:52:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51373 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfAJOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:52:05 -0500
Received: by mail-io1-f71.google.com with SMTP id q207so9890108iod.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ThGa1YnbFKLREVQQL92cKWtLckGD3kd39z6lywgvhHQ=;
        b=MTJ5+0ZVwj7OUxRcOHWyAlsdp9PlPOv4FEjQgUzpuQPFGuTldUUS2nn2/VYLgsHxu+
         cQ9GjqC0U2BHQoVIYpLlhQSJ9+83cBVdiB5EtnhRml5INDtyvN+RzyMIsR+X5oYvwEr/
         3Hn2/c+ggN5Hc93ix3sVTC5tb93oqykyB9TaY/cUOepMBfmPspYpVsdXQSWCMz7lpchV
         VZcAWDcrv/ugnppCDyYzJmpPplXpHuGTIYp0q3yUY/ujpmbl80VABO8ipvB4+C+aTsMI
         5Y4scG6uJv/B59om5XlmSrSzG23E00KBtCwIYrcPRK7/A4Y1MQ0XjetCmZ+EaIi3v3cP
         AkWA==
X-Gm-Message-State: AJcUuke96Pi9A7/hpuciX88c1/VD5XxtUJv7KD1eG6BShWZ2BJ2jdY5/
        Teb+UFEtlOlif3HLciFohIIJMEcBgwDUKDZKsujk1ZPF1b7f
X-Google-Smtp-Source: ALg8bN44nW6gFxZz9xxBoYxuidd0IP0k3YSW51crd5jB5S/NSEjVUXLicHD8UHfpn2js1X+y6R2UTsz1EoP+hAbU2/jwLbUsV2xA
MIME-Version: 1.0
X-Received: by 2002:a24:a945:: with SMTP id x5mr4545825iti.26.1547131923817;
 Thu, 10 Jan 2019 06:52:03 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:52:03 -0800
In-Reply-To: <20190110143953.GB23837@veci.piliscsaba.redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd862a057f1bb8df@google.com>
Subject: Re: general protection fault in fuse_dev_do_write
From:   syzbot <syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
general protection fault in fuse_dev_do_write

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7047 Comm: syz-executor3 Not tainted 5.0.0-rc1+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1769 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1831 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1864 [inline]
RIP: 0010:fuse_dev_do_write+0x2040/0x3690 fs/fuse/dev.c:1944
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 9b 15 00 00 49 8b 9e 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5d
kobject: 'loop4' (00000000b4b3d7a3): kobject_uevent_env
RSP: 0018:ffff8881ba16f6d0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff828bbe06
RDX: 0000000000000000 RSI: ffffffff828bbe18 RDI: 0000000000000004
kobject: '0:45' (0000000085bf2112): kobject_add_internal: parent: 'bdi',  
set: 'devices'
RBP: ffff8881ba16faa8 R08: ffff8881cc1b8040 R09: ffffed1037b3837f
R10: ffffed1037b3837e R11: ffff8881bd9c1bf3 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8881bd9c1bd0 R15: 0000000000000030
FS:  00007f3f82f69700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
kobject: 'loop4' (00000000b4b3d7a3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: '0:45' (0000000085bf2112): kobject_uevent_env
CR2: 00000000004dac7b CR3: 00000001c8a55000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: '0:45' (0000000085bf2112): fill_kobj_path: path  
= '/devices/virtual/bdi/0:45'
Call Trace:
kobject: '0:46' (00000000ccc2aed9): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:46' (00000000ccc2aed9): kobject_uevent_env
kobject: '0:46' (00000000ccc2aed9): fill_kobj_path: path  
= '/devices/virtual/bdi/0:46'
kobject: 'loop5' (0000000005a3b0d2): kobject_uevent_env
kobject: 'loop5' (0000000005a3b0d2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: '0:47' (000000005bbd81cf): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:47' (000000005bbd81cf): kobject_uevent_env
kobject: '0:47' (000000005bbd81cf): fill_kobj_path: path  
= '/devices/virtual/bdi/0:47'
  fuse_dev_write+0x191/0x240 fs/fuse/dev.c:2025
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
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
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3f82f68c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000030 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3f82f696d4
R13: 00000000004c50c5 R14: 00000000004d8718 R15: 00000000ffffffff
Modules linked in:
general protection fault: 0000 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 7077 Comm: syz-executor5 Tainted: G      D           5.0.0-rc1+  
#1
---[ end trace 66e9b609cb2a2e29 ]---
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1769 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1831 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1864 [inline]
RIP: 0010:fuse_dev_do_write+0x2040/0x3690 fs/fuse/dev.c:1944
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 9b 15 00 00 49 8b 9e 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5d
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1769 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1831 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1864 [inline]
RIP: 0010:fuse_dev_do_write+0x2040/0x3690 fs/fuse/dev.c:1944
RSP: 0018:ffff8881b85876d0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff828bbe06
RDX: 0000000000000000 RSI: ffffffff828bbe18 RDI: 0000000000000004
RBP: ffff8881b8587aa8 R08: ffff8881cb40c040 R09: ffffed103a778501
R10: ffffed103a778500 R11: ffff8881d3bc2803 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8881d3bc27e0 R15: 0000000000000030
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 9b 15 00 00 49 8b 9e 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5d
FS:  00007f5ec4d1b700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f79aba6e000 CR3: 00000001ba466000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
RSP: 0018:ffff8881ba16f6d0 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff828bbe06
RDX: 0000000000000000 RSI: ffffffff828bbe18 RDI: 0000000000000004
  fuse_dev_write+0x191/0x240 fs/fuse/dev.c:2025
  call_write_iter include/linux/fs.h:1862 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x764/0xb40 fs/read_write.c:487
RBP: ffff8881ba16faa8 R08: ffff8881cc1b8040 R09: ffffed1037b3837f
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
R10: ffffed1037b3837e R11: ffff8881bd9c1bf3 R12: 0000000000000000
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5ec4d1ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 0000000000000030 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ec4d1b6d4
R13: 00000000004c50c5 R14: 00000000004d8718 R15: 00000000ffffffff
Modules linked in:
R13: 0000000000000000 R14: ffff8881bd9c1bd0 R15: 0000000000000030
---[ end trace 66e9b609cb2a2e2a ]---
FS:  00007f3f82f69700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
kobject: '0:46' (00000000ccc2aed9): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop2' (00000000da33663a): kobject_uevent_env
CR2: 00007f31375f41b0 CR3: 00000001c8a55000 CR4: 00000000001406f0
kobject: '0:46' (00000000ccc2aed9): fill_kobj_path: path  
= '/devices/virtual/bdi/0:46'
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'loop2' (00000000da33663a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1769 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1831 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1864 [inline]
RIP: 0010:fuse_dev_do_write+0x2040/0x3690 fs/fuse/dev.c:1944
kobject: '0:48' (00000000202d68fd): kobject_add_internal: parent: 'bdi',  
set: 'devices'
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 9b 15 00 00 49 8b 9e 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5d
kobject: '0:48' (00000000202d68fd): kobject_uevent_env
RSP: 0018:ffff8881ba16f6d0 EFLAGS: 00010247
kobject: '0:46' (00000000ccc2aed9): kobject_cleanup, parent           (null)
kobject: '0:49' (000000005ce0ce9e): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:48' (00000000202d68fd): fill_kobj_path: path  
= '/devices/virtual/bdi/0:48'
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: '0:46' (00000000ccc2aed9): calling ktype release
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff828bbe06
kobject: '0:46': free name
RDX: 0000000000000000 RSI: ffffffff828bbe18 RDI: 0000000000000004
kobject: 'loop1' (000000001048627e): kobject_uevent_env
kobject: '0:49' (000000005ce0ce9e): kobject_uevent_env
kobject: 'loop1' (000000001048627e): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kasan: CONFIG_KASAN_INLINE enabled
RBP: ffff8881ba16faa8 R08: ffff8881cc1b8040 R09: ffffed1037b3837f
kasan: GPF could be caused by NULL-ptr deref or user memory access


Tested on:

commit:         9c6432f41365 fuse: use atomic64_t for khctr
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125205e8c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a1071b8d4184257
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

