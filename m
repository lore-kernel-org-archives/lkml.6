Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40882217FE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40882217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeHJRMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:12:15 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:37399 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbeHJRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:12:15 -0400
Received: by mail-it0-f72.google.com with SMTP id n144-v6so2142493itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jNDMrtUEg9pX5Sv6awPuv7+By36IuqdtL8QAO2ybvOo=;
        b=ohbH/7nnaafigdp4iMH4XO64NeUF761bapNpKNnkP2n0durfJd3j1lvUIylf3r8fas
         bAC/biymZgs//fOhpTH73kDPkbgnwP/zc/cM9ypqkJfpQ9QCFgbKwtno2zmRYMMqm/MC
         lDmSkc5uIdpIr6h0M4odPnGtlBwbUzNYFLOfxK+CVoQx34DYQglU5859ucwBTTmpeELU
         hGXyZLNeCMnmca9OC2ofipCuH5RdBqInqowf7HWdmRcaX48g6cEyYy07X3ssW1dojxB3
         RUlNlLm9tmHYZ9UFH9sesLvvzbwjnOjggrvrQU1kd5WtdVAW10RnF9wDYF+zaa8KODsG
         Zd0Q==
X-Gm-Message-State: AOUpUlHXvr7X+QS934loB/xFWQD3bp+OTLrh+RyXvhNZD3ZSG+B+HV98
        uxReeyy7prLIDBOzBQoWXO8GLdqdUN+ramFf3naksx3KFlrQ
X-Google-Smtp-Source: AA+uWPx3cdTf9UsuVuH7Y4AWC2B2yYXMNbO49jV7qpCPdeBiFdZqpiotPbkCgy4urEBZf/MHBm94m6EarrSpg8IPqYlnApazn6Re
MIME-Version: 1.0
X-Received: by 2002:a02:95b:: with SMTP id f88-v6mr3164662jad.28.1533912123029;
 Fri, 10 Aug 2018 07:42:03 -0700 (PDT)
Date:   Fri, 10 Aug 2018 07:42:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035c2ed057315bf85@google.com>
Subject: general protection fault in finish_task_switch (2)
From:   syzbot <syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com>
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

HEAD commit:    8c8399e0a3fb Add linux-next specific files for 20180806
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c6b8e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
dashboard link: https://syzkaller.appspot.com/bug?extid=1f56df64bfb3c29dde6f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
  vmwrite_error+0x4c/0x60 arch/x86/kvm/vmx.c:2201
CPU: 0 PID: 9256 Comm: syz-executor2 Not tainted 4.18.0-rc8-next-20180806+  
#32
  __vmcs_writel arch/x86/kvm/vmx.c:2211 [inline]
  vmcs_writel arch/x86/kvm/vmx.c:2251 [inline]
  vmx_vcpu_load+0xcdb/0xfe0 arch/x86/kvm/vmx.c:2917
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481  
[inline]
RIP: 0010:fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
RIP: 0010:finish_task_switch+0x538/0x870 kernel/sched/core.c:2679
Code: 89 e1 48 c1 e9 03 42 80 3c 39 00 0f 85 ab 01 00 00 4d 8b 24 24 4d 85  
e4 0f 84 e3 fc ff ff 49 8d 7c 24 10 48 89 f9 48 c1 e9 03 <42> 80 3c 39 00  
74 a5 e8 1c e8 67 00 eb 9e 80 3d 80 e4 31 07 00 0f
RSP: 0018:ffff8801977a7980 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: ffff8801db02ca40 RCX: 1bd5a00000000022
RDX: 0000000000040000 RSI: ffffffff810edd32 RDI: dead000000000110
RBP: ffff8801977a7a68 R08: ffff88019386a080 R09: fffffbfff1107d28
R10: fffffbfff1107d28 R11: 0000000000000003 R12: dead000000000100
  kvm_arch_vcpu_load+0x22b/0x940 arch/x86/kvm/x86.c:3081
R13: ffff88019549c240 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fd2dc8cf700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3975
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x50d/0x870 kernel/sched/core.c:2679
CR2: 0000001b2fb21000 CR3: 0000000190863000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  preempt_schedule_common+0x22/0x60 kernel/sched/core.c:3595
  schedule+0xfb/0x450 kernel/sched/core.c:3515
  _cond_resched+0x1d/0x30 kernel/sched/core.c:4961
  __mutex_lock_common kernel/locking/mutex.c:908 [inline]
  __mutex_lock+0x13d/0x1700 kernel/locking/mutex.c:1073
  exit_to_usermode_loop+0x22f/0x380 arch/x86/entry/common.c:152
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456cb9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd2dc8cecf8 EFLAGS: 00000246
  ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 0000000000930148 RCX: 0000000000456cb9
RDX: 0000000000000016 RSI: 0000000000000001 RDI: 000000000093014c
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000093014c
R13: 00007ffd09c12e5f R14: 00007fd2dc8cf9c0 R15: 0000000000000001
  arch_jump_label_transform+0x1b/0x40 arch/x86/kernel/jump_label.c:112
Modules linked in:
  __jump_label_update+0x16e/0x1a0 kernel/jump_label.c:375
  jump_label_update+0x151/0x2e0 kernel/jump_label.c:760
Dumping ftrace buffer:
  static_key_slow_inc_cpuslocked+0x341/0x430 kernel/jump_label.c:110
    (ftrace buffer empty)
---[ end trace de1ac742ecfe90a2 ]---
RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481  
[inline]
RIP: 0010:fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
RIP: 0010:finish_task_switch+0x538/0x870 kernel/sched/core.c:2679
Code: 89 e1 48 c1 e9 03 42 80 3c 39 00 0f 85 ab 01 00 00 4d 8b 24 24 4d 85  
e4 0f 84 e3 fc ff ff 49 8d 7c 24 10 48 89 f9 48 c1 e9 03 <42> 80 3c 39 00  
74 a5 e8 1c e8 67 00 eb 9e 80 3d 80 e4 31 07 00 0f
RSP: 0018:ffff8801977a7980 EFLAGS: 00010a06
  static_key_slow_inc+0x1a/0x30 kernel/jump_label.c:125
  kvm_arch_vcpu_init+0x300/0x830 arch/x86/kvm/x86.c:8710
  kvm_vcpu_init+0x2fb/0x420 arch/x86/kvm/../../../virt/kvm/kvm_main.c:317
RAX: 0000000000000000 RBX: ffff8801db02ca40 RCX: 1bd5a00000000022
  vmx_create_vcpu+0x14c/0x2980 arch/x86/kvm/vmx.c:10665
RDX: 0000000000040000 RSI: ffffffff810edd32 RDI: dead000000000110
RBP: ffff8801977a7a68 R08: ffff88019386a080 R09: fffffbfff1107d28
R10: fffffbfff1107d28 R11: 0000000000000003 R12: dead000000000100
R13: ffff88019549c240 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fd2dc8cf700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
  kvm_arch_vcpu_create+0xe5/0x220 arch/x86/kvm/x86.c:8398
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:2476  
[inline]
  kvm_vm_ioctl+0x488/0x1d80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2977
CR2: 0000001b2fb21000 CR3: 0000000190863000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
