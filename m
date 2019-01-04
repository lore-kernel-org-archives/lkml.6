Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF441C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D2208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7EazVJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfADLTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:19:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34560 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfADLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:19:45 -0500
Received: by mail-io1-f68.google.com with SMTP id b16so9629994ior.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhjB4kFYOvrG+2t2redIk+i3093mUIRr30vUDlxdlgU=;
        b=W7EazVJYN4KwvAJZ6CHN7tgCuTqKqRwJwcnvBiz5rOws6rvcl5nfAbcKn4hmtmqpTe
         iEz2yX3RUuQkDVeHuenBN2du2OGCENkYjh+XyCOQBcf9g7r5H6Ot0O5V6aZNT6kuEPCq
         JnNSGKVPhcpFnLRP6COFYe7xZnsDzPYpOh82JsZA40+x9earRf55XtYpuLSzeHWAm2M2
         w8+xs5XYYbPom3EBMmr4GnpNrmS/ozh4DPln/m7N01lJ0cX0pwYEO2IcCi4zttdhY1pJ
         KjPlXuCefsFBPfr34lVDBjTSiCZtChfLFkDnxV72prWEndUJvTH4JLLmb/RPkvr2TgE3
         dbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhjB4kFYOvrG+2t2redIk+i3093mUIRr30vUDlxdlgU=;
        b=lyu2WkfIih94Bc2a2bWk3fwUmeXgJ0D92HvsaCDsO0RxdIbR0ZyYhmqJanbXR1aNgt
         zL/pNpf+PdwqUHK/2nI5zqV+YSnyYLdBq7qCSVG5ymohbfEC/8Q9GMoJDI0SLRNQn5AE
         8kcsofPuuemX9Qm9rF4dtzcHrEZ1bqO1DXOPhs0cWiHH40JpJta5KrM3sF28cimUKaf4
         dhlGzj4D7nkMtgsBc4gRsOA+WiOyncEpRy0p/ofC6tlo6CxcZOzWzgW5xAFpPAIltUO2
         UUMGeEKrfF2IhYmthhgjfKZDbiW90VWgS5ifaqagvjRtKltWuZT/KgXDOkUkpni8u5kT
         SO0g==
X-Gm-Message-State: AJcUukfpEyYhmxvqLKTYZdnW5kg0KqT9UN7AMy5yQwRYkCoIRnB28QY9
        jJs9YWSA93ujpP8mYxiKejXGQQUmWRZsEO8XtZ/Lsw==
X-Google-Smtp-Source: ALg8bN4fJ7JvL6HpZJZ8H1+ebgTS1SzzEGnHJkVjl6qZyMWJPd96fzLZW2/qWq72ycT8r08uOMYJy/5kFOl2owKkWlU=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr9250154ior.282.1546600783503;
 Fri, 04 Jan 2019 03:19:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000db041505726f64d5@google.com>
In-Reply-To: <000000000000db041505726f64d5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 12:19:32 +0100
Message-ID: <CACT4Y+ZFJn3Afhy0LSUHV3dYBjN6KHXJ_Ws7=pf4hQucQ4uaxg@mail.gmail.com>
Subject: Re: kernel panic: corrupted stack end detected inside scheduler (3)
To:     syzbot <syzbot+05b2210c521c829a20f5@syzkaller.appspotmail.com>
Cc:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 10:14 AM syzbot
<syzbot+05b2210c521c829a20f5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    fea49f60c9b7 net: ethernet: ti: cpsw: replace unnecessaril..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d5fae8400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a9eba95cc5dd8e
> dashboard link: https://syzkaller.appspot.com/bug?extid=05b2210c521c829a20f5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=108ef064400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1022672c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+05b2210c521c829a20f5@syzkaller.appspotmail.com

We will probably lose a bunch of other bad bugs here (udp stack
overflow was introduced later than this report), but since nobody
looks at this anyways, for the purpose of keeping dashboard useful:

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2


> RBP: 00007ffdbb414a40 R08: 0000000020000000 R09: 000000000000001c
> R10: 0000000000000040 R11: 0000000000000216 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> Kernel panic - not syncing: corrupted stack end detected inside scheduler
>
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 6188 Comm: syz-executor748 Not tainted 4.18.0-rc6+ #165
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
> RIP: 0010:put_page include/linux/mm.h:913 [inline]
> RIP: 0010:tls_push_sg+0x2a3/0x880 net/tls/tls_main.c:133
> Code: fb 4d 39 e5 75 a2 e8 4c 5f d6 fb 48 8b 85 08 ff ff ff 49 8d 7f 08 48
> b9 00 00 00 00 00 fc ff df c6 00 00 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f
> 85 50 05 00 00 48 8b 85 08 ff ff ff 49 8b 5f 08 80
> RSP: 0018:ffff8801c9f1f7b8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffffffff85a5b634 RDI: 0000000000000008
> RBP: ffff8801c9f1f8d8 R08: ffff8801c7d88340 R09: 0000000000000000
> R10: fffff94000e38bc6 R11: ffffea00071c5e37 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  000000000119b880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8c0bf4a000 CR3: 00000001c777e000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   tls_push_record+0xaf3/0x1400 net/tls/tls_sw.c:247
>   tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:259
>   tls_handle_open_record net/tls/tls_main.c:155 [inline]
>   tls_sk_proto_close+0x759/0xb90 net/tls/tls_main.c:255
>   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
>   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>   __sock_release+0xd7/0x250 net/socket.c:597
>   sock_close+0x19/0x20 net/socket.c:1157
>   __fput+0x355/0x8b0 fs/file_table.c:209
>   ____fput+0x15/0x20 fs/file_table.c:243
>   task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>   exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4017f0
> Code: 01 f0 ff ff 0f 83 d0 0a 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 83 3d 3d 30 2d 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 a4 0a 00 00 c3 48 83 ec 08 e8 5a 01 00 00
> RSP: 002b:00007ffdbb414a28 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000004017f0
> RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000003
> RBP: 00007ffdbb414a40 R08: 0000000020000000 R09: 000000000000001c
> R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000004
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> Dumping ftrace buffer:
>     (ftrace buffer empty)
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
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000db041505726f64d5%40google.com.
> For more options, visit https://groups.google.com/d/optout.
