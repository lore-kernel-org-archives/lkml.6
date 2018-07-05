Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C398C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973532405C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/kFH1MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973532405C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754385AbeGEQVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:21:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45826 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeGEQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:21:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id y24-v6so5854233pfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=niIjubxqTaR209XwPhMgdICksYr0KHIblAOl/GVTeqc=;
        b=C/kFH1MZiJDJtH1HqfuYiH9wLD9ie6OOxJVSNvbKOylkWz+Rz1wZFuxMSbXNvk2mnt
         9vNF83TtopAbrReGFtd+C1gDSy3hnNu6KxyxlrhyPUpwsn1sroEoAqV5cfMLHT3vEKz/
         MBnd33PQuhQ6EZQwmTHb2Sojr1+oyPNEw53eHEqmjd2RzYIp5QnCMlTbSy27qME3SxKU
         MkA/HJQVDArROmhhyvstVh5osCwEBGF8xAuVxkMAtoFM4TaJQ6MuvBmAYmr2/0jx3Ohc
         3ZNk3IQ1M2Kjk3NXhwDlbQJzKvvGLmxVPPkETapQcAFbSHpdS6DDHnsZ4+3y+qo+TDAI
         Xyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=niIjubxqTaR209XwPhMgdICksYr0KHIblAOl/GVTeqc=;
        b=RWxyL/0R2Wx+2zbuqevuV6Gk1MZyQjuOxAEzfjTiNMa6CsF8Irtqi8mQ8yC+eHbYiu
         uH086q45fVndMAG8uTowitM0TfkIVewc3yPyafnQgLKHz2VHZ07XqXcMN0fYzWfBlFNH
         5x75vgVoVSdn5+uSTnf07+sOJdDGxiB4wy6UsnYCghz+BtdtWMhOYVT+0qSQe/Tz46F3
         vnUi+rsFl0J4YE3Kt30bxMh8Bk9eoaptznfE44s08b6JqXl/CwFgXEBoejHFSFQB+s3u
         KsaDCOAiACWSGLNIpbNqwsKlTnQhVaedrdjnoo/eAHkF+c6c/q5Gnmng0z+Arr4qPJBN
         iU0Q==
X-Gm-Message-State: APt69E24A0b5EpQ2RqgWBdMAZida0J5M/nR39vCsQ2VcVQmWmIX79PRY
        sB/t+bI3WcwlHexYgaCkX01MsSAfZV5OUfhFS+TDKNXHm8o=
X-Google-Smtp-Source: AAOMgpfCD9VULHepsD5n0SedXaJmxvSmREuMVBi7njW7SRHdwNrELTogg9cZCe3x9nvDnaAUQrEDtNJjpT9q2SGVYa4=
X-Received: by 2002:a63:501c:: with SMTP id e28-v6mr6274285pgb.114.1530807711880;
 Thu, 05 Jul 2018 09:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:21:31
 -0700 (PDT)
In-Reply-To: <000000000000c19fad05702dd6a8@google.com>
References: <000000000000c19fad05702dd6a8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:21:31 +0200
Message-ID: <CACT4Y+YQGrmdn3852E3RtRp6ztJMT6xet4USAsJsOU4bfqAk3g@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in update_cfs_group
To:     syzbot <syzbot+3d9a14b389b1d7e54d6d@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:11 PM, syzbot
<syzbot+3d9a14b389b1d7e54d6d@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=153954c2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d9a14b389b1d7e54d6d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3d9a14b389b1d7e54d6d@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> ==================================================================
> PANIC: double fault, error_code: 0x0
> BUG: KASAN: stack-out-of-bounds in __read_once_size
> include/linux/compiler.h:188 [inline]
> BUG: KASAN: stack-out-of-bounds in calc_group_shares
> kernel/sched/fair.c:2931 [inline]
> BUG: KASAN: stack-out-of-bounds in update_cfs_group+0x4b1/0x590
> kernel/sched/fair.c:3028
> CPU: 1 PID: 15263 Comm: syz-executor7 Not tainted 4.18.0-rc3+ #45
> Read of size 8 at addr ffff8801aca4b500 by task syz-executor5/15250
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
>
> Code: 41
> CPU: 0 PID: 15250 Comm: syz-executor5 Not tainted 4.18.0-rc3+ #45
> 57 41
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> 89 cf
> Call Trace:
> 41 56
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> 41 55
> 49 89
> fd 41
> 54 45
> 89
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> cc 53
> 65 4c
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> 8b 34
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> 25 40
>  __read_once_size include/linux/compiler.h:188 [inline]
>  calc_group_shares kernel/sched/fair.c:2931 [inline]
>  update_cfs_group+0x4b1/0x590 kernel/sched/fair.c:3028
> ee 01
> 00 48
> 83 e4
> f0 48
>  dequeue_entity+0x400/0x15e0 kernel/sched/fair.c:4322
> 81
> ec 60
> 03 00
> 00 48
> 8b 45
> 10 <89>
> 94 24
> 80
>  dequeue_task_fair+0xf2/0x9e0 kernel/sched/fair.c:5455
> 00 00
> 00 48
> ba 00
> 00 00
> 00 00
> fc ff
> df 48
>  dequeue_task kernel/sched/core.c:762 [inline]
>  deactivate_task+0xf3/0x330 kernel/sched/core.c:778
> 89
>  __schedule+0x9c9/0x1ed0 kernel/sched/core.c:3454
> 84 24
> 98
> RSP: 0018:ffff8801ac5ffe80 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 1ffff100358c004c RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
> RBP: ffff8801ac600208 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff8801acc771b8 R11: ffff8801daf236b3 R12: 0000000000000000
> R13: ffffffff88f92620 R14: ffff8801aee52140 R15: 0000000000000002
> FS:  00007fe265cc0700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8801ac5ffe78 CR3: 00000001aaa5e000 CR4: 00000000001406e0
> DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
>  schedule+0xfb/0x450 kernel/sched/core.c:3548
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c19fad05702dd6a8%40google.com.
> For more options, visit https://groups.google.com/d/optout.
