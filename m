Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B64218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551224970;
	bh=ETAADUkuksVx/B0e6RwpEiyG4k5F+pXqQEZXKCZrtsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ScR4UxM2DQxabZytCmj8uXRh/N7T7gykQ2y1GApKC5egdLBLvCiax/5zcFDpzjfn
	 HEXbRd8ka//8i2M7J+jAgexvFP6Le64yUgvUkL7VC6eryGdyLUFmGEn88Eh3yHSXUD
	 a2EyGxctStSEImckT3LpvyA+Yo+btw+J8ao10QEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfBZXt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBZXt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:49:28 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B6E218CD;
        Tue, 26 Feb 2019 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551224967;
        bh=ETAADUkuksVx/B0e6RwpEiyG4k5F+pXqQEZXKCZrtsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xhdzlXUxbzztWJ737JcOJt6wQM+I+mHpzSUvDOWLjkaLh3ux7rn74qddUrLl1FeZO
         98ZsuvP+gJrnFLZB0P/2Tl2CePTFNSQprSR095mqj0PIAQRsNw3w4Eu2vdB+RfQTQt
         MO4/4GIUjYZ50smUE8E8f5QCJrzZn2P95oIYW1Z4=
Date:   Tue, 26 Feb 2019 15:49:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+20eae20afcbd851b8601@syzkaller.appspotmail.com>
Cc:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in kvm_ioapic_scan_entry
Message-ID: <20190226234925.GF218103@gmail.com>
References: <0000000000001c7a5c0573607583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001c7a5c0573607583@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:50:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1c2f2531cf8b Add linux-next specific files for 20180809
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16016cf8400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=44657afb75515c8b
> dashboard link: https://syzkaller.appspot.com/bug?extid=20eae20afcbd851b8601
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12038e22400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163caee2400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+20eae20afcbd851b8601@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> urandom_read: 1 callbacks suppressed
> random: sshd: uninitialized urandom read (32 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 4332 Comm: syz-executor255 Not tainted 4.18.0-rc8-next-20180809+
> #35
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54
> 53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48 89
> f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
> RSP: 0018:ffff8801cf1a7430 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 00000000000001b0 RCX: 0000000000000000
> RDX: 0000000000000036 RSI: 0000000000000000 RDI: 00000000000001b4
> RBP: ffff8801cf1a7458 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed0035c51089 R11: ffff8801ae28844f R12: ffff8801ae288430
> R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00000000014a5880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 00000001b4a66000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
>  _raw_spin_lock+0x32/0x40 kernel/locking/spinlock.c:144
>  spin_lock include/linux/spinlock.h:329 [inline]
>  kvm_ioapic_scan_entry+0x7f/0x3c0 arch/x86/kvm/ioapic.c:246
>  vcpu_scan_ioapic arch/x86/kvm/x86.c:7253 [inline]
>  vcpu_enter_guest+0x494b/0x6360 arch/x86/kvm/x86.c:7389
>  vcpu_run arch/x86/kvm/x86.c:7660 [inline]
>  kvm_arch_vcpu_ioctl_run+0x33e/0x1690 arch/x86/kvm/x86.c:7837
>  kvm_vcpu_ioctl+0x7b8/0x1300 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4402f9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb31251d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401b80
> R13: 0000000000401c10 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace c89a962150abb5ce ]---
> RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
> Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54
> 53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48 89
> f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
> RSP: 0018:ffff8801cf1a7430 EFLAGS: 00010286
> RAX: dffffc0000000000 RBX: 00000000000001b0 RCX: 0000000000000000
> RDX: 0000000000000036 RSI: 0000000000000000 RDI: 00000000000001b4
> RBP: ffff8801cf1a7458 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffed0035c51089 R11: ffff8801ae28844f R12: ffff8801ae288430
> R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00000000014a5880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 00000001b4a66000 CR4: 00000000001426e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

This was fixed by:

commit dcbd3e49c2f0b2c2d8a321507ff8f3de4af76d7c
Author: Wanpeng Li <wanpengli@tencent.com>
Date:   Mon Dec 17 10:43:23 2018 +0800

    KVM: X86: Fix NULL deref in vcpu_scan_ioapic

#syz fix: KVM: X86: Fix NULL deref in vcpu_scan_ioapic
