Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5jm1DTCHGltoAwAAmS7hNA
	; Fri, 08 Jun 2018 13:40:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1A9BF602FC; Fri,  8 Jun 2018 13:40:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7aC5Jvf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 413E260590;
	Fri,  8 Jun 2018 13:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 413E260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFHNj5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:39:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47044 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeFHNjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:39:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so8336589pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GWEzuKM7vvnHQTkGBDBWKlB+1+1xc74a7BMLOnD24Qc=;
        b=X7aC5JvfRuCKjrKTMAF5H/mFIQOnHZdan+uOU/iyYpifjH07KkK0pD1ccCZ5MRMiIj
         Mp0ha+pWREu4ygAMqHJfz9PcLXmCYgCt1PEy25HeFQVl8dHS8nZFHvJ1SgXGAA0bDXK0
         UxPXgSKFa9RBmxE86yshifiTfE/D48egb3gnNsDe4uPDUWltFjfS/wu6qXtr9xj6gRfV
         64P/f9ltugH6ODS579hQfcbT482eUtifTYD1WxtogNKnxxLp5x5bDMRyER82eicaiemq
         aTvpvY2g8auvuE7tRVEAwG6U5gLr3RdtQ0ZC4UPT4yR6pYF2hum4lKY9977TQmWEFMG5
         DCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GWEzuKM7vvnHQTkGBDBWKlB+1+1xc74a7BMLOnD24Qc=;
        b=d3X29cQ+JIUGxmSW2M3HGDkoV7lpGf5k0RlSkELB09z54g2Akr5zqu0B68VeFILcwK
         OMMweRFux+EyRdP32ZaeBM8kfnUEIQroHh/GyZgYFT8voVkaNVJvDbUOdKSRp7NLovoO
         uNI+KFh+0lj+4Yr2sq5nvVnRC5eKBCRun7dT5kBXXesq6HWmeORXZ77+vD9CHgcxv7Up
         ckSfEud14CtGlqw5cXLJBCWojKhqq/+zVeY3Vyym1btb5cMT0g6WkkO3QLVJkUBpl3no
         kHqoxxSJQnk5BQdtqIHssb8H2ij9hKE4/ImrhsMs0loGDGCR6X2NY+z9+UunaD3hlfgp
         hL6w==
X-Gm-Message-State: APt69E3tuYFIaBFqQ4be5h44D3Okp4mw6HieDPKst2aJi6zAnE+lc6dR
        VPwU0m0ZGYtnjtQppwJtbwAdUHlnj3PBurQoRIj5SkpY9wk=
X-Google-Smtp-Source: ADUXVKIYj1KzZjPObCrpU2mvYYGKO8A+M0MtCpqz6za8XbH23G6p6tI5O9A0gOBDjdRhqT9WEeTcje1LzFIWrqj0cqc=
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr6888177pls.264.1528465191365;
 Fri, 08 Jun 2018 06:39:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:39:30
 -0700 (PDT)
In-Reply-To: <000000000000b98577056e212120@google.com>
References: <000000000000b98577056e212120@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 15:39:30 +0200
Message-ID: <CACT4Y+Z9PL4m85TGBfoLLOrw3PtqiCf+vLgdXnLUMPmHcBC33A@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in corrupted
To: syzbot <syzbot+f5066e369b2d5fff630f@syzkaller.appspotmail.com>,
        ubraun@linux.ibm.com, linux-s390@vger.kernel.org
Cc: David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 3:11 PM, syzbot
<syzbot+f5066e369b2d5fff630f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    68abbe729567 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f7cebf800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a4673d4582131c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f5066e369b2d5fff630f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1191756f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162236af800000

The reproducer suggests that this is in smc.
+smc maintainers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f5066e369b2d5fff630f@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> PGD 1b51e5067 P4D 1b51e5067 PUD 1b508f067 PMD 0
> Oops: 0010 [#1] SMP KASAN
> CPU: 1 PID: 4485 Comm: syz-executor452 Not tainted 4.17.0+ #90
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:          (null)
> Code: Bad RIP value.
> RSP: 0018:ffff8801b6f273a0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8801b629b800 RCX: 1ffffffff10ea805
> RDX: ffff8801b6f27c00 RSI: ffff8801ae67a100 RDI: ffff8801b51feac0
> RBP: ffff8801b6f27510 R08: ffff8801b563cf78 R09: 0000000000000006
> R10: ffff8801b563c740 R11: 0000000000000000 R12: 1ffff10036de4e79
> R13: ffff8801b6f27c00 R14: ffff8801b629b812 R15: ffff8801b629bc58
> FS:  0000000001c2b880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000001b5625000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  sock_poll+0x1d1/0x710 net/socket.c:1156
>  vfs_poll+0x77/0x2a0 fs/select.c:40
>  ep_item_poll.isra.15+0x2c1/0x390 fs/eventpoll.c:887
>  ep_insert+0x6b8/0x1c00 fs/eventpoll.c:1459
>  __do_sys_epoll_ctl fs/eventpoll.c:2113 [inline]
>  __se_sys_epoll_ctl fs/eventpoll.c:1999 [inline]
>  __x64_sys_epoll_ctl+0xef1/0x10f0 fs/eventpoll.c:1999
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43fcc9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff59e3a2f8 EFLAGS: 00000217 ORIG_RAX: 00000000000000e9
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fcc9
> RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000020000000 R11: 0000000000000217 R12: 00000000004015f0
> R13: 0000000000401680 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> CR2: 0000000000000000
> ---[ end trace 090a30b2125a99a3 ]---
> RIP: 0010:          (null)
> Code: Bad RIP value.
> RSP: 0018:ffff8801b6f273a0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8801b629b800 RCX: 1ffffffff10ea805
> RDX: ffff8801b6f27c00 RSI: ffff8801ae67a100 RDI: ffff8801b51feac0
> RBP: ffff8801b6f27510 R08: ffff8801b563cf78 R09: 0000000000000006
> R10: ffff8801b563c740 R11: 0000000000000000 R12: 1ffff10036de4e79
> R13: ffff8801b6f27c00 R14: ffff8801b629b812 R15: ffff8801b629bc58
> FS:  0000000001c2b880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 00000001b5625000 CR4: 00000000001406e0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b98577056e212120%40google.com.
> For more options, visit https://groups.google.com/d/optout.
