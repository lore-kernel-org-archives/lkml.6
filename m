Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F274AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933C22084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNEP46V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBWKdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:33:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34397 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBWKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:33:46 -0500
Received: by mail-io1-f65.google.com with SMTP id e1so3880772iok.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHBlBbOuaXZm0VBwLXubU2GUHUb1Mc7VFMvl3XM9sn4=;
        b=VNEP46V2iTHpoaHivMsDDUcAQgDgVvE63vtYwyi40DWRmSKUN7tvCdPj7uQPzOb2pt
         r0uIrxdw6qI/xbZtnZiWey/Mag9A4krXyzD2rRnsyaGJKo0turRIfHn3yGUCtLnZlYg5
         J9eQl3QPRweLq78JWfx2m1y7tdxfNmQloAZYUzBw6BZbuZWCjJ7L3oBVf+RteYKhR6k/
         iNYE0/wI/Jc+lML7P+M67UG0+xYx3kpRdQqa5RZqudfZ/O0FN35VLMXYkY4mao4g2s1t
         w3UyZNh4LLNIFZD1kqot4GaWTp7JIUJ1zGkVThgoAK9S6blcVEQrxdW/QGWrKowS2H1o
         sqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHBlBbOuaXZm0VBwLXubU2GUHUb1Mc7VFMvl3XM9sn4=;
        b=Szd0Nm40eXapLkOL0y4gD1ZR8WgCnmZ5uUq9w/DOyLXbEGwAx0IjtA/YFudUVgD95Q
         iGxwUKN36Qp8CzTuhoa83EHgkMxaHkPn5ZUMv9Lhc+ED8fcu4C2MG3Vu6lpuL29y8cMW
         6KUhaTD6m7wpKbDujHmw1J7NiXeltKY2D7NlYTM5100lFHdCamHKhUz7Emz1I/c90UB3
         6+sY8d9EOrNKOvZMIn/3hgzMCJbiKw89gkv4vPaFVgEodiDZy52rP68pcZJPSWB1i1nz
         PRbujtXimtlDmzCvfd0/uCcXPrbLoF6HkC9EPBr4s77h40pF0XjbvlNzbBRLk3HIBny1
         bWHw==
X-Gm-Message-State: AHQUAubEQ7a1ZiiiMc/N5wCUAdQNUbAXdjYX3ztw6s44cH6DRo8o+cvY
        RVyE4HCkj4ZZ0UHKD103to1vqBSH5SDTLPLc12L09g==
X-Google-Smtp-Source: AHgI3IaU15MKmm/3RHt+7cte0qZ1cyqewLCdOVRGrtLjg+9LRUGqMhO0IkavA/24JvVCE9MiNpeRMWBIDMxywsZeV5Y=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr4366512ior.271.1550918024732;
 Sat, 23 Feb 2019 02:33:44 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007da94e05827ea99a@google.com> <20190222222036.GC30766@zn.tnic>
In-Reply-To: <20190222222036.GC30766@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Feb 2019 11:33:33 +0100
Message-ID: <CACT4Y+aq+5Hor2f-SsaO4VW3p1Xq2Xk-2OUeKhpp=aOx0XMmzg@mail.gmail.com>
Subject: Re: WARNING in rcu_check_gp_start_stall
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, puwen@hygon.cn,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wang.yi59@zte.com.cn,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:20 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 22, 2019 at 09:10:04AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    8a61716ff2ab Merge tag 'ceph-for-5.0-rc8' of git://github...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1531dd3f400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000
>
> So I ran this for more than an hour in a guest here with the above
> .config but nothing happened. The compiler I used is 8.2, dunno of that
> makes the difference or I'm missing something else...

I was able to reproduce this on the first run:

# ./syz-execprog -procs=8 -repeat=0 hang
2019/02/23 10:24:31 parsed 1 programs
2019/02/23 10:24:31 executed programs: 0
2019/02/23 10:24:36 executed programs: 23
2019/02/23 10:24:41 executed programs: 71
2019/02/23 10:24:46 executed programs: 118
2019/02/23 10:24:52 executed programs: 162
2019/02/23 10:24:57 executed programs: 208
2019/02/23 10:25:02 executed programs: 258
2019/02/23 10:25:07 executed programs: 288

And on the console:

[   77.032078] sched: RT throttling activated
[  183.901866] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  183.902595] rcu: (detected by 2, t=10502 jiffies, g=5945, q=335)
[  183.903249] rcu: All QSes seen, last rcu_preempt kthread activity
10500 (4294955649-4294945149), jiffies_till_next_fqs=1, root ->qsmask
0x0
[  183.904548] syz-executor    R  running task    56728  7574   6076 0x00000000
[  183.905300] Call Trace:
[  183.905570]  <IRQ>
[  183.905807]  sched_show_task.cold+0x273/0x2d5
[  183.906283]  ? can_nice.part.0+0x20/0x20
[  183.906708]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[  183.907205]  ? print_usage_bug+0xd0/0xd0
[  183.907629]  ? __sanitizer_cov_trace_cmp8+0x18/0x20
[  183.908149]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.908729]  print_other_cpu_stall.cold+0x7f2/0x8bb
[  183.909260]  ? print_cpu_stall+0x170/0x170
[  183.909703]  ? add_lock_to_list.isra.0+0x450/0x450
[  183.910219]  ? find_held_lock+0x35/0x120
[  183.910643]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.911217]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.911791]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.912367]  ? check_preemption_disabled+0x48/0x290
[  183.912889]  ? __this_cpu_preempt_check+0x1d/0x30
[  183.913389]  ? rcu_preempt_need_deferred_qs+0x71/0x1a0
[  183.913939]  ? do_trace_rcu_torture_read+0x10/0x10
[  183.914496]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.915119]  ? check_preemption_disabled+0x48/0x290
[  183.915681]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.916307]  ? check_preemption_disabled+0x48/0x290
[  183.916876]  rcu_check_callbacks+0xf36/0x1380
[  183.917381]  ? account_system_index_time+0x31a/0x5f0
[  183.917964]  ? rcutree_dead_cpu+0x10/0x10
[  183.918437]  ? trace_hardirqs_off+0xb8/0x310
[  183.918934]  ? __lock_is_held+0xb6/0x140
[  183.919392]  ? trace_hardirqs_on_caller+0x310/0x310
[  183.919966]  ? check_preemption_disabled+0x48/0x290
[  183.920536]  ? raise_softirq+0x189/0x430
[  183.920997]  ? account_system_index_time+0x33f/0x5f0
[  183.921575]  ? raise_softirq_irqoff+0x2d0/0x2d0
[  183.922110]  ? check_preemption_disabled+0x48/0x290
[  183.922679]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20
[  183.923303]  ? hrtimer_run_queues+0x99/0x410
[  183.923806]  ? run_local_timers+0x194/0x230
[  183.924301]  ? timer_clear_idle+0x90/0x90
[  183.924777]  ? account_process_tick+0x27f/0x350
[  183.925314]  ? ktime_mono_to_any+0x3a0/0x3a0
[  183.925819]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.926461]  update_process_times+0x32/0x80
[  183.926960]  tick_sched_handle+0xa2/0x190
[  183.927438]  tick_sched_timer+0x47/0x130
[  183.927905]  __hrtimer_run_queues+0x3a7/0x1050
[  183.928433]  ? tick_sched_do_timer+0x1b0/0x1b0
[  183.928959]  ? hrtimer_fixup_init+0x90/0x90
[  183.929450]  ? kvm_clock_read+0x18/0x30
[  183.929904]  ? __sanitizer_cov_trace_cmp4+0x16/0x20
[  183.930473]  ? ktime_get_update_offsets_now+0x3d5/0x5e0
[  183.931081]  ? do_timer+0x50/0x50
[  183.931474]  ? add_lock_to_list.isra.0+0x450/0x450
[  183.932032]  ? rcu_softirq_qs+0x20/0x20
[  183.932482]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.933112]  hrtimer_interrupt+0x314/0x770
[  183.933600]  smp_apic_timer_interrupt+0x18d/0x760
[  183.934160]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  183.934716]  ? smp_call_function_single_interrupt+0x640/0x640
[  183.935386]  ? trace_hardirqs_off+0x310/0x310
[  183.935897]  ? task_prio+0x50/0x50
[  183.936304]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.936932]  ? check_preemption_disabled+0x48/0x290
[  183.937504]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  183.938067]  apic_timer_interrupt+0xf/0x20
[  183.938549]  </IRQ>
[  183.938808] RIP: 0010:lock_is_held_type+0x17e/0x210
[  183.939379] Code: 00 00 00 fc ff df 41 c7 85 7c 08 00 00 00 00 00
00 48 c1 e8 03 80 3c 10 00 75 63 48 83 3d f9 65 2e 08 00 74 30 48 89
df 57 9d <0f> 1f 44 00 00 48 83 c4 08 44 89 e0 5b 41 5c 41 5d 5d c3 48
83 c4
[  183.941512] RSP: 0018:ffff88804c04f2c8 EFLAGS: 00000286 ORIG_RAX:
ffffffffffffff13
[  183.942388] RAX: 1ffffffff132607e RBX: 0000000000000286 RCX: dffffc0000000000
[  183.943208] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000286
[  183.944032] RBP: ffff88804c04f2e8 R08: ffff88805c074000 R09: ffffed100d8a7f98
[  183.944855] R10: ffffed100d8a7f97 R11: ffff88806c53fcbb R12: 0000000000000000
[  183.945674] R13: ffff88805c074000 R14: dffffc0000000000 R15: 0000000000000008
[  183.946508]  ___might_sleep+0xd5/0x160
[  183.946956]  ? ext4_write_end+0x1090/0x1090
[  183.947452]  generic_perform_write+0x3fd/0x6a0
[  183.947978]  ? add_page_wait_queue+0x480/0x480
[  183.948504]  ? current_time+0x1b0/0x1b0
[  183.948958]  ? generic_write_check_limits+0x380/0x380
[  183.949547]  ? ext4_file_write_iter+0x28b/0x1440
[  183.950091]  __generic_file_write_iter+0x25e/0x630
[  183.950659]  ext4_file_write_iter+0x37a/0x1440
[  183.951184]  ? ext4_file_mmap+0x410/0x410
[  183.951654]  ? save_stack+0xa9/0xd0
[  183.952065]  ? save_stack+0x45/0xd0
[  183.952477]  ? __kasan_kmalloc.constprop.0+0xcf/0xe0
[  183.953053]  ? kasan_kmalloc+0x9/0x10
[  183.953485]  ? __kmalloc+0x15c/0x740
[  183.953918]  ? iter_file_splice_write+0x267/0xfc0
[  183.954466]  ? splice_direct_to_actor+0x3be/0x9d0
[  183.955015]  ? do_splice_direct+0x2c7/0x420
[  183.955504]  ? do_sendfile+0x61d/0xe60
[  183.955948]  ? __x64_sys_sendfile64+0x15a/0x240
[  183.956475]  ? do_syscall_64+0x1a3/0x800
[  183.956939]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  183.957550]  ? debug_lockdep_rcu_enabled+0x71/0xa0
[  183.958115]  ? common_file_perm+0x231/0x800
[  183.958604]  ? print_usage_bug+0xd0/0xd0
[  183.959066]  do_iter_readv_writev+0x902/0xbc0
[  183.959582]  ? vfs_dedupe_file_range+0x780/0x780
[  183.960122]  ? apparmor_file_permission+0x25/0x30
[  183.960674]  ? rw_verify_area+0x118/0x360
[  183.961146]  do_iter_write+0x184/0x610
[  183.961587]  ? pipe_to_sendpage+0x390/0x390
[  183.962087]  ? rcu_read_lock_sched_held+0x110/0x130
[  183.962658]  ? __kmalloc+0x5d5/0x740
[  183.963082]  vfs_iter_write+0x77/0xb0
[  183.963515]  iter_file_splice_write+0x885/0xfc0
[  183.964044]  ? fsnotify+0x4f5/0xed0
[  183.964462]  ? page_cache_pipe_buf_steal+0x800/0x800
[  183.965046]  ? rw_verify_area+0x118/0x360
[  183.965516]  ? page_cache_pipe_buf_steal+0x800/0x800
[  183.966098]  direct_splice_actor+0x126/0x1a0
[  183.966598]  splice_direct_to_actor+0x3be/0x9d0
[  183.967125]  ? generic_pipe_buf_nosteal+0x10/0x10
[  183.967679]  ? do_splice_to+0x190/0x190
[  183.968134]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.968762]  ? rw_verify_area+0x118/0x360
[  183.969233]  do_splice_direct+0x2c7/0x420
[  183.969709]  ? splice_direct_to_actor+0x9d0/0x9d0
[  183.970264]  ? rcu_read_lock_sched_held+0x110/0x130
[  183.970833]  ? rcu_sync_lockdep_assert+0x73/0xb0
[  183.971376]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  183.972003]  ? __sb_start_write+0x1aa/0x360
[  183.972499]  do_sendfile+0x61d/0xe60
[  183.972926]  ? do_compat_pwritev64+0x1c0/0x1c0
[  183.973453]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  183.974084]  ? _copy_from_user+0xdd/0x150
[  183.974561]  __x64_sys_sendfile64+0x15a/0x240
[  183.975080]  ? __ia32_sys_sendfile+0x2a0/0x2a0
[  183.975605]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  183.976151]  do_syscall_64+0x1a3/0x800
[  183.976598]  ? syscall_return_slowpath+0x5f0/0x5f0
[  183.977161]  ? prepare_exit_to_usermode+0x3b0/0x3b0
[  183.977733]  ? __switch_to_asm+0x34/0x70
[  183.978204]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  183.978758]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  183.979348] RIP: 0033:0x457629
[  183.979714] Code: 8d b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66
90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b b5 fb ff c3 66 2e 0f 1f 84 00 00
00 00
[  183.981845] RSP: 002b:00007f435f197c88 EFLAGS: 00000246 ORIG_RAX:
0000000000000028
[  183.982718] RAX: ffffffffffffffda RBX: 000000000071bfa0 RCX: 0000000000457629
[  183.983533] RDX: 0000000020000000 RSI: 0000000000000003 RDI: 0000000000000003
[  183.984358] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[  183.985179] R10: 00008080fffffffe R11: 0000000000000246 R12: 00007f435f1986d4
[  183.986005] R13: 00000000004abf30 R14: 00000000006eb8b8 R15: 00000000ffffffff



This is with qemu with 4 CPUs:

qemu-system-x86_64 -hda wheezy.img -net
user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net nic -nographic -kernel
arch/x86/boot/bzImage -append "kvm-intel.nested=1
kvm-intel.unrestricted_guest=1 kvm-intel.ept=1
kvm-intel.flexpriority=1 kvm-intel.vpid=1
kvm-intel.emulate_invalid_guest_state=1 kvm-intel.eptad=1
kvm-intel.enable_shadow_vmcs=1 kvm-intel.pml=1
kvm-intel.enable_apicv=1 console=ttyS0 root=/dev/sda
earlyprintk=serial slub_debug=UZ vsyscall=native rodata=n oops=panic
panic_on_warn=1 panic=86400 ima_policy=tcb" -enable-kvm -pidfile
vm_pid -m 2G -smp 4 -cpu host


There is a bunch of other bug reports about hangs where reproducers
mention perf_event_open and sched_setattr.
