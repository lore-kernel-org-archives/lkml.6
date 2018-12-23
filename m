Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B60C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4024D21738
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c99KB2BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbeLWKnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:43:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36085 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeLWKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 05:43:01 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so7197123ioh.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yr3+Gd7W1QVmYQwuLr7tZM+BCtvkKAP33p43K63jKnM=;
        b=c99KB2BIMU6nzbQ2dT4C0L4zdqq8FhW4ZMHZrQNXtFy6CB9btiG4ocK2MKs/4RKl27
         ozOwM2rEEG9Dbi4Mv/+/bt23YEEbCgbYKxGI6XA5s3Mih94YffRaYMM0otIo/ZV6vg/d
         4Mb4m8K28/o8n7g/KeDdyI10lL443xrie6IGv7QGZZGbUP9wBWCDwj9yBA8H3qzqZ23w
         KVg1tv0WM/a+zGAy28AvN4THt3RmhxCXxPiTsIfpCcyO8+oLHgVHVCDA3a+Jyc8C0NYU
         YOSce/XMCIWvObmMzRdXHFqU31NvJhlahNwQaFxHhkau6jZNjuwfKVEHmX6X3eGL0cHj
         4UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yr3+Gd7W1QVmYQwuLr7tZM+BCtvkKAP33p43K63jKnM=;
        b=sucHtkzy1okbnnfQCKt5TWPt2kGQPkkpagfXXPbyHQguSmOzmkf5PWTc9ULlXAdKAv
         wnfYfl23scDq5ot9hlRBHmjOo4nqkHPb10CgosuDI+b1nr3LEJo4W09JjUv4UkMkz5l6
         ir8mc4Suz98chsYy1Ef97xD21Mx3cQiIEHNdJMBoeXzxs2QwRNmvdmv5Lj/+AU/L4g8v
         PUO6Z6ybqd5tb8W2junbonvMq35sX8AURrQ9L3BnoFx5A5+24aNr8QBaPwf6a0Jdp0QG
         YzvyJOFuGuvhXToolvyyISyVW9WTa5Br3z6NAFuysYT9HW8YedKRPUEpALVrSyUeviUU
         KVMg==
X-Gm-Message-State: AJcUukdPoomVe5QVHe5oG27gi6NsEA0h6ezRdnP/5SDZ9QpMTMlA66ZV
        HwV/T7UcIrm2FU0AO/Lv+RJWN9TVNciXTz2JePiB4g==
X-Google-Smtp-Source: ALg8bN5n9NoL9PVGNUNvCSYDc9tuPNtIhY87DdKZDNHh3o2m0LAyf6dOE6j39bs//S2Sn42y/Wv+5JQBMyUFQQ10hK8=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr5825276ioh.271.1545561780310;
 Sun, 23 Dec 2018 02:43:00 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com> <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com> <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com> <CACT4Y+ZitcDg=OA8NbJJTWQyHHzmiZ7rFekFkgxmdOOnSKTfXg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZitcDg=OA8NbJJTWQyHHzmiZ7rFekFkgxmdOOnSKTfXg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 23 Dec 2018 11:42:48 +0100
Message-ID: <CACT4Y+bUYDEEdB-WrWc2gdzuQ-xOSoCZxzT7faNd3_ENnxFNnQ@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     manfred <manfred@colorfullife.com>
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

On Sun, Dec 23, 2018 at 11:30 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Dec 23, 2018 at 10:57 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sun, Dec 23, 2018 at 8:37 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Dec 22, 2018 at 8:07 PM Manfred Spraul <manfred@colorfullife.com> wrote:
> > > >
> > > > Hi Dmitry,
> > > >
> > > > On 12/20/18 4:36 PM, Dmitry Vyukov wrote:
> > > > > On Wed, Dec 19, 2018 at 10:04 AM Manfred Spraul
> > > > > <manfred@colorfullife.com> wrote:
> > > > >> Hello Dmitry,
> > > > >>
> > > > >> On 12/12/18 11:55 AM, Dmitry Vyukov wrote:
> > > > >>> On Tue, Dec 11, 2018 at 9:23 PM syzbot
> > > > >>> <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
> > > > >>>> Hello,
> > > > >>>>
> > > > >>>> syzbot found the following crash on:
> > > > >>>>
> > > > >>>> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > > > >>>> git tree:       upstream
> > > > >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
> > > > >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > > > >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> > > > >>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > >>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000
> > > > >>> +Manfred, this looks similar to the other few crashes related to
> > > > >>> semget$private(0x0, 0x4000, 0x3f) that you looked at.
> > > > >> I found one unexpected (incorrect?) locking, see the attached patch.
> > > > >>
> > > > >> But I doubt that this is the root cause of the crashes.
> > > > >
> > > > > But why? These one-off sporadic crashes reported by syzbot looks
> > > > > exactly like a subtle race and your patch touches sem_exit_ns involved
> > > > > in all reports.
> > > > > So if you don't spot anything else, I would say close these 3 reports
> > > > > with this patch (I see you already included Reported-by tags which is
> > > > > great!) and then wait for syzbot reaction. Since we got 3 of them, if
> > > > > it's still not fixed I would expect that syzbot will be able to
> > > > > retrigger this later again.
> > > >
> > > > As I wrote, unless semop() is used, sma->use_global_lock is always 9 and
> > > > nothing can happen.
> > > >
> > > > Every single-operation semop() reduces use_global_lock by one, i.e a
> > > > single semop call as done here cannot trigger the bug:
> > > >
> > > > https://syzkaller.appspot.com/text?tag=ReproSyz&x=16803afb400000
> > >
> > > It contains "repeat":true,"procs":6, which means that it run 6
> > > processes running this test in infinite loop. The last mark about
> > > number of tests executed was:
> > > 2018/12/11 18:38:02 executed programs: 2955
> > >
> > > > But, one more finding:
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> > > >
> > > > https://syzkaller.appspot.com/text?tag=CrashLog&x=109ecf6e400000
> > > >
> > > > The log file contain 1080 lines like these:
> > > >
> > > > > semget$private(..., 0x4003, ...)
> > > > >
> > > > > semget$private(..., 0x4006, ...)
> > > > >
> > > > > semget$private(..., 0x4007, ...)
> > > >
> > > > It ends up as kmalloc(128*0x400x), i.e. slightly more than 2 MB, an
> > > > allocation in the 4 MB kmalloc buffer:
> > > >
> > > > > [ 1201.210245] kmalloc-4194304      4698112KB    4698112KB
> > > > >
> > > > i.e.: 1147 4 MB kmalloc blocks --> are we leaking nearly 100% of the
> > > > semaphore arrays??
> > >
> > > /\/\/\/\/\/\
> > >
> > > Ha, this is definitely not healthy.
> >
> > I can reproduce this infinite memory consumption with the C program:
> > https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
> >
> > But this is working as intended, right? It just creates infinite
> > number of large semaphore sets, which reasonably consumes infinite
> > amount of memory.
> > Except that it also violates the memcg bound and a process can have
> > effectively unlimited amount of such "drum memory" in semaphores.
> >
> >
> >
> >
> > > > This one looks similar:
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> > > >
> > > > except that the array sizes are mixed, and thus there are kmalloc-1M and
> > > > kmalloc-2M as well.
> > > >
> > > > (and I did not count the number of semget calls)
> > > >
> > > >
> > > > The test apps use unshare(CLONE_NEWNS) and unshare(CLONE_NEWIPC), correct?
> > > >
> > > > I.e. no CLONE_NEWUSER.
> > > >
> > > > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1523
> > >
> > > CLONE_NEWUSER is used on some instances as well:
> > > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1765
> > > This crash happened on 2 different instances and 1 of them uses
> > > CLONE_NEWUSER and another does not.
> > > If it's important because of CAP_ADMIN in IPC namespace, then all
> > > instances should have it (instances that don't use NEWUSER are just
> > > root).
>
> My naive attempts to re-reproduce this failed so far.
> But I noticed that _all_ logs for these 3 crashes:
> https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
> involve low memory conditions. My gut feeling says this is not a
> coincidence. This is also probably the reason why all reproducers
> create large sem sets. There must be some bad interaction between low
> memory condition and semaphores/ipc namespaces.


Actually was able to reproduce this with a syzkaller program:

./syz-execprog -repeat=0 -procs=10 prog
...
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8788 Comm: syz-executor8 Not tainted 4.20.0-rc7+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:117 [inline]
 list_del include/linux/list.h:125 [inline]
 unlink_queue ipc/sem.c:786 [inline]
 freeary+0xddb/0x1c90 ipc/sem.c:1164
 free_ipcs+0xf0/0x160 ipc/namespace.c:112
 sem_exit_ns+0x20/0x40 ipc/sem.c:237
 free_ipc_ns ipc/namespace.c:120 [inline]
 put_ipc_ns+0x55/0x160 ipc/namespace.c:152
 free_nsproxy+0xc0/0x1f0 kernel/nsproxy.c:180
 switch_task_namespaces+0xa5/0xc0 kernel/nsproxy.c:229
 exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
 do_exit+0x19e5/0x27d0 kernel/exit.c:866
 do_group_exit+0x151/0x410 kernel/exit.c:970
 __do_sys_exit_group kernel/exit.c:981 [inline]
 __se_sys_exit_group kernel/exit.c:979 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
 do_syscall_64+0x192/0x770 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4570e9
Code: 5d af fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 2b af fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe35f12018 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004570e9
RDX: 0000000000410540 RSI: 0000000000a34c00 RDI: 0000000000000045
RBP: 00000000004a43a4 R08: 000000000000000c R09: 0000000000000000
R10: 0000000000d24940 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000008
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 17829b0f00569a59 ]---
RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


The prog is:
unshare(0x8020000)
semget$private(0x0, 0x4007, 0x0)

kernel is on 9105b8aa50c182371533fc97db64fc8f26f051b3

and again it involved lots of oom kills, the repro eats all memory, a
process getting killed, frees some memory and the process repeats.
