Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F02217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehwrueo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfBDIFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:05:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53194 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfBDIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:05:11 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so19109339itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQj/dh6VAgQFa+1tySNn9ShFDbfk2x0+fU0jXlNf0h4=;
        b=ehwrueo97Vw+XuWFKnA0rYJN6rJ9ad32GY7ZL24yBWvFpnfe2YZQ4sdP/eWepMXgrw
         Zkp1f/1kZraxCWTGDDVARyXhxMrSvJ0bXBvniXUuXPVTZ5Evt6ong3MYR9U2yLSFBLbp
         GyCusws9R1Qj6fCODEEY+0RMq976IRiFTps//DxomoS4gic/MaLbFHY2pWPvWE34Rz22
         vXao9GjuRgVRJKMXkOrQm4EgwntCTmFlL63jTUlAtwR7cnHu7pelpDSTV35RmB4/5w1e
         bRW7Pxuv+kYdpIPEjI3e1QUJeoi9Dn0gNXkxUcdo3cAJvrmGKP9QDQFqyF+CY9MMnHfO
         U1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQj/dh6VAgQFa+1tySNn9ShFDbfk2x0+fU0jXlNf0h4=;
        b=p4se3AR9dGmrhb6hF0KWDevJepmqH7fP0L3gQi4DvHtnBqtzYRl69NRCAdImn/mj6M
         ZVmLt1oa/GqIZy/YEbCoQFZ5//e9Ggt5xspVj9ZKAvAWik4TBmqSCwgc7enVkVb8Seem
         cTmdu4TINNbTsrkifMrwoVMQMMxBouChvOO4kyWHMd2tXDGm46XhA3ePv97xP2oxoNK4
         Bahii30rg+jsweffpUbuEZ2XGajQTN0PusA6VKVv86apcXQV1nUEfEfgxpjsK/K3AoOE
         HpoF0l3QC8XfqXo4SfXC88AcuiLhSqHSr3E1LDkOHx2HjK2KaRB9nsqVxH7FiHZ1tFbl
         jLww==
X-Gm-Message-State: AHQUAuaz+SuyD9ghEPbpFgBRi18/5UALfNCH7DMi2hGiUo24+Z3T2Bvy
        yHyWwHm+FNRmfbIh6xoWjrIduIzrE1kzKZrqgHqJZQ==
X-Google-Smtp-Source: AHgI3IYSZ/Gn3iFFz/ixKHbGCmxwEf7Lm413UdYCqede+l9Wh+maVgAq5LaLOYFBhnsVysL7qF+SJ0CQMB7rPr0uLkw=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr15247317iom.11.1549267510191;
 Mon, 04 Feb 2019 00:05:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ea7ffe057edb3156@google.com>
In-Reply-To: <000000000000ea7ffe057edb3156@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Feb 2019 09:04:59 +0100
Message-ID: <CACT4Y+YSXHpxBgb4SSag71Naf_BsjPV8AdFiXYu+hLz8CVsgDw@mail.gmail.com>
Subject: Re: WARNING: refcount bug in nr_release
To:     syzbot <syzbot+b0b1952f5864b4009b09@syzkaller.appspotmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        linux-hams <linux-hams@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:53 AM syzbot
<syzbot+b0b1952f5864b4009b09@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f1c2f8857c5a Merge tag 'powerpc-4.21-2' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16af96bb400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47c29c309c47af16
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0b1952f5864b4009b09
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b0b1952f5864b4009b09@syzkaller.appspotmail.com

#syz fix: netrom: switch to sock timer API

> ------------[ cut here ]------------
> refcount_t: increment on 0; use-after-free.
> WARNING: CPU: 1 PID: 3768 at lib/refcount.c:153 refcount_inc_checked
> lib/refcount.c:153 [inline]
> WARNING: CPU: 1 PID: 3768 at lib/refcount.c:153
> refcount_inc_checked+0x61/0x70 lib/refcount.c:151
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 3768 Comm: syz-executor5 Not tainted 4.20.0+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   panic+0x2cb/0x65c kernel/panic.c:214
>   __warn.cold+0x20/0x48 kernel/panic.c:571
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   fixup_bug arch/x86/kernel/traps.c:173 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:refcount_inc_checked lib/refcount.c:153 [inline]
> RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:151
> Code: 1d ec 29 c8 06 31 ff 89 de e8 fb 1a f2 fd 84 db 75 dd e8 b2 19 f2 fd
> 48 c7 c7 e0 98 81 88 c6 05 cc 29 c8 06 01 e8 df 6e bb fd <0f> 0b eb c1 90
> 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49
> RSP: 0018:ffff8880675af460 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81684ce6 RDI: 0000000000000005
> RBP: ffff8880675af470 R08: ffff88806164e600 R09: ffffed1015ce5021
> R10: ffffed1015ce5020 R11: ffff8880ae728107 R12: ffff88808cf2a940
> R13: ffff88809669c1a0 R14: ffff88808cf2ac28 R15: ffff88808cf2a940
>   sock_hold include/net/sock.h:647 [inline]
>   nr_release+0x62/0x3c0 net/netrom/af_netrom.c:523
>   __sock_release+0xd3/0x250 net/socket.c:579
>   sock_close+0x1b/0x30 net/socket.c:1141
>   __fput+0x3c5/0xb10 fs/file_table.c:278
>   ____fput+0x16/0x20 fs/file_table.c:309
>   task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x19d6/0x2650 kernel/exit.c:867
>   do_group_exit+0x177/0x430 kernel/exit.c:970
>   get_signal+0x8b4/0x19b0 kernel/signal.c:2517
>   do_signal+0x91/0x1ea0 arch/x86/kernel/signal.c:816
>   exit_to_usermode_loop+0x2f7/0x3b0 arch/x86/entry/common.c:162
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb2e6be7cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000073c048 RCX: 0000000000457ec9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000073c048
> RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000073c04c
> R13: 00007fffae482f5f R14: 00007fb2e6be89c0 R15: 000000000073c04c
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
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ea7ffe057edb3156%40google.com.
> For more options, visit https://groups.google.com/d/optout.
