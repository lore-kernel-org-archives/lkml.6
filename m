Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3AFC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2BD224B3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDARTyJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2BD224B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeGGHAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:00:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34272 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:00:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so10098674pfn.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zq5O0AEuD8JpQIKNnxzltRZnaNihfpFd+BGFh8TL/6Q=;
        b=dDARTyJkZwEsOFa/VPWeRzV021Vi+llaD7qAaHvmjOuxOIods65+ZdUU/Xhiw137mQ
         sNA2nKKq8jnyQ1tVC2PbxsrXg1n61WZGbfJPGgOLtuVqMuGEtBF2S9R7E3QflWsu3BJB
         8007x2MlcQBEWtjwLhwxcm6fUsTFeNAvdMkYfxV/JyD2lEyHLaEp6R/R8K+WT2kNyxfu
         isMHiLGgR6Kw0f/64lZHAxoaclJA0hK4cD6xFBEd8tg+5/FuSJu2XjKJyceaq527wqMn
         KRNBVYxdW6sSM7jckIGn0Vksm2Xo3XqIW33Zpao5PGWR6fnZD5wDEVWr8GxbH09zyvf4
         qliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zq5O0AEuD8JpQIKNnxzltRZnaNihfpFd+BGFh8TL/6Q=;
        b=dvmyL9ZGqlQAwx7qSrLBEI9YuJyFoTjrIg3xGnZqEkwpLSzwyZ7ffbi9RDD82483a9
         3VGYFuqmlVc8RBnfHNpdCQl46+4CkB90HrLWBnwNs5oGEjPfG6ZSAF5doNp37ilg00Mv
         cOSMP3zb9eZn2dLGUVX5UwRKVS+hasraoqeO6VzAWcFIyPA7BeTaZakXAjFKb8myi1Ds
         XodT+3TSgiU25JTrhkFYo5FAQoFRJqoYTBGIMtxlrwCzlXLCvuKK80cgFzvi/0JiX9M7
         PgZRQ/S4ToXZKxTul5CQt7L5D2yQY2kFicJ5MYkf1kkjmkGTivakLhRz0F8cswzG8FQQ
         atyg==
X-Gm-Message-State: APt69E2pe7rgz33C+1AHvVftkQWDJIFe9zGY+umFgB2fl8QRhe0QdvpU
        aUrYceQgWTfA0EYJlOuNn/M9YKygcYgiR5aBBekMSQ==
X-Google-Smtp-Source: AAOMgpcBKCcxsWz+e50A9Qh0GboFl5NueRhorQ4rRcc58jz43agSacKQ51miUUvDsrKtZadfYxFTObaQ1IExIOY7lys=
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr11399383pgf.84.1530946833721;
 Sat, 07 Jul 2018 00:00:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:00:13
 -0700 (PDT)
In-Reply-To: <000000000000d8e31b05705e901b@google.com>
References: <000000000000d8e31b05705e901b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 7 Jul 2018 09:00:13 +0200
Message-ID: <CACT4Y+Z2OWT4mzADTFScQv9r+8xyJgd4oAk9=Gv48XQ3YLfMfQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in vmalloc_fault
To:     syzbot <syzbot+7b269953d076326d7de0@syzkaller.appspotmail.com>
Cc:     bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        stephen hemminger <stephen@networkplumber.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 3:19 AM, syzbot
<syzbot+7b269953d076326d7de0@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    6fcf9b1d4d6c r8169: fix runtime suspend
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=174529b2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d264f2b04177ca7c
> dashboard link: https://syzkaller.appspot.com/bug?extid=7b269953d076326d7de0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1397e2c2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120e462c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7b269953d076326d7de0@syzkaller.appspotmail.com


This looks like the bpf map bug which leads to random bugs on stack:

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add


> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in pgd_val
> arch/x86/include/asm/paravirt.h:412 [inline]
> BUG: KASAN: stack-out-of-bounds in p4d_pfn
> arch/x86/include/asm/pgtable.h:205 [inline]
> BUG: KASAN: stack-out-of-bounds in vmalloc_fault+0x743/0x760
> arch/x86/mm/fault.c:462
> Read of size 8 at addr ffff8801a936f160 by task ksoftirqd/0/9
>
> CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.18.0-rc3+ #47
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  pgd_val arch/x86/include/asm/paravirt.h:412 [inline]
>  p4d_pfn arch/x86/include/asm/pgtable.h:205 [inline]
>  vmalloc_fault+0x743/0x760 arch/x86/mm/fault.c:462
>  __do_page_fault+0x829/0xe50 arch/x86/mm/fault.c:1245
>  do_page_fault+0xf6/0x8c0 arch/x86/mm/fault.c:1471
>  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1160
> RIP: 0010:ebt_do_table+0x1a7/0x2170 net/bridge/netfilter/ebtables.c:208
> Code: 24 04 4d 8d ac 24 80 00 00 00 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89
> f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 8f 1e 00 00 <41> 8b 44 24 04 49
> 8d 7c 24 38 65 8b 15 28 7f 39 79 48 c1 e0 04 48
> RSP: 0018:ffff8801d9ab6ab8 EFLAGS: 00010246
> RAX: 0000000000000007 RBX: 0000000000000005 RCX: ffffffff81601dff
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90001e2c004
> RBP: ffff8801d9ab6c88 R08: ffffed003a6f4e49 R09: ffffed003a6f4e48
> R10: ffffed003a6f4e48 R11: ffff8801d37a7243 R12: ffffc90001e2c000
> R13: ffffc90001e2c080 R14: ffff8801d9ab6cc0 R15: ffff8801d9394380
>  ebt_broute+0x200/0x340 net/bridge/netfilter/ebtable_broute.c:60
>  br_handle_frame+0x6d1/0x1a20 net/bridge/br_input.c:292
>  __netif_receive_skb_core.constprop.140+0x142d/0x3620 net/core/dev.c:4697
>  __netif_receive_skb_one_core+0xd0/0x200 net/core/dev.c:4766
>  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:4873
>  process_backlog+0x219/0x760 net/core/dev.c:5676
>  napi_poll net/core/dev.c:6088 [inline]
>  net_rx_action+0x7a5/0x1950 net/core/dev.c:6154
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
>  run_ksoftirqd+0x86/0x100 kernel/softirq.c:649
>  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
>  kthread+0x345/0x410 kernel/kthread.c:240
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> The buggy address belongs to the page:
> page:ffffea0006a4dbc0 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801a936f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801a936f080: 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00
>>
>> ffff8801a936f100: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 f8
>
>                                                        ^
>  ffff8801a936f180: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00
>  ffff8801a936f200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d8e31b05705e901b%40google.com.
> For more options, visit https://groups.google.com/d/optout.
