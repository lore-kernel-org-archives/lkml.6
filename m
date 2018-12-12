Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB37C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59CA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjvQtDnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59CA20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeLLK4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:56:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:56:11 -0500
Received: by mail-io1-f66.google.com with SMTP id w21so759195ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGCR+ncxGP3RSrwaCLSJQfCAtR50HiPXpWLEXe4kTYE=;
        b=jjvQtDnYUaJyJ9wiLB1pwCLgoqSmvC0dqXB6zX8Eh88z2j0RQ7Zjl3yUjTs1FX+hG+
         egB/y8dTUlb+0KKTCeLVI+5XxMdEvM045xT5NysYC0rpUNVLjB2vB9am0cxn5r+ypLrh
         KFBJJ55P2VMYoYwZ+nY9UL7Cqm65wR8RHus/XOVcrTG+XedUsmQP3LcGeSXK3aw7pwlb
         AyQhWnyaU8rr7rOJQ3D59g2e+CPp5QrlqeyW4w7FDdBwmTqrTWLFtAFzn31ML8jbkRWi
         7fu96WJnxjWvjJZkARjpy0t0zzUG/eM3obao1hB5tHQTiWsuj2R7Whqz91LKMRx2gjlO
         Yxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGCR+ncxGP3RSrwaCLSJQfCAtR50HiPXpWLEXe4kTYE=;
        b=Bjj+csb2SyMggTvcMgW7dKuLwPLyWZoKk0ufojBIUI/y06elD+Rh+4Ivj3EkVe7kbz
         wWlCO2ujqoOx4UcWKH9ywWAPClVY6n5wZb+PlN9Znn+utWQmtfDiKNYzfp00QYge1qq7
         gFYVAiHDbkZyhbPi9UVUs/ST2g/lWjgw1n8wM+1BpH9yZ9U1x8SdCsB0uNRz8SHhBNrb
         Wgifsyq0zRuAT5VT8SHEyW2sD1laHNdTxooPSSSwedvE6dUK+pKNMgtMAzjwizzWDG4P
         fTP1Xga9xEG/+shLp510TBYxVs6gvoT4R24H7H+xcho7pSuXbuw0RR8SwZ1v38X6xiwg
         u4pA==
X-Gm-Message-State: AA+aEWaQEOLpMSNtXI87xF8PAxyL41ZvZBHehXUdU7L9B+o6MbLTwLBm
        Ta3q4MJk9Mr8SsTT1g5WtsnER7OhOGoxn9V5aTYpZg==
X-Google-Smtp-Source: AFSGD/Us6cLNOdCsESWOyHeYC0qNJaI7ERGGAhIVug8Ay1figQie6GBDoPz1crpYi0R2uhUDPm+BZbZg3LDg6B0pBRw=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr13561677ioh.271.1544612169707;
 Wed, 12 Dec 2018 02:56:09 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com>
In-Reply-To: <00000000000051ee78057cc4d98f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Dec 2018 11:55:58 +0100
Message-ID: <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        manfred <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:23 PM syzbot
<syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000

+Manfred, this looks similar to the other few crashes related to
semget$private(0x0, 0x4000, 0x3f) that you looked at.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com
>
> kmem_cache               221KB        225KB
> Out of memory: Kill process 6139 (syz-execprog) score 1 or sacrifice child
> Killed process 6164 (syz-executor0) total-vm:37444kB, anon-rss:60kB,
> file-rss:0kB, shmem-rss:0kB
> oom_reaper: reaped process 6164 (syz-executor0), now anon-rss:0kB,
> file-rss:0kB, shmem-rss:0kB
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 6159 Comm: syz-executor3 Not tainted 4.20.0-rc6+ #151
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:put_pid.part.3+0xb6/0x240 kernel/pid.c:108
> Code: d2 0f 85 89 01 00 00 44 8b 63 04 49 8d 44 24 03 48 c1 e0 04 48 8d 7c
> 03 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 66 01 00 00 49 83 c4 03 be 04 00 00 00 48 89 df
> RSP: 0018:ffff8881ae116e78 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffffffff816149a0 RCX: ffffffff833e420e
> RDX: 00000001933eab7c RSI: ffffffff8152bf8e RDI: 0000000c99f55be0
> RBP: ffff8881ae116f08 R08: ffff8881cdbf2300 R09: fffff52001507600
> R10: fffff52001507600 R11: ffffc9000a83b003 R12: 00000000d1894120
> R13: 1ffff11035c22dd0 R14: ffff8881ae116ee0 R15: dffffc0000000000
> FS:  000000000166d940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000075c458 CR3: 00000001d2bd1000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   put_pid+0x1f/0x30 kernel/pid.c:105
>   ipc_update_pid ipc/util.h:159 [inline]
>   freeary+0x10c8/0x1a40 ipc/sem.c:1167
>   free_ipcs+0x9f/0x1c0 ipc/namespace.c:112
>   sem_exit_ns+0x20/0x40 ipc/sem.c:237
>   free_ipc_ns ipc/namespace.c:120 [inline]
>   put_ipc_ns+0x66/0x180 ipc/namespace.c:152
>   free_nsproxy+0xcf/0x220 kernel/nsproxy.c:180
>   switch_task_namespaces+0xb3/0xd0 kernel/nsproxy.c:229
>   exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
>   do_exit+0x1ad1/0x26d0 kernel/exit.c:866
>   do_group_exit+0x177/0x440 kernel/exit.c:970
>   get_signal+0x8b0/0x1980 kernel/signal.c:2517
>   do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>   exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
>   prepare_exit_to_usermode+0x342/0x3b0 arch/x86/entry/common.c:197
>   retint_user+0x8/0x18
> RIP: 0033:0x45a4d0
> Code: 10 44 00 00 00 e8 c0 cc ff ff 0f b6 44 24 18 eb c2 e8 44 ad ff ff e9
> 6f ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <64> 48 8b 0c 25
> f8 ff ff ff 48 3b 61 10 76 68 48 83 ec 28 48 89 6c
> RSP: 002b:00007fff9b9d3578 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000000a4edb RCX: 0000000000483170
> RDX: 0000000000000000 RSI: 00007fff9b9d3580 RDI: 0000000000000001
> RBP: 00000000000002ef R08: 0000000000000001 R09: 000000000166d940
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 00000000000a4e70 R14: 00000000000001f1 R15: 0000000000000003
> Modules linked in:
> ---[ end trace 9933854824df8420 ]---
> RIP: 0010:put_pid.part.3+0xb6/0x240 kernel/pid.c:108
> Code: d2 0f 85 89 01 00 00 44 8b 63 04 49 8d 44 24 03 48 c1 e0 04 48 8d 7c
> 03 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 66 01 00 00 49 83 c4 03 be 04 00 00 00 48 89 df
> RSP: 0018:ffff8881ae116e78 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffffffff816149a0 RCX: ffffffff833e420e
> RDX: 00000001933eab7c RSI: ffffffff8152bf8e RDI: 0000000c99f55be0
> RBP: ffff8881ae116f08 R08: ffff8881cdbf2300 R09: fffff52001507600
> R10: fffff52001507600 R11: ffffc9000a83b003 R12: 00000000d1894120
> R13: 1ffff11035c22dd0 R14: ffff8881ae116ee0 R15: dffffc0000000000
> FS:  000000000166d940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000075c458 CR3: 00000001d2bd1000 CR4: 00000000001406f0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000051ee78057cc4d98f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
