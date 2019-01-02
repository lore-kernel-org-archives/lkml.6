Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A80C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DC92075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfABLLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:11:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:57693 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfABLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:11:05 -0500
Received: by mail-it1-f200.google.com with SMTP id n124so32847869itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pFgmXT7/BoUybKP3SowCGa+963Zl8XxUdwVWvSqPdTI=;
        b=pRaAqW5IW3HZ9/0kXDz20XFa+ooeiI05XcO3RqX94M/E+Bsqh1VTZPpFxf6AgVMSwC
         LJkSA+7eTB8KCa8GZnW20CfxXR0N62uXwSX1eFnM0p2v2kDpqwlCriWvlCHILpqc4JIr
         s90CCQyTXiOGp4Pa3U5Bt3lm1t51jWldF4YNQLfGFvwUgG6bOs9hdgxAEVjbxpAbWOvd
         O+cvbp3ikE+2HbCs33oqc0CE8ydJEluGH4icojxx4gIcqufqGyMKZQiprk3pJ9KthlGN
         xNJTurV0UXEJ9q+v8PXY0KaSEeakS/m8MAia4VOM0Oh+3bTMdOo8a7HGMRoTeQd3OZGN
         kIKA==
X-Gm-Message-State: AJcUukc3VPh32lFn/M8FjKrylsxvlo8365jh6eq3fS4AqrUofXQaDHzR
        44we/PScKq2/GMe3Rx1Xu1izp3gTdZDnkmxMswMTCMhq4UqJ
X-Google-Smtp-Source: ALg8bN6ictnE+TXVrO55EGgaZ0iT2pZA4nGTntUuaNg3XofxmOs7KrTN4mVklSOZPlqxWBsFSyX5xS4rSqx5V3dFjs7DhvSxnT6a
MIME-Version: 1.0
X-Received: by 2002:a6b:e519:: with SMTP id y25mr21484320ioc.36.1546427464387;
 Wed, 02 Jan 2019 03:11:04 -0800 (PST)
Date:   Wed, 02 Jan 2019 03:11:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af9873057e77b3fb@google.com>
Subject: KASAN: slab-out-of-bounds Read in kvm_clear_dirty_log_protect
From:   syzbot <syzbot+028366e52c9ace67deb3@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f12e840c819b Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b03ee7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76d28549be7c27cf
dashboard link: https://syzkaller.appspot.com/bug?extid=028366e52c9ace67deb3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104dc120c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1656b6e7400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+028366e52c9ace67deb3@syzkaller.appspotmail.com

audit: type=1800 audit(1546340268.292:30): pid=7481 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
IPVS: ftp: loaded support on port[0] = 21
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
==================================================================
BUG: KASAN: slab-out-of-bounds in kvm_clear_dirty_log_protect+0x8cf/0x970  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1262
Read of size 8 at addr ffff88809e631290 by task syz-executor007/7635

CPU: 0 PID: 7635 Comm: syz-executor007 Not tainted 4.20.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  kvm_clear_dirty_log_protect+0x8cf/0x970  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1262
  kvm_vm_ioctl_clear_dirty_log+0xff/0x260 arch/x86/kvm/x86.c:4468
  kvm_vm_ioctl+0xc19/0x1fe0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3127
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440b09
Code: 23 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00000000007dff68 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004a28d8 RCX: 0000000000440b09
RDX: 0000000020000080 RSI: 00000000c018aec0 RDI: 0000000000000004
RBP: 00000000004a28d8 R08: 0000000120080522 R09: 0000000120080522
R10: 0000000120080522 R11: 0000000000000217 R12: 00000000004022a0
R13: 0000000000402330 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 7635:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc mm/kasan/common.c:482 [inline]
  kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
  __do_kmalloc_node mm/slab.c:3671 [inline]
  __kmalloc_node+0x4e/0x70 mm/slab.c:3678
  kmalloc_node include/linux/slab.h:588 [inline]
  kvmalloc_node+0x68/0x100 mm/util.c:416
  kvmalloc include/linux/mm.h:602 [inline]
  kvzalloc include/linux/mm.h:610 [inline]
  kvm_create_dirty_bitmap arch/x86/kvm/../../../virt/kvm/kvm_main.c:792  
[inline]
  __kvm_set_memory_region+0x1da1/0x2c40  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1018
  kvm_set_memory_region+0x2f/0x60  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1084
  kvm_vm_ioctl_set_memory_region  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1096 [inline]
  kvm_vm_ioctl+0xafa/0x1fe0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3108
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4427:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kfree+0xcf/0x230 mm/slab.c:3804
  single_release+0x95/0xc0 fs/seq_file.c:597
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809e631280
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 16 bytes inside of
  32-byte region [ffff88809e631280, ffff88809e6312a0)
The buggy address belongs to the page:
page:ffffea0002798c40 count:1 mapcount:0 mapping:ffff88812c3f01c0  
index:0xffff88809e631fc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002763388 ffff88812c3f1238 ffff88812c3f01c0
raw: ffff88809e631fc1 ffff88809e631000 000000010000001c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809e631180: 00 01 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809e631200: fb fb fb fb fc fc fc fc 04 fc fc fc fc fc fc fc
> ffff88809e631280: 00 00 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
                          ^
  ffff88809e631300: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809e631380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
