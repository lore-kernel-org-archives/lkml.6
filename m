Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C666214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C666214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeHVJva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:51:30 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:34190 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeHVJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:51:30 -0400
Received: by mail-it0-f71.google.com with SMTP id k204-v6so9289242ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 23:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4zIMt/K2N8Dr1F+5lKRabRUwrL9MExxKdrnDjIFjNFY=;
        b=lPLgj7b8fPt+dYASTZ8XeNuUqQ2lFIW98h7Bs1urxRxUba1uskSqFFx7kU7KToKb2a
         oTgfc2/nc8sGue2DB/Ldd2jD5mP4X4VsZbORznd8/U8wnA94Rrbd2KebcvC//9mwXa3k
         7xEsj2kYEXia+a/O2H68o4fPnrs9i75MpX5ETCjQvkWLBo3vsVkm3b6ZWQnTP6nWvJO7
         32dGegHPVc7FzJE+kUoRIthe2Ih8+vSQOYg1ez+KAbuY1XfFkLo3nzaafcKe9itNMCKQ
         MhvLzIrQkX03eh28UTugEv6xEVK5MpLVUT0GRBDJmxv/xIelz8m5WmKcQDDl1DIsG+fF
         YNsg==
X-Gm-Message-State: APzg51B4NEgbD8j6/xBpxZeo5g/kUMSHRJPwJT+osLv1NwTnF7Uylb27
        us4RuAPpaC+bJfqmP1l7OMOeocVqQ63coM3u9JNqP0QXjfrE
X-Google-Smtp-Source: ANB0VdZ6EKqSflaSLcozY1AoYSZQeDR4vKZtmjyJGt0j8gMcklKFkguryqPYb/grBurNfumlXG5cOvDRcHJgWk3iXa/iohJlCZMB
MIME-Version: 1.0
X-Received: by 2002:a24:1305:: with SMTP id 5-v6mr1063244itz.23.1534919282616;
 Tue, 21 Aug 2018 23:28:02 -0700 (PDT)
Date:   Tue, 21 Aug 2018 23:28:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009972a10574003ef3@google.com>
Subject: BUG: corrupted list in vmx_vcpu_load
From:   syzbot <syzbot+bba49d73fe3404646a7b@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0214f46b3a03 Merge branch 'siginfo-linus' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bc9c2e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=214e4990bd49329f
dashboard link: https://syzkaller.appspot.com/bug?extid=bba49d73fe3404646a7b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bba49d73fe3404646a7b@syzkaller.appspotmail.com

kvm [9433]: vcpu0, guest rIP: 0x20e disabled perfctr wrmsr: 0x187 data  
0x60000000800
list_add corruption. next->prev should be prev (ffff8801db01d130), but was  
dead000000000200. (next=ffff8801947fdaa0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:25!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 9519 Comm: syz-executor2 Not tainted 4.18.0+ #201
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid.cold.0+0xf/0x25 lib/list_debug.c:23
Code: e8 93 f5 5b fe e9 68 ff ff ff e8 89 f5 5b fe eb c9 4c 89 e7 e8 7f f5  
5b fe eb 97 48 89 d9 48 c7 c7 e0 9b 3a 87 e8 32 d8 03 fe <0f> 0b 48 89 f1  
48 c7 c7 a0 9c 3a 87 48 89 de e8 1e d8 03 fe 0f 0b
RSP: 0018:ffff88018f9bf058 EFLAGS: 00010082
RAX: 0000000000000075 RBX: ffff8801947fdaa0 RCX: ffffc9000200d000
RDX: 0000000000000000 RSI: ffffffff8163a441 RDI: 0000000000000001
RBP: ffff88018f9bf070 R08: ffff880196e3a2c0 R09: ffffed003b605008
R10: ffffed003b605008 R11: ffff8801db028047 R12: ffff8801947fdaa0
R13: ffff8801947f8300 R14: ffff8801947fdaa0 R15: ffff8801db01d130
FS:  00007ff35b75e700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb6c09b000 CR3: 00000001ca309000 CR4: 00000000001426f0
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add include/linux/list.h:79 [inline]
  vmx_vcpu_load+0x205/0xfe0 arch/x86/kvm/vmx.c:3061
  kvm_arch_vcpu_load+0x22b/0x940 arch/x86/kvm/x86.c:3106
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3970
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x50d/0x870 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2828 [inline]
  __schedule+0x884/0x1df0 kernel/sched/core.c:3473
  preempt_schedule_common+0x22/0x60 kernel/sched/core.c:3597
  _cond_resched+0x1d/0x30 kernel/sched/core.c:4963
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x292/0x710 mm/slab.c:3552
  alloc_inode+0xb2/0x190 fs/inode.c:212
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:903
  new_inode+0x1c/0x40 fs/inode.c:932
  debugfs_get_inode+0x19/0x120 fs/debugfs/inode.c:37
  __debugfs_create_file+0xb5/0x400 fs/debugfs/inode.c:352
  debugfs_create_file+0x57/0x70 fs/debugfs/inode.c:399
  kvm_create_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:615  
[inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3209  
[inline]
  kvm_dev_ioctl+0xbf5/0x1b10 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3236
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff35b75dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff35b75e6d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce9b8 R14: 00000000004c50d7 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace a4f093c8080a0418 ]---
RIP: 0010:__list_add_valid.cold.0+0xf/0x25 lib/list_debug.c:23
Code: e8 93 f5 5b fe e9 68 ff ff ff e8 89 f5 5b fe eb c9 4c 89 e7 e8 7f f5  
5b fe eb 97 48 89 d9 48 c7 c7 e0 9b 3a 87 e8 32 d8 03 fe <0f> 0b 48 89 f1  
48 c7 c7 a0 9c 3a 87 48 89 de e8 1e d8 03 fe 0f 0b
RSP: 0018:ffff88018f9bf058 EFLAGS: 00010082
RAX: 0000000000000075 RBX: ffff8801947fdaa0 RCX: ffffc9000200d000
RDX: 0000000000000000 RSI: ffffffff8163a441 RDI: 0000000000000001
RBP: ffff88018f9bf070 R08: ffff880196e3a2c0 R09: ffffed003b605008
R10: ffffed003b605008 R11: ffff8801db028047 R12: ffff8801947fdaa0
R13: ffff8801947f8300 R14: ffff8801947fdaa0 R15: ffff8801db01d130
FS:  00007ff35b75e700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb6c09b000 CR3: 00000001ca309000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
