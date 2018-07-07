Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74983C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E102175C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWTXV47v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E102175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeGGQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:47:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34238 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeGGQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:47:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so10761296pfn.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1n/CLah3deU0Jt9+/S0oGb4RL6b+o80fAGILo+qMIms=;
        b=WWTXV47vPlT8NkCzZ9jrclcFLcgXQb5+e1hb5Zq+htN5EbeR5CsRY+OiNrx9qkO6dD
         sXjIJ00As1rAINtZy78wkTMgD/UrEr/4Y/JVEgyYZkerpiKbO5d1ggIupRT3ZewcyAR7
         YCwqCTCqs8isN8+1WBKohbzw3ykYq3Z/F9rDs+XhbpimkowFDj5V/NJYXhcpTg1nZMWj
         h5gz7Z7yD9Xi1ctAHJpbGQGpG0mui94NdQOYzQQDMZqZN6ctrgi4yMy+FnN3Q+CxMniv
         1wdHbzdFQYTbiLOlCSq/lhvkT/rUaTrqK/1j7G1atAXwPunecmIURmWJbIRg7WZT0ek3
         Ta9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1n/CLah3deU0Jt9+/S0oGb4RL6b+o80fAGILo+qMIms=;
        b=kQdW7pqxhXc6wNmEeWJAkW+fIp9UIVlMj4IUMSXIHW7DHIqdOxzxUqsaYjWDxIDyiF
         qtJfLXcJtpTTg1RxZBQdZci9shlOwhR5xkhUBhFyWGlx0ZYyZyApowf9FpPRFqEyoxXc
         W27RSmwhKK1e3d/Hcmhmi063COI4qvRyj+cCYGEcbaK9wmxhxZXvUrSCcx8NR17sTT6N
         Gt7oWERhMqDK/AO+Uv+E0n6G+SiDcyZQfhI+zjVAp6csMF/w/8Q8BP8EF7tsYR+hdvKO
         XnA61ZWm1ddZco14NoUd1LxPRo5i+Hnut35tq/4abBDXukk1BBXPi4U2Zl+R/mdkbKuh
         KTeA==
X-Gm-Message-State: APt69E3u2I+CNX5ywUCWY1CZtmCk5ASHXtiX1jq20WIRZ6GHB0yL61YR
        U5yKzoXQbmuWac0hB6BxlwrzXH0zf0BcPafZ9r+/aWL56Cw=
X-Google-Smtp-Source: AAOMgpfyWkgQvIczABjHS5/SGON6elxWVB5cFXOWUIpJZ3MBbY/XNqs4YiPeNQzVIVKtVcHfAr+tdpCTmYD9XQKBTms=
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr13132760pfa.45.1530982063440;
 Sat, 07 Jul 2018 09:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sat, 7 Jul 2018 09:47:22
 -0700 (PDT)
In-Reply-To: <00000000000025545a05706a29d4@google.com>
References: <00000000000025545a05706a29d4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 7 Jul 2018 18:47:22 +0200
Message-ID: <CACT4Y+bO6d-EB9NkFQZCFwvJ+mng0yXLdEisR9vjaNVogVmdJg@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in rb_erase (3)
To:     syzbot <syzbot+52ee52c330c2fcdade39@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 5:09 PM, syzbot
<syzbot+52ee52c330c2fcdade39@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    29119529d8de Merge tag 'for-linus-20180706' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e2550c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=52ee52c330c2fcdade39
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1463ef48400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e481b2400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+52ee52c330c2fcdade39@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in ____rb_erase_color lib/rbtree.c:258
> [inline]
> BUG: KASAN: stack-out-of-bounds in rb_erase+0x19e9/0x3550 lib/rbtree.c:462
> Read of size 8 at addr ffff8801c2dd7718 by task syz-executor396/4530
>
> CPU: 1 PID: 4530 Comm: syz-executor396 Not tainted 4.18.0-rc3+ #134
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  ____rb_erase_color lib/rbtree.c:258 [inline]
>  rb_erase+0x19e9/0x3550 lib/rbtree.c:462
>  timerqueue_del+0x86/0x150 lib/timerqueue.c:87
>  __remove_hrtimer+0xa8/0x1b0 kernel/time/hrtimer.c:984
>  __run_hrtimer kernel/time/hrtimer.c:1380 [inline]
>  __hrtimer_run_queues+0x369/0x10c0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
>
> The buggy address belongs to the page:
> page:ffffea00070b75c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 ffffffff070b0101 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801c2dd7600: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00
>  ffff8801c2dd7680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> ffff8801c2dd7700: f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2
>
>                             ^
>  ffff8801c2dd7780: f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 f8 f2 f2 f2
>  ffff8801c2dd7800: f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00 00
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000025545a05706a29d4%40google.com.
> For more options, visit https://groups.google.com/d/optout.
