Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB112086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dorU7GEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB112086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeK1CtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:49:04 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36464 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeK1CtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:49:04 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so34652897itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bwm22j+2QRnkEaMqpznfeN3T67moQntFqqbXkU3w4gc=;
        b=dorU7GEeIj6Lwhj3wzCwLQrqN9cupsvUlIdOWOhulw5fv18WLVuJ23ZxdGZYjZIkEm
         2KJAw51HKWbf73T3C79EzFxJCNluKeyhZGL+DeoB3Jbtg6ZINQxUffP72g0XuUWx1Mhn
         3LYpws6CKlu8Uq6P84G14dI+sOPmbRxGe3c/5OG4laYEtIurrA6HP3q9WPNk8uZ0wRB3
         asVNdHGxWbM1iCv0IfMrlMGmv0OQ5JnBtoU+I5ElItJCPI7+weaDM9RklqyqjnvIpFgn
         Knm7PswrF1tAkxcS/wPUEghWIn9F8+u3p/B8bLbEYPeQp26D1hQ48axpb4F2SVY2WkOx
         sf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bwm22j+2QRnkEaMqpznfeN3T67moQntFqqbXkU3w4gc=;
        b=BVcd60PZ/9FuRlsQoVZrnG9yG+KcDCiN5FnrtcH7kr3O30SPK3OD0wLjU22pUQ5ocg
         kOQKLZfJOr121QBG/Tax6JdwwB1mSHDuLtY337fHO2SsfhGojDBIt1AZ9U2kiuiNW0w5
         yYfZSOCsTk4iuHmo/k4eR0pAR9mB1ANH77gmw7497r7+pZA75Ot08BYyDXhRn5t2ck4I
         jIhRZmMXPScrBF5a/x5ZWPhtau69y2syLNHEVh64nhuNenfzNV9TPx0IMO0tZADfQDcP
         kXeq3CK6w7RwhEs1pZmN3++rJchrxmmo6Urjf0GvHBUNqrhnuXxNSF8J1TeQfvrgan3Y
         7AdA==
X-Gm-Message-State: AGRZ1gIm9LNSxHw1TRwwkzJ5jnUWG4vpbAqFxrn1+zVS36bx38thmR60
        Aqa5Kd20xVpnEc1CsNZY/aKv2AvlfTJUMtMYhdYyHQ==
X-Google-Smtp-Source: AFSGD/VRRKjNtb1rH1Fy9SGgHmZBDaD0FSG5We2gneUmJQLT+ThQA5czHtrTRgP5CjDJxmDFpejXbNkLHzu4NE93lV4=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr25069343itl.144.1543333843448;
 Tue, 27 Nov 2018 07:50:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 07:50:21
 -0800 (PST)
In-Reply-To: <000000000000e10044057ba6fbcf@google.com>
References: <000000000000e10044057ba6fbcf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Nov 2018 16:50:21 +0100
Message-ID: <CACT4Y+bKDG92jaGGGD99UHHxKNtbawynWNxe7rjQqxN6URMFEA@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds in update_curr
To:     syzbot <syzbot+d3bf6aae26942dc9c8dc@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:20 PM, syzbot
<syzbot+d3bf6aae26942dc9c8dc@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    4bffc669d624 net: remove unsafe skb_insert()
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1385db8340000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36a72af2123e=
78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd3bf6aae26942dc=
9c8dc
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D107b426d400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b2e53340000=
0


From reproducer it looks like something network related. So +netdev.
This also happened on net-next and there seems to be several memory-
corruption-looking crashes on net-next.


> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+d3bf6aae26942dc9c8dc@syzkaller.appspotmail.com
>
> DEBUG_LOCKS_WARN_ON(!hlock->nest_lock)
> ------------[ cut here ]------------
> Bad or missing usercopy whitelist? Kernel memory overwrite attempt detect=
ed
> to SLAB object 'task_struct' (offset 1432, size 2)!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ------------[ cut here ]------------
> BUG: KASAN: out-of-bounds in calc_delta_fair kernel/sched/fair.c:630
> [inline]
> BUG: KASAN: out-of-bounds in update_curr+0x9c0/0xbd0 kernel/sched/fair.c:=
824
> kernel BUG at mm/slab.c:4425!
> Read of size 8 at addr ffff8881d9b4a4c0 by task ksoftirqd/0/9
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>
> CPU: 1 PID: 38 Comm: =EF=BF=BD=EF=BF=BD=EF=BF=BD=D9=81=EF=BF=BD=EF=BF=BD=
=EF=BF=BDd =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD Not taint=
ed 4.20.0-rc3+ #314
> CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0-rc3+ #314
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
> Call Trace:
> Code: 48 c7 c7 5d df 14 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 2=
9
> c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7=
 5d
> df 14 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 18 e0
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
> RSP: 0018:ffff8881d9b49ea8 EFLAGS: 00010093
> RAX: 00000000000a57eb RBX: 1ffff1103b3693dc RCX: 000000000000000c
> RDX: ffff8881d9b4a440 RSI: 0000000000000001 RDI: ffff8881d9b4a088
> RBP: ffff8881d9b49ea8 R08: ffff8881d9b4a440 R09: ffff8881da970180
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> R10: 000000004afd68ef R11: 0000000000000000 R12: ffff8881d9b4a088
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> R13: 0000000000000001 R14: ffffea000766d280 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000=
000
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  calc_delta_fair kernel/sched/fair.c:630 [inline]
>  update_curr+0x9c0/0xbd0 kernel/sched/fair.c:824
> CR2: 0000000cffc5fa18 CR3: 00000001bfadf000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> Modules linked in:
> ---[ end trace 04af116ff405efee ]---
> RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
> Code: 48 c7 c7 5d df 14 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 2=
9
> c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7=
 5d
> df 14 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 18 e0
> RSP: 0018:ffff8881d9b49ea8 EFLAGS: 00010093
> RAX: 00000000000a57eb RBX: 1ffff1103b3693dc RCX: 000000000000000c
>  enqueue_entity+0x3f5/0x20a0 kernel/sched/fair.c:3871
> RDX: ffff8881d9b4a440 RSI: 0000000000000001 RDI: ffff8881d9b4a088
> RBP: ffff8881d9b49ea8 R08: ffff8881d9b4a440 R09: ffff8881da970180
> R10: 000000004afd68ef R11: 0000000000000000 R12: ffff8881d9b4a088
> R13: 0000000000000001 R14: ffffea000766d280 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000cffc5fa18 CR3: 00000001bfadf000 CR4: 00000000001406e0
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e10044057ba6=
fbcf%40google.com.
> For more options, visit https://groups.google.com/d/optout.
