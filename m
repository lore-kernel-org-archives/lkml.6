Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6CDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35920854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ll02p/T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfAGKEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:04:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51552 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAGKET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:04:19 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so351783ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtpZZ82T+J672IEzf3rtrmsgcO0W/zmgYx3Gu0WKyLQ=;
        b=Ll02p/T294fLunfCXo5gc5nCLZoyZTVFFBe/cOfuR7/6Wnu68nV2GRKES9Uk9dROPC
         KugUqdMvhPN/WQt9HpZycscDzI30MsuqVhhY5w2oKoOPKhbFSyBZ+Eku6n9jNSg+1+TU
         nKRCuSLHDk4h0UfKgvbKoXkoNcdOwnHoV3zdwsLuQ95NkNCJYhF2qmVSGHRiQ5jyA3jJ
         8isrXxx4fjGUNU1wGDgzzQLzATv4rp2cEkUXj0ry9H/mxvPrrtsz4Jn1jldXRdo7wHV6
         9GFfmezhmfOwxlEMR0YFzqA9DyGh3vL1EaiIODCu+a3eYMt8RFLtiIgC6cIjpMRM7xXF
         F7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtpZZ82T+J672IEzf3rtrmsgcO0W/zmgYx3Gu0WKyLQ=;
        b=E8RR/Jo2HCCf+g4qEACgXBQ8ti4FZEBo1H16JB7Kb1VlWvMpmI5Jp6/VyXgcNgTD0p
         u1PD2i0iYK27AhPhgIfRnVf7xRK4z1i8S4O0+gXPC8WuHuOvWMnc5Z41M9l6MsovgHtR
         6BaKB9i0mvLDb/OgXk5Wp0a7lt1wQ8mYxxEHGIhZQYcpD07q2DUEevpYo81xslCIg0/H
         U2TIeyxq283ax2UMEj23nOVB8eWBJohz4IWegCoAQqvNepJoeKB1upt06W26qNwT8kGu
         cgSS/T54HSX/o29ysWaHfivRwpr58v4pFoH4HHlsn17MIjvklqI0evqyzQrye4Ho6OUv
         n1fw==
X-Gm-Message-State: AJcUukexmpU7BeaYSBINVtFTwJVsJT3rVM2T7aCSijf7qFwZZSzyCTIh
        Vn2hryAYypIYH3KLD126hw2tyU07iqJyM+g6TbVTpA==
X-Google-Smtp-Source: ALg8bN49vzOWVIP2egw6eUF61mC0F8g9GsqIREEGm82t9jqjE1DfdKFInZTQ0o4+qvPbsEcbrqOqaXYNNYIdvCDTk78=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr5964820itl.144.1546855458217;
 Mon, 07 Jan 2019 02:04:18 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b7cbf057edb4e33@google.com>
In-Reply-To: <0000000000007b7cbf057edb4e33@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Jan 2019 11:04:07 +0100
Message-ID: <CACT4Y+YLNQRe-vsoaGtHpPT=M7z2ybjXqrUSbVctZ54Ub5Li-Q@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in unwind_next_frame
To:     syzbot <syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 11:01 AM syzbot
<syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b5aef86e089a Merge tag 'docs-5.0-fixes' of git://git.lwn.n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1034c54b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf0ed2b3bc8fc51fc6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com

This happens on the line that does _not_ use READ_ONCE_TASK_STACK:

/* Get the next frame pointer: */
if (state->regs)
        next_bp = (unsigned long *)state->regs->bp;
else
        next_bp = (unsigned long *)READ_ONCE_TASK_STACK(state->task,
*state->bp);

Should the first line also use READ_ONCE_TASK_STACK?
Or should we always have state->regs == NULL when unwinding a remote task?
Or is it a true OOB if we are unwinding own stack?



> ==================================================================
> BUG: KASAN: out-of-bounds in unwind_next_frame.part.0+0x756/0xa90
> arch/x86/kernel/unwind_frame.c:324
> Read of size 8 at addr ffff88805082fb68 by task syz-executor2/21500
>
> CPU: 0 PID: 21500 Comm: syz-executor2 Not tainted 4.20.0+ #12
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>   unwind_next_frame.part.0+0x756/0xa90 arch/x86/kernel/unwind_frame.c:324
>   unwind_next_frame+0x3b/0x50 arch/x86/kernel/unwind_frame.c:287
>   __save_stack_trace+0x7a/0xf0 arch/x86/kernel/stacktrace.c:44
>   save_stack_trace_tsk arch/x86/kernel/stacktrace.c:76 [inline]
>   save_stack_trace_tsk+0x9e/0xd0 arch/x86/kernel/stacktrace.c:69
>   proc_pid_stack+0x272/0x430 fs/proc/base.c:438
>   proc_single_show+0xf6/0x180 fs/proc/base.c:739
>   seq_read+0x4db/0x1130 fs/seq_file.c:229
>   do_loop_readv_writev fs/read_write.c:700 [inline]
>   do_loop_readv_writev fs/read_write.c:687 [inline]
>   do_iter_read+0x4a9/0x660 fs/read_write.c:921
>   vfs_readv+0x175/0x1c0 fs/read_write.c:983
>   do_preadv+0x1c4/0x280 fs/read_write.c:1067
>   __do_sys_preadv fs/read_write.c:1117 [inline]
>   __se_sys_preadv fs/read_write.c:1112 [inline]
>   __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1112
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f8d6c5e5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457ec9
> RDX: 00000000000001a1 RSI: 00000000200017c0 RDI: 0000000000000005
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d6c5e66d4
> R13: 00000000004c4861 R14: 00000000004d7d20 R15: 00000000ffffffff
>
> The buggy address belongs to the page:
> page:ffffea0001420bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x1fffc0000000000()
> raw: 01fffc0000000000 0000000000000000 ffffffff01420101 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff88805082fa00: 00 f2 f2 00 f2 f2 f2 00 f2 f2 f2 00 f2 f2 f2 f8
>   ffff88805082fa80: f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff88805082fb00: f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00
>                                                            ^
>   ffff88805082fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
>   ffff88805082fc00: f1 f1 00 f2 f2 f2 00 00 f2 f2 04 f3 f3 f3 00 00
> ==================================================================
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007b7cbf057edb4e33%40google.com.
> For more options, visit https://groups.google.com/d/optout.
