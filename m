Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF612082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LwIUcaii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF612082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeKZJ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:59:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vXMn6YtPbbtUC2hy7XfNUeYbDeYuGr+SULaQwOPlYk8=; b=LwIUcaiik58kVu5xQTxgG67Nuy
        rV4HZTNT5j5bpQEr1eftja2f1m7ta9nudhgM6eYY1rLBWhINnQGYV09GYNKnVbQtiQKDXe9O5IzA9
        sSx4TaQBFJ4tBTOclRWu8cTSLbSF1H1IedNpqObtVoHFKIPFxfsegT9HqV+jsw7VsR6yJVWPraPzS
        tW0tLJVJi65vNkd191zn3kmNxQdqQdK4KpNAyNCIAFU17k1ErunEHZvU1lcoi4dgkbjvPc+pgaWY2
        lCzT4sL+tOPHBzOgWvVLQHOUCEJZ07TfLJRMljfMN+rr6c5atw+bIhSJ63fX0/Mq67RTsE2lO0W5a
        LBrv0rDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gR3Uy-0000e5-8f; Sun, 25 Nov 2018 23:07:32 +0000
Date:   Sun, 25 Nov 2018 15:07:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com>
Cc:     crecklin@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: WARNING: bad usercopy in corrupted (2)
Message-ID: <20181125230732.GE3065@bombadil.infradead.org>
References: <000000000000f7cb53057b7ee3cb@google.com>
 <20181125212708.GD3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181125212708.GD3065@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 01:27:09PM -0800, Matthew Wilcox wrote:
> On Sun, Nov 25, 2018 at 07:30:04AM -0800, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following crash on:
> >=20
> > HEAD commit:    aea0a897af9e ptp: Fix pass zero to ERR_PTR() in ptp_clo=
ck_..
> > git tree:       net-next
>=20
> If you found it on net-next, I'd suggets cc'ing linux-net ...

Uh.  I meant netdev.  Oops.

> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D101b91d5400=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36a72af212=
3e78a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd89b30c46434c=
433dbf8
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D170f6a474=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12e1df7b400=
000
> >=20
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+d89b30c46434c433dbf8@syzkaller.appspotmail.com
> >=20
> > ------------[ cut here ]------------
> > DEBUG_LOCKS_WARN_ON(!hlock->nest_lock)
> > ------------[ cut here ]------------
> > Bad or missing usercopy whitelist? Kernel memory overwrite attempt dete=
cted
> > to SLAB object 'task_struct' (offset 1432, size 2)!
> > WARNING: CPU: 1 PID: 38 at mm/usercopy.c:83 usercopy_warn+0xee/0x110
> > mm/usercopy.c:78
> > Kernel panic - not syncing: panic_on_warn set ...
> > list_add corruption. next->prev should be prev (ffff8881daf2d798), but =
was
> > 0b7e0c8e49cc0400. (next=3Dffff8881d9b4a4f0).
> > CPU: 1 PID: 38 Comm: =EF=BF=BD=EF=BF=BD=EF=BF=BD=D9=81=EF=BF=BD=EF=BF=
=BD=EF=BF=BDd=0B=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD Not =
tainted 4.20.0-rc3+ #312
> > ------------[ cut here ]------------
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > kernel BUG at lib/list_debug.c:25!
> > ------------[ cut here ]------------
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > kernel BUG at mm/slab.c:4425!
> > CPU: 0 PID: 8652 Comm: syz-executor607 Not tainted 4.20.0-rc3+ #312
> > WARNING: CPU: 1 PID: 38 at kernel/rcu/tree_plugin.h:438
> > __rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Modules linked in:
> > RIP: 0010:__list_add_valid.cold.2+0xf/0x2a lib/list_debug.c:23
> > CPU: 1 PID: 38 Comm: =EF=BF=BD=EF=BF=BD=EF=BF=BD=D9=81=EF=BF=BD=EF=BF=
=BD=EF=BF=BDd=0B=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD Not =
tainted 4.20.0-rc3+ #312
> > Code: d1 60 88 e8 a1 37 d2 fd 0f 0b 48 89 de 48 c7 c7 60 d1 60 88 e8 90=
 37
> > d2 fd 0f 0b 48 89 d9 48 c7 c7 20 d2 60 88 e8 7f 37 d2 fd <0f> 0b 48 89 =
f1 48
> > c7 c7 a0 d2 60 88 48 89 de e8 6b 37 d2 fd 0f 0b
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RSP: 0000:ffff8881dae07588 EFLAGS: 00010082
> > usercopy: Kernel memory overwrite attempt detected to SLAB object
> > 'signal_cache' (offset 1328, size 23)!
> > RAX: 0000000000000075 RBX: ffff8881d9b4a4f0 RCX: 0000000000000000
> > ------------[ cut here ]------------
> > RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
> > kernel BUG at mm/usercopy.c:102!
> > RBP: ffff8881dae075a0 R08: ffff8881d25ce100 R09: ffffed103b5c5020
> > R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881bd890230
> > R13: dffffc0000000000 R14: ffff8881dae07980 R15: ffff8881daf2d798
> > FS:  000000000083c880(0000) GS:ffff8881dae00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fff14476600 CR3: 00000001d2a59000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <IRQ>
> >  __list_add include/linux/list.h:60 [inline]
> >  list_add include/linux/list.h:79 [inline]
> >  list_move include/linux/list.h:171 [inline]
> >  detach_tasks kernel/sched/fair.c:7298 [inline]
> >  load_balance+0x1b8d/0x39a0 kernel/sched/fair.c:8731
> >  rebalance_domains+0x845/0xdc0 kernel/sched/fair.c:9109
> >  run_rebalance_domains+0x38d/0x500 kernel/sched/fair.c:9731
> >  __do_softirq+0x308/0xb7e kernel/softirq.c:292
> >  invoke_softirq kernel/softirq.c:373 [inline]
> >  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
> >  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
> >  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1061
> >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
> >  </IRQ>
> > RIP: 0033:0x4005dd
> > Code: c9 00 04 00 66 0f 1f 84 00 00 00 00 00 48 8b 05 f1 2e 2d 00 48 85=
 c0
> > 74 11 bf 3c e8 4b 00 b9 0e 00 00 00 48 89 c6 f3 a6 75 01 <c3> 48 89 c7 =
e9 9a
> > ec 01 00 66 2e 0f 1f 84 00 00 00 00 00 8b 05 4a
> > RSP: 002b:00007fff144765a8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> > RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00000000006d2190
> > RDX: 0000000000402410 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00000000006cc0a8 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
> > Modules linked in:
> > ---[ end trace eeb5734c13709e17 ]---
> > invalid opcode: 0000 [#2] PREEMPT SMP KASAN
> > CPU: 1 PID: 38 Comm: =EF=BF=BD=EF=BF=BD=EF=BF=BD=D9=81=EF=BF=BD=EF=BF=
=BD=EF=BF=BDd=0B=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD Tain=
ted: G      D           4.20.0-rc3+
> > #312
> > RIP: 0010:__list_add_valid.cold.2+0xf/0x2a lib/list_debug.c:23
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Code: d1 60 88 e8 a1 37 d2 fd 0f 0b 48 89 de 48 c7 c7 60 d1 60 88 e8 90=
 37
> > d2 fd 0f 0b 48 89 d9 48 c7 c7 20 d2 60 88 e8 7f 37 d2 fd <0f> 0b 48 89 =
f1 48
> > c7 c7 a0 d2 60 88 48 89 de e8 6b 37 d2 fd 0f 0b
> > RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:90
> > RSP: 0000:ffff8881dae07588 EFLAGS: 00010082
> > Code: c0 e8 f7 dc b1 ff 48 8b 55 c0 49 89 d9 4d 89 f0 ff 75 c8 4c 89 e1=
 4c
> > 89 ee 48 c7 c7 80 d5 34 88 ff 75 d0 41 57 e8 e7 28 98 ff <0f> 0b e8 cc =
dc b1
> > ff e8 97 13 f5 ff 8b 95 e4 fe ff ff 4c 89 e1 31
> > RAX: 0000000000000075 RBX: ffff8881d9b4a4f0 RCX: 0000000000000000
> > RSP: 0018:ffff8881d9b49438 EFLAGS: 00010086
> > RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
> > RAX: 0000000000000068 RBX: ffffffff88291020 RCX: 0000000000000000
> > RBP: ffff8881dae075a0 R08: ffff8881d25ce100 R09: ffffed103b5c5020
> > RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
> > R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881bd890230
> > RBP: ffff8881d9b49490 R08: ffff8881d9b4a440 R09: ffffed103b5e3ef8
> > R13: dffffc0000000000 R14: ffff8881dae07980 R15: ffff8881daf2d798
> > R10: ffffed103b5e3ef8 R11: ffff8881daf1f7c7 R12: ffffffff8914da1d
> > FS:  000000000083c880(0000) GS:ffff8881dae00000(0000) knlGS:00000000000=
00000
> > R13: ffffffff8834d3e0 R14: ffffffff8834d320 R15: ffffffff8834d2e0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:00000000000=
00000
> > CR2: 00007fff14476600 CR3: 00000001d2a59000 CR4: 00000000001406f0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > CR2: 0000000000000130 CR3: 00000001d7880000 CR4: 00000000001406e0
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> > Modules linked in:
> > ---[ end trace eeb5734c13709e18 ]---
> > RIP: 0010:__list_add_valid.cold.2+0xf/0x2a lib/list_debug.c:23
> > Code: d1 60 88 e8 a1 37 d2 fd 0f 0b 48 89 de 48 c7 c7 60 d1 60 88 e8 90=
 37
> > d2 fd 0f 0b 48 89 d9 48 c7 c7 20 d2 60 88 e8 7f 37 d2 fd <0f> 0b 48 89 =
f1 48
> > c7 c7 a0 d2 60 88 48 89 de e8 6b 37 d2 fd 0f 0b
> > RSP: 0000:ffff8881dae07588 EFLAGS: 00010082
> > RAX: 0000000000000075 RBX: ffff8881d9b4a4f0 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
> > RBP: ffff8881dae075a0 R08: ffff8881d25ce100 R09: ffffed103b5c5020
> > R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: ffff8881bd890230
> > R13: dffffc0000000000 R14: ffff8881dae07980 R15: ffff8881daf2d798
> > FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000130 CR3: 00000001d7880000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >=20
> >=20
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>=20
