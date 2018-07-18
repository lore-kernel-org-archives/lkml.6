Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF05ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651E82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkXze/se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651E82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeGRJY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:24:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36118 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGRJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:24:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id d14-v6so1894399pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ia3IltJWQoTS35mHp2lysfxzogWLVuSdyunbxS6GDo4=;
        b=BkXze/sebItRjfiFTjGdWFLa53TDVp409EYYGsW2MWsBC1BTBdjrDQuzgpW9qOdrA8
         XKfCpydGKeM5cVIsOrebmeWheJclMQtRb0EB6SfYeiDD/xj/RrsiK1Opje6iCbxVWOv/
         IgJEKHsj5nvKgfMzX+73Tp9de63u2TNIPIhW/uiEnAhjeEHrMK89fBCo3QufLHmGG9dl
         3SfW2/F5YzsTkCbgK6YAUH2IzRlS4chUmCvIqvRqL4xU1jZU1gTs4hg54L3gJ7b75Btm
         aqEnXBzMhmMpIVyWKBm9UJkafArIzNUtV/EScVYBsxerLndOHOj6YzOTiqIw4dMEsOVs
         R2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ia3IltJWQoTS35mHp2lysfxzogWLVuSdyunbxS6GDo4=;
        b=tPZ97s7M63MEvwqJshus9qljFkBFVS7MrmK9xUW3rU82g0j7xeDrpliBdgWDQheVCo
         GMFv+DTwkybLc6yhLsT/1n/3gqEe4ZPzTtNcAyJo1NETUSl9sawTIGxrNbYToccK8e/O
         oHMPOs6QkbLe3xVvjr52tXnAWBH9YLkemoLVnVMP81+YpRGNEfXoyiSf+tYKUER1Ndgy
         nKxdpwmUksullab4PBWrUB/0qVLfAA3x8ZO5xoqcsTbTBRNhzEtPPdH2C9b1VREe5BYc
         unpm8O/LKjUF3U8ywoJ89Aj5DVSRLNe+r15blxmmvUVTq89qZ5kVFSKygTIJhL7zTNHY
         sGUg==
X-Gm-Message-State: AOUpUlE3/L8rw71gLvt6Kks12R4/e81vKUGUTna27cP6uf5lZf7RumFf
        CuROxuvaQ0SM176nidIGqG7iMhzIDYqCF6kCzu9Lug==
X-Google-Smtp-Source: AAOMgpcFASSjHeJgHtiRt0Gab5/awguxGtnSs5xb+la3Ba0e9YBlZUF+eykXpRLKU+QuwP3BHvGYpn79ztcBhuiC0Ls=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr5097700pgh.216.1531903656830;
 Wed, 18 Jul 2018 01:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 01:47:16
 -0700 (PDT)
In-Reply-To: <00000000000091198305713e80fd@google.com>
References: <00000000000091198305713e80fd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 10:47:16 +0200
Message-ID: <CACT4Y+bhFCvNA9hyykLVq+oUc+n4+Adtn3hbJ9Bw2tXGC0=3Jw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in corrupted
To:     syzbot <syzbot+a7429c9ff268823af453@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:29 AM, syzbot
<syzbot+a7429c9ff268823af453@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    dc989d2ce2c2 tools: bpftool: don't pass FEATURES_DUMP to l..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14289578400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7429c9ff268823af453
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=106314c8400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1495b4c8400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a7429c9ff268823af453@syzkaller.appspotmail.com

#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

> ==================================================================
> BUG: KASAN: slab-out-of-bounds in do_error_trap+0x3b6/0x4d0
> arch/x86/kernel/traps.c:296
> Read of size 8 at addr ffff8801c0ce3cb0 by task syz-executor113/9480
>
> CPU: 1 PID: 9480 Comm: syz-executor113 Not tainted 4.18.0-rc3+ #57
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>
> Allocated by task 2164292896:
> BUG: unable to handle kernel paging request at ffffffff8c433958
> PGD 8e6d067 P4D 8e6d067 PUD 8e6e063 PMD 0
> Thread overran stack, or stack corrupted
> Oops: 0000 [#1] SMP KASAN
> CPU: 1 PID: 9480 Comm: syz-executor113 Not tainted 4.18.0-rc3+ #57
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
> Code: e8 c5 2e 47 fe e9 b3 fd ff ff e8 bb 2e 47 fe e9 55 fd ff ff 90 90 90
> 90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60 39
> 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
> RSP: 0018:ffff8801c0ce3a08 EFLAGS: 00010006
> RAX: 00000000001fffff RBX: ffff8801c0ce3bc4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801c0ce3a10 RDI: 0000000000003ff0
> RBP: ffff8801c0ce3a38 R08: ffff8801b2632440 R09: ffffed003b5e3ec2
> R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801c0ce2bc0
> R13: ffff8801c0ce3cb0 R14: ffff8801da987dc0 R15: ffff8801c0ce3bc0
> FS:  0000000000b43940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c433958 CR3: 00000001ae01a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> CR2: ffffffff8c433958
> ---[ end trace 3b9527e7dfd4d0bc ]---
> RIP: 0010:depot_fetch_stack+0x10/0x30 lib/stackdepot.c:201
> Code: e8 c5 2e 47 fe e9 b3 fd ff ff e8 bb 2e 47 fe e9 55 fd ff ff 90 90 90
> 90 90 90 89 f8 c1 ef 11 25 ff ff 1f 00 81 e7 f0 3f 00 00 <48> 03 3c c5 60 39
> 43 8b 8b 47 0c 48 83 c7 18 c7 46 10 00 00 00 00
> RSP: 0018:ffff8801c0ce3a08 EFLAGS: 00010006
> RAX: 00000000001fffff RBX: ffff8801c0ce3bc4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801c0ce3a10 RDI: 0000000000003ff0
> RBP: ffff8801c0ce3a38 R08: ffff8801b2632440 R09: ffffed003b5e3ec2
> R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: ffff8801c0ce2bc0
> R13: ffff8801c0ce3cb0 R14: ffff8801da987dc0 R15: ffff8801c0ce3bc0
> FS:  0000000000b43940(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff8c433958 CR3: 00000001ae01a000 CR4: 00000000001406e0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000091198305713e80fd%40google.com.
> For more options, visit https://groups.google.com/d/optout.
