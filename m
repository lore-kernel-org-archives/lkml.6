Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DF920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejur7XvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DF920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeLLLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:03:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34678 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:03:12 -0500
Received: by mail-io1-f67.google.com with SMTP id w21so774562ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiwv8W5aZApI4t08boNWiUlMIqz8mcNbYp2Rg69YZj4=;
        b=Ejur7XvY7o22msNwrNyu3IyPnW2NNPzmv7LDYV8lZVdu9D9J4iPgcNP4XCs9jHC9Ad
         Op4Rvh6Kgl2XikoBnpxC7z308Ra1HaiqVZlbzFbQkIaz1NWh0MdLqkwdE1h3/TdGb5ma
         Xm7oekduiMydFPabmDNVMvduwYGt9gyfez/UYezPUyaZkBAC3L+iamP5ipGTffobLEJb
         aWsPDH1woeZedifH5WNKkWd+dqDZxCysA4phoKDC5rggA/D82JOlx1d/1mAwBHiPvobY
         MwXYe6gBlHMwL3xyi0NRksM8VVgvHC1jUEgGH3pUMAO4rd+Ud5JQEJObEUgKMhBLhV9k
         hovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiwv8W5aZApI4t08boNWiUlMIqz8mcNbYp2Rg69YZj4=;
        b=UVQlTSwKd/2eddgNE4GQ8reVhLv2RAXTyH5f8CkfSWI3DNXHpBR962uEf512cJikzB
         LQv8Vm8jATVVOo37lqKP09PIPFZY4glj0pTAoiJWeepK2DWrIhwV1gtPspbt3Xdjq1dO
         HERoQgy2BnwJ3tiqIuAYR7tEre/62P3EA3mYc+ciW92cxcw1vmdCs1vqzD85w7z3fLQb
         rX+fQmKNaoo+tjhvhgxGC4EAutcL4TiAg26wwfCJ7t8fssG3l6HZUa0nOrylugyzB3uq
         0S3DiRBFSl/y6H1RUg6ws5EtJeAb82+ec5Kyc/zZ+y+0c1D6T8CKp4QhjQCb35t4jLuh
         IdIA==
X-Gm-Message-State: AA+aEWYqtRzMvRFfTbB+Uce+xaN2J9V+OM1HEM4YHUWgA3h8xXD9SXuL
        FQSMykda68RBCXMA8zy/RjyqUWRUwoIrerkJthU+5w==
X-Google-Smtp-Source: AFSGD/Viz2xZ4ASFyJ+/eW7GdYaCB1ij9iKwe+Fxn6izCnGk1055UllooHQXsC5wX5cCyu7ut/vF+/QAEGF76RhYD0E=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr16086483iom.11.1544612590456;
 Wed, 12 Dec 2018 03:03:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e68826057cd10e99@google.com>
In-Reply-To: <000000000000e68826057cd10e99@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Dec 2018 12:02:59 +0100
Message-ID: <CACT4Y+avtWqGKCyJGL=W407GW9Z8pTZfrUnUjh2AuxR9q4fnFQ@mail.gmail.com>
Subject: Re: general protection fault in __ip_append_data
To:     syzbot+aab62b9c7b12e7c6ab0b@syzkaller.appspotmail.com,
        Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        David Miller <davem@davemloft.net>,
        tipc-discussion@lists.sourceforge.net
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:57 AM syzbot
<syzbot+aab62b9c7b12e7c6ab0b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e03afb400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> dashboard link: https://syzkaller.appspot.com/bug?extid=aab62b9c7b12e7c6ab0b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb9c8b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1261667d400000

From the reproducer it looks like a dup of TIPC bug:

#syz dup: KASAN: use-after-free Read in kfree_skb (2)



> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+aab62b9c7b12e7c6ab0b@syzkaller.appspotmail.com
>
> Enabling of bearer <udp:syz1> rejected, already enabled
> Enabling of bearer <udp:syz1> rejected, already enabled
> Enabling of bearer <udp:syz1> rejected, already enabled
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.20.0-rc6+ #371
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__ip_append_data.isra.48+0x31a/0x29b0 net/ipv4/ip_output.c:896
> Code: c7 85 c8 fd ff ff 00 00 00 00 0f 85 12 10 00 00 e8 7b c1 e0 fa 48 8b
> 95 48 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f
> 85 e5 22 00 00 48 8b 85 48 fe ff ff 48 8b 18 48 b8
> RSP: 0018:ffff8881d9b569c0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff869ec275
> RDX: 0000000000000000 RSI: ffffffff869ec2f5 RDI: 0000000000000001
> RBP: ffff8881d9b56c28 R08: ffff8881d9b4a440 R09: ffffffff86b113b0
> R10: ffff8881d9b56da0 R11: 0000000000000000 R12: ffff8881d2c18a88
> R13: ffffffff86258ba0 R14: ffffffff8bc37110 R15: ffff8881d2c18cd8
> FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001ac0 CR3: 00000001cb6ea000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ip_append_data.part.49+0xef/0x170 net/ipv4/ip_output.c:1197
>   ip_append_data+0x6d/0x90 net/ipv4/ip_output.c:1186
>   icmp_push_reply+0x18e/0x540 net/ipv4/icmp.c:375
>   icmp_send+0x1544/0x1bd0 net/ipv4/icmp.c:736
>   __udp4_lib_rcv+0x2484/0x32e0 net/ipv4/udp.c:2233
>   udp_rcv+0x21/0x30 net/ipv4/udp.c:2392
>   ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
>   NF_HOOK include/linux/netfilter.h:289 [inline]
>   ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
>   dst_input include/net/dst.h:450 [inline]
>   ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
>   NF_HOOK include/linux/netfilter.h:289 [inline]
>   ip_rcv+0xed/0x600 net/ipv4/ip_input.c:524
>   __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4946
>   __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5056
>   process_backlog+0x24e/0x7a0 net/core/dev.c:5864
>   napi_poll net/core/dev.c:6287 [inline]
>   net_rx_action+0x7fa/0x19b0 net/core/dev.c:6353
>   __do_softirq+0x308/0xb7e kernel/softirq.c:292
>   run_ksoftirqd+0x5e/0x100 kernel/softirq.c:654
>   smpboot_thread_fn+0x68b/0xa00 kernel/smpboot.c:164
>   kthread+0x35a/0x440 kernel/kthread.c:246
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Modules linked in:
> ---[ end trace 762165cda5fdc138 ]---
> Enabling of bearer <udp:syz1> rejected, already enabled
> RIP: 0010:__ip_append_data.isra.48+0x31a/0x29b0 net/ipv4/ip_output.c:896
> Code: c7 85 c8 fd ff ff 00 00 00 00 0f 85 12 10 00 00 e8 7b c1 e0 fa 48 8b
> 95 48 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f
> 85 e5 22 00 00 48 8b 85 48 fe ff ff 48 8b 18 48 b8
> Enabling of bearer <udp:syz1> rejected, already enabled
> RSP: 0018:ffff8881d9b569c0 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff869ec275
> RDX: 0000000000000000 RSI: ffffffff869ec2f5 RDI: 0000000000000001
> RBP: ffff8881d9b56c28 R08: ffff8881d9b4a440 R09: ffffffff86b113b0
> R10: ffff8881d9b56da0 R11: 0000000000000000 R12: ffff8881d2c18a88
> R13: ffffffff86258ba0 R14: ffffffff8bc37110 R15: ffff8881d2c18cd8
> Enabling of bearer <udp:syz1> rejected, already enabled
> FS:  0000000000000000(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001ac0 CR3: 000000000946a000 CR4: 00000000001406e0
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
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e68826057cd10e99%40google.com.
> For more options, visit https://groups.google.com/d/optout.
