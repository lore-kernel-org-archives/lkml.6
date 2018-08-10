Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCAEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB10122407
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB10122407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeHJQJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:09:01 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43291 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeHJQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:09:01 -0400
Received: by mail-it0-f72.google.com with SMTP id d9-v6so1965901itf.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nKPEHvRcEZK8IPOpe0g7njZl7Uk2xrW0sFzHqh66AN4=;
        b=Jks4A6eVXRbCaQ8uJnIJTy7ZxZP80EwCI7aCghDRhpUoISuEcOqmQZZhzk/Vcxdb+U
         hmL58VA+1WgB7OZ0yX2MUQM9QP8RisSCGCB2BvTOaeOtv9fextvcujtMSmUxvRQk93/k
         xurPq6kNK9lDmZGTz/ry4i0jx00zqYVv5lpoYQk24umrjT6oOIjyVnblC2p+jwoSHbZc
         Mz0bpZj4N4gSSgs4Y9P8X86BPsu2dSkj8VcKdWcI9urb1ZzN4tbvfc/6bliLAb/BqHrR
         6O4quQoB7FOJZKlkBpcp8G3RBKrPTeHjqgxRIG34jAeclQFvy+TwUlVFwojHkYAp+uIA
         4big==
X-Gm-Message-State: AOUpUlHz5A5WSdnrUblkykJH4RYMB8ilYuSCncficIYYxTy+hbZF3sYK
        mflDPJ01u6UWqbmSL9aE2Ze1DJ+a/JG3L+JADdTCbcIpOBiC
X-Google-Smtp-Source: AA+uWPw4D3iBVEQR/BJ9ZDKpUJYt3aaqY2y7Lh7QcYYV9dXoMgOENwmoF6Qf0O2mZy0I93T/5lrVjUK7uCLsMZ0+kX9VTbE8KHmt
MIME-Version: 1.0
X-Received: by 2002:a6b:fb18:: with SMTP id h24-v6mr2623485iog.17.1533908342957;
 Fri, 10 Aug 2018 06:39:02 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:39:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e67a05057314ddf6@google.com>
Subject: general protection fault in __schedule (2)
From:   syzbot <syzbot+7e2ab84953e4084a638d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pasha.tatashin@oracle.com, pombredanne@nexb.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=101fe2ac400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
dashboard link: https://syzkaller.appspot.com/bug?extid=7e2ab84953e4084a638d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1628c2ac400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12847864400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7e2ab84953e4084a638d@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
urandom_read: 1 callbacks suppressed
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4345 Comm: syz-executor659 Not tainted  
4.18.0-rc8-next-20180806+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__fire_sched_out_preempt_notifiers kernel/sched/core.c:2497  
[inline]
RIP: 0010:fire_sched_out_preempt_notifiers kernel/sched/core.c:2505 [inline]
RIP: 0010:prepare_task_switch kernel/sched/core.c:2611 [inline]
RIP: 0010:context_switch kernel/sched/core.c:2788 [inline]
RIP: 0010:__schedule+0x1061/0x1ec0 kernel/sched/core.c:3471
Code: 4c 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 ea 08 00 00 4d 8b 6d 00 4d  
85 ed 0f 84 6b f6 ff ff 49 8d 7d 10 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00  
74 a6 e8 93 26 04 fb eb 9f 4c 89 e6 48 89 df e8 46
RSP: 0018:ffff8801ac05ea80 EFLAGS: 00010806
RAX: 1bd5a00000000022 RBX: ffff8801af7f83c0 RCX: 1ffff1003731888f
RDX: 0000000040000000 RSI: 0000000000000000 RDI: dead000000000110
RBP: ffff8801ac05ec50 R08: ffff8801af7f83c0 R09: fffff520003c4a47
R10: fffff520003c4a47 R11: ffffc90001e2523b R12: ffff8801d9ee8280
R13: dead000000000100 R14: dffffc0000000000 R15: ffff8801db12ca40
FS:  00000000023af880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c7cdd3000 CR3: 0000000007e6a000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  preempt_schedule_common+0x22/0x60 kernel/sched/core.c:3595
  _cond_resched+0x1d/0x30 kernel/sched/core.c:4961
  __mutex_lock_common kernel/locking/mutex.c:908 [inline]
  __mutex_lock+0x13d/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  arch_jump_label_transform+0x1b/0x40 arch/x86/kernel/jump_label.c:112
  __jump_label_update+0x16e/0x1a0 kernel/jump_label.c:375
  jump_label_update+0x151/0x2e0 kernel/jump_label.c:760
  __static_key_slow_dec_cpuslocked+0xb8/0x210 kernel/jump_label.c:205
  __static_key_slow_dec kernel/jump_label.c:215 [inline]
  static_key_slow_dec+0x63/0xa0 kernel/jump_label.c:229
  kvm_arch_vcpu_uninit+0x18e/0x1d0 arch/x86/kvm/x86.c:8768
  kvm_vcpu_uninit+0x44/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:337
  vmx_free_vcpu+0x23a/0x300 arch/x86/kvm/vmx.c:10649
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8384 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8833 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8930
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:784
  __fput+0x376/0x8a0 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b25/0x2760 kernel/exit.c:869
  do_group_exit+0x177/0x440 kernel/exit.c:972
  __do_sys_exit_group kernel/exit.c:983 [inline]
  __se_sys_exit_group kernel/exit.c:981 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:981
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ed58
Code: Bad RIP value.
RSP: 002b:00007ffcc3a21518 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ed58
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be608 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 23164517240acd85 ]---
RIP: 0010:__fire_sched_out_preempt_notifiers kernel/sched/core.c:2497  
[inline]
RIP: 0010:fire_sched_out_preempt_notifiers kernel/sched/core.c:2505 [inline]
RIP: 0010:prepare_task_switch kernel/sched/core.c:2611 [inline]
RIP: 0010:context_switch kernel/sched/core.c:2788 [inline]
RIP: 0010:__schedule+0x1061/0x1ec0 kernel/sched/core.c:3471
Code: 4c 89 e8 48 c1 e8 03 42 80 3c 30 00 0f 85 ea 08 00 00 4d 8b 6d 00 4d  
85 ed 0f 84 6b f6 ff ff 49 8d 7d 10 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00  
74 a6 e8 93 26 04 fb eb 9f 4c 89 e6 48 89 df e8 46
RSP: 0018:ffff8801ac05ea80 EFLAGS: 00010806
RAX: 1bd5a00000000022 RBX: ffff8801af7f83c0 RCX: 1ffff1003731888f
RDX: 0000000040000000 RSI: 0000000000000000 RDI: dead000000000110
RBP: ffff8801ac05ec50 R08: ffff8801af7f83c0 R09: fffff520003c4a47
R10: fffff520003c4a47 R11: ffffc90001e2523b R12: ffff8801d9ee8280
R13: dead000000000100 R14: dffffc0000000000 R15: ffff8801db12ca40
FS:  00000000023af880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043ed2e CR3: 0000000007e6a000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
