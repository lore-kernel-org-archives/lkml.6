Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7458D20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIHok0i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7458D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeGLIAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:00:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39508 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeGLIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:00:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so10338271plq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FJubhv4nBuYcCFDGXmtQLGkOw+fytMp4/oWB71UOg/g=;
        b=FIHok0i9cvgLqkxtcjdSkUqYeNTK7CCl1xSfM1NMT1ZuV4rHt1EwlRl1H9P20tnDP3
         088CF3zk+hdmbqjQaf0lmU39PgFWuM6HCFkTb9NeZi226KncKBnoVX0wM6b1MOSCyX5N
         ahsNdcrVoM9qS1w+LORDCsKempWyW4fvDNmyYPn66YOHfTRn+kcOwqxF5uco4X67DCxm
         b4RJ0WaK7utiaiJnp9Sflsc3urzxNJeCViUUZ18ynZyhm4XyUQtPwwzMRu5XOD7BiRqz
         436doGVAKQxk4AqLZK94RXZgpq+rwHkACCCKgyHIArji+dUPbo4JDl3WsL2OsGMO/I0p
         ZdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FJubhv4nBuYcCFDGXmtQLGkOw+fytMp4/oWB71UOg/g=;
        b=cESwiT2khW0xMtCAEv0o9Dq+/iVPeuDVlfdbSrOQ6JFUwh+dKaqyjAXs99xPxLIkCg
         mpzY918lt2CCt/sZiFQyYplB7SALUaJas78uJyFBVUP9890V/MWkR46I5sS07KhB8Rt3
         JVn8mIrrurPCWkJkAnvT6jLSiCBETZjLD9Qm9y7ynRGmff4nTnjwLkG/q72dp/zLtT4r
         QEsCh9BNwEtKj/dHgjYd4su+1D6lWxxOQfMq1DpuvoDYe2nXy4Zsa1/qrEXieILFwqa7
         JfHElwy1fCHV7Bba2bDXO1GuynJ8op8uqHfjZNmdcUwQRja9GafOzB9m6X6PUueEP7DX
         ykFQ==
X-Gm-Message-State: AOUpUlEJNaKC7JU8F8mj5cZX1w3wIPXZrTbRh+EZk7vX25fQNSxK2z3f
        /0YBrJi0P6ifEiA9xa0HwxcPSrOhrIDEuR2DEtiFaQ==
X-Google-Smtp-Source: AAOMgpczdLs21XljpzJ5Yj98uHM2kYR5YVkZjC1TR+F8zduMYEZheqToczQEtUeAJrjRPSqEpXUg/L6XIqhYlEn4gds=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr1118322plr.264.1531381905721;
 Thu, 12 Jul 2018 00:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Thu, 12 Jul 2018 00:51:25
 -0700 (PDT)
In-Reply-To: <00000000000025f8880570c87c51@google.com>
References: <00000000000025f8880570c87c51@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Jul 2018 09:51:25 +0200
Message-ID: <CACT4Y+aDK2yFb=8GGMEL8+Tfq6VVJhU-jrhMrQj9KywmMBNHNg@mail.gmail.com>
Subject: Re: WARNING in bpf_check
To:     syzbot <syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 9:41 AM, syzbot
<syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    671dffa7de7b Merge branch 'bpf-bpftool-improved-prog-load'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1550b562400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d427828b2ea6e592804
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7d427828b2ea6e592804@syzkaller.appspotmail.com
>
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
> R13: 00000000004bbbc2 R14: 00000000004c8e28 R15: 0000000000000037
> ------------[ cut here ]------------
> verifier bug. No program starts at insn 3
> WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613
> get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
> WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613 fixup_call_args
> kernel/bpf/verifier.c:5587 [inline]
> WARNING: CPU: 0 PID: 12586 at kernel/bpf/verifier.c:1613
> bpf_check+0x5239/0x5e60 kernel/bpf/verifier.c:5952
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 12586 Comm: syz-executor0 Not tainted 4.18.0-rc3+ #49
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
> RIP: 0010:fixup_call_args kernel/bpf/verifier.c:5587 [inline]
> RIP: 0010:bpf_check+0x5239/0x5e60 kernel/bpf/verifier.c:5952
> Code: ff 48 89 df e8 28 08 2e 00 e9 d8 d7 ff ff e8 6e 2f f0 ff 8b 74 24 58
> 48 c7 c7 20 8d ef 87 c6 05 d5 f1 0d 08 01 e8 37 52 bb ff <0f> 0b 48 8b 54 24
> 08 b8 ff ff 37 00 48 c1 e0 2a 48 c1 ea 03 0f b6
> RSP: 0018:ffff88019745f980 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90003eec000
> RDX: 0000000000040000 RSI: ffffffff81631851 RDI: ffff88019745f658
> RBP: ffff88019745fb30 R08: ffff880197666100 R09: fffffbfff11f1220
> R10: fffffbfff11f1220 R11: ffffffff88f89103 R12: dffffc0000000000
> R13: ffffc90001ace040 R14: 00000000fffffffe R15: ffff8801b0b7e800
>  bpf_prog_load+0x1141/0x1c90 kernel/bpf/syscall.c:1352
>  __do_sys_bpf kernel/bpf/syscall.c:2305 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
>  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2267
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455e29
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f28af3e8c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f28af3e96d4 RCX: 0000000000455e29
> RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
> R13: 00000000004bbbc2 R14: 00000000004c8e28 R15: 0000000000000037
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..


Reproducer is below. It seems to be related to the kmalloc failure in
jit_subprogs():


[  140.990644] FAULT_INJECTION: forcing a failure.
[  140.990644] name failslab, interval 1, probability 0, space 0, times 0
[  140.994740] CPU: 3 PID: 4072 Comm: a.out Not tainted 4.18.0-rc4+ #51
[  140.997070] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  141.000046] Call Trace:
[  141.001025]  __dump_stack lib/dump_stack.c:77 [inline]
[  141.001025]  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
[  141.001714]  ? dump_stack_print_info.cold.2+0x52/0x52 lib/dump_stack.c:60
[  141.002637]  ? kernel_text_address+0x79/0xf0 kernel/extable.c:152
[  141.003423]  fail_dump lib/fault-inject.c:51 [inline]
[  141.003423]  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
[  141.004145]  ? fault_create_debugfs_attr+0x1f0/0x1f0 lib/fault-inject.c:249
[  141.005056]  ? save_stack+0xa9/0xd0 mm/kasan/kasan.c:454
[  141.005694]  ? save_stack+0x43/0xd0 mm/kasan/kasan.c:448
[  141.006352]  ? graph_lock+0x170/0x170 arch/x86/include/asm/paravirt.h:674
[  141.007021]  ? lock_downgrade+0x8f0/0x8f0 kernel/locking/lockdep.c:3658
[  141.007736]  ? __lock_is_held+0xb5/0x140 kernel/locking/lockdep.c:3744
[  141.008441]  ? trace_hardirqs_off+0xd/0x10 kernel/locking/lockdep.c:2932
[  141.009190]  ? rcu_note_context_switch+0x730/0x730
include/linux/compiler.h:188
[  141.010052]  __should_failslab+0x124/0x180 mm/failslab.c:32
[  141.010789]  should_failslab+0x9/0x14 mm/slab_common.c:1557
[  141.011450]  slab_pre_alloc_hook mm/slab.h:423 [inline]
[  141.011450]  slab_alloc mm/slab.c:3378 [inline]
[  141.011450]  __do_kmalloc mm/slab.c:3716 [inline]
[  141.011450]  __kmalloc+0x2c8/0x760 mm/slab.c:3727
[  141.012070]  ? find_subprog+0xbb/0x100 kernel/bpf/verifier.c:778
[  141.012773]  ? find_good_pkt_pointers+0x630/0x630 kernel/bpf/verifier.c:3422
[  141.013632]  ? kmalloc_array include/linux/slab.h:635 [inline]
[  141.013632]  ? kcalloc include/linux/slab.h:646 [inline]
[  141.013632]  ? jit_subprogs kernel/bpf/verifier.c:5451 [inline]
[  141.013632]  ? fixup_call_args kernel/bpf/verifier.c:5578 [inline]
[  141.013632]  ? bpf_check+0x3947/0x5e60 kernel/bpf/verifier.c:5952
[  141.014309]  ? trace_hardirqs_on+0xd/0x10 kernel/locking/lockdep.c:2894
[  141.015019]  kmalloc_array include/linux/slab.h:635 [inline]
[  141.015019]  kcalloc include/linux/slab.h:646 [inline]
[  141.015019]  jit_subprogs kernel/bpf/verifier.c:5451 [inline]
[  141.015019]  fixup_call_args kernel/bpf/verifier.c:5578 [inline]
[  141.015019]  bpf_check+0x3947/0x5e60 kernel/bpf/verifier.c:5952
[  141.015668]  ? pvclock_read_flags+0x160/0x160
arch/x86/include/asm/pvclock.h:35
[  141.016453]  ? fixup_bpf_calls+0x1fb0/0x1fb0 kernel/bpf/verifier.c:5677
[  141.017224]  ? ktime_get_with_offset+0x32e/0x4b0
kernel/time/timekeeping.c:788
[  141.018046]  ? ktime_get+0x440/0x440 kernel/time/timekeeping.c:751
[  141.018693]  ? memset+0x31/0x40 mm/kasan/kasan.c:287
[  141.019264]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 kernel/kcov.c:174
[  141.020180]  ? bpf_obj_name_cpy+0x17c/0x1c0 kernel/bpf/syscall.c:427
[  141.020890]  bpf_prog_load+0x1141/0x1c90 kernel/bpf/syscall.c:1352
[  141.021555]  ? bpf_prog_new_fd+0x60/0x60 kernel/bpf/syscall.c:1099
[  141.022220]  ? lock_downgrade+0x8f0/0x8f0 kernel/locking/lockdep.c:3658
[  141.022903]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20 kernel/kcov.c:195
[  141.023842]  __do_sys_bpf kernel/bpf/syscall.c:2305 [inline]
[  141.023842]  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
[  141.023842]  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2267
[  141.024529]  ? bpf_prog_get+0x20/0x20 kernel/bpf/syscall.c:1197
[  141.025214]  ? do_syscall_64+0x9a/0x820 arch/x86/entry/common.c:277
[  141.025905]  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
[  141.026583]  ? syscall_return_slowpath+0x5e0/0x5e0
arch/x86/entry/common.c:255
[  141.027435]  ? prepare_exit_to_usermode arch/x86/entry/common.c:211 [inline]
[  141.027435]  ? syscall_return_slowpath+0x31d/0x5e0
arch/x86/entry/common.c:268
[  141.028293]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  141.029237]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  141.030089]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  141.030998] RIP: 0033:0x44a949
[  141.031559] Code: e8 2c aa 01 00 48 83 c4 18 c3 0f 1f 80 00 00 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 0c fc ff c3 66 2e 0f 1f 84 00 00
00 00
[  141.035037] RSP: 002b:00007fe7874b0d88 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[  141.036347] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044a949
[  141.037590] RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
[  141.038813] RBP: 00007fe7874b0da0 R08: 0000000000000002 R09: 0000000000000000
[  141.040069] R10: 0000000000000001 R11: 0000000000000206 R12: 0000000000000000
[  141.041302] R13: 00007ffe20cc628f R14: 00007fe7874b1700 R15: 0000000000000000
[  141.042804] ------------[ cut here ]------------
[  141.043668] verifier bug. No program starts at insn 3
[  141.044648] ARNING: CPU: 3 PID: 4072 at kernel/bpf/verifier.c:1613
get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
[  141.044648] ARNING: CPU: 3 PID: 4072 at kernel/bpf/verifier.c:1613
fixup_call_args kernel/bpf/verifier.c:5587 [inline]
[  141.044648] ARNING: CPU: 3 PID: 4072 at kernel/bpf/verifier.c:1613
bpf_check+0x525e/0x5e60 kernel/bpf/verifier.c:5952
[  141.046103]
[  141.047355] CPU: 3 PID: 4072 Comm: a.out Not tainted 4.18.0-rc4+ #51
[  141.048446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  141.049877] Call Trace:
[  141.050324]  __dump_stack lib/dump_stack.c:77 [inline]
[  141.050324]  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
[  141.050950]  ? dump_stack_print_info.cold.2+0x52/0x52 lib/dump_stack.c:60
[  141.051837]  panic+0x238/0x4e7 kernel/panic.c:184
[  141.052386]  ? add_taint.cold.5+0x16/0x16 kernel/panic.c:385
[  141.053101]  ? __warn.cold.8+0x148/0x1ba kernel/panic.c:537
[  141.053814]  ? __warn.cold.8+0x117/0x1ba kernel/panic.c:530
[  141.054506]  ? get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
[  141.054506]  ? fixup_call_args kernel/bpf/verifier.c:5587 [inline]
[  141.054506]  ? bpf_check+0x525e/0x5e60 kernel/bpf/verifier.c:5952
[  141.055163]  __warn.cold.8+0x163/0x1ba kernel/panic.c:538
[  141.055820]  ? get_callee_stack_depth kernel/bpf/verifier.c:1612 [inline]
[  141.055820]  ? fixup_call_args kernel/bpf/verifier.c:5587 [inline]
[  141.055820]  ? bpf_check+0x525e/0x5e60 kernel/bpf/verifier.c:5952
[  141.056478]  report_bug+0x252/0x2d0 lib/bug.c:186
[  141.057106]  fixup_bug arch/x86/kernel/traps.c:178 [inline]
[  141.057106]  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
[  141.057764]  ? graph_lock+0x170/0x170 arch/x86/include/asm/paravirt.h:674
[  141.058402]  ? math_error+0x3e0/0x3e0 arch/x86/kernel/traps.c:844
[  141.059058]  ? vprintk_default+0x28/0x30 kernel/printk/printk.c:1991
[  141.059748]  ? vprintk_func+0x81/0xe7 kernel/printk/printk_safe.c:383
[  141.060395]  ? printk+0xa7/0xcf kernel/printk/printk.c:2024
[  141.060975]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  141.061800]  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
[  141.062434]  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
[  141.063026] RIP: 0010:get_callee_stack_depth
kernel/bpf/verifier.c:1612 [inline]
[  141.063026] RIP: 0010:fixup_call_args kernel/bpf/verifier.c:5587 [inline]
[  141.063026] RIP: 0010:bpf_check+0x525e/0x5e60 kernel/bpf/verifier.c:5952
[  141.063795] Code: ff 48 89 df e8 a3 0e 2e 00 e9 7a f2 ff ff e8 b9
30 f0 ff 8b 74 24 58 48 c7 c7 a0 6b b0 87 c6 05 db c9 f3 07 01 e8 a2
41 bb ff <0f> 0b 48 8b 54 24 08 b8 ff ff 37 00 48 c1 e0 2a 48 c1 ea 03
0f b6
[  141.067166] RSP: 0018:ffff880067b5f980 EFLAGS: 00010286
[  141.068060] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  141.069281] RDX: 0000000000000000 RSI: ffffffff81633d81 RDI: 0000000000000001
[  141.070478] RBP: ffff880067b5fb30 R08: ffff880062faa340 R09: ffffed000d8f4fc0
[  141.071687] R10: ffffed000d8f4fc0 R11: ffff88006c7a7e07 R12: dffffc0000000000
[  141.072912] R13: ffffc90000b68040 R14: 00000000fffffffe R15: ffff8800602e2280
[  141.074135]  ? vprintk_func+0x81/0xe7 kernel/printk/printk_safe.c:383
[  141.074745]  ? pvclock_read_flags+0x160/0x160
arch/x86/include/asm/pvclock.h:35
[  141.075466]  ? fixup_bpf_calls+0x1fb0/0x1fb0 kernel/bpf/verifier.c:5677
[  141.076167]  ? ktime_get_with_offset+0x32e/0x4b0
kernel/time/timekeeping.c:788
[  141.076928]  ? ktime_get+0x440/0x440 kernel/time/timekeeping.c:751
[  141.077531]  ? memset+0x31/0x40 mm/kasan/kasan.c:287
[  141.078063]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 kernel/kcov.c:174
[  141.078945]  ? bpf_obj_name_cpy+0x17c/0x1c0 kernel/bpf/syscall.c:427
[  141.079695]  bpf_prog_load+0x1141/0x1c90 kernel/bpf/syscall.c:1352
[  141.080358]  ? bpf_prog_new_fd+0x60/0x60 kernel/bpf/syscall.c:1099
[  141.081018]  ? lock_downgrade+0x8f0/0x8f0 kernel/locking/lockdep.c:3658
[  141.081688]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20 kernel/kcov.c:195
[  141.082576]  __do_sys_bpf kernel/bpf/syscall.c:2305 [inline]
[  141.082576]  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
[  141.082576]  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2267
[  141.083217]  ? bpf_prog_get+0x20/0x20 kernel/bpf/syscall.c:1197
[  141.083829]  ? do_syscall_64+0x9a/0x820 arch/x86/entry/common.c:277
[  141.084466]  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
[  141.085125]  ? syscall_return_slowpath+0x5e0/0x5e0
arch/x86/entry/common.c:255
[  141.085945]  ? prepare_exit_to_usermode arch/x86/entry/common.c:211 [inline]
[  141.085945]  ? syscall_return_slowpath+0x31d/0x5e0
arch/x86/entry/common.c:268
[  141.086764]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  141.087653]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  141.088462]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  141.089331] RIP: 0033:0x44a949
[  141.089858] Code: e8 2c aa 01 00 48 83 c4 18 c3 0f 1f 80 00 00 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 0c fc ff c3 66 2e 0f 1f 84 00 00
00 00
[  141.093216] RSP: 002b:00007fe7874b0d88 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[  141.094510] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000044a949
[  141.095712] RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
[  141.096924] RBP: 00007fe7874b0da0 R08: 0000000000000002 R09: 0000000000000000
[  141.098124] R10: 0000000000000001 R11: 0000000000000206 R12: 0000000000000000
[  141.099314] R13: 00007ffe20cc628f R14: 00007fe7874b1700 R15: 0000000000000000
[  141.100989] Kernel Offset: disabled
[  141.101637] Rebooting in 86400 seconds..




// autogenerated by syzkaller (http://github.com/google/syzkaller)
#define _GNU_SOURCE
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

__attribute__((noreturn)) static void doexit(int status)
{
  volatile unsigned i;
  syscall(__NR_exit_group, status);
  for (i = 0;; i++) {
  }
}
#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

const int kFailStatus = 67;
const int kRetryStatus = 69;

static void exitf(const char* msg, ...)
{
  int e = errno;
  va_list args;
  va_start(args, msg);
  vfprintf(stderr, msg, args);
  va_end(args);
  fprintf(stderr, " (errno %d)\n", e);
  doexit(kRetryStatus);
}

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);

  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static int inject_fault(int nth)
{
  int fd;
  char buf[16];

  fd = open("/proc/thread-self/fail-nth", O_RDWR);
  if (fd == -1)
    exitf("failed to open /proc/thread-self/fail-nth");
  sprintf(buf, "%d", nth + 1);
  if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
    exitf("failed to write /proc/thread-self/fail-nth");
  return fd;
}

struct thread_t {
  int created, running, call;
  pthread_t th;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    while (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE))
      syscall(SYS_futex, &th->running, FUTEX_WAIT, 0, 0);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    __atomic_store_n(&th->running, 0, __ATOMIC_RELEASE);
    syscall(SYS_futex, &th->running, FUTEX_WAKE);
  }
  return 0;
}

static void execute(int num_calls)
{
  int call, thread;
  running = 0;
  for (call = 0; call < num_calls; call++) {
    for (thread = 0; thread < sizeof(threads) / sizeof(threads[0]); thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        pthread_attr_t attr;
        pthread_attr_init(&attr);
        pthread_attr_setstacksize(&attr, 128 << 10);
        pthread_create(&th->th, &attr, thr, th);
      }
      if (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE)) {
        th->call = call;
        __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
        __atomic_store_n(&th->running, 1, __ATOMIC_RELEASE);
        syscall(SYS_futex, &th->running, FUTEX_WAKE);
        struct timespec ts;
        ts.tv_sec = 0;
        ts.tv_nsec = 20 * 1000 * 1000;
        syscall(SYS_futex, &th->running, FUTEX_WAIT, 1, &ts);
        if (__atomic_load_n(&running, __ATOMIC_RELAXED))
          usleep((call == num_calls - 1) ? 10000 : 1000);
        break;
      }
    }
  }
}

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

void execute_call(int call)
{
  switch (call) {
  case 0:
    *(uint32_t*)0x20000000 = 1;
    *(uint32_t*)0x20000004 = 0xa;
    *(uint64_t*)0x20000008 = 0x20001000;
    memcpy((void*)0x20001000,
           "\xbf\x16\x00\x00\x00\x00\x00\x00\x85\x10\x00\x00\x05\x00\x00\x00"
           "\x54\x00\x00\x00\x00\x00\x00\x00\xbf\x61\x00\x00\x00\x00\x00\x00"
           "\x85\x10\x00\x00\x02\x00\x00\x00\xbf\x01\x00\x00\x00\x00\x00\x00"
           "\x95\x00\x00\x00\x00\x00\x00\x00\x15\x01\x00\x00\x00\x00\x00\x00"
           "\xb7\x00\x00\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00",
           80);
    *(uint64_t*)0x20000010 = 0x20000100;
    memcpy((void*)0x20000100, "GPL", 4);
    *(uint32_t*)0x20000018 = 0;
    *(uint32_t*)0x2000001c = 0;
    *(uint64_t*)0x20000020 = 0;
    *(uint32_t*)0x20000028 = 0;
    *(uint32_t*)0x2000002c = 0;
    *(uint8_t*)0x20000030 = 0;
    *(uint8_t*)0x20000031 = 0;
    *(uint8_t*)0x20000032 = 0;
    *(uint8_t*)0x20000033 = 0;
    *(uint8_t*)0x20000034 = 0;
    *(uint8_t*)0x20000035 = 0;
    *(uint8_t*)0x20000036 = 0;
    *(uint8_t*)0x20000037 = 0;
    *(uint8_t*)0x20000038 = 0;
    *(uint8_t*)0x20000039 = 0;
    *(uint8_t*)0x2000003a = 0;
    *(uint8_t*)0x2000003b = 0;
    *(uint8_t*)0x2000003c = 0;
    *(uint8_t*)0x2000003d = 0;
    *(uint8_t*)0x2000003e = 0;
    *(uint8_t*)0x2000003f = 0;
    *(uint32_t*)0x20000040 = 0;
    *(uint32_t*)0x20000044 = 0;
    write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
    write_file("/sys/kernel/debug/fail_futex/ignore-private", "N");
    inject_fault(55);
    syscall(__NR_bpf, 5, 0x20000000, 0x48);
    break;
  }
}

void loop()
{
  execute(1);
}

int main()
{
  write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
  write_file("/sys/kernel/debug/fail_futex/ignore-private", "N");
  inject_fault(55);
  syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
  loop();
  return 0;
}
