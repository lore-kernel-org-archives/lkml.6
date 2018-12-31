Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C1321019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5Z3zuon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLaGfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 01:35:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43335 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLaGfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 01:35:44 -0500
Received: by mail-io1-f65.google.com with SMTP id a2so9020160ios.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 22:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfzdauCZhoEjjtzETPQhyq82uT1QhfYuLBcput13h6c=;
        b=O5Z3zuon243G7G0aSr1a/BQnAPpsllMIU7OIqn332ZDaJsX90KGT81KyP2m3fF2TiP
         BmsTfI+Zn2Lz+PocfD5anRn6gww2L1VJNm16+CRmE441lKBxMkCVyTcd0i2VG9KiYp55
         5FxzFmyScY8+esxASAwd9ApQYWXkanTh6OKwzRxWtwR7fCJMobpTbgLF8/GH74dcDT7z
         e9uga2c8WxkOkxv7q6+620xWFO+q0i/oabuTW5t9dg5zIKfSG+LNnhfg5B9wziLGgcX0
         V+oqit678MUtQH9FKkLX5xfisydy7xS/GMGonole8sr374gob3W11sESsD2ZSJLXnPMd
         1TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfzdauCZhoEjjtzETPQhyq82uT1QhfYuLBcput13h6c=;
        b=LYPolSl7XKbkfUxiIT88pOlcv/RIAQqJI9d9CinyIGnV37o4QX1s5xu4lWZLPtg9Ae
         6rgKG+iusjvVWaZ8PwmDn2NddExbloFQ1wDSSBfnlBH2WqNV9/Ex4lhM/TquGZrRwITC
         /GOe6isfs6lBiQSRF70apeDhvVqqk/mEkkm+UGtUuGX5sPwxuijrfKV7TcnwmHsFuC5W
         3UtukOZiReGIv44kcgnO+Ej4/ZU88OMVEVK4aSMN0wCFseoy3D+zPVrwwav8ge302Gth
         DKQOOeZPfbaZNNaD/+Sa+548xfeaGaPUfE2KAXNjTZBA4ufzmouzbKPXd+7eSEwF3WJK
         TUtA==
X-Gm-Message-State: AJcUukf0RWm8qoMtDWW2X5cs2xuH83A+OyntdS5gBA3rYW42QVTPzbw1
        vyA5u6odfwFqGrGFX43CG9Uu2bSNmyjQH1hgbiVbsA==
X-Google-Smtp-Source: ALg8bN4v9OFS59N7u53aIAQJNn7Mw0GY/5AfWgwBQPep+eoP4Pu8bwKORF/wPqehx6sJg753D+L0NL/A9dhTJgWDYJ8=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr230259ior.282.1546238142897;
 Sun, 30 Dec 2018 22:35:42 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com> <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com> <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
 <CACT4Y+ZitcDg=OA8NbJJTWQyHHzmiZ7rFekFkgxmdOOnSKTfXg@mail.gmail.com>
 <CACT4Y+bUYDEEdB-WrWc2gdzuQ-xOSoCZxzT7faNd3_ENnxFNnQ@mail.gmail.com>
 <f4eaca71-09f6-3c21-258c-336d1b56d38c@colorfullife.com> <CACT4Y+Z3GYkvL28BmyGWJHZmK=NgrJcMfhqyXPPMME_Rk8X_qw@mail.gmail.com>
 <CACT4Y+Zg85KDMhq3BNtHH0gbO2hWQ6O05n8K9=MRO5htLovMgQ@mail.gmail.com> <CACT4Y+axE-hxbn1pYwY+14PAa4Wq4cb0ohRueumGZONrQ9iuRQ@mail.gmail.com>
In-Reply-To: <CACT4Y+axE-hxbn1pYwY+14PAa4Wq4cb0ohRueumGZONrQ9iuRQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 Dec 2018 07:35:31 +0100
Message-ID: <CACT4Y+b+Exydw6Ya86J3XTXnT5RLscai0W+X=dVudW1Ae5fXiw@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     Manfred Spraul <manfred@colorfullife.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 10:31 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Dec 26, 2018 at 10:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > Hello Dmitry,
> > > >
> > > > On 12/23/18 11:42 AM, Dmitry Vyukov wrote:
> > > > > Actually was able to reproduce this with a syzkaller program:
> > > > > ./syz-execprog -repeat=0 -procs=10 prog
> > > > > ...
> > > > > kasan: CONFIG_KASAN_INLINE enabled
> > > > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > > > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 1 PID: 8788 Comm: syz-executor8 Not tainted 4.20.0-rc7+ #6
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > > > RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> > > > > Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> > > > > 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > > > > 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> > > > > RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> > > > > RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> > > > > RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> > > > > RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> > > > > R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> > > > > R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> > > > > FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >   __list_del_entry include/linux/list.h:117 [inline]
> > > > >   list_del include/linux/list.h:125 [inline]
> > > > >   unlink_queue ipc/sem.c:786 [inline]
> > > > >   freeary+0xddb/0x1c90 ipc/sem.c:1164
> > > > >   free_ipcs+0xf0/0x160 ipc/namespace.c:112
> > > > >   sem_exit_ns+0x20/0x40 ipc/sem.c:237
> > > > >   free_ipc_ns ipc/namespace.c:120 [inline]
> > > > >   put_ipc_ns+0x55/0x160 ipc/namespace.c:152
> > > > >   free_nsproxy+0xc0/0x1f0 kernel/nsproxy.c:180
> > > > >   switch_task_namespaces+0xa5/0xc0 kernel/nsproxy.c:229
> > > > >   exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
> > > > >   do_exit+0x19e5/0x27d0 kernel/exit.c:866
> > > > >   do_group_exit+0x151/0x410 kernel/exit.c:970
> > > > >   __do_sys_exit_group kernel/exit.c:981 [inline]
> > > > >   __se_sys_exit_group kernel/exit.c:979 [inline]
> > > > >   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
> > > > >   do_syscall_64+0x192/0x770 arch/x86/entry/common.c:290
> > > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > RIP: 0033:0x4570e9
> > > > > Code: 5d af fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> > > > > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > > > > 01 f0 ff ff 0f 83 2b af fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > > RSP: 002b:00007ffe35f12018 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > > > > RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004570e9
> > > > > RDX: 0000000000410540 RSI: 0000000000a34c00 RDI: 0000000000000045
> > > > > RBP: 00000000004a43a4 R08: 000000000000000c R09: 0000000000000000
> > > > > R10: 0000000000d24940 R11: 0000000000000246 R12: 0000000000000000
> > > > > R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000008
> > > > > Modules linked in:
> > > > > Dumping ftrace buffer:
> > > > >     (ftrace buffer empty)
> > > > > ---[ end trace 17829b0f00569a59 ]---
> > > > > RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> > > > > Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> > > > > 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > > > > 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> > > > > RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> > > > > RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> > > > > RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> > > > > RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> > > > > R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> > > > > R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> > > > > FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > >
> > > > >
> > > > > The prog is:
> > > > > unshare(0x8020000)
> > > > > semget$private(0x0, 0x4007, 0x0)
> > > > >
> > > > > kernel is on 9105b8aa50c182371533fc97db64fc8f26f051b3
> > > > >
> > > > > and again it involved lots of oom kills, the repro eats all memory, a
> > > > > process getting killed, frees some memory and the process repeats.
> > > >
> > > > I was too fast: I can't reproduce the memory leak.
> > > >
> > > > Can you send me the source for prog?
> > >
> > >
> > > Here is the program:
> > > https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
> > >
> > > But we concluded this is not a leak, right?
> > > It just creates large semaphores tied to a persistent ipcns. Once the
> > > process is killed, all memory is released. When this program runs, it
> > > eats all memory, then one of the subprocesses is oom-killed, part of
> > > memory is released, then all memory is consumed again by a new
> > > subprocess and this repeats. If all processes are killed, all memory
> > > is released back. It seems to be working as intended.
> > >
> > > However, what you said about kernel.sem sysctl is useful and I think
> > > we need to use it for additional sandboxing of syzkaller test
> > > processes. I am thinking of applying:
> > >
> > > kernel.shmmax = 16777216
> > > kernel.shmall = 536870912
> > > kernel.shmmni = 1024
> > > kernel.msgmax = 8192
> > > kernel.msgmni = 1024
> > > kernel.msgmnb = 1024
> > > kernel.sem = 1024 1048576 500 1024
> > >
> > > It should be enough to trigger bugs of any complexity (oom's aside),
> > > but should prevent uncontrolled memory consumption.
> > > Looking at the code I figured that these sysctls are
> > > per-ipc-namespace, right? I.e. if I do sysctl from an ipcns, the
> > > limits will be set only only for that ns. I won't use this initially,
> > > but something to keep in mind if the global limits will fail in some
> > > way.
> >
> > +Shakeel who was interested in memory isolation problems
> >
> > Setting these sysctl's globally does not help, as they are reset for
> > new ipc namespaces (?). Setting them for test process namespaces does
> > not help either, as it's trivial to do unshare(NEWIPC) (which the
> > repro in fact does). It seems to make things somewhat better for
> > syzkaller because any namespaces that a test creates are short-lived.
> > But this seems to be a general resource isolation issue for
> > containers.
>
>
> The stack overflow was reported 5 months ago with a bunch of repros:
> https://groups.google.com/forum/#!msg/syzkaller-bugs/C7d0Hm6YcDM/nQeciKgtCgAJ
> now we are spending time re-debugging other incarnations of the same bug.

FTR, the main place to track the stack overflow is now this thread:
https://groups.google.com/forum/#!msg/syzkaller-bugs/nFeC8-UG1gg/_KMuN0ViFQAJ

Manfred, you are proceeding with submission of the race fix, right?
Since it includes 3 Reported-by tags I will not mark these bugs as dup
of "kernel panic: corrupted stack end in wb_workfn", otherwise it will
cause confusion (the patch will appear as fixing the stack overflow
which it is not). Of, if you remove the tags, we can mark these 3 bugs
as a dup.
