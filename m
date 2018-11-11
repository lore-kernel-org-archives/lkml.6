Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E0620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df7Mmwz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E0620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeKLENr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:13:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51743 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeKLENr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:13:47 -0500
Received: by mail-it1-f195.google.com with SMTP id m34-v6so9658962iti.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kDtAPGl17qd5q+6PCUnbgtmNwqBOJ/fqiPSP6AzIP7A=;
        b=df7Mmwz1tqBrC5L3XMVks0yhUh6pF9JDM0aPwW0bVTPF+HWB8OxoghL97vXBNAkS1U
         N9Nm0m/h4o99SetNMqkK7fy+vsRoy7bbj6q67naAsAKOiGPiyPHPq9zFAVLgJw+leO5Z
         1AxU3ENSBBkVfXkkcOphY6XIHGlQHAY6ad/Lsg+A9RYFo9Npf1aDvcogPfDovrmnd64g
         X+XWsMAyxKfmmaUzBxO7qn9UTnPkrnMIeaIo51SB9b3H/NRTTYIo9uQjZkOI9GQc6xd9
         gfcYy6oYalDXTZZCA/VpRhWm9F0KGDEBra//okHQFLqHTb7oCDMjOP/ccyD7iHqSNX5s
         8xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kDtAPGl17qd5q+6PCUnbgtmNwqBOJ/fqiPSP6AzIP7A=;
        b=f6GYPeKyqd2N9eYTWwm55C6eUmOiu/uYPIw3kMhByTlhUZjgQGvOYZQxMUs3U2hhLm
         gD6LbHTAUrDHzgKES5ZPTonk1THikhT6475jdKJnrr29gSX+lpfYzX8eWxBeMZTW95GE
         h6kdHnN2qzL+KCULywDc7qjBluEgUSpQZ6G06HgBLK5MLpHfToDRmIXTHZzlISH89o64
         APNSFEZEjNzAQUkKbtKAZHo8YR2/pJbpcJIqdp13z5ghyoxqSFeAmy6AdDjYx3ZZ88gy
         6abcZRgaAU68Ma7qJrJp89mO2KTuk97MrD0MFjlhfmLZnIANeP0ckLcorh6XDzwV42vJ
         VWIw==
X-Gm-Message-State: AGRZ1gL3ThDG1f9R022Y0PX5+nHc6q50t5X8n9DNIr9c1biNVBE2/3xN
        Mp5+M43Qvf8tPePcog/DBUbVZ6iEpbPyUshFlr2p2IS+wRsFKQ==
X-Google-Smtp-Source: AJdET5fRqw5pwe9J+ZRpysDKkcQ7u1pbEkd90yB2G3oNvzH9ZUE0IRA/I7P2q5/qjWEf9mQGHSC3CUyl66BypYe5I6k=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr7164065itf.166.1541960671258;
 Sun, 11 Nov 2018 10:24:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 10:24:10
 -0800 (PST)
In-Reply-To: <000000000000fd464c057a679adb@google.com>
References: <000000000000fd464c057a679adb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 11 Nov 2018 10:24:10 -0800
Message-ID: <CACT4Y+YSGC-NMhyeQ0ZT-QmFgPsnC0VQ4QAcBn9RcJcL2h1v-g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in update_blocked_averages
To:     syzbot <syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:18 AM, syzbot
<syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    12ceaf8864c2 infiniband: nes: Fix more direct skb list acc..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a82783400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcbea7daf3ea3e3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0dbf864d3b52555e8265
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ae6d5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbd77b400000

Looking at the reproducer this looks network related, +netdev

r0 = socket$inet6(0xa, 0x2, 0x0)
connect$inet6(r0, &(0x7f0000000100)={0xa, 0x0, 0x0, @dev, 0x6}, 0x1c)
connect$inet6(r0, &(0x7f0000000580)={0xa, 0x4e22, 0x0, @ipv4={[], [],
@local}}, 0x1c)
sendmmsg(r0, &(0x7f00000092c0), 0x4ff, 0x0)


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: use-after-free in skip_blocked_update kernel/sched/fair.c:3324
> [inline]
> BUG: KASAN: use-after-free in update_blocked_averages+0x1533/0x1e00
> kernel/sched/fair.c:7400
> kasan: CONFIG_KASAN_INLINE enabled
> Read of size 8 at addr ffff8801bf0d6ea0 by task syz-executor841/6015
>
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> CPU: 1 PID: 6015 Comm: syz-executor841 Not tainted 4.20.0-rc1+ #289
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> CPU: 0 PID: 6272 Comm: syz-executor841 Not tainted 4.20.0-rc1+ #289
> Call Trace:
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
> RIP: 0010:vmalloc_fault+0x426/0x770 arch/x86/mm/fault.c:405
> Code: e0 e8 fe 25 47 00 48 b8 00 00 00 00 00 88 ff ff 48 ba 00 00 00 00 00
> fc ff df 48 01 c3 4d 21 e5 4c 01 eb 48 89 d9 48 c1 e9 03 <80> 3c 11 00 0f 85
> b2 02 00 00 48 8b 1b 31 ff 49 89 dc 49 83 e4 9f
> RSP: 0018:ffff8801d9d624c8 EFLAGS: 00010002
> RAX: ffff880000000000 RBX: 000f100180000040 RCX: 0001e20030000008
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> RDX: dffffc0000000000 RSI: ffffffff813864c2 RDI: 0000000000000007
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> RBP: ffff8801d9d624f8 R08: ffff8801bbb56700 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 000fffffc0000000
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> R13: 000f880180000000 R14: ffffc90001159838 R15: 1ffffffff12a3f98
>  skip_blocked_update kernel/sched/fair.c:3324 [inline]
>  update_blocked_averages+0x1533/0x1e00 kernel/sched/fair.c:7400
> FS:  0000000001f7d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90001159838 CR3: 00000001ba705000 CR4: 00000000001406f0
> Call Trace:
> Modules linked in:
> ---[ end trace f6450057874cc9c7 ]---
> RIP: 0010:vmalloc_fault+0x426/0x770 arch/x86/mm/fault.c:405
> Code: e0 e8 fe 25 47 00 48 b8 00 00 00 00 00 88 ff ff 48 ba 00 00 00 00 00
> fc ff df 48 01 c3 4d 21 e5 4c 01 eb 48 89 d9 48 c1 e9 03 <80> 3c 11 00 0f 85
> b2 02 00 00 48 8b 1b 31 ff 49 89 dc 49 83 e4 9f
> RSP: 0018:ffff8801d9d624c8 EFLAGS: 00010002
> RAX: ffff880000000000 RBX: 000f100180000040 RCX: 0001e20030000008
> RDX: dffffc0000000000 RSI: ffffffff813864c2 RDI: 0000000000000007
> RBP: ffff8801d9d624f8 R08: ffff8801bbb56700 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 000fffffc0000000
> R13: 000f880180000000 R14: ffffc90001159838 R15: 1ffffffff12a3f98
> FS:  0000000001f7d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc90001159838 CR3: 00000001ba705000 CR4: 00000000001406f0
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fd464c057a679adb%40google.com.
> For more options, visit https://groups.google.com/d/optout.
