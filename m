Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9891A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9891A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeHVAty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:49:54 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:38381 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHVAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:49:53 -0400
Received: by mail-it0-f71.google.com with SMTP id h5-v6so191151itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 14:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gJakVlmp3jyIfu+2HIKOZVclIV3p6qdYW4qBjCPA8HI=;
        b=BQbBY2hRL4Fi3yifaYEkmrbwOVRK5Jkw/IcUgtnqWGTRE47o++6+5+qKPCPJEktkai
         YroIKPQoJHcTa6ZpTn/QxyvzNbuAHczgjunsqS2aUBgW8q6xzUHVPJ9JUcrhoGQKjUFI
         MqAxFf0uGpa9ll34ZYcFGh4kzuf4hPj4mc4SiYT9GjUmZxEQEHcyoUbW6mpufcFew1tJ
         uKH+Nk4QgLGZO+Tnq2PIbx130Z7JbOCOzr+Q1yMH/QvQdYWu8eEnh/98nPqQobphjJnd
         MyWfBW4gxlUm2MO2VD3cgOI+Px9f9wSLpaOXk70nkZxX1RxrXC0aXi080C8SoHiMKfrK
         Si6A==
X-Gm-Message-State: AOUpUlGyrol1HHZac1MHeVpktmHQ5KlPEItRTLx1p0/so7Q6VuTIFLe2
        S6wsPn9PleWLcI5jNglf6q26YI0hyoQhf+SO3WRsgORATay+
X-Google-Smtp-Source: AA+uWPxcrul/VOUvDckAUB+GHvrkWpCtG+9PZ2NJuEzOh+hLu6CB5prG1ENd+3MQ4mKIc0oVjrgBn1Y6Ves4+2pEhNAbTOYSTUjy
MIME-Version: 1.0
X-Received: by 2002:a6b:9fc1:: with SMTP id i184-v6mr23346752ioe.75.1534886883000;
 Tue, 21 Aug 2018 14:28:03 -0700 (PDT)
Date:   Tue, 21 Aug 2018 14:28:02 -0700
In-Reply-To: <00000000000035c2ed057315bf85@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e87360573f8b328@google.com>
Subject: Re: general protection fault in finish_task_switch (2)
From:   syzbot <syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com>
To:     dvhart@infradead.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    778a33959a8a Merge tag 'please-pull-noboot' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a5385a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=214e4990bd49329f
dashboard link: https://syzkaller.appspot.com/bug?extid=1f56df64bfb3c29dde6f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13ffa561400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10023961400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4489 Comm: syz-executor233 Not tainted 4.18.0+ #103
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481  
[inline]
RIP: 0010:fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
RIP: 0010:finish_task_switch+0x538/0x870 kernel/sched/core.c:2679
Code: 89 e1 48 c1 e9 03 42 80 3c 39 00 0f 85 ab 01 00 00 4d 8b 24 24 4d 85  
e4 0f 84 e3 fc ff ff 49 8d 7c 24 10 48 89 f9 48 c1 e9 03 <42> 80 3c 39 00  
74 a5 e8 8c a5 67 00 eb 9e 80 3d 8b c3 32 07 00 0f
RSP: 0018:ffff8801ac0ff058 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: ffff8801db02cc40 RCX: 1bd5a00000000022
RDX: 0000000000000000 RSI: ffffffff810ed162 RDI: dead000000000110
RBP: ffff8801ac0ff140 R08: ffff8801acb8c300 R09: ffffed003b221b6c
R10: ffffed003b221b6c R11: ffff8801d910db67 R12: dead000000000100
R13: ffff8801ca5e0040 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801db000000(0063) knlGS:00000000f7f07b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f1304e0b000 CR3: 00000001acab3000 CR4: 00000000001426f0
Call Trace:
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1df0 kernel/sched/core.c:3471
  schedule+0xfb/0x450 kernel/sched/core.c:3515
  freezable_schedule include/linux/freezer.h:172 [inline]
  futex_wait_queue_me+0x3f9/0x840 kernel/futex.c:2530
  futex_wait+0x45b/0xa20 kernel/futex.c:2645
  do_futex+0x336/0x27d0 kernel/futex.c:3527
  __do_compat_sys_futex kernel/futex_compat.c:201 [inline]
  __se_compat_sys_futex kernel/futex_compat.c:175 [inline]
  __ia32_compat_sys_futex+0x3d9/0x5f0 kernel/futex_compat.c:175
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f0bca9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f071ec EFLAGS: 00000296 ORIG_RAX: 00000000000000f0
RAX: ffffffffffffffda RBX: 00000000080fb008 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00000000c080aebe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace a4bb2f1beb6735f0 ]---
RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481  
[inline]
RIP: 0010:fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
RIP: 0010:finish_task_switch+0x538/0x870 kernel/sched/core.c:2679
Code: 89 e1 48 c1 e9 03 42 80 3c 39 00 0f 85 ab 01 00 00 4d 8b 24 24 4d 85  
e4 0f 84 e3 fc ff ff 49 8d 7c 24 10 48 89 f9 48 c1 e9 03 <42> 80 3c 39 00  
74 a5 e8 8c a5 67 00 eb 9e 80 3d 8b c3 32 07 00 0f
RSP: 0018:ffff8801ac0ff058 EFLAGS: 00010a06
RAX: 0000000000000000 RBX: ffff8801db02cc40 RCX: 1bd5a00000000022
RDX: 0000000000000000 RSI: ffffffff810ed162 RDI: dead000000000110
RBP: ffff8801ac0ff140 R08: ffff8801acb8c300 R09: ffffed003b221b6c
R10: ffffed003b221b6c R11: ffff8801d910db67 R12: dead000000000100
R13: ffff8801ca5e0040 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801db000000(0063) knlGS:00000000f7f07b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f1304e0b000 CR3: 00000001acab3000 CR4: 00000000001426f0

