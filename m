Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C93C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FF920854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrjUOvQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FF920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeKQG5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:57:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42773 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeKQG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:57:03 -0500
Received: by mail-io1-f65.google.com with SMTP id h19-v6so18044738iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xvXXatidMut5kzxSFtl38ryo7VY+GkCztQOHs1dnykQ=;
        b=nrjUOvQWI2SE37gneLh6yg8h+VP9pmTu3xs1SHIG2KEGpBAo3rUx1d9Jw81MrvnOY2
         WsrAuV2TXnfgaPMwdEa3CtL2n5MG+MuYD1AJpBTR3p9fWmJBx3SGJ4xmAq1dcO/NW0tk
         1waSlq+wfiqUWn1ZxsPVUJMYynUf4OUSoD98VM4jeFKGq1z4i0/wfuvo/PT91932RUCW
         OTzuExmaWATdvXosC0aifyZuDDXDu5dnqi/krECVMyuBtRC3lvYUf56kPJkFdE/56An8
         uYuuxox5wMi4KZciABYyheaiSmEqY2yKdRT86+ElngliYiS1/TuDGCHk4cvZnAE+g6R2
         fanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xvXXatidMut5kzxSFtl38ryo7VY+GkCztQOHs1dnykQ=;
        b=e9BG4YJ6vi8WlgC+/Txm1ElBUxCJL0H9iE3HRzve0HNC+8zCh1zjOQYonebJeLE6l2
         7l11QeQ5uilooEYLoweizkPh8oTF2DAG7Jo3r91RYniwuqeAuK1FyoIkIiQvcAFIRJ/0
         +LG5Of/cmgTMk421E5bJeKNcuNtQ/P0nzDlJzfzmXVvq/OQAIK7jAFq/FDLTjiMHBQhk
         R3f+UNztGFhn3+RcLXn6PMFvzGwoU/NqPTMOBcuOVXKNIu7Q5Yz1EQJISu/Q5+xaNuDS
         P4WHs4Pd7wLznz1hXQlnB3c1georUnZBhwbAmQgPKqqAnryp5V8k6tQjsQH2fA7c4AOo
         2YHw==
X-Gm-Message-State: AA+aEWaMn39Ken1gjbVwyUjjUPWetRvY6iUaq4ZOsk4KFv+Q9pndKOEW
        Amp/Z29PlXmoYktOA8Qh1NoDWea2Khp0jFVdoqOhPw==
X-Google-Smtp-Source: AFSGD/WeyeHcvWiGKxdLbIrlo6OTdscSYWkJwFKM1qnmyHvBWe6o3myqd6XWA9dypAk15A6Klz7DeGh0MPnRoAusnDc=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr8560843iod.282.1542400986644;
 Fri, 16 Nov 2018 12:43:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 12:42:46
 -0800 (PST)
In-Reply-To: <000000000000381781057a0c452e@google.com>
References: <000000000000381781057a0c452e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 12:42:46 -0800
Message-ID: <CACT4Y+ZcZXk=iRxofU=NKV_GYMkHaqhy_qEKbK4TioSkYn541g@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in locks_remove_file
To:     syzbot <syzbot+1d200d0b1db9c9f449d0@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:20 PM, syzbot
<syzbot+1d200d0b1db9c9f449d0@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1103882b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d200d0b1db9c9f449d0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1d200d0b1db9c9f449d0@syzkaller.appspotmail.com

Assuming this is another manifestation of the following report.

#syz dup: KASAN: use-after-free Read in locks_delete_block

> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle kernel paging request at ffff880194657bb8
> PGD be01067 P4D be01067 PUD 1bf029063 PMD 80000001946001e3
> Oops: 0011 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8074 Comm: syz-executor4 Not tainted 4.20.0-rc1-next-20181107+
> #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:0xffff880194657bb8
> Code: c1 eb 86 af 8c 32 00 f1 ff 1f d0 7c 65 94 01 88 ff ff f8 7d 65 94 01
> 88 ff ff 00 00 00 00 00 fc ff df 04 00 00 00 00 00 00 00 <78> 7d 65 94 01 88
> ff ff bc 9e 2b 81 ff ff ff ff 38 89 d3 8c 01 88
> kobject: 'loop5' (00000000fd72d949): kobject_uevent_env
> RSP: 0018:ffff880194657508 EFLAGS: 00010212
> RAX: 0000000000040000 RBX: ffff880194657bb8 RCX: ffffc9000a5f1000
> RDX: 000000000000039f RSI: ffffffff81ed5c9e RDI: ffff880194657588
> RBP: ffff8801946576f0 R08: ffff88018cd380c0 R09: ffffed003b5e5b67
> R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d9678080
> R13: ffff880194657588 R14: 1ffff100328caea5 R15: dffffc0000000000
> kobject: 'loop5' (00000000fd72d949): fill_kobj_path: path =
> '/devices/virtual/block/loop5'
> FS:  00007f5f1e438700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff880194657bb8 CR3: 00000001cd753000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kobject: 'loop3' (00000000367508b9): kobject_uevent_env
> Call Trace:
> kobject: 'loop3' (00000000367508b9): fill_kobj_path: path =
> '/devices/virtual/block/loop3'
>  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
>  __fput+0x2f0/0xa70 fs/file_table.c:271
>  ____fput+0x15/0x20 fs/file_table.c:312
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  get_signal+0x1550/0x1970 kernel/signal.c:2347
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f5f1e437c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000049
> RAX: fffffffffffffe00 RBX: 0000000000000002 RCX: 0000000000457569
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5f1e4386d4
> R13: 00000000004bdd9e R14: 00000000004ccdb8 R15: 00000000ffffffff
> Modules linked in:
> CR2: ffff880194657bb8
> ---[ end trace f5c1663e01f0c934 ]---
> RIP: 0010:0xffff880194657bb8
> Code: c1 eb 86 af 8c 32 00 f1 ff 1f d0 7c 65 94 01 88 ff ff f8 7d 65 94 01
> 88 ff ff 00 00 00 00 00 fc ff df 04 00 00 00 00 00 00 00 <78> 7d 65 94 01 88
> ff ff bc 9e 2b 81 ff ff ff ff 38 89 d3 8c 01 88
> RSP: 0018:ffff880194657508 EFLAGS: 00010212
> RAX: 0000000000040000 RBX: ffff880194657bb8 RCX: ffffc9000a5f1000
> RDX: 000000000000039f RSI: ffffffff81ed5c9e RDI: ffff880194657588
> RBP: ffff8801946576f0 R08: ffff88018cd380c0 R09: ffffed003b5e5b67
> R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801d9678080
> R13: ffff880194657588 R14: 1ffff100328caea5 R15: dffffc0000000000
> FS:  00007f5f1e438700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff880194657bb8 CR3: 00000001cd753000 CR4: 00000000001406e0
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000381781057a0c452e%40google.com.
> For more options, visit https://groups.google.com/d/optout.
