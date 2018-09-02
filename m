Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC9C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 14:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 14:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B0820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeIBSdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 14:33:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:60153 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBSdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 14:33:05 -0400
Received: by mail-it0-f72.google.com with SMTP id a10-v6so10065322itc.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NOzw9g6SkILGvEZVhgEwB5pQjQD25to5EFi3tArLPHk=;
        b=l/gw6khZ1fcIkJM6y2clkAx0c6c3jiJFY6JLonK+rriX8muu+79skNBL+QY1mayTAa
         8y60x1/g/IMC5XdBboChQ+YDWVC34JLMTKi4XlT5Z7Sj8RtCk4K6ijJ+Jl+5WPMwGoP5
         DFzRq5ZuEDhE91zn1ixm2z64Y8bIV/UKIHrEYWRpR7YAMoZ3eoyu9DC+FB8p6w+sSJCx
         ZqU9lXYupDGYmWNJE6KZ2RRebXs2SXLV+3S+YV6JYGppDl6pPciBvVQ7QUGNKcGxWsIv
         u/hIwpD7t1PATO6PTXWWsfjgBh4gb0nvpeChTLJK47u38PYJoGLxi7+TcG/BSokx6J0I
         QMWA==
X-Gm-Message-State: APzg51AbDWPdtnGVyzLgNWNV2xeI3JPZWYfpMPIlpYXuOUACZT1aqHy7
        UV6Q981bAfJmEy//eAh2Eecb11+is3+s702ga1E2LsfVS1mG
X-Google-Smtp-Source: ANB0Vdbw+WTJJ8046vdwVfKWuR+0TITuNUWt/o9oFg5x9SzLFe1X/bHchgLZTQXwWNotVJHMKf0ZDYo/YjXZ3TCn8LcmdLg7BE2M
MIME-Version: 1.0
X-Received: by 2002:a24:468f:: with SMTP id j137-v6mr2292865itb.22.1535897823551;
 Sun, 02 Sep 2018 07:17:03 -0700 (PDT)
Date:   Sun, 02 Sep 2018 07:17:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f300e0574e414a5@google.com>
Subject: KASAN: use-after-free Write in preempt_notifier_unregister
From:   syzbot <syzbot+bf450fa2acc8014a9c45@syzkaller.appspotmail.com>
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

HEAD commit:    87b93b43da14 Add linux-next specific files for 20180829
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=103a6801400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29f635fa875f8ab1
dashboard link: https://syzkaller.appspot.com/bug?extid=bf450fa2acc8014a9c45
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bf450fa2acc8014a9c45@syzkaller.appspotmail.com

IDTVectoring: info=00000000 errcode=00000000
TSC Offset = 0xffffff26d29935f5
TPR Threshold = 0x00
EPT pointer = 0x00000001d8de201e
==================================================================
BUG: KASAN: use-after-free in __hlist_del include/linux/list.h:681 [inline]
BUG: KASAN: use-after-free in hlist_del include/linux/list.h:686 [inline]
BUG: KASAN: use-after-free in preempt_notifier_unregister+0x235/0x250  
kernel/sched/core.c:2472
Write of size 8 at addr ffff880190e58990 by task syz-executor2/21149

CPU: 1 PID: 21149 Comm: syz-executor2 Not tainted 4.19.0-rc1-next-20180829+  
#50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/report.c:438
  __hlist_del include/linux/list.h:681 [inline]
  hlist_del include/linux/list.h:686 [inline]
  preempt_notifier_unregister+0x235/0x250 kernel/sched/core.c:2472
  vcpu_put+0x25/0x30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:173
  kvm_arch_vcpu_ioctl_run+0xafc/0x16d0 arch/x86/kvm/x86.c:7879
  kvm_vcpu_ioctl+0x7b8/0x1280 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9a3cdc2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9a3cdc36d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000009
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ceea8 R14: 00000000004c5529 R15: 0000000000000001

Allocated by task 21133:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x710 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  vmx_create_vcpu+0xcf/0x2830 arch/x86/kvm/vmx.c:10954
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8434
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 21129:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x280 mm/slab.c:3756
  vmx_free_vcpu+0x26b/0x300 arch/x86/kvm/vmx.c:10948
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8420 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8870 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8967
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880190e58980
  which belongs to the cache kvm_vcpu of size 23872
The buggy address is located 16 bytes inside of
  23872-byte region [ffff880190e58980, ffff880190e5e6c0)
The buggy address belongs to the page:
page:ffffea0006439600 count:1 mapcount:0 mapping:ffff8801d4cb5c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0006376208 ffffea00074ac608 ffff8801d4cb5c40
raw: 0000000000000000 ffff880190e58980 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff880190e58880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff880190e58900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff880190e58980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff880190e58a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff880190e58a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
