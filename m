Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F53C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78BF206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PC2yyUuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfANR1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:27:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50755 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfANR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:27:22 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so630204iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DoYw0w8ve4rpqMRphATL6nR9254ircnnCJuCR3+Ms4g=;
        b=PC2yyUuZgzH5Ok8lT3n3T62mUZ+ZCj5nISuhTiuTnMtPT1aMEAb6QH+Klh89KFmxiS
         wF7a4c0bVc+rxVnMKTeykUyKzIacfkoJrJyUEL7bs+u5lNSO+drxDegPqzG6G+mQScNl
         CNIMlBOL1TYXXEvx7RN2B/FS0IMJslxwZ0EV2Or5oqhrfn865VSvSobmDck5bK12jvky
         /NKNU+u4g7WRWYXWb0nUGsKXlaGuPGcYKah0kzoRdcFM0XKbhpGUqkbxWCZkJ1UA5mB0
         Zk9i4goqzzXNyVLQAzPULG4zAEh4ojVlJjxLrRqcEUlNDHV5vdWt87H1NWWP7tSBmUW+
         yl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DoYw0w8ve4rpqMRphATL6nR9254ircnnCJuCR3+Ms4g=;
        b=GMguCy5JxehOeIod9Z+Z/OMSykhjSWtB61AqLVYeAsPmLpCaxPzEXU1cpwuv0Kl4Z0
         R1P5wpm2zL1igoFK1a4z4QvfKJr2MGXBpKBvWD1EVAjs8xTv2Lxp8/gcArrszM4mg1RH
         AisnpOzBet/fGidNUPGJMZfP7bm7vo6qOUHdCXXDeaYdQ+2rPxyTjOC9gtVYKNdhRrin
         I+f6eSsfNb7zg52m2Z5+Fy098kMJlMTlglFzyOpP+PrMh1WSssovkgPgjGvjR3YuZ+ew
         BCTtjCdX9vvrgceZBGrg/FIx5pzTKTOtM1WXJXWuBk238KbzPEk0D62jcYIqZ6+D9C01
         oP0A==
X-Gm-Message-State: AJcUukfNm0tCFtT/sGak7WU/6nof+ZkF/gCN6lLb6wDf+3oPECjOUFr9
        LhC+i6i9gnQiu8HobL4wcCSV9dWVYeLEyf2MZ8pGKA==
X-Google-Smtp-Source: ALg8bN7T/F10RnZlXImJGMX0HwAGwHkLPg2TcDuuEa1fL6a5ZsoDG6a5jVqDBAPrX32/Djj8pMMxUHmE5SO/xalRAWU=
X-Received: by 2002:a02:8904:: with SMTP id o4mr17668936jaj.35.1547486841154;
 Mon, 14 Jan 2019 09:27:21 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002a3bfb057f6e4c96@google.com>
In-Reply-To: <0000000000002a3bfb057f6e4c96@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 18:27:10 +0100
Message-ID: <CACT4Y+YioGPyPokfHvtjOw4ZVPfj=X4tKVfucN_rUivv41Rs1g@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in swake_up_one
To:     syzbot <syzbot+af057431e1ebbdadd4d1@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 6:23 PM syzbot
<syzbot+af057431e1ebbdadd4d1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    de6629eb262e Merge tag 'pci-v5.0-fixes-1' of git://git.ke=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10dd2fab40000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dedf1c3031097c=
304
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Daf057431e1ebbda=
dd4d1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10bd0237400=
000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+af057431e1ebbdadd4d1@syzkaller.appspotmail.com

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2

> IPv6: ADDRCONF(NETDEV_UP): hsr0: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> 8021q: adding VLAN 0 to HW filter on device batadv0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: stack-out-of-bounds in swake_up_locked kernel/sched/swait.c:3=
0
> [inline]
> BUG: KASAN: stack-out-of-bounds in swake_up_locked kernel/sched/swait.c:2=
2
> [inline]
> BUG: KASAN: stack-out-of-bounds in swake_up_one+0x2bf/0x3c0
> kernel/sched/swait.c:40
> kasan: CONFIG_KASAN_INLINE enabled
> Read of size 8 at addr ffff8880a9487a88 by task syz-executor5/8368
> kasan: GPF could be caused by NULL-ptr deref or user memory access
>
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8368 Comm: syz-executor5 Not tainted 5.0.0-rc1+ #20
> CPU: 1 PID: 64 Comm: ksoftirq=EF=BF=BD=EF=BF=BD1 Not tainted 5.0.0-rc1+ #=
20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
> RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
> RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 8=
4
> d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00
> 0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
> RSP: 0018:ffff8880ae707b80 EFLAGS: 00010003
> RAX: 1ffffffff16d60bc RBX: 0000000000000004 RCX: ffff8880ae726620
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> RDX: 000000000000019d RSI: 0000000000000004 RDI: 0000000000000ced
> RBP: ffff8880ae707c70 R08: 1ffff11015ce0f5c R09: ffffffff899b13e0
> R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000cd5
> R13: dffffc0000000000 R14: 1ffff11015ce0f74 R15: ffffffff8b6b05e8
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 0000000096ff7000 CR4: 00000000001406e0
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   swake_up_locked kernel/sched/swait.c:30 [inline]
>   swake_up_locked kernel/sched/swait.c:22 [inline]
>   swake_up_one+0x2bf/0x3c0 kernel/sched/swait.c:40
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   rcu_gp_kthread_wake+0xc3/0x100 kernel/rcu/tree.c:1571
>   debug_hrtimer_deactivate kernel/time/hrtimer.c:412 [inline]
>   debug_deactivate kernel/time/hrtimer.c:462 [inline]
>   __run_hrtimer kernel/time/hrtimer.c:1359 [inline]
>   __hrtimer_run_queues+0x225/0x1050 kernel/time/hrtimer.c:1451
>   rcu_report_qs_rsp+0x177/0x220 kernel/rcu/tree.c:2131
>   rcu_report_unblock_qs_rnp kernel/rcu/tree.c:2235 [inline]
>   rcu_preempt_deferred_qs_irqrestore+0xc03/0xfd0 kernel/rcu/tree_plugin.h=
:574
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>   rcu_read_unlock_special+0x1cd/0x380 kernel/rcu/tree_plugin.h:665
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   __rcu_read_unlock+0x204/0x210 kernel/rcu/tree_plugin.h:437
>   </IRQ>
> Modules linked in:
> ---[ end trace d4ad3f10efc73e81 ]---
> RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
> RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
> RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
>   rcu_read_unlock include/linux/rcupdate.h:660 [inline]
>   is_bpf_text_address+0xb6/0x170 kernel/bpf/core.c:668
> Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 8=
4
> d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00
> 0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
>   kernel_text_address+0x73/0xf0 kernel/extable.c:152
> RSP: 0018:ffff8880ae707b80 EFLAGS: 00010003
>   __kernel_text_address+0xd/0x40 kernel/extable.c:107
> RAX: 1ffffffff16d60bc RBX: 0000000000000004 RCX: ffff8880ae726620
>   unwind_get_return_address arch/x86/kernel/unwind_frame.c:18 [inline]
>   unwind_get_return_address+0x61/0xa0 arch/x86/kernel/unwind_frame.c:13
> RDX: 000000000000019d RSI: 0000000000000004 RDI: 0000000000000ced
>   __save_stack_trace+0x8a/0xf0 arch/x86/kernel/stacktrace.c:45
> RBP: ffff8880ae707c70 R08: 1ffff11015ce0f5c R09: ffffffff899b13e0
>   save_stack_trace+0x1a/0x20 arch/x86/kernel/stacktrace.c:60
> R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000cd5
> R13: dffffc0000000000 R14: 1ffff11015ce0f74 R15: ffffffff8b6b05e8
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 0000000096ff7000 CR4: 00000000001406e0
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
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/0000000000002a3bfb057f6e4c96%40google.com.
> For more options, visit https://groups.google.com/d/optout.
