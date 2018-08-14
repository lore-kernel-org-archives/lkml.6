Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8556C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5992521570
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvhnGFFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5992521570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeHNSra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:47:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39718 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbeHNSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:47:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id g18-v6so13680524uam.6;
        Tue, 14 Aug 2018 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G7RbFbNdZKSMk8L0NcExZ2wvdBNk1k2X6oWU6Bgb1Hg=;
        b=cvhnGFFcBuuW3zA2oiEJuq73wHHQ7HGMa5iPzrJ5kQ7bwG7dFQV3c9dFop8d09nWb9
         BYDmH93N3iA9000TpBBxnpGlWMnw0RXpJZWpDsqRsCOiE05y/9lX9hP25yC4jPD0k9Jm
         +DXIRuRjZC8pqLABL+76NLUODXFQ6uMZZLOyO4bk0p8JIGKfMstfjKtsh5PlUz4U+qYo
         ITt1mZKvjLhxTXSoVv0/ffx8Nobrn6IcPyAfW07FvpB45MwgXeenwa7qi+O67ou3TxTH
         /ghTsG3tmMfzhltVI2xqxqyqZXTXD9Wbq3ihSRpAUUqlzz9btDbXay2ZlPx820km63LN
         S+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G7RbFbNdZKSMk8L0NcExZ2wvdBNk1k2X6oWU6Bgb1Hg=;
        b=PdMNDQK55Z1Zv7tMTMtoF6gxKcKVyFih0I5T7mt4Lf89XaZDbB5EP1nbboo4WJXxEF
         Xv5A42auHQfsLI4MsBQxSVDDcOoaHyBrB8CGeFy7MpCsBL/7LXVjBgB9N0BAko4DNLE6
         oIAxYNxIKEW19XKcUQt8vTBZE3uU6aVnZaA2KbC1RH4lm1vbopJmUIOh04xoIlz3DuQN
         6N9lcmB3s+8iKIFWhNMq2P62hK2UGuqkg8bpF/BmKbRCQEH7eDHthfEjMBBLnxeWQl/a
         dAh8yPssHRZI60q+i9gmUuBm+xrRT/MTb91femAhidhvjeBYmZObmJO8RuRyqPWMfHMv
         tPjQ==
X-Gm-Message-State: AOUpUlFV40lmbHrI12VD2gqlc0X+Z+gcadJKAJXK2UHqwpd/Uz4Xyhgk
        sQ2HkE8WXx8gRNJFtVyeV0vuCGxVyxsHHwtfqaA=
X-Google-Smtp-Source: AA+uWPzmqIea7SAxGvUrSHjIa4I02vzNKE8dLhO+qkcEpEDprl6jii+V/SuW8816UYX1NUS0p+At2sj2bbRRMqxzJYE=
X-Received: by 2002:ab0:5507:: with SMTP id t7-v6mr14476075uaa.100.1534262384778;
 Tue, 14 Aug 2018 08:59:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7f52:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 08:59:04
 -0700 (PDT)
In-Reply-To: <000000000000863a6e057361feb4@google.com>
References: <000000000000863a6e057361feb4@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Tue, 14 Aug 2018 08:59:04 -0700
Message-ID: <CAH3MdRWZHkpTq+Pr5Fe6bcEYpYGOhyrfHLd6rjf3s66wr+aR+w@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in bpf_prog_array_copy_core
To:     syzbot <syzbot+6e72317008eef84a216b@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:40 AM, syzbot
<syzbot+6e72317008eef84a216b@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=109bac02400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e72317008eef84a216b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=157ef48a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e16cf8400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6e72317008eef84a216b@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
>
> =============================
> WARNING: suspicious RCU usage
> 4.18.0-rc8-next-20180810+ #36 Not tainted
> -----------------------------
> kernel/bpf/core.c:1582 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syz-executor287/4449:
>  #0: 00000000d8131c0c (&ctx->mutex){+.+.}, at:
> perf_event_ctx_lock_nested+0x375/0x600 kernel/events/core.c:1276
>  #1: 000000006c916250 (bpf_event_mutex){+.+.}, at:
> perf_event_query_prog_array+0x1c6/0x380 kernel/trace/bpf_trace.c:1062
>
> stack backtrace:
> CPU: 1 PID: 4449 Comm: syz-executor287 Not tainted 4.18.0-rc8-next-20180810+
> #36
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4562
>  bpf_prog_array_copy_core+0x2d9/0x360 kernel/bpf/core.c:1582
>  bpf_prog_array_copy_info+0x9a/0x110 kernel/bpf/core.c:1720
>  perf_event_query_prog_array+0x22e/0x380 kernel/trace/bpf_trace.c:1063
>  _perf_ioctl+0x986/0x1600 kernel/events/core.c:5079
>  perf_ioctl+0x59/0x80 kernel/events/core.c:5110
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:501 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>  __do_sys_ioctl fs/ioctl.c:709 [inline]
>  __se_sys_ioctl fs/ioctl.c:707 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440409
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fffc5fc1488 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440409
> RDX: 0000000020000180 RSI: 00000000c008240a RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401c90
> R13: 0000000000401d20 R14: 0000000000000000
>

I will take a look at this one.
We have a mutex lock at kernel/trace/bpf_trace.c,

1062         mutex_lock(&bpf_event_mutex);
1063         ret = bpf_prog_array_copy_info(event->tp_event->prog_array,
1064                                        ids,
1065                                        ids_len,
1066                                        &prog_cnt);
1067         mutex_unlock(&bpf_event_mutex);

We may need a variant of rcu_dereference, e.g., rcu_dereference_protected.

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
