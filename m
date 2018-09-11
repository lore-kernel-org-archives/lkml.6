Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01670C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSXaUPe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D5E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeIKMeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:34:46 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55049 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:34:45 -0400
Received: by mail-it0-f65.google.com with SMTP id f14-v6so257145ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nYayb+6WRYC1HFRSafr9Ma9q6c214vMXGZHjEkpxyJ4=;
        b=RSXaUPe6u+Vpvr5VVmBQDdY7Ao1ZDNn46YYwIMKmykwT91Usumby9n4CCRgok/mP5p
         exaEl2OhZWMNzePqt2H/lu2cwN+1dLLFIJuJv3Gzvo3GwHmFSZxMMwBo4cV04pUYHy3V
         JkZVI1A2qa2NlK3GNfdjI0cswJJVxhbVFpJNPIi6gyFOKUv3exu4CUF5PbsZ3XtYNy1l
         B1Lkf+ZuGVs+BKX/0I72YAJt9/HR/v5l3W/kB9qab9/RBuPntYur/xOmSHhM+Z4BN3k0
         zA4rf4k94Rfe1WNaiwIkbWEowjeoagfwPcRHXuvG6ffAFWqfQf19zfyjEZ7q9ALwMwh2
         +QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nYayb+6WRYC1HFRSafr9Ma9q6c214vMXGZHjEkpxyJ4=;
        b=b1UQoZdsT3NRbrlpCVwARCd0VJ/zZZ6rck5yK39LJVJNGLPU7kw9kx7NPZqtNjiLKt
         mNf2FrFYX38cTyT7okL8zB8xJWzzHVyoeGzkOXvEyePMB6A8gmW9ibLS33/z1j22ezkh
         URGCh88eYVqFDLKFMdmHaxVuBmqct5RR8aJM7BCOeciT/dUDas3D/SI/OziY5opSpwPn
         U6w1wR7gyG3mryZykpwGPiuQ8WuLESQ8yEOdZj76FQ42i05WEaCQRH+1+N8/MiI9jJYR
         wexoCY/z3v69tepHwuZ5Irqx2g3EPr3uAMUjtHVKdv3vrwlb59d2SDKzEUs5DTVAMUn4
         ZD0A==
X-Gm-Message-State: APzg51AQaCmph1h/eQaCUkOX8zni9Rt0jmxyY5Sy7jTMuymboObrMfub
        A0NZN7OXtPe405c6kD0HZAeXExudPK6E1K6vOI3N9A==
X-Google-Smtp-Source: ANB0VdZU/jYirg0KjLS1gWtMGso6FetKeTlOPy3BsbmgIrGP93l093FwrBC8Sxw8oazIWU5KcjZ9rI3D39NJ0r1bWgo=
X-Received: by 2002:a24:140f:: with SMTP id 15-v6mr393192itg.57.1536651404577;
 Tue, 11 Sep 2018 00:36:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 00:36:24
 -0700 (PDT)
In-Reply-To: <000000000000cf740005757f7a21@google.com>
References: <000000000000cf740005757f7a21@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Sep 2018 09:36:24 +0200
Message-ID: <CACT4Y+bwUDXSMWkCrOu1AkKpMei5uz8UX+fFpt26kZpWa-4MAg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in kvm_mmu_unprotect_page
To:     syzbot <syzbot+3656615bd54615add56a@syzkaller.appspotmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 9:41 AM, syzbot
<syzbot+3656615bd54615add56a@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d31571400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3656615bd54615add56a
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124a5346400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3656615bd54615add56a@syzkaller.appspotmail.com

#syz dup: INFO: rcu detected stall in kvm_vcpu_ioctl

> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> hrtimer: interrupt took 30378 ns
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and
> https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    (detected by 1, t=10502 jiffies, g=7113, q=509)
> rcu: All QSes seen, last rcu_preempt kthread activity 10498
> (4295042895-4295032397), jiffies_till_next_fqs=1, root ->qsmask 0x0
> syz-executor0   R  running task    22808  7363   5346 0x00000000
> Call Trace:
>  <IRQ>
>  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
>  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
>  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
>  __rcu_pending kernel/rcu/tree.c:3276 [inline]
>  rcu_pending kernel/rcu/tree.c:3319 [inline]
>  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
>  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:788
> [inline]
> RIP: 0010:lock_acquire+0x268/0x520 kernel/locking/lockdep.c:3904
> Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 44 02 00 00 48 83 3d af
> 39 f1 07 00 0f 84 c3 01 00 00 48 8b bd 20 ff ff ff 57 9d <0f> 1f 44 00 00 48
> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00
> RSP: 0018:ffff8801c664eb20 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: dffffc0000000000 RBX: 1ffff10038cc9d69 RCX: 0000000000000000
> RDX: 1ffffffff12a4535 RSI: 0000000000000000 RDI: 0000000000000282
> RBP: ffff8801c664ec10 R08: ffff8801c10e6e70 R09: 0000000000000002
> R10: ffff8801c10e6e50 R11: f333abdc872bc457 R12: ffff8801c10e6580
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
>  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
>  spin_lock include/linux/spinlock.h:329 [inline]
>  kvm_mmu_unprotect_page+0xf9/0x450 arch/x86/kvm/mmu.c:2720
>  retry_instruction arch/x86/kvm/x86.c:5982 [inline]
>  x86_emulate_instruction+0x635/0x1fc0 arch/x86/kvm/x86.c:6210
>  kvm_mmu_page_fault+0x396/0x1b30 arch/x86/kvm/mmu.c:5280
>  handle_ept_violation+0x29e/0x6a0 arch/x86/kvm/vmx.c:7679
>  vmx_handle_exit+0x2f7/0x17e0 arch/x86/kvm/vmx.c:10115
>  vcpu_enter_guest+0x14a9/0x62e0 arch/x86/kvm/x86.c:7648
>  vcpu_run arch/x86/kvm/x86.c:7711 [inline]
>  kvm_arch_vcpu_ioctl_run+0x375/0x16e0 arch/x86/kvm/x86.c:7888
>  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457099
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff8bfb2748 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000212b914 RCX: 0000000000457099
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
> rcu: rcu_preempt kthread starved for 10498 jiffies! g7113 f0x2
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: RCU grace-period kthread stack dump:
> rcu_preempt     R  running task    22872    10      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2825 [inline]
>  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
>  schedule+0xfe/0x460 kernel/sched/core.c:3517
>  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
>  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> rcu:    (detected by 1, t=10652 jiffies, g=-1171, q=0)
> rcu: All QSes seen, last rcu_sched kthread activity 10649
> (4295043046-4295032397), jiffies_till_next_fqs=1, root ->qsmask 0x0
> syz-executor0   R  running task    22808  7363   5346 0x80000000
> Call Trace:
>  <IRQ>
>  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
>  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
>  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
>  __rcu_pending kernel/rcu/tree.c:3276 [inline]
>  rcu_pending kernel/rcu/tree.c:3319 [inline]
>  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
>  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:788
> [inline]
> RIP: 0010:lock_acquire+0x268/0x520 kernel/locking/lockdep.c:3904
> Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 44 02 00 00 48 83 3d af
> 39 f1 07 00 0f 84 c3 01 00 00 48 8b bd 20 ff ff ff 57 9d <0f> 1f 44 00 00 48
> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00
> RSP: 0018:ffff8801c664eb20 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: dffffc0000000000 RBX: 1ffff10038cc9d69 RCX: 0000000000000000
> RDX: 1ffffffff12a4535 RSI: 0000000000000000 RDI: 0000000000000282
> RBP: ffff8801c664ec10 R08: ffff8801c10e6e70 R09: 0000000000000002
> R10: ffff8801c10e6e50 R11: f333abdc872bc457 R12: ffff8801c10e6580
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
>  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
>  spin_lock include/linux/spinlock.h:329 [inline]
>  kvm_mmu_unprotect_page+0xf9/0x450 arch/x86/kvm/mmu.c:2720
>  retry_instruction arch/x86/kvm/x86.c:5982 [inline]
>  x86_emulate_instruction+0x635/0x1fc0 arch/x86/kvm/x86.c:6210
>  kvm_mmu_page_fault+0x396/0x1b30 arch/x86/kvm/mmu.c:5280
>  handle_ept_violation+0x29e/0x6a0 arch/x86/kvm/vmx.c:7679
>  vmx_handle_exit+0x2f7/0x17e0 arch/x86/kvm/vmx.c:10115
>  vcpu_enter_guest+0x14a9/0x62e0 arch/x86/kvm/x86.c:7648
>  vcpu_run arch/x86/kvm/x86.c:7711 [inline]
>  kvm_arch_vcpu_ioctl_run+0x375/0x16e0 arch/x86/kvm/x86.c:7888
>  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457099
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff8bfb2748 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000212b914 RCX: 0000000000457099
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
> rcu: rcu_sched kthread starved for 10649 jiffies! g-1171 f0x2
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: RCU grace-period kthread stack dump:
> rcu_sched       R  running task    24600    11      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2825 [inline]
>  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
>  schedule+0xfe/0x460 kernel/sched/core.c:3517
>  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
>  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
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
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000cf740005757f7a21%40google.com.
> For more options, visit https://groups.google.com/d/optout.
