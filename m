Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC13ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DAA20870
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DAA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbeIUUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:33:14 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41363 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUUdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:33:14 -0400
Received: by mail-io1-f70.google.com with SMTP id q24-v6so21554348iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 07:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ph0iYBgSUponKlP/8jBBCW8HpYlXDq99uoPqsCwQXOg=;
        b=aOHci111+Qpblo9jPSHWrKeKFEs/MAdQ2+RV36OfpkQb11cUg6P5C12fZHijOzWWcu
         kfNZ4mfZpRqlrtih+rkm7ZVguF2Dpm950zXneKEGNsEmLBojZVQg5K+u6q9Uun57uy00
         BIle0c4y5ulqnPw8RINsW9C5degqCNnCgKyZ2htqXL9bhxDcJhY6Wtrrr3YVKvqQxbQw
         kyzSUCiwHtSZdwhIsmGAK6bPU4adZ8JGgtVEjcicmtN/Gitfr9OGKms7/c0aF91DotWn
         2md2GmH0mQgOFvHXXoCPenzyMroKDY44oGg9jRJqfVF9qW8ufxglkVbKMnE1h9lvM627
         DkAw==
X-Gm-Message-State: APzg51Cw678eAmzCGi4bJ0fzs9L0XAquZLZw2j7VZbb9DUdlDUlVyoYW
        YQh6btsJruRPnOSElZZ40jaTlzIZM1Vs68Bcwhc7KW9aA4YK
X-Google-Smtp-Source: ANB0VdaiN5sXE7+hjDyKQ1rVgjW0JX4Q+Eg1MUumwhlgNAMh3dTnX7jpdL426tLsKm/Swq0ZJIhxdgHnHDRPFn3h9Pir9LD8/thR
MIME-Version: 1.0
X-Received: by 2002:a6b:e017:: with SMTP id z23-v6mr33231733iog.86.1537541042939;
 Fri, 21 Sep 2018 07:44:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 07:44:02 -0700
In-Reply-To: <0000000000006af1a90573251240@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b12d4c057662aba3@google.com>
Subject: Re: general protection fault in kvm_lapic_hv_timer_in_use
From:   syzbot <syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    234b69e3e089 ocfs2: fix ocfs2 read block panic
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151d6511400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=1c69d94fe42901b029c1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e14956400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com

RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000072c04c
R13: 00007ffc0845277f R14: 00007f1c1a1f89c0 R15: 0000000000000002
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5601 Comm: syz-executor0 Not tainted 4.19.0-rc4+ #248
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_lapic_hv_timer_in_use+0x56/0xd0 arch/x86/kvm/lapic.c:1622
Code: c1 ea 03 80 3c 02 00 75 7a 48 8b 9b e0 03 00 00 e8 cf 7a 66 00 48 8d  
7b 7c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 5b 7c
RSP: 0018:ffff8801b8d0f098 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff810f00fe
RDX: 000000000000000f RSI: ffffffff811859b1 RDI: 000000000000007c
RBP: ffff8801b8d0f0a0 R08: ffff8801d1ea60c0 R09: ffffed00371cfb6c
R10: ffffed00371cfb6c R11: ffff8801b8e7db67 R12: 0000000000000001
R13: 1ffff100371a1e1a R14: 0000000000000000 R15: ffff8801b8e78060
FS:  00007f1c1a1f8700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f63d064f000 CR3: 00000001c23f2000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kvm_arch_vcpu_load+0x516/0x970 arch/x86/kvm/x86.c:3128
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3975
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x56e/0x900 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2828 [inline]
  __schedule+0x874/0x1ed0 kernel/sched/core.c:3473
  preempt_schedule_common+0x1f/0xd0 kernel/sched/core.c:3597
  preempt_schedule+0x4d/0x60 kernel/sched/core.c:3623
  ___preempt_schedule+0x16/0x18
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
  _raw_spin_unlock_irqrestore+0xbb/0xd0 kernel/locking/spinlock.c:184
  try_to_wake_up+0x10a/0x12f0 kernel/sched/core.c:2055
  wake_up_process kernel/sched/core.c:2123 [inline]
  wake_up_q+0xa4/0x100 kernel/sched/core.c:441
  futex_wake+0x61f/0x760 kernel/futex.c:1556
  do_futex+0x2e4/0x26d0 kernel/futex.c:3533
  __do_sys_futex kernel/futex.c:3589 [inline]
  __se_sys_futex kernel/futex.c:3557 [inline]
  __x64_sys_futex+0x472/0x6a0 kernel/futex.c:3557
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457679
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1c1a1f7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000072c048 RCX: 0000000000457679
RDX: 0000000000000016 RSI: 0000000000000081 RDI: 000000000072c04c
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000072c04c
R13: 00007ffc0845277f R14: 00007f1c1a1f89c0 R15: 0000000000000002
Modules linked in:
---[ end trace 107e9054540c67ea ]---
RIP: 0010:kvm_lapic_hv_timer_in_use+0x56/0xd0 arch/x86/kvm/lapic.c:1622
Code: c1 ea 03 80 3c 02 00 75 7a 48 8b 9b e0 03 00 00 e8 cf 7a 66 00 48 8d  
7b 7c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 5b 7c
RSP: 0018:ffff8801b8d0f098 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff810f00fe
RDX: 000000000000000f RSI: ffffffff811859b1 RDI: 000000000000007c
RBP: ffff8801b8d0f0a0 R08: ffff8801d1ea60c0 R09: ffffed00371cfb6c
R10: ffffed00371cfb6c R11: ffff8801b8e7db67 R12: 0000000000000001
R13: 1ffff100371a1e1a R14: 0000000000000000 R15: ffff8801b8e78060
FS:  00007f1c1a1f8700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f63d064f000 CR3: 00000001c23f2000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

