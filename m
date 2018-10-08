Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88AAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dsx//JOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1072B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJHX2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:28:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36704 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJHX2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:28:12 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so12701583itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ou1Rup2zPuV93Z2Ojjs1kHbTkT2ZlB+kXVhmYQxn0ss=;
        b=Dsx//JOdOmNI7ARD24fn1kANZmqSRdYe/JcTlfqllbJgyCY9wq6RNUy6ft/HKbQleN
         dSc2sp6QFY+wRT3gvFy4cA2UPZk7ii3s8cVS5SFAOXSv0Er6Us7p8MlKWrKsJwynydUa
         xCgSt6NZjtnK8RMxDrC1f5e5u3UQSVELMBN4JuC/zg/JSKMMC+rHOMz1UlSrCUl844Ns
         t4MvoMJRGpXywMR68AF6CTsowGLqEYGRtE5OX84vMaPXZT7Z0ZWSmj52d/Bx8Nq4Xg0R
         7eWbrRMv/M9QM6JIzeMMbn0wMOaRB+cB3eTzqEaZaf9xpd5xbkY/WLyDzvRtV7mSR34d
         zVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ou1Rup2zPuV93Z2Ojjs1kHbTkT2ZlB+kXVhmYQxn0ss=;
        b=Km+zApUq5IQoAvXZoJFM4h8AXDLq0A1GN+oey5YqlGKe9vUT5XJMyVwSOHWDW56J5t
         f21NqAxFXtwZqC9QH5jxOn75JqWfiZDs0Jsfii/FJ8U8mfLntRPspIy3Cym4yk/OTSn5
         RG+x9VSefcoff5HpR12xW9riXGtLIP7xGpYTrwfb3EXRhRd0wI4xTFZ0hnIsJ4kFdwDb
         F2EqZJ6p+TAK9yIxmp7T1XFEHLNIeOX72xseUMILaLWFznQ+kyhhMSyXzHnnmQ6QGh6o
         4LNWDNgWckAkLS2hLuFQdVAR8/dEQhBF8SWC5orsWixiiCMI1fdBjSHyuKhoo2JDKM7A
         wfEg==
X-Gm-Message-State: ABuFfoi9bKn9p3qpLBWK7rHog46KYLv2ve3X+D1Wu0EBeI01HQDyOWSq
        YTpDjDegzE2NbfSMFvUyoNRlm8FFK19kzRAoMugRGA==
X-Google-Smtp-Source: ACcGV63NXxecSAfc9XIRo7KchmBRxZF+xW7LFwdwxtetcciUCKNIvkhy3znLjtqMB90+Qf8L+ybB2yJtDOYYyxBgyXg=
X-Received: by 2002:a24:3383:: with SMTP id k125-v6mr16500680itk.14.1539015343263;
 Mon, 08 Oct 2018 09:15:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 09:15:22 -0700 (PDT)
In-Reply-To: <000000000000b3d5610577b9e12c@google.com>
References: <000000000000b3d5610577b9e12c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Oct 2018 18:15:22 +0200
Message-ID: <CACT4Y+bfqk8Fczw4dJHhVzM63YhYNSovEE-KygZ1XmgUQVGCWQ@mail.gmail.com>
Subject: Re: WARNING in __put_task_struct (2)
To:     syzbot <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com>,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, swise@opengridcomputing.com,
        markb@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        marcos.souza.org@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:12 PM, syzbot
<syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e7c6a1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
> dashboard link: https://syzkaller.appspot.com/bug?extid=1ed9dfaa984c88cf0ef8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com


This was triggered by the following program, all is rdma-related, so
+rdma maintainers.

10:27:26 executing program 5:
r0 = openat$rdma_cm(0xffffffffffffff9c,
&(0x7f0000000380)='/dev/infiniband/rdma_cm\x00', 0x2, 0x0)
write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000080)={0x0, 0x18,
0xfa00, {0x0, &(0x7f0000000040)={<r1=>0xffffffffffffffff}, 0x13f}},
0x12d)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000200)={0x3, 0x40,
0xfa00, {{0xa, 0x4e21}, {0xa, 0x0, 0x0, @mcast1}, r1}}, 0x48)
write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000340)={0x0, 0x18,
0xfa00, {0x0, &(0x7f0000000300)={<r2=>0xffffffffffffffff}, 0x13f}},
0x20)
write$RDMA_USER_CM_CMD_SET_OPTION(r0, &(0x7f00000002c0)={0xe, 0x18,
0xfa00, @id_afonly={&(0x7f0000000000)=0x1, r1, 0x0, 0x2, 0x4}}, 0x20)
write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000100)={0x3, 0x40,
0xfa00, {{0x2, 0x4e21}, {0xa, 0x0, 0x0, @local}, r2}}, 0x1ff)
write$RDMA_USER_CM_CMD_DESTROY_ID(r0, &(0x7f0000000180)={0x1, 0x10,
0xfa00, {&(0x7f00000000c0), r2}}, 0x18)



> WARNING: CPU: 1 PID: 16271 at kernel/fork.c:718
> __put_task_struct+0x3ef/0x620 kernel/fork.c:718
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 16271 Comm: syz-executor5 Not tainted 4.19.0-rc7-next-20181008+
> #89
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x3ab lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x254/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> RIP: 0010:__put_task_struct+0x3ef/0x620 kernel/fork.c:718
> Code: 4c 89 ee e8 d3 9d 7b 00 e9 a1 fe ff ff e8 89 53 37 00 0f 0b e9 7c fd
> ff ff e8 7d 53 37 00 0f 0b e9 87 fd ff ff e8 71 53 37 00 <0f> 0b e9 d0 fc ff
> ff e8 65 53 37 00 49 8d 87 90 05 00 00 31 f6 48
> RSP: 0018:ffff88018dbcf808 EFLAGS: 00010293
> RAX: ffff880187474180 RBX: ffff88018cc7a1c0 RCX: ffffffff8147298d
> RDX: 0000000000000000 RSI: ffffffff81472cbf RDI: 0000000000000005
> RBP: ffff88018dbcf8e8 R08: ffff880187474180 R09: ffffed003198f43c
> R10: ffffed003198f43c R11: ffff88018cc7a1e3 R12: 1ffff10031b79f04
> R13: 0000000000000000 R14: ffff88018dbcf8c0 R15: ffff88018daceb40
>  put_task_struct include/linux/sched/task.h:96 [inline]
>  rdma_restrack_del+0x2e0/0x3b0 drivers/infiniband/core/restrack.c:243
>  rdma_destroy_id+0x126/0xcc0 drivers/infiniband/core/cma.c:1820
>  ucma_close+0x114/0x310 drivers/infiniband/core/ucma.c:1767
>  __fput+0x3bc/0xa70 fs/file_table.c:279
>  ____fput+0x15/0x20 fs/file_table.c:312
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x411051
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48
> 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89
> c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffd6e8617b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411051
> RDX: 0000000000000000 RSI: 0000000000731850 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffd6e8616e0 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000156 R15: 0000000000000005
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b3d5610577b9e12c%40google.com.
> For more options, visit https://groups.google.com/d/optout.
