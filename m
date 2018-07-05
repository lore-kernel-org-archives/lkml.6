Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E76C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D4D24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FD+ScUrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D4D24053
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeGEQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:19:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40910 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGEQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:19:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so1485075plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ty5AgRbiBOkQaw3TsmWJqrIVTmKtUdFNgmyd6+fFArE=;
        b=FD+ScUrk4DcahYmtRICf3r01xgFWOw8deXuvENc7NJQQXHpUcBLqOD8zTC7lalf7I4
         4nxOx5NDj6r1zen+CG94uufqh4IJzD4tIUrBvXT8eWOJ1vA1gjtdv+2ZF6aU4kOqSZ3p
         PfXI7dHVJQcAhNdZ6EGqzKt7yN+A7dbUFemyA5C7RygoNOBXhXZpA1g0wpuWbMg6zFxS
         I/z5Rv2Cbf4UprerllBcApwGwWfHhhLQ15BOSN6rPIdLqA2KidFlJUYu7DkNhFPWqi/o
         XUDrvzTspTQSqF/SVTdV8rESUlT2C4W3l7Y9sPRsNn2VEUmeshf7fFtiV8A69uiNugVD
         z+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ty5AgRbiBOkQaw3TsmWJqrIVTmKtUdFNgmyd6+fFArE=;
        b=eKZosXZxJorw5Rv0a6aToICbnyC3emeNuBapExI/eAB2ts/VVHh6iYT2Et5AQXN2Pj
         qfXgVYBFP7aDWz8QNej2OeSnH2/hQbszNCxKmXK6FXC8leefNGxKauj17ZuHPIwN4Azu
         BPXllBnSL8+WYj9zGrQbqzGOL0ZnIJXUQAJJWwCReu9OhwevmyUs/qcWEpJVw5uAhSom
         eICYgepRUTZOOlexlvzRJGN+wXRxFrrpKe3ABO3aMHRnO4/Ngs/HIPFLMuWt+Xcoi9Xl
         RWBeyZQFr4XB6EUdW8U9ysdyc26Dzm67DOeQXr+xlTPd67B0NuO0yBZcY0YAKk4g1/n5
         CEyQ==
X-Gm-Message-State: APt69E2RRkiE0GDJsfuKe3gXfNmu5/z2KhOyJPKaB+vba0Hsj1KQU4VU
        6HKIfIr/L1IjDGbVHcdqTRJnSMuoopmQiZbwkjmYHOMtHoI=
X-Google-Smtp-Source: AAOMgpdCjRxAryNLpz3ns19MxVXlSYDV2AupE0LqYp1PTbZ9pw/viRihZPIG3d3L2NhEe7f8bhUj0u6RF1JJOS1EhSg=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr975403pll.85.1530807565215;
 Thu, 05 Jul 2018 09:19:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:19:04
 -0700 (PDT)
In-Reply-To: <0000000000002769a90570394450@google.com>
References: <0000000000002769a90570394450@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:19:04 +0200
Message-ID: <CACT4Y+ZC+71N7PU+4mMm4_-j_F3xzFaf-wQkWqf69=O=pHpAAA@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in move_expired_inodes
To:     syzbot <syzbot+eb366f9430d25498f0f6@syzkaller.appspotmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 6:49 AM, syzbot
<syzbot+eb366f9430d25498f0f6@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d35aa4400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=eb366f9430d25498f0f6
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=149e9e0c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17464278400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+eb366f9430d25498f0f6@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in move_expired_inodes+0xcb5/0xd80
> fs/fs-writeback.c:1120
> Read of size 8 at addr ffff8801a802c750 by task kworker/u4:4/849
>
> CPU: 0 PID: 849 Comm: kworker/u4:4 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  move_expired_inodes+0xcb5/0xd80 fs/fs-writeback.c:1120
>  queue_io+0x309/0x860 fs/fs-writeback.c:1169
>  wb_writeback+0xaf9/0xf80 fs/fs-writeback.c:1761
>  wb_check_old_data_flush fs/fs-writeback.c:1867 [inline]
>  wb_do_writeback fs/fs-writeback.c:1920 [inline]
>  wb_workfn+0xfb7/0x1760 fs/fs-writeback.c:1949
>  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> Allocated by task 2170490192:
> BUG: unable to handle kernel paging request at ffffffff8c430958
> PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 0
> Oops: 0000 [#1] SMP KASAN
> CPU: 0 PID: 849 Comm: kworker/u4:4 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
> Code: e8 65 30 47 fe e9 b3 fd ff ff e8 5b 30 47 fe e9 55 fd ff ff 90 90 90
> 90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60 09
> 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
> RSP: 0018:ffff8801d7dae930 EFLAGS: 00010006
> RAX: 00000000001fffff RBX: ffff8801a802cbb4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801d7dae938 RDI: 0000000000003ff0
> RBP: ffff8801d7dae960 R08: ffff8801d7c4e380 R09: ffffed003b5c3ec2
> R10: ffffed003b5c3ec2 R11: ffff8801dae1f617 R12: ffff8801a802c400
> R13: ffff8801a802c750 R14: ffff8801d3f30e40 R15: ffff8801a802cbb0
> FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c430958 CR3: 00000001bb012000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  describe_object mm/kasan/report.c:243 [inline]
>  print_address_description+0xfb/0x20b mm/kasan/report.c:263
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  move_expired_inodes+0xcb5/0xd80 fs/fs-writeback.c:1120
>  queue_io+0x309/0x860 fs/fs-writeback.c:1169
>  wb_writeback+0xaf9/0xf80 fs/fs-writeback.c:1761
> PANIC: double fault, error_code: 0x0
> CPU: 1 PID: 8116 Comm: syz-executor725 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
> Code: 41
> 57
> 41 89
>  wb_check_old_data_flush fs/fs-writeback.c:1867 [inline]
>  wb_do_writeback fs/fs-writeback.c:1920 [inline]
>  wb_workfn+0xfb7/0x1760 fs/fs-writeback.c:1949
>  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
> cf
> 41 56
> 41 55
> 49 89
> fd 41
> 54 45
> 89 cc
> 53 65
> 4c 8b
> 34 25
> 40 ee
> 01 00
>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
> 48 83
> e4 f0
> 48 81
> ec 60
> 03 00
> 00 48
> 8b
> 45 10
> <89>
> 94 24
> 80 00
> 00 00
>  kthread+0x345/0x410 kernel/kthread.c:240
> 48 ba
> 00 00
> 00
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 00 00
> Modules linked in:
> fc ff
> df 48
> Dumping ftrace buffer:
> 89 84
>    (ftrace buffer empty)
> 24 98
> CR2: ffffffff8c430958
> RSP: 0018:ffff8800fffffed0 EFLAGS: 00010082
> ---[ end trace 565e600e75d0194b ]---
> RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
> RAX: 0000000000000000 RBX: 1ffff10020000056 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
> Code:
> RBP: ffff880100000258 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: dffffc0000000000 R12: 0000000000000000
> e8
> R13: ffffffff88f92620 R14: ffff8801cf4343c0 R15: 0000000000000002
> FS:  00007f2e19c1b700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> 65
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8800fffffec8 CR3: 0000000008e6a000 CR4: 00000000001406e0
> 30
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 47
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> fe
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002769a90570394450%40google.com.
> For more options, visit https://groups.google.com/d/optout.
