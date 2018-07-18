Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2F5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3882084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u49Csl3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3882084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGRLiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:38:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42723 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeGRLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:38:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so2028148pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=va/9dklV8MXDQbiVO5uRrWwmaZDX8qwC+4/t23l51co=;
        b=u49Csl3CKdYSQzJo6gpTCOst4UlMyleDkQZKANfubBbmYjAHAbR+2wwLQRGJvX73SY
         7ERP7IWMrskDaH+hsqJgy7Fl3ehMdYn/Z6US7muI1xQvgfbyVr+zA53SjeWmK9sw8cA7
         G/wG177mCeo/7KyM0fiDFYO5D/00FK8o94loDcDPvo1aAkwRmmdN+BT3S7QSqrRiG0Uf
         wNt29aIUD4n49+ILA8GI/SyTJ5UqNDMimYDirzXZ3mdDP7KbVxBV8LiCWRcNidSd0pkC
         RVxPel03sNGNb+9vLOyZLDiBhvPME91kUK85w8Md7dxcQfMgm296cJ4qst6Wpi0wavm2
         fKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=va/9dklV8MXDQbiVO5uRrWwmaZDX8qwC+4/t23l51co=;
        b=cHq4W4nozdhZB7nY4ekVQgXteIraqI6T1LBu8wvQMobVW7K0DeoyxQiW6M4wOc4k6m
         +RHlYYwB0iG7DFJwhh0K/i2dzb3GX+f/HJIUs71Wdha5Fy5p9Vu2YEnFPReRt8qGYTee
         JvWDAGR7QFS9PmxB3iRf87m1tVycgtWWdVnojWBfjGgidgWpJqNq0ar+bYoo/69QvnqF
         8/AjzB58y2R517q+zEhJpl49RnTrtg/4CNdVazcv6UA7MZbwfG/6Kq0p2/nLfYQkf50F
         OggIBbqEM7n0tzJjtZCXgjLvsKC4fisbsFRdUqcIIqCel02EkeYU8MhJur7StyHkjfaI
         Y7Gg==
X-Gm-Message-State: AOUpUlEydddOVAhFD5g92t+6Wz5YFHfCsSwWyFcAJMS80aMrh6v6D2YI
        4BN2iogpMbSpgb0qpsMjCU0BKOmg5UJ8u+cu3kpF9g==
X-Google-Smtp-Source: AAOMgpc9delqGj9+llVnZyETJGqgPZPTwbtwXwqqRbWeH8AA2Rs3Gk2QswtFro6aVi3CVyYY3ijIO0q81/d46ZAybt0=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr5286057pgu.96.1531911658635;
 Wed, 18 Jul 2018 04:00:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:00:38
 -0700 (PDT)
In-Reply-To: <001a11405130a984300562e8e7b3@google.com>
References: <001a11405130a984300562e8e7b3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 13:00:38 +0200
Message-ID: <CACT4Y+Y1ZskrqsmhWoHWXOigMHX5eyG5nGGyuU6cZ0uNnChSiQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in l2tp_session_create
To:     jchapman@katalix.com
Cc:     David Miller <davem@davemloft.net>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        g.nault@alphalink.fr, Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Hackmann <ghackmann@google.com>,
        syzbot <syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2018 at 7:29 PM, syzbot
<syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzkaller hit the following crash on
> a8750ddca918032d6349adbf9a4b6555e7db20da
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> Unfortunately, I don't have any reproducer for this bug yet.
>
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


James,

Did you fix this? You asked syzbot to test a fix for this bug some time ago.
If yes, did you include the Reported-by tag in the commit? This bug is
still considered open by syzbot. But it stopped happening ~4 months
ago:
https://syzkaller.appspot.com/bug?id=6fed0854381422329e78d7e16fb9cf4af8c9aef1
We are also seeing these crashes in 4.4 and 4.9, it would be good to
backport the fix.

Thanks


> ==================================================================
> BUG: KASAN: use-after-free in l2tp_session_create+0xa6d/0xc60
> net/l2tp/l2tp_core.c:1757
> Read of size 4 at addr ffff8801d80ad868 by task syz-executor3/5462
>
> CPU: 0 PID: 5462 Comm: syz-executor3 Not tainted 4.15.0-rc8+ #263
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:429
>  l2tp_session_create+0xa6d/0xc60 net/l2tp/l2tp_core.c:1757
>  pppol2tp_connect+0xed7/0x1dd0 net/l2tp/l2tp_ppp.c:748
>  SYSC_connect+0x213/0x4a0 net/socket.c:1621
>  SyS_connect+0x24/0x30 net/socket.c:1602
>  entry_SYSCALL_64_fastpath+0x29/0xa0
> RIP: 0033:0x452df9
> RSP: 002b:00007f93ec47fc58 EFLAGS: 00000212 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452df9
> RDX: 000000000000002e RSI: 00000000205fafd2 RDI: 0000000000000018
> RBP: 00000000000005a9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: 00000000006f6878
> R13: 00000000ffffffff R14: 00007f93ec4806d4 R15: 0000000000000000
>
> Allocated by task 5462:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3610
>  kmalloc include/linux/slab.h:499 [inline]
>  kzalloc include/linux/slab.h:688 [inline]
>  l2tp_tunnel_create+0x5e1/0x17f0 net/l2tp/l2tp_core.c:1554
>  pppol2tp_connect+0x14b7/0x1dd0 net/l2tp/l2tp_ppp.c:707
>  SYSC_connect+0x213/0x4a0 net/socket.c:1621
>  SyS_connect+0x24/0x30 net/socket.c:1602
>  entry_SYSCALL_64_fastpath+0x29/0xa0
>
> Freed by task 5484:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xd6/0x260 mm/slab.c:3803
>  __rcu_reclaim kernel/rcu/rcu.h:190 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2758 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:3012 [inline]
>  __rcu_process_callbacks kernel/rcu/tree.c:2979 [inline]
>  rcu_process_callbacks+0xe94/0x17f0 kernel/rcu/tree.c:2996
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>
> The buggy address belongs to the object at ffff8801d80ad780
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 232 bytes inside of
>  512-byte region [ffff8801d80ad780, ffff8801d80ad980)
> The buggy address belongs to the page:
> page:ffffea0007602b40 count:1 mapcount:0 mapping:ffff8801d80ad000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801d80ad000 0000000000000000 0000000100000006
> raw: ffffea00070e8760 ffffea00070f8ca0 ffff8801dac00940 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d80ad700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801d80ad780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>
>> ffff8801d80ad800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                                                           ^
>  ffff8801d80ad880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d80ad900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a11405130a984300562e8e7b3%40google.com.
> For more options, visit https://groups.google.com/d/optout.
