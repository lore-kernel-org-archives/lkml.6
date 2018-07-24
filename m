Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3310205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHYJQb4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3310205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbeGXIet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:34:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbeGXIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:34:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so2253378pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uhHphUjDUAAywIIrA2pII+CDg40f7xYRZOIrndap140=;
        b=nHYJQb4o+8cgeM/bn5s/oRF196WD5ZOzN0fS2uudo9MJLDovi/5VZ9vOEqmiX3PkTy
         ITxGzvvnXzT/HNKqJtuM2+PuQYUEHafNMPdrW2+xyWXmPI0eBMtfi14MfhekRmI2kS3q
         V/6sqjUuRfoxjS/9del6jfxzAC56GD8HR+m5Sa+7Yt7gFUubcaVSpxu+oRu7AhkZJ5Q5
         bgy+ysH+8InNopYbC917PiOfJ6vEj9YfD5NADe+xFkp+Y6foYr0IMRsDFxu4cvSabTpl
         mhPifqTe38tU/5dtlYTc1KHed3cSe1PjUxqElktAyt0D563H1sfVm+uSWy6QO9W3mrLU
         4AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uhHphUjDUAAywIIrA2pII+CDg40f7xYRZOIrndap140=;
        b=Q8RViiRmtfKFwRV0HIg4uSU9RP2q0XJvy5yjlc8zD/4IFQWjedWWMcCnb1Gr42e5fN
         1sQ0YdREoNU2iSWxMj+Xg/Vr2vE5i6IneZ5Tw1M3kmDuF5clV2KQrjTd6y7BhTe3hRWO
         GGKGeDRrTAEpaO02ony9JP3I5Oh6Xa4R8uXB5aknjYfUzvWdoYh96RW0vej/8yvET7jH
         rwIcSxsxsBeFCR9G8jbUn1DEiMqNn7i8iSIiQ8OHu2KcluZESB3ZEXk201sajYmrD89e
         0fYqM0E5fU+/fAI9tt9OV4aIw7nJ6v2snPNmwLZmHikz1DHTgxF/y11JLIsXTH5OirIu
         KUTA==
X-Gm-Message-State: AOUpUlE/gzNRNPVpSRG/oOtH7J5iHSHoLzfrpCcsoWsJEpvngXdBvIsE
        vAgv2OC9bbXkHihDmxFo0V7QeuoJ2GqO1M4iF96Znjp7Qb8=
X-Google-Smtp-Source: AAOMgpdjca8pQWtgChUtjRJsg3EGzDaIQNyi+ajSl4pbRley1mjIvgVq8whi8zJxHJ5XeQ25+diqBXbEavMOBXUYAZ4=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr15485678pgp.334.1532417382686;
 Tue, 24 Jul 2018 00:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:8e82:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:29:19
 -0700 (PDT)
In-Reply-To: <0000000000002a222a0571b9b069@google.com>
References: <0000000000002a222a0571b9b069@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 24 Jul 2018 09:29:19 +0200
Message-ID: <CACT4Y+apw5VfGP5oVRXi+4poy27oNiwBRB9acj6ZMW1peq04Nw@mail.gmail.com>
Subject: Re: general protection fault in cpuacct_charge
To:     syzbot <syzbot+a22ee0b9ff4d252439f4@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:27 AM, syzbot
<syzbot+a22ee0b9ff4d252439f4@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8ae71e76cf1f Merge branch 'bpf-offload-sharing'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1645f97840000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D89129667b4649=
6c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da22ee0b9ff4d252=
439f4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+a22ee0b9ff4d252439f4@syzkaller.appspotmail.com

#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 0 Comm: =EF=BF=BDG+=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD0x=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD Not tainted 4.18.0-rc3+=
 #58
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:task_css include/linux/cgroup.h:477 [inline]
> RIP: 0010:task_ca kernel/sched/cpuacct.c:43 [inline]
> RIP: 0010:cpuacct_charge+0x1b8/0x5d0 kernel/sched/cpuacct.c:349
> Code: 68 ff ff ff 85 c0 74 0d 80 3d 45 31 3c 08 00 0f 84 04 02 00 00 48 b=
8
> 00 00 00 00 00 fc ff df 49 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85
> 65 03 00 00 4d 8b 65 10 4d 85 e4 0f 84 0a 01 00
> RSP: 0018:ffff8801daf072b0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: ffff8801c72b40c0 RCX: 0000000000000000
> RDX: 00000000000009f3 RSI: 00000000ffff8801 RDI: 0000000000004f99
> RBP: ffff8801daf07348 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000780baf52484d R11: 0000000000000000 R12: 1ffff1003b5e0e5c
> R13: 0000000000004f89 R14: dffffc0000000000 R15: 1ffff1003b5e0e58
> FS:  00007f4ba8413700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000340 CR3: 00000001cf0ac000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  cgroup_account_cputime include/linux/cgroup.h:724 [inline]
>  update_curr+0x389/0xc00 kernel/sched/fair.c:832
>  enqueue_entity+0x40d/0x2130 kernel/sched/fair.c:4195
>  enqueue_task_fair+0x22d/0x910 kernel/sched/fair.c:5408
>  enqueue_task kernel/sched/core.c:751 [inline]
>  activate_task+0x123/0x2e0 kernel/sched/core.c:770
>  ttwu_activate kernel/sched/core.c:1659 [inline]
>  ttwu_do_activate+0xd5/0x1f0 kernel/sched/core.c:1718
>  ttwu_queue kernel/sched/core.c:1863 [inline]
>  try_to_wake_up+0x948/0x12b0 kernel/sched/core.c:2076
>  wake_up_process+0x10/0x20 kernel/sched/core.c:2149
>  hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1647
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 63a513d0f55cc290 ]---
> RIP: 0010:task_css include/linux/cgroup.h:477 [inline]
> RIP: 0010:task_ca kernel/sched/cpuacct.c:43 [inline]
> RIP: 0010:cpuacct_charge+0x1b8/0x5d0 kernel/sched/cpuacct.c:349
> Code: 68 ff ff ff 85 c0 74 0d 80 3d 45 31 3c 08 00 0f 84 04 02 00 00 48 b=
8
> 00 00 00 00 00 fc ff df 49 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f=
 85
> 65 03 00 00 4d 8b 65 10 4d 85 e4 0f 84 0a 01 00
> RSP: 0018:ffff8801daf072b0 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: ffff8801c72b40c0 RCX: 0000000000000000
> RDX: 00000000000009f3 RSI: 00000000ffff8801 RDI: 0000000000004f99
> RBP: ffff8801daf07348 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000780baf52484d R11: 0000000000000000 R12: 1ffff1003b5e0e5c
> R13: 0000000000004f89 R14: dffffc0000000000 R15: 1ffff1003b5e0e58
> FS:  00007f4ba8413700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000340 CR3: 00000001cf0ac000 CR4: 00000000001406e0
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002a222a0571b9=
b069%40google.com.
> For more options, visit https://groups.google.com/d/optout.
