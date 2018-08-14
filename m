Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332652171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzI9Nv2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332652171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeHNXjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:39:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45346 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeHNXjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:39:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so9622924pgq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D86JtDvkcnyXcnz1BbkVtuou9KJiedinFFHyZeDx+DU=;
        b=qzI9Nv2GhHASJNkrxg+/C5bJuehF7SRQq4x2y02heAcz9ejpcSIV2Ox/8A4qNySNfU
         BUFw44KQuhU9BpbylBN419gYmhssS+Dpwh6zhdQxHr5nw0HSHjXRBV5tGRpgUfgNtmtC
         luMnE4Gs+X/X18NxvG7AhIN/Ws6EDp1XuoiMndsdiFG/kw/29636WXOZoefzFilcylg8
         rX52XVavCo8ktG7qH0nfg7YxftCV/gwoqSRwKlkp4R4tXBwvlUQ/wNsQeiwMMU45x/nP
         UNlL9TYfUJBsPZW6x+iRCclKCmw/zmmcWQ8b6Ht4f4uBnezij8df3nZrLtgqIKPVbaxJ
         RI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D86JtDvkcnyXcnz1BbkVtuou9KJiedinFFHyZeDx+DU=;
        b=iY546ARr0faiKZtW4cMe1Avh+WaIczCCrCWKcSigBoLLh8JXq6uOLCxy5tAwVyJPoB
         vHrmdeSJ2esV9Hw1lIuBs25E6fTDplvp/abADKvwfR7+JIOmjXneQmYr2ZqHENe9Crfs
         Qcved6jnHFTIjTW2S4ZmKftW1IBNiJHpCeT9wTAR4V4k97hmJYY7pL0a+OczoR9Aan5h
         VHn6EneDXtRRnVo5oXJMnE7sby1de0dN+zEAP2vNtii83/ivLxRI6MZhVGYl7MJ4Mvp9
         YaEP4RRtl1/4ORNSVgpG1r4KW6YB0q6UVQOvKJN8BepjaZokzKDjlZoSPq1PtT2Ar/RM
         eBig==
X-Gm-Message-State: AOUpUlFU5iX9ziRM4oYJDIAdTSCt3vU1P5m13G0btihbaNLmPQRfynsd
        oVqV56Fsi9AU6BCMKIifEpZyHCxE+UC+e5/UdKNJEQ==
X-Google-Smtp-Source: AA+uWPw6UVGUjmyYAW9JLRbeMovXnj4YiH4B5ZOWgxyhNaqVjxuCOHuOwHlfMS1U7xtcjxx0olU2ZcaZlP09kVwlQko=
X-Received: by 2002:a62:d113:: with SMTP id z19-v6mr24697696pfg.98.1534279841660;
 Tue, 14 Aug 2018 13:50:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:50:20
 -0700 (PDT)
In-Reply-To: <20180814191129.GN7906@fieldses.org>
References: <0000000000007f59610573509684@google.com> <000000000000f4136d0573512103@google.com>
 <20180814191129.GN7906@fieldses.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Aug 2018 13:50:20 -0700
Message-ID: <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
Subject: Re: general protection fault in send_sigurg_to_task
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>> git tree:       linux-next
>
> I fetched linux-next but don't have 5ed5da74de9e.

Hi Bruce,

+Stephen for the disappeared linux-next commit.

On the dashboard link you can see that it also happened on a more
recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
now in linux-next.

> I'm also not sure why I'm on the cc for this.

You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
as maintainer of the file, which is the file where the crash happened.

> --b.
>
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10787028400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1f371ca19b341a276761
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1487e828400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15084b72400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com
>>
>> nf_conntrack: default automatic helper assignment has been turned
>> off for security reasons and CT-based  firewall rule not found. Use
>> the iptables CT target to attach helpers instead.
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> CPU: 1 PID: 4474 Comm: syz-executor782 Not tainted 4.18.0-next-20180813+ #37
>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>> BIOS Google 01/01/2011
>> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
>> RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
>> RIP: 0010:send_sigurg_to_task+0xf5/0x4d0 fs/fcntl.c:810
>> Code: 61 af b1 ff 45 84 f6 0f 84 52 03 00 00 e8 83 ae b1 ff 49 8d bf
>> 58 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
>> 3c 02 00 0f 85 91 03 00 00 48 8d 43 c0 4d 8b b7 58 06 00 00 48
>> RSP: 0000:ffff8801db106c18 EFLAGS: 00010202
>> RAX: dffffc0000000000 RBX: ffff8801db106c88 RCX: ffffffff81cae2d0
>> RDX: 00000000000000cb RSI: ffffffff81cadf6d RDI: 0000000000000658
>> RBP: ffff8801db106cb0 R08: ffff8801b4ad4640 R09: ffffed003b6246d6
>> R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: 1ffff1003b620d85
>> R13: ffff8801b4cb9388 R14: 0000000000000001 R15: 0000000000000000
>> FS:  0000000000949880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000400bc3 CR3: 00000001bb122000 CR4: 00000000001406e0
>> Call Trace:
>>  <IRQ>
>>  send_sigurg+0x342/0x480 fs/fcntl.c:833
>>  sk_send_sigurg+0xd2/0x3d0 net/core/sock.c:2731
>>  tcp_check_urg net/ipv4/tcp_input.c:5266 [inline]
>>  tcp_urg+0x3c3/0xba0 net/ipv4/tcp_input.c:5307
>>  tcp_rcv_established+0xd45/0x2130 net/ipv4/tcp_input.c:5637
>>  tcp_v4_do_rcv+0x635/0x8f0 net/ipv4/tcp_ipv4.c:1532
>>  tcp_v4_rcv+0x2ff9/0x3a90 net/ipv4/tcp_ipv4.c:1824
>>  ip_local_deliver_finish+0x2eb/0xda0 net/ipv4/ip_input.c:215
>>  NF_HOOK include/linux/netfilter.h:287 [inline]
>>  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
>>  dst_input include/net/dst.h:450 [inline]
>>  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
>>  NF_HOOK include/linux/netfilter.h:287 [inline]
>>  ip_rcv+0xed/0x610 net/ipv4/ip_input.c:524
>>  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4892
>>  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5002
>>  process_backlog+0x219/0x760 net/core/dev.c:5808
>>  napi_poll net/core/dev.c:6228 [inline]
>>  net_rx_action+0x799/0x1900 net/core/dev.c:6294
>>  __do_softirq+0x2e8/0xa6d kernel/softirq.c:292
>>  invoke_softirq kernel/softirq.c:372 [inline]
>>  irq_exit+0x1d4/0x210 kernel/softirq.c:412
>>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>>  smp_apic_timer_interrupt+0x186/0x690 arch/x86/kernel/apic/apic.c:1055
>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
>>  </IRQ>
>> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783
>> [inline]
>> RIP: 0010:lock_is_held_type+0x18b/0x210 kernel/locking/lockdep.c:3941
>> Code: ff df 41 c7 84 24 3c 08 00 00 00 00 00 00 48 89 fa 48 c1 ea 03
>> 80 3c 02 00 75 63 48 83 3d f4 33 93 06 00 74 30 48 89 df 57 9d <0f>
>> 1f 44 00 00 48 83 c4 08 44 89 e8 5b 41 5c 41 5d 5d c3 48 83 c4
>> RSP: 0000:ffff8801c6de7578 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
>> RAX: dffffc0000000000 RBX: 0000000000000286 RCX: 0000000000000000
>> RDX: 1ffffffff0fe3665 RSI: 0000000000000000 RDI: 0000000000000286
>> RBP: ffff8801c6de7598 R08: ffffed003b6246d7 R09: ffffed003b6246d6
>> R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: ffff8801b4ad4640
>> R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000000
>>  lock_is_held include/linux/lockdep.h:344 [inline]
>>  rcu_read_lock_held+0xa9/0xc0 kernel/rcu/update.c:285
>>  xa_entry include/linux/xarray.h:486 [inline]
>>  xas_next_entry include/linux/xarray.h:905 [inline]
>>  filemap_map_pages+0xdab/0x1990 mm/filemap.c:2536
>>  do_fault_around mm/memory.c:3603 [inline]
>>  do_read_fault mm/memory.c:3637 [inline]
>>  do_fault mm/memory.c:3742 [inline]
>>  handle_pte_fault mm/memory.c:3973 [inline]
>>  __handle_mm_fault+0x339c/0x4470 mm/memory.c:4097
>>  handle_mm_fault+0x53e/0xc80 mm/memory.c:4134
>>  __do_page_fault+0x620/0xe50 arch/x86/mm/fault.c:1395
>>  do_page_fault+0xf6/0x7a4 arch/x86/mm/fault.c:1470
>>  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1164
>> RIP: 0033:0x400bc3
>> Code: 09 00 00 00 e8 0e 09 04 00 48 c7 05 2b 2b 2d 00 00 00 00 00 48
>> 83 c4 10 e8 fa f1 03 00 85 c0 0f 85 d2 07 00 00 e8 ed f1 03 00 <89>
>> c3 89 c5 85 c0 79 0a bf 01 00 00 00 e8 6b ed 00 00 85 c0 0f 85
>> RSP: 002b:00007ffd6e71ae70 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 000000000000116b RCX: 000000000043fe8a
>> RDX: 0000001899a3a3ae RSI: 0000000000000000 RDI: 0000000001200011
>> RBP: 000000000000116b R08: 0000000000001149 R09: 0000000000949880
>> R10: 0000000000949b50 R11: 0000000000000246 R12: 000000000000a5e7
>> R13: 00000000004023f0 R14: 0000000000000000 R15: 0000000000000000
>> Modules linked in:
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> ---[ end trace b74ebc04d71b9f0f ]---
>> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
>> RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
>> RIP: 0010:send_sigurg_to_task+0xf5/0x4d0 fs/fcntl.c:810
>> Code: 61 af b1 ff 45 84 f6 0f 84 52 03 00 00 e8 83 ae b1 ff 49 8d bf
>> 58 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
>> 3c 02 00 0f 85 91 03 00 00 48 8d 43 c0 4d 8b b7 58 06 00 00 48
>> RSP: 0000:ffff8801db106c18 EFLAGS: 00010202
>> RAX: dffffc0000000000 RBX: ffff8801db106c88 RCX: ffffffff81cae2d0
>> RDX: 00000000000000cb RSI: ffffffff81cadf6d RDI: 0000000000000658
>> RBP: ffff8801db106cb0 R08: ffff8801b4ad4640 R09: ffffed003b6246d6
>> R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: 1ffff1003b620d85
>> R13: ffff8801b4cb9388 R14: 0000000000000001 R15: 0000000000000000
>> FS:  0000000000949880(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000400bc3 CR3: 00000001bb122000 CR4: 00000000001406e0
