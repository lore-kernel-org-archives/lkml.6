Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B153BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZ1hJEQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeKQILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:11:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37826 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeKQILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:11:08 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so30007iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2219vtLvzCj0S4WHR8WuPm10Iyd3P1c6RtLhP4lSJfA=;
        b=cZ1hJEQC0QH7R/7IyVjM+FByT8KR76nBrHZw7hEqWnP1ufxzDlCs0gsndyQ7zyvtEo
         8A3IrCcKFoqDV0Hdhk1y0L4I1SX3no8oGTsc6N5nmV+B4qcMqAoGPbEk+9WNmITHKa2B
         W+tMuOH1iYxlazrjBHq2hXRgu2swJ+vQH8fwTUXmSKOZ5cQQ4BhYTZe/43Kdhn0AXUlL
         Q5D/l+hy9QnCXI5y2ASIWS6wPKz5oTB8VeJO0fiIJrnmkmlhInJbCzzMjZcVMDZEvCP/
         i/DU1R0LRs/jcfA62eanclKJ1oARGjF8X9Y4y0g+NgVLq5MHxx8qcDA9fieSsd2HJYB+
         jZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2219vtLvzCj0S4WHR8WuPm10Iyd3P1c6RtLhP4lSJfA=;
        b=tIDvrGcK1r5tKbU97WUYgv25osiYb8/3+pbbn1TJkt6ajkvCNviOTuw/yIWGoI8+/K
         LZexaghEE1cBSVdbufh6N19t41R6wb+u413QPKWdWLgR+8boBNYOKwGywbUpwVhfNLs/
         in35sI09KgaLLjmepEwi+QUkrcflkEG/atrd/oCL9LX69BWkY0TT/tprGrfB9B1w68W9
         uTSZPdSj1YSclIT66U7f4H4/hYJWowSnY6AqVEyVMw6HEkwN1Kmtn1NEsNc+P2cdKCz1
         kKRf4CBRW484nkUG8xjDUtDbRNbQvuOjC3qojHkwBh55yEO7FmGJ7bTHCLHbDdLepA9R
         VSJA==
X-Gm-Message-State: AGRZ1gIiYAF47kFhznNsXniur6dor2z3gweCBMUzVJMrBXYUOrjU6Fb/
        kLdszqKrF9jE4RPqWiu5D0urLErc3bsJo/Px64r9fQ==
X-Google-Smtp-Source: AJdET5cLDdNezsHAXJYOvaV8WNQbYOZkdn7nPa5DHKRw3q/ikAxTKSrMZMX0DZ27LsXfJUyWuObic8bGzQwRakeE4Qc=
X-Received: by 2002:a02:8904:: with SMTP id o4mr8907769jaj.35.1542405419408;
 Fri, 16 Nov 2018 13:56:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 13:56:38
 -0800 (PST)
In-Reply-To: <0000000000005b7456057a9abc57@google.com>
References: <0000000000005b7456057a9abc57@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 13:56:38 -0800
Message-ID: <CACT4Y+bN2=BKSX+-6LVnH+kO7xcQH8JVePbEQUSX6pLAh_0wDw@mail.gmail.com>
Subject: Re: kernel BUG at mm/slab.c:LINE! (3)
To:     syzbot <syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:18 PM, syzbot
<syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    3e536cff3424 net: phy: check if advertising is zero using ..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f95b83400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=2182db487a523d86bf34
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d46d5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6a225400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com

All reproducers just do something simple with inet6 sockets and all
crashes are on net-next, so +netdev

r0 = socket$inet6(0xa, 0x2, 0x0)
connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4e24, 0x0, @ipv4={[], [],
@loopback}}, 0x1c)
sendmmsg(r0, &(0x7f00000092c0), 0x3ffffffffff0c00, 0x0)


> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH)
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:4425!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: -642842048 Comm: ksoftirqd/0 Not tainted 4.20.0-rc2+ #294
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
> Code: 48 c7 c7 15 73 12 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29
> c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7 15
> 73 12 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 d0 73
> RSP: 0018:ffff8881d9af0030 EFLAGS: 00010093
> RAX: 00000000000a57eb RBX: 1ffff1103b35e00d RCX: 000000000000000c
> RDX: ffff8881d9af0240 RSI: 0000000000000002 RDI: ffff8881d9af01d8
> RBP: ffff8881d9af0030 R08: ffff8881d9af0240 R09: ffff8881da970180
> R10: 000000004afd69e7 R11: 0000000000000000 R12: ffff8881d9af01d8
> R13: 0000000000000002 R14: ffffea000766bc00 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 00000001bb987000 CR4: 00000000001406f0
> Call Trace:
> Modules linked in:
> ---[ end trace 1c9eb38e9e38ee03 ]---
> RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4450
> Code: 48 c7 c7 15 73 12 89 e8 97 e3 0a 00 5d c3 41 8b 91 04 01 00 00 48 29
> c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7 15
> 73 12 89 e8 fd eb 0a 00 44 89 e9 48 c7 c7 d0 73
> RSP: 0018:ffff8881d9af0030 EFLAGS: 00010093
> RAX: 00000000000a57eb RBX: 1ffff1103b35e00d RCX: 000000000000000c
> RDX: ffff8881d9af0240 RSI: 0000000000000002 RDI: ffff8881d9af01d8
> RBP: ffff8881d9af0030 R08: ffff8881d9af0240 R09: ffff8881da970180
> R10: 000000004afd69e7 R11: 0000000000000000 R12: ffff8881d9af01d8
> R13: 0000000000000002 R14: ffffea000766bc00 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 00000001bb987000 CR4: 00000000001406f0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005b7456057a9abc57%40google.com.
> For more options, visit https://groups.google.com/d/optout.
