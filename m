Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A151DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2452403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPzpUcR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2452403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGEQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:18:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40807 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbeGEQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:18:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so1483546plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0IkDIewOXB7XaxpZVdXQyJKeomg82arDLwjBV1lqUuU=;
        b=nPzpUcR0lHgq+688s94fwgCmpNLigVEAz/VCvS5QyFDKaTwKtmNqCHKz7nboNk6Ty5
         sWZgUVHjaqXKmXhttkWB5Q72S5SVvZrNkOI9JREZDolDplrhclsNw23O2HaeJW+Dht4p
         fxlUObb6O6yX2+Y94ymTAQJP5TScR4j2jeJKvlxgjA+ak+CD22XKMJHpu9J1ALAtmUTo
         eVIjEY7uzRv76i8RsqLBQ2Xexes1+GXhWxPtHT6vZTBfqXG9j3XfMe5VJTAoGm4a7Tm1
         rNRBooe55QEMtIBK5cqvsKw/zTupPPRL2hKQXfaZIDoUxMmrezX0l/BOLrGk3APG2yOT
         qK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0IkDIewOXB7XaxpZVdXQyJKeomg82arDLwjBV1lqUuU=;
        b=P9/w0+3Jr8j2EQXoWKYBr7ICqqMDpQ7V4WC8GS+LAEcbhnXil0Wm4boL1/vl2oPBEn
         SW+9FpiTVo7qxia+av4R4n/u7ADmU1+3kQhg4JiZqeiV3s9v7KkoZIO4SIM1NkauWU33
         HcBW8pYa18lLlBo/Mq9Abw1ftx1X7R2yS7Fa8HtUeVUh/+KJb/iBmVp3qmJL40kTSQm0
         1c8y4MsbwEMfcTdFWtZ6Nkw13sNGEHOkFXpwHk7Yd6ztPai1YGmGWp/rM7b6J+AOlfTo
         +uNrstxJ8wW/N2ZW0q2xLGeAZ359c1/oqdTOVrMUUq47Pavjzp3OmfqnWRInOn5mRbIt
         zMoA==
X-Gm-Message-State: APt69E2lb8TYBgqIUSZEdxmq6zbcJ3SMc/EKTJgrNrJ6UwpR5nCG3S83
        IScZOpkZCutexg54cf7rRYxEzKz+tohnpThUmtnRgQ==
X-Google-Smtp-Source: AAOMgpfr2j9xglpCDaI0GIptQoDKTP7sBA6T2Y/PvX7DRQveiUxqkaKEuBaF25VgjAqhjjYwwp/2kEzNEhkUEwmZonE=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr6694702plr.264.1530807495505;
 Thu, 05 Jul 2018 09:18:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:17:55
 -0700 (PDT)
In-Reply-To: <000000000000eddf7305703967c6@google.com>
References: <000000000000eddf7305703967c6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:17:55 +0200
Message-ID: <CACT4Y+ZTWznd1fyeHaioJahpKsQXTU9iS5M0ZSphQSYzYyieYQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __neigh_create
To:     syzbot <syzbot+4dcaeea39647ed97d4c1@syzkaller.appspotmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsa@cumulusnetworks.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        w.bumiller@proxmox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 6:59 AM, syzbot
<syzbot+4dcaeea39647ed97d4c1@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d40858400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=4dcaeea39647ed97d4c1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=174aae68400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120a0a1c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4dcaeea39647ed97d4c1@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in __neigh_create+0x1e93/0x2080
> net/core/neighbour.c:522
> Read of size 8 at addr ffff8801d4832220 by task kworker/1:2/2005
>
> CPU: 1 PID: 2005 Comm: kworker/1:2 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: ipv6_addrconf addrconf_dad_work
> Call Trace:
> ------------[ cut here ]------------
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> do_IRQ(): syz-executor810 has overflown the kernel stack
> (cur:ffff8801d6450000,sp:ffff8801ce2cbd68,irq stk
> top-bottom:ffff8801dae00080-ffff8801dae08000,exception stk
> top-bottom:fffffe0000007080-fffffe0000011000,ip:lock_release+0x87/0xa30)
> WARNING: CPU: 0 PID: 4713 at arch/x86/kernel/irq_64.c:63
> stack_overflow_check arch/x86/kernel/irq_64.c:60 [inline]
> WARNING: CPU: 0 PID: 4713 at arch/x86/kernel/irq_64.c:63
> handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:72
> Kernel panic - not syncing: panic_on_warn set ...
>
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __neigh_create+0x1e93/0x2080 net/core/neighbour.c:522
>  ip6_finish_output2+0xa5d/0x2820 net/ipv6/ip6_output.c:117
>  ip6_finish_output+0x5fe/0xbc0 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
>  ip6_output+0x234/0x9d0 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  NF_HOOK include/linux/netfilter.h:287 [inline]
>  ndisc_send_skb+0x100d/0x1570 net/ipv6/ndisc.c:491
>  ndisc_send_ns+0x3c1/0x8d0 net/ipv6/ndisc.c:633
>  addrconf_dad_work+0xbf2/0x1310 net/ipv6/addrconf.c:4061
>  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> CPU: 0 PID: 4713 Comm: syz-executor810 Not tainted 4.18.0-rc3+ #45
> Allocated by task 4511:
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> Call Trace:
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  <IRQ>
>  __do_kmalloc mm/slab.c:3718 [inline]
>  __kmalloc_track_caller+0x14a/0x760 mm/slab.c:3733
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  kmemdup+0x24/0x50 mm/util.c:118
>  kmemdup include/linux/string.h:418 [inline]
>  neigh_parms_alloc+0xea/0x6b0 net/core/neighbour.c:1492
>  ipv6_add_dev+0x3ec/0x13b0 net/ipv6/addrconf.c:392
>  panic+0x238/0x4e7 kernel/panic.c:184
>  addrconf_notify+0x9fb/0x27f0 net/ipv6/addrconf.c:3435
>  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1735
>  call_netdevice_notifiers net/core/dev.c:1753 [inline]
>  register_netdevice+0xb9d/0x1100 net/core/dev.c:8183
>  veth_newlink+0x5f5/0xa70 drivers/net/veth.c:443
>  rtnl_newlink+0xeff/0x1d60 net/core/rtnetlink.c:3050
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  rtnetlink_rcv_msg+0x46e/0xc30 net/core/rtnetlink.c:4662
>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4680
>  report_bug+0x252/0x2d0 lib/bug.c:186
>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1336
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:641 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:651
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2125
>  __sys_sendmsg+0x11d/0x290 net/socket.c:2163
>  __do_sys_sendmsg net/socket.c:2172 [inline]
>  __se_sys_sendmsg net/socket.c:2170 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2170
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> Freed by task 0:
> RIP: 0010:stack_overflow_check arch/x86/kernel/irq_64.c:60 [inline]
> RIP: 0010:handle_irq+0x1fb/0x2e7 arch/x86/kernel/irq_64.c:72
> (stack is not available)
> Code:
>
> 00
> The buggy address belongs to the object at ffff8801d4832200
>  which belongs to the cache kmalloc-192 of size 192
> 00
> The buggy address is located 32 bytes inside of
>  192-byte region [ffff8801d4832200, ffff8801d48322c0)
> ff
> The buggy address belongs to the page:
> b6 80
> page:ffffea0007520c80 count:1 mapcount:0 mapping:ffff8801da800040 index:0x0
> 00
> 00 00
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea00074f9d48 ffffea0007526848 ffff8801da800040
> 48
> raw: 0000000000000000 ffff8801d4832000 0000000100000010 0000000000000000
> c7 c7
> page dumped because: kasan: bad access detected
> 40
>
> bc
> Memory state around the buggy address:
> e4
>  ffff8801d4832100: f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2
> 87
>  ffff8801d4832180: f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f2 f2 f2 f2 f2 f2
> 41
>>
>> ffff8801d4832200: f2 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00
>
> 54 41
>                                ^
> 55
>  ffff8801d4832280: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2
> 65
>  ffff8801d4832300: f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2
> 48
> ==================================================================
> 8b 04
> kasan: CONFIG_KASAN_INLINE enabled
> 25 40 ee 01
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> 00 48 05 68 06
> general protection fault: 0000 [#1] SMP KASAN
> 00 00
> CPU: 1 PID: 2005 Comm: kworker/1:2 Tainted: G    B             4.18.0-rc3+
> #45
> 48 89
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: ipv6_addrconf addrconf_dad_work
> c6
> e8 85
> RIP: 0010:__x86_indirect_thunk_r14+0x10/0x20 arch/x86/lib/retpoline.S:46
> b3 1c
> Code: 90
> 00
> 0f
> <0f>
> ae e8
> 0b
> eb f9
> 48 83
> 4c 89
> c4 18
> 2c 24
> e9 3f
> c3 0f
> ff
> 1f
> ff ff
> 44
> 48
> 00
> 89 75
> 00 66
> e0 e8
> 2e 0f
> a1 69
> 1f 84
> 8f 00
> 00 00
> 48 8b
> 00 00
> 00 e8
> RSP: 0018:ffff8801dae07f58 EFLAGS: 00010082
> 07 00
> 00 00
> RAX: 0000000000000000 RBX: ffff8801ce1a4000 RCX: 0000000000000000
> RDX: 0000000000010000 RSI: ffffffff81631851 RDI: 0000000000000001
> f3 90
> RBP: ffff8801dae07fb0 R08: ffff8801a9c52400 R09: ffffed003b5c3ec2
> R10: ffffed003b5c3ec2 R11: ffff8801dae1f617 R12: fffffe0000011000
> 0f ae
> R13: fffffe0000007080 R14: 0000000000000027 R15: 0000000000000000
> e8 eb
> f9 4c
> 89
> 34 24
>  do_IRQ+0x78/0x190 arch/x86/kernel/irq.c:245
> <c3> 0f
>  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
> 1f
>  </IRQ>
> 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 e8 07 00 00 00 f3
> RSP: 0018:ffff8801cd80ecb8 EFLAGS: 00010293
> RAX: ffff8801cd8065c0 RBX: ffff8801d4832200 RCX: ffffffff81601b77
> RDX: 0000000000000000 RSI: ffffffff85fb9eaf RDI: ffff8801d6419b40
> RBP: ffff8801cd80ef90 R08: fffffbfff1205391 R09: fffffbfff1205390
> R10: fffffbfff1205390 R11: ffffffff89029c83 R12: ffffffff8984e080
> R13: ffff8801d6419b40 R14: 1ffff1003a906446 R15: ffffffff8984de00
> FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff2099bb70 CR3: 0000000008e6a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ip6_finish_output2+0xa5d/0x2820 net/ipv6/ip6_output.c:117
>  ip6_finish_output+0x5fe/0xbc0 net/ipv6/ip6_output.c:154
>  NF_HOOK_COND include/linux/netfilter.h:276 [inline]
>  ip6_output+0x234/0x9d0 net/ipv6/ip6_output.c:171
>  dst_output include/net/dst.h:444 [inline]
>  NF_HOOK include/linux/netfilter.h:287 [inline]
>  ndisc_send_skb+0x100d/0x1570 net/ipv6/ndisc.c:491
>  ndisc_send_ns+0x3c1/0x8d0 net/ipv6/ndisc.c:633
>  addrconf_dad_work+0xbf2/0x1310 net/ipv6/addrconf.c:4061
>  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Dumping ftrace buffer:
>    (ftrace buffer empty)
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000eddf7305703967c6%40google.com.
> For more options, visit https://groups.google.com/d/optout.
