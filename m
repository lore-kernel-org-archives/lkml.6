Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26CC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diNKwHVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26CC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeLLLFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:05:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39246 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeLLLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:05:30 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so9117058itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIph2iTLROWYHFivZySwQC1FbQehxKg4nuCV9H7DavU=;
        b=diNKwHVoaGj+tszOtOXvUSnn6fwZlzWIF4FxAXOXKgo/z0x/rCbLhSrBmL4LtuycXh
         L5OhHQwEZlGyqv2M/Bgw++TjnA60jjq05pC2GOUWInd4yzSvl5Xwv65XE2VTN41oPlAB
         eZ66k1DPu8DiN0xMiQlGKW8lo8tgGpVoWuvHCj/FoVxQT6MW2EaOXYQebKjpRzvWZQJx
         fcsHRDof3tUTBc13D/uVhaFAueSPDf5PdObq63woHcNLkvzN+UhA/bWWESXvLTgvYnUx
         dCwqxjaY0VnKvyd69YPvfZE2fzjN2+bZRe3BwpSapwBIVZQPiBWUTvCol0WOb/7BAfYw
         bbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIph2iTLROWYHFivZySwQC1FbQehxKg4nuCV9H7DavU=;
        b=go6u7K5gtEc06SRjl5wX9Dp59aFEH1QRheHV4ImuLlSkx9xdEUDs6T+4mnv/78W3/T
         kh6QQoZyQQjas9aPc4qLrDb5Lko+zejnPInm+NbMbWi4915txU4ualsmLzGQu71Zw77O
         kjvb12PEGtUAvfHoi3B6LGWAafxavj04D6XfXr649osxe03tqMmWhwh+1iPkuINVnQTV
         aqABspLXvyIgqWXo+pEIWe09gA2jBfzblJ8QfjBCvbU5zxdbxONydV4iga4eD62Gjlet
         umJSrFq3GDZfHXKSB9SOcMcjBG3iBt7m5q/1Pi97AuzGmiIHSP40CMUwegsOYp1r/Azy
         m99g==
X-Gm-Message-State: AA+aEWb/WXiOM0A1YuJUcyB+fnClNYCNRpaj+rHNK6z4S/C+4xFlWlHI
        lsvoCn5VWBHuhdKTIwRDu1Z26TxObNY4u+fGtjNLkw==
X-Google-Smtp-Source: AFSGD/Xod639PbwjHLTLw2/WTO5XMvACXKb2qEGfANge6Fg7xgb7kusqoYt2/emN/jRxy2PDw9V12AScyMIgUbbPcTc=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr4840086itl.144.1544612729044;
 Wed, 12 Dec 2018 03:05:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e0642f057cd10e42@google.com> <CACT4Y+azUL69yb4K8hbbyGmn7zap+gDpdnfgc4Pce4-SDvSBWA@mail.gmail.com>
In-Reply-To: <CACT4Y+azUL69yb4K8hbbyGmn7zap+gDpdnfgc4Pce4-SDvSBWA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Dec 2018 12:05:17 +0100
Message-ID: <CACT4Y+Y7C=b6cdViUSdX6q=F+YN4BPqBZfAVoJ0Ckdvr0KCD4w@mail.gmail.com>
Subject: Re: general protection fault in __bfs
To:     syzbot+9af93090b1662f253d62@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, konrad.wilk@oracle.com,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:02 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Dec 12, 2018 at 11:57 AM syzbot
> <syzbot+9af93090b1662f253d62@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1657b01b400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9af93090b1662f253d62
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > userspace arch: i386
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118448cd400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f32705400000
>
> From the reproducer it looks like a dup of TIPC bug:
>
> #syz dup: KASAN: use-after-free Read in kfree_skb (2)

A good question is how this skb double-free gets past KASAN and
silently corrupts memory? Does it just exploit the narrow race between
KASAN check and actual memory write or there is something more
fundamental?...


> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+9af93090b1662f253d62@syzkaller.appspotmail.com
> >
> > Enabling of bearer <udp:syz1> rejected, already enabled
> > Enabling of bearer <udp:syz1> rejected, already enabled
> > Enabling of bearer <udp:syz1> rejected, already enabled
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 9250 Comm: syz-executor424 Not tainted 4.20.0-rc6+ #274
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:lock_accessed kernel/locking/lockdep.c:964 [inline]
> > RIP: 0010:__bfs+0x3d9/0x780 kernel/locking/lockdep.c:1032
> > Code: 7c 24 c0 41 c6 45 00 f8 74 7c 49 8d 7f 10 4c 89 fe 4c 8b 0d 89 8a aa
> > 09 48 89 f8 48 81 ee 20 55 eb 8a 48 c1 e8 03 48 c1 fe 06 <42> 80 3c 30 00
> > 0f 85 d4 01 00 00 4d 8b 47 10 49 8d 40 2c 48 89 c7
> > RSP: 0018:ffff8881dae06c88 EFLAGS: 00010003
> > RAX: 0000000000000002 RBX: ffffffff8ae100d0 RCX: 1ffff1103b5c0db1
> > RDX: 1ffffffff15c201a RSI: 0000000001d452ab RDI: 0000000000000010
> > RBP: ffff8881dae06df0 R08: 0000000000000001 R09: 0000000000001b46
> > R10: ffffed103b5c5b5f R11: ffff8881c3dba240 R12: ffff8881dae06dc8
> > R13: ffffed103b5c0db1 R14: dffffc0000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8881dae00000(0063) knlGS:0000000009355840
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 0000000008100000 CR3: 00000001c34e9000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <IRQ>
> >   __bfs_forwards kernel/locking/lockdep.c:1060 [inline]
> >   find_usage_forwards kernel/locking/lockdep.c:1360 [inline]
> >   check_usage_forwards+0x163/0x3d0 kernel/locking/lockdep.c:2572
> >   mark_lock_irq kernel/locking/lockdep.c:2687 [inline]
> >   mark_lock+0x9b5/0x1cd0 kernel/locking/lockdep.c:3059
> >   mark_irqflags kernel/locking/lockdep.c:2937 [inline]
> >   __lock_acquire+0x155f/0x4c20 kernel/locking/lockdep.c:3298
> >   lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
> >   spin_lock include/linux/spinlock.h:329 [inline]
> >   __queue_work+0xc1b/0x1440 kernel/workqueue.c:1414
> >   delayed_work_timer_fn+0x5d/0x90 kernel/workqueue.c:1500
> >   call_timer_fn+0x272/0x920 kernel/time/timer.c:1326
> >   expire_timers kernel/time/timer.c:1359 [inline]
> >   __run_timers+0x723/0xc70 kernel/time/timer.c:1682
> >   run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1695
> >   __do_softirq+0x308/0xb7e kernel/softirq.c:292
> >   invoke_softirq kernel/softirq.c:373 [inline]
> >   irq_exit+0x17f/0x1c0 kernel/softirq.c:413
> >   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
> >   smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
> >   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
> >   </IRQ>
> > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:761
> > [inline]
> > RIP: 0010:console_unlock+0xf41/0x1190 kernel/printk/printk.c:2422
> > Code: 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 54 02 00 00 48 83 3d 9f 84
> > ec 07 00 74 72 e8 18 08 1a 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00
> > e9 f3 f2 ff ff e8 00 08 1a 00 0f 0b e8 f9 07 1a 00
> > RSP: 0018:ffff8881d9246d08 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> > RAX: ffff8881c3dba240 RBX: 0000000000000200 RCX: 1ffff110387b756b
> > RDX: 0000000000000000 RSI: ffffffff81657c58 RDI: 0000000000000293
> > RBP: ffff8881d9246e78 R08: ffff8881c3dbab58 R09: 0000000000000006
> > R10: 0000000000000000 R11: ffff8881c3dba240 R12: 0000000000000000
> > R13: ffffffff849c4410 R14: dffffc0000000000 R15: ffffffff89b639d0
> >   vprintk_emit+0x391/0x990 kernel/printk/printk.c:1922
> >   vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
> >   vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
> >   printk+0xa7/0xcf kernel/printk/printk.c:1997
> >   tipc_enable_bearer+0x4ad/0xf10 net/tipc/bearer.c:338
> >   __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:897
> >   tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:905
> >   genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
> >   genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
> >   netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2477
> >   genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
> >   netlink_unicast+0x5a5/0x760 net/netlink/af_netlink.c:1336
> >   netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
> >   sock_sendmsg_nosec net/socket.c:621 [inline]
> >   sock_sendmsg+0xd5/0x120 net/socket.c:631
> >   ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
> >   __sys_sendmsg+0x11d/0x280 net/socket.c:2154
> >   __compat_sys_sendmsg net/compat.c:754 [inline]
> >   __do_compat_sys_sendmsg net/compat.c:761 [inline]
> >   __se_compat_sys_sendmsg net/compat.c:758 [inline]
> >   __ia32_compat_sys_sendmsg+0x7a/0xb0 net/compat.c:758
> >   do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
> >   do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
> >   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> > RIP: 0023:0xf7f0fa29
> > Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> > 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90
> > 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> > RSP: 002b:000000000820fd6c EFLAGS: 00000213 ORIG_RAX: 0000000000000172
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020001e40
> > RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000122
> > RBP: 0000000000010b54 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > Modules linked in:
> > ---[ end trace fc7927d741510429 ]---
> > RIP: 0010:lock_accessed kernel/locking/lockdep.c:964 [inline]
> > RIP: 0010:__bfs+0x3d9/0x780 kernel/locking/lockdep.c:1032
> > Code: 7c 24 c0 41 c6 45 00 f8 74 7c 49 8d 7f 10 4c 89 fe 4c 8b 0d 89 8a aa
> > 09 48 89 f8 48 81 ee 20 55 eb 8a 48 c1 e8 03 48 c1 fe 06 <42> 80 3c 30 00
> > 0f 85 d4 01 00 00 4d 8b 47 10 49 8d 40 2c 48 89 c7
> > RSP: 0018:ffff8881dae06c88 EFLAGS: 00010003
> > RAX: 0000000000000002 RBX: ffffffff8ae100d0 RCX: 1ffff1103b5c0db1
> > RDX: 1ffffffff15c201a RSI: 0000000001d452ab RDI: 0000000000000010
> > RBP: ffff8881dae06df0 R08: 0000000000000001 R09: 0000000000001b46
> > R10: ffffed103b5c5b5f R11: ffff8881c3dba240 R12: ffff8881dae06dc8
> > R13: ffffed103b5c0db1 R14: dffffc0000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8881dae00000(0063) knlGS:0000000009355840
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 0000000008100000 CR3: 00000001c34e9000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e0642f057cd10e42%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
