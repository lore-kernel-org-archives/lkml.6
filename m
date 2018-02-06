Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeBFI6U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:58:20 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:33149 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:58:10 -0500
X-Google-Smtp-Source: AH8x227A3mfix0xSZVt+YOrj7Skyq8c+FuZtzE5czAIpcLi1/90SJ7QNpry7Pl3pXAso09eBAdL06OawwnIyQHfwE/4=
MIME-Version: 1.0
In-Reply-To: <001a11433bee1bd9c0056486fc7c@google.com>
References: <001a11440f66112544055c75c246@google.com> <001a11433bee1bd9c0056486fc7c@google.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 6 Feb 2018 16:58:09 +0800
Message-ID: <CANRm+CzJZvgLJ6iOF0VsUM3i60Gu9SfO+0Qa08qA-+rkSSVHoQ@mail.gmail.com>
Subject: Re: WARNING in handle_ept_misconfig
To: syzbot
        <syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-06 16:30 GMT+08:00 syzbot
<syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com>:
> syzbot has found reproducer for the following crash on upstream commit
> 2deb41b245320f0eefb535a5c8ea19ed66b33c04 (Mon Feb 5 18:07:40 2018 +0000)
> Merge tag 'rproc-v4.16' of git://github.com/andersson/remoteproc
>
> So far this crash happened 234 times on linux-next, mmots, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed.
>
> WARNING: CPU: 0 PID: 4187 at arch/x86/kvm/vmx.c:6771
> handle_ept_misconfig+0x140/0x520 arch/x86/kvm/vmx.c:6771
> Kernel panic - not syncing: panic_on_warn set ...

I can reproduce, will have a look.

Regards,
Wanpeng Li

>
> CPU: 0 PID: 4187 Comm: syzkaller225100 Not tainted 4.15.0+ #298
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:984
> RIP: 0010:handle_ept_misconfig+0x140/0x520 arch/x86/kvm/vmx.c:6771
> RSP: 0018:ffff8801b2807360 EFLAGS: 00010293
> RAX: ffff8801b2a16740 RBX: 1ffff10036500e6e RCX: ffffffff81193de0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffed0036500e58
> RBP: ffff8801b2807438 R08: 0000000000000007 R09: ffff8801b28071d8
> R10: ffff8801b2806f30 R11: 0000000000000002 R12: ffff8801c5618480
> R13: 00000000fffffff2 R14: ffff8801b2807410 R15: dffffc0000000000
>  vmx_handle_exit+0x25d/0x1ce0 arch/x86/kvm/vmx.c:8955
>  vcpu_enter_guest arch/x86/kvm/x86.c:7083 [inline]
>  vcpu_run arch/x86/kvm/x86.c:7145 [inline]
>  kvm_arch_vcpu_ioctl_run+0x1c69/0x5bf0 arch/x86/kvm/x86.c:7312
>  kvm_vcpu_ioctl+0x64c/0x1010 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2564
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x26/0x9b
> RIP: 0033:0x448a79
> RSP: 002b:00007ff13702fda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000006ddc3c RCX: 0000000000448a79
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000011b
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc38
> R13: 6d766b2f7665642f R14: 00007ff1370309c0 R15: 000000000000000d
>
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
