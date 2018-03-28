Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeC1H3F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:29:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45348 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeC1H3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:29:01 -0400
X-Google-Smtp-Source: AIpwx48ihDTO4Jl/3zNqPc4vXXnJwt4lJyPvx3AU+npx+cwU9/E9TD5pbjjBjMZAUxX4f5ds9GtdQJMBV3Oz8WdZ+5Y=
MIME-Version: 1.0
In-Reply-To: <000000000000d05a78056873bc47@google.com>
References: <000000000000d05a78056873bc47@google.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 28 Mar 2018 15:29:00 +0800
Message-ID: <CANRm+Cz9GEhgc_Na3E8DqYBccPTimybeu+idP1hDJSk4jni7ag@mail.gmail.com>
Subject: Re: WARNING in kvm_arch_vcpu_ioctl_run (3)
To: syzbot <syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-28 15:13 GMT+08:00 syzbot
<syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com>:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 99fec39e7725d091c94d1bb0242e40c8092994f6 (Fri Mar 23 22:34:18 2018 +0000)
> Merge tag 'trace-v4.16-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=760a73552f47a8cd0fd9
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6275011434250240
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
> compiler: gcc (GCC) 7.1.1 20170620
> user-space arch: i386
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+760a73552f47a8cd0fd9@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> WARNING: CPU: 1 PID: 9515 at arch/x86/kvm/x86.c:7544

Maybe the same as this one. https://lkml.org/lkml/2018/3/21/174 Paolo,
any idea against my analysis?

Regards,
Wanpeng Li

> kvm_arch_vcpu_ioctl_run+0x1c7/0x5c80 arch/x86/kvm/x86.c:7544
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 9515 Comm: syz-executor4 Not tainted 4.16.0-rc6+ #274
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x1f4/0x2b0 lib/bug.c:186
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
> RIP: 0010:kvm_arch_vcpu_ioctl_run+0x1c7/0x5c80 arch/x86/kvm/x86.c:7544
> RSP: 0018:ffff8801a2d17580 EFLAGS: 00010212
> RAX: 0000000000010000 RBX: ffff8801cdfd8000 RCX: ffffffff810dfea7
> RDX: 0000000000000062 RSI: ffffc90003c1b000 RDI: ffff8801ac1a8498
> RBP: ffff8801a2d17910 R08: 1ffff10035835b2d R09: 0000000000000001
> R10: ffff8801a2d17560 R11: 0000000000000005 R12: 0000000000000000
> R13: ffff8801ab083100 R14: ffff8801ac1a8280 R15: ffff8801ac1a8280
>  kvm_vcpu_ioctl+0x6f1/0xff0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2560
>  kvm_vcpu_compat_ioctl+0x364/0x450
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:2755
>  C_SYSC_ioctl fs/compat_ioctl.c:1461 [inline]
>  compat_SyS_ioctl+0x151/0x2a30 fs/compat_ioctl.c:1407
>  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>  do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f41c99
> RSP: 002b:00000000f773d09c EFLAGS: 00000286 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 000000000000ae80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
