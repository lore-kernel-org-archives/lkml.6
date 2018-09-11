Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B604C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E185320870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+bP7CLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E185320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeIKMd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:33:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35409 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeIKMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:33:55 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so262120itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QYX5xY0sSB4BOLjwXSpmi3con/j+um9zkF3tu/bdhuM=;
        b=f+bP7CLCAIo89WGjM/pD9bCWtkOKuF8KCPt5y3+9SHfzh4lMeTQ6M5mhBPzGZHMChI
         70jZI9da9zCSAM25k2HiFsosMSE/+cVGjUnwOR8abEw+20Zcz7ytX5GAVWMNVsIwbzOb
         jqvgANfXVrWrFeDouMVlI9Bum+Jm8gia/UV2eOXe3d6M7WpYfRwuH/KBC/tse7XpOB+X
         d3IlB8xS+8bY8BzPF5aYjcQlmVtn2hJWJcQBJbAcODtOAjnAwBaeZXNkedFthR4sgHRW
         qo3W1hNe3F9Dmc5oWd272zVdof4G8dsQ7S/3IzpTAwVI4QJFyTdzTwisVkHkBnRSGLNr
         GwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QYX5xY0sSB4BOLjwXSpmi3con/j+um9zkF3tu/bdhuM=;
        b=We0aQ4CUrqDSrHC3CBC1C51y5PbKmL7/Bznpak7t3/zWAtOefcHWINkwjOrpVO/OKd
         c5IkAjyN0WlRyOemU29AK6B+S2p8HsO3NEbJJTR1zzLrLCR9gi3C+zMFnfQaNNTmdbpp
         o8DQwoCzFuetVTQiYeNgAeEGdBRpwfouCC/ddGOFKf/0gcSAfRD08vFx/0LG1MqZVoAl
         vkGw/gU7/HGvZ0OfgRD2gy4FNQI0ZqGKRyi5RvvS6kWbyC5Z63rqdZMU/gokI71HaTMa
         umHycGH0l8Dse4Cg9twUWWiqc2vEwjbMoD8vNPa0jbntBpYh1zxQiaKfe5iNy6AwFpWk
         SghQ==
X-Gm-Message-State: APzg51Bqlz8xrvnH/cdnPh3b1seKn56oCo1FHf99AOR5M9/o+NDyg5Qr
        AyvzQerQZs5fi8eIhzzFIOxV+J5FCLDbnyp42S4IEw==
X-Google-Smtp-Source: ANB0VdbCDQsz/dAkkeHjGhXwt62iIJjYC2JpkQNhgAf2oncNOr3MS8ZfZQ8mxrOinYxzaayYy9MLcL/Eo8PCEzsZkc0=
X-Received: by 2002:a02:49cf:: with SMTP id p76-v6mr22093238jad.25.1536651354635;
 Tue, 11 Sep 2018 00:35:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 00:35:34
 -0700 (PDT)
In-Reply-To: <0000000000004e8a8c0575925aa2@google.com>
References: <0000000000004e8a8c0575925aa2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Sep 2018 09:35:34 +0200
Message-ID: <CACT4Y+arqVLVkHi4UFW2bJKLAq=FBetqiM-au5vQJo2b=qkFuw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in kvm_arch_vcpu_ioctl_run
To:     syzbot <syzbot+b3fdc9590894087f1188@syzkaller.appspotmail.com>
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

On Tue, Sep 11, 2018 at 8:12 AM, syzbot
<syzbot+b3fdc9590894087f1188@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12820cd1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3fdc9590894087f1188
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16940056400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b3fdc9590894087f1188@syzkaller.appspotmail.com

#syz dup: INFO: rcu detected stall in kvm_vcpu_ioctl

> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> hrtimer: interrupt took 32920 ns
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and
> https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    (detected by 1, t=10502 jiffies, g=7509, q=466)
> rcu: All QSes seen, last rcu_preempt kthread activity 10502
> (4295044073-4295033571), jiffies_till_next_fqs=1, root ->qsmask 0x0
> syz-executor7   R  running task    23424  7586   5576 0x00000000
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
> RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
> RIP: 0010:vcpu_enter_guest+0x12ad/0x62e0 arch/x86/kvm/x86.c:7610
> Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b7 4a 00 00 48 83 3d bd 8c 43 08
> 00 0f 84 b1 3d 00 00 e8 3a 32 70 00 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00 e8
> 09 cf 46 00 31 ff 65 44 8b 25 af 50 f3 7e 44 89
> RSP: 0018:ffff8801b116f4f0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: ffff8801cd182680 RBX: ffff8801d97f8080 RCX: 1ffff10039a305e4
> RDX: 0000000000000000 RSI: ffffffff810e9d06 RDI: ffffffff895229b8
> RBP: ffff8801b116f840 R08: ffff8801cd182f20 R09: 0000000000000006
> R10: 0000000000000000 R11: ffff8801cd182680 R12: ffff8801cd182680
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  vcpu_run arch/x86/kvm/x86.c:7693 [inline]
>  kvm_arch_vcpu_ioctl_run+0x375/0x16e0 arch/x86/kvm/x86.c:7870
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
> RSP: 002b:00007ffdfe480958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000001598914 RCX: 0000000000457099
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
> rcu: rcu_preempt kthread starved for 10502 jiffies! g7509 f0x2
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004e8a8c0575925aa2%40google.com.
> For more options, visit https://groups.google.com/d/optout.
