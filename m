Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3604C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5120D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAmYbeME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLYJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:42:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40782 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLYJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:42:07 -0500
Received: by mail-io1-f68.google.com with SMTP id a2so94836iok.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXfwVWGczs/nj3s833vSn8bveLLD3C18UDixdDc5MYg=;
        b=IAmYbeMEkXzNKIwcCFoToZTNxNFbPkQtMlFqR7XXCcK36uXO0tAWXSuGno9R5GutTj
         6JKVjgz896qIXwlRUCfh64qtgEh4XOJqvckGojyqF/ZHmlc9BFH+cDFBhim7iGqhxC9e
         00BjQfvG8d6fmQ61NkqQaDokQi1Hm8iXqgwEtDLotox21a6juRbgDrjMyjCp32CDS7Xa
         5/q7CGn68D444jmSIiBM+3/cUDusu59JJV3nWp5aeKmRencjmhHUlw+BPbiZwTcDaYtS
         njr34swnRIDCg9vMQJnFU9fKn4ljFqXbA59Wx5jkSpp7Bxd/cZKc/hAaiB2lcfqrqLT9
         BYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXfwVWGczs/nj3s833vSn8bveLLD3C18UDixdDc5MYg=;
        b=UTUeclT2daRIsdskZ60ir1a9x0B4yuiZ9VpFzRZW5Vt3AWRJia0M6Yx4qiexaxvRwY
         O3auI2F2fTJ28mJ28U4c5bEP4JmrsbkhL+2n596d2BPjwcWac9cMsYqR8Mv8J4w+UlNb
         4Qqpso1mW/yAd6zc/yew25+VG+62MmxAarv/EQ9gZvmiCiNf+mJjL4dBzI8a2LrgruGH
         ts4yIxqhVxZ60Zki0VP/F/HYlJH6drmRQSDjjJCzcJydnCSF4OBEhGfajMJOm/Bg12BW
         QKUqAebr1sGgdw23kYQHiOfzy1jTF3iYADKZ6dO1x+Bvxp6RKl+Nmsvap1WLV6sx8fy0
         LuBQ==
X-Gm-Message-State: AJcUukf4CWOwJFlbmScJkoOQGjTXzpH6Tx424Nigu7/9JWRbW9gAJAIJ
        1vUK0jA6MgINcTVLf7+p52t1WTBYqQvqmLFeJygQrQ==
X-Google-Smtp-Source: ALg8bN4ACPVYfVN0Mpf4KAJ3bSjLQ5OIhzkdMuicLFovpTpHYLpQHR3zi2tR3LhBR5nRzxJ7SmityHjWq6Q5u5iB4LM=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr135022ior.282.1545730924405;
 Tue, 25 Dec 2018 01:42:04 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com> <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com> <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
 <CACT4Y+ZitcDg=OA8NbJJTWQyHHzmiZ7rFekFkgxmdOOnSKTfXg@mail.gmail.com>
 <CACT4Y+bUYDEEdB-WrWc2gdzuQ-xOSoCZxzT7faNd3_ENnxFNnQ@mail.gmail.com> <f4eaca71-09f6-3c21-258c-336d1b56d38c@colorfullife.com>
In-Reply-To: <f4eaca71-09f6-3c21-258c-336d1b56d38c@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Dec 2018 10:41:53 +0100
Message-ID: <CACT4Y+Z1FiaYyL1qRynmV96Kcv4QrZkP8HPEZXzsUT2f1QDfuQ@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     Manfred Spraul <manfred@colorfullife.com>
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

On Sun, Dec 23, 2018 at 1:32 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Dmitry,
>
> let's simplify the mail, otherwise noone can follow:
>
> On 12/23/18 11:42 AM, Dmitry Vyukov wrote:
> >
> >> My naive attempts to re-reproduce this failed so far.
> >> But I noticed that _all_ logs for these 3 crashes:
> >> https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
> >> https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
> >> https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
> >> involve low memory conditions. My gut feeling says this is not a
> >> coincidence. This is also probably the reason why all reproducers
> >> create large sem sets. There must be some bad interaction between low
> >> memory condition and semaphores/ipc namespaces.
> >
> > Actually was able to reproduce this with a syzkaller program:
> >
> > ./syz-execprog -repeat=0 -procs=10 prog
> > ...
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 8788 Comm: syz-executor8 Not tainted 4.20.0-rc7+ #6
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> > Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> > 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> > RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> > RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> > RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> > RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> > R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> > R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> > FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   __list_del_entry include/linux/list.h:117 [inline]
> >   list_del include/linux/list.h:125 [inline]
> >   unlink_queue ipc/sem.c:786 [inline]
> >   freeary+0xddb/0x1c90 ipc/sem.c:1164
> >   free_ipcs+0xf0/0x160 ipc/namespace.c:112
> >   sem_exit_ns+0x20/0x40 ipc/sem.c:237
> >   free_ipc_ns ipc/namespace.c:120 [inline]
> >   put_ipc_ns+0x55/0x160 ipc/namespace.c:152
> >   free_nsproxy+0xc0/0x1f0 kernel/nsproxy.c:180
> >   switch_task_namespaces+0xa5/0xc0 kernel/nsproxy.c:229
> >   exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
> >   do_exit+0x19e5/0x27d0 kernel/exit.c:866
> >   do_group_exit+0x151/0x410 kernel/exit.c:970
> >   __do_sys_exit_group kernel/exit.c:981 [inline]
> >   __se_sys_exit_group kernel/exit.c:979 [inline]
> >   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
> >   do_syscall_64+0x192/0x770 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4570e9
> > Code: 5d af fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 0f 83 2b af fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffe35f12018 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004570e9
> > RDX: 0000000000410540 RSI: 0000000000a34c00 RDI: 0000000000000045
> > RBP: 00000000004a43a4 R08: 000000000000000c R09: 0000000000000000
> > R10: 0000000000d24940 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000008
> > Modules linked in:
> > Dumping ftrace buffer:
> >     (ftrace buffer empty)
> > ---[ end trace 17829b0f00569a59 ]---
> > RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> > Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> > 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> > RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> > RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> > RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> > RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> > R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> > R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> > FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > The prog is:
> > unshare(0x8020000)
> > semget$private(0x0, 0x4007, 0x0)
> >
> > kernel is on 9105b8aa50c182371533fc97db64fc8f26f051b3
> >
> > and again it involved lots of oom kills, the repro eats all memory, a
> > process getting killed, frees some memory and the process repeats.
>
> Ok, thus the above program triggers two bugs:
>
> - a huge memory leak with semaphore arrays
>
> - under OOM pressure, an oops.
>
>
> 1) I can reproduce the memory leak, it happens all the time :-(
>
> I must look what is wrong.
>
> 2) regarding the crash:
>
> What differs under oom pressure?
>
> - kvmalloc can fall back to vmalloc()
>
> - the 2nd or 3rd of multiple allocations can fail, and that triggers a
> rare codepath/race condition.
>
> - rcu callback can happen earlier that expected
>
> So far, I didn't notice anything unexpected :-(

I started suspecting a stack overflow. But I was afraid if may be a
KASAN artifact, as it both increases stack usage and disables vmap
stacks.
But I was able to reproduce this without KASAN and root cause at the same time.

I am on v4.20, config is (basically just defconfig+kvmconfig):
https://gist.githubusercontent.com/dvyukov/f8401c8da367088c789bfb953d42d3b3/raw/eac0e85d3db577ba68ec59acf916899b61741ee1/gistfile1.txt

Running the syzkaller program gave me:

Out of memory: Kill process 13971 (syz-executor) score 998 or sacrifice child
Killed process 13971 (syz-executor) total-vm:37512kB, anon-rss:92kB,
file-rss:0kB, shmem-rss:0kB
oom_reaper: reaped process 13971 (syz-executor), now anon-rss:0kB,
file-rss:0kB, shmem-rss:0kB
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 3 PID: 2555 Comm: kworker/u12:3 Not tainted 4.20.0-rc7+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 dump_stack+0x1d4/0x2b5 lib/earlycpio.c:120
 panic+0x25e/0x49c kernel/cpu.c:617
 __schedule+0x1be8/0x21d0
 preempt_schedule_common+0x35/0xe0
 preempt_schedule+0x23/0x30
 ___preempt_schedule+0x16/0x18
 _raw_spin_unlock_irq+0x75/0x80
 mark_work_canceling kernel/workqueue.c:747 [inline]
 __flush_work+0x4f5/0x970 kernel/workqueue.c:2996
 flush_work+0x17/0x20 kernel/workqueue.c:3059
 drain_all_pages+0x418/0x680 mm/page_alloc.c:4570
 __alloc_pages_slowpath+0xb76/0x2c10 mm/page_alloc.c:4072
 __alloc_pages_nodemask+0xa6c/0xe10 mm/page_alloc.c:5029
 cache_grow_begin+0x9d/0x8a0
 fallback_alloc+0x204/0x2e0
 ____cache_alloc_node+0x1cc/0x1f0
 slab_alloc_node mm/slub.c:2710 [inline]
 slab_alloc mm/slub.c:2752 [inline]
 kmem_cache_alloc+0x296/0x720 mm/slub.c:2769
 mempool_alloc_slab+0x44/0x60 mm/mempool.c:130
 mempool_alloc+0x174/0x4e0 mm/mempool.c:433
 bvec_alloc+0x150/0x2d0 block/bio.c:485
 bio_alloc_bioset+0x44e/0x650 block/bio.c:1455
 ext4_bio_write_page+0xc11/0x1780 fs/ext4/resize.c:76
 mpage_add_bh_to_extent fs/ext4/inode.c:2300 [inline]
 mpage_submit_page+0x138/0x230 fs/ext4/inode.c:2335
 ext4_da_page_release_reservation fs/ext4/inode.c:1651 [inline]
 mpage_process_page_bufs+0x429/0x500 fs/ext4/inode.c:3226
 mpage_prepare_extent_to_map+0xb2a/0x1640 fs/ext4/inode.c:154
 ext4_inode_journal_mode fs/ext4/ext4_jbd2.h:411 [inline]
 ext4_should_journal_data fs/ext4/ext4_jbd2.h:427 [inline]
 ext4_writepages+0x112c/0x3a20 fs/ext4/inode.c:2190
 test_and_set_bit arch/x86/include/asm/bitops.h:220 [inline]
 TestSetPageDirty include/linux/page-flags.h:287 [inline]
 do_writepages+0xfc/0x170 mm/page-writeback.c:2383
 mark_inode_dirty_sync include/linux/fs.h:2124 [inline]
 __writeback_single_inode+0x1cd/0x12e0 fs/fs-writeback.c:1372
 writeback_sb_inodes+0x6c7/0x1040 fs/fs-writeback.c:1795
 __writeback_inodes_wb+0x1a3/0x310 fs/fs-writeback.c:1704
 wb_writeback+0x92c/0xe10 include/trace/events/writeback.h:572
syz-executor invoked oom-killer:
gfp_mask=0x7080c0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), nodemask=(null),
order=3, oom_score_adj=0
syz-executor cpuset=/ mems_allowed=0-1
 wb_workfn+0xdf3/0x1600 fs/pnode.c:430
 get_unbound_pool kernel/workqueue.c:3437 [inline]
 process_one_work+0xcf3/0x1be0 kernel/workqueue.c:3612
 worker_thread+0x17d/0x12f0 kernel/workqueue.c:2289
 __write_once_size include/linux/compiler.h:218 [inline]
 __list_del include/linux/list.h:106 [inline]
 __list_del_entry include/linux/list.h:120 [inline]
 list_del_init include/linux/list.h:159 [inline]
 kthread+0x354/0x430 kernel/kthread.c:1010
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:358
CPU: 0 PID: 6768 Comm: syz-executor Not tainted 4.20.0-rc7+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x1d4/0x2b5 lib/earlycpio.c:120
 dump_header+0x294/0xfaf
 oom_killer_enable mm/oom_kill.c:715 [inline]
 oom_kill_process+0xa3f/0xd20 mm/oom_kill.c:750
 out_of_memory+0x88c/0x12a0 mm/fadvise.c:184
 compound_order include/linux/mm.h:707 [inline]
 page_hstate include/linux/hugetlb.h:469 [inline]
 __alloc_pages_slowpath+0x1cfa/0x2c10 mm/page_alloc.c:7820
 __alloc_pages_nodemask+0xa6c/0xe10 mm/page_alloc.c:5029
 copy_process+0x94c/0x7b00
 variable_test_bit arch/x86/include/asm/bitops.h:332 [inline]
 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
 trace_sched_process_fork include/trace/events/sched.h:288 [inline]
 _do_fork+0x191/0xf20 kernel/fork.c:2232
 __x64_sys_clone+0xbf/0x150 kernel/fork.c:2340
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
 do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
 do_syscall_64+0x192/0x770 arch/x86/entry/common.c:349
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45578b
Code: db 45 85 f6 0f 85 95 01 00 00 64 4c 8b 04 25 10 00 00 00 31 d2
4d 8d 90 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d
00 f0 ff ff 0f 87 d6 00 00 00 85 c0 41 89 c5 0f 85 dd 00 00
RSP: 002b:00007fff9dc6ca20 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007fff9dc6ca20 RCX: 000000000045578b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007fff9dc6ca70 R08: 0000000001d0d940 R09: 0000000000000000
R10: 0000000001d0dc10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000

and second time:

[  281.244340] Kernel panic - not syncing: corrupted stack end
detected inside scheduler
[  281.245754] CPU: 2 PID: 6265 Comm: kworker/u12:4 Not tainted 4.20.0-rc7+ #6
[  281.246887] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  281.248240] Workqueue: writeback wb_workfn (flush-8:0)
[  281.248992] Call Trace:
[  281.249364]  dump_stack+0x1d4/0x2b5
[  281.252261]  panic+0x25e/0x49c
[  281.255403]  __schedule+0x1be8/0x21d0
[  281.263754]  preempt_schedule_common+0x35/0xe0
[  281.264425]  preempt_schedule+0x23/0x30
[  281.265010]  ___preempt_schedule+0x16/0x18
[  281.265635]  _raw_spin_unlock_irqrestore+0xbf/0xe0
[  281.266357]  __remove_mapping+0x77b/0x17e0
[  281.291388]  shrink_page_list+0x5232/0xa6b0
[  281.414732]  shrink_inactive_list+0x997/0x1ab0
[  281.419009]  shrink_node_memcg+0x9de/0x16a0
[  281.424799]  shrink_node+0x3af/0x1530
[  281.433316]  do_try_to_free_pages+0x3bc/0x1170
[  281.435723]  try_to_free_pages+0x43c/0x9e0
[  281.442644]  __alloc_pages_slowpath+0xa4c/0x2c10
[  281.459197]  __alloc_pages_nodemask+0xa6c/0xe10
[  281.466504]  alloc_pages_current+0xb6/0x1e0
[  281.467326]  __page_cache_alloc+0x332/0x560
[  281.471049]  pagecache_get_page+0x2af/0xdd0
[  281.487360]  __getblk_gfp+0x36e/0xd50
[  281.497989]  ext4_read_block_bitmap_nowait+0x2ed/0x1e10
[  281.509111]  ext4_read_block_bitmap+0x23/0x80
[  281.509934]  ext4_mb_mark_diskspace_used+0x180/0x10a0
[  281.512755]  ext4_mb_new_blocks+0xeb7/0x4260
[  281.540189]  ext4_ext_map_blocks+0x2776/0x5b00
[  281.556040]  ext4_map_blocks+0xcaa/0x1860
[  281.559967]  ext4_writepages+0x1e4c/0x3a20
[  281.575738]  do_writepages+0xfc/0x170
[  281.578546]  __writeback_single_inode+0x1cd/0x12e0
[  281.592498]  writeback_sb_inodes+0x6c7/0x1040
[  281.598601]  __writeback_inodes_wb+0x1a3/0x310
[  281.600816]  wb_writeback+0x92c/0xe10
[  281.618064]  wb_workfn+0xdf3/0x1600
[  281.635970]  process_one_work+0xcf3/0x1be0
[  281.662614]  worker_thread+0x17d/0x12f0
[  281.680989]  kthread+0x354/0x430
[  281.682529]  ret_from_fork+0x3a/0x50

One time it took about 10 seconds and another time it took 5 minutes.

Whom should we route this to? It looks both mm and ext4 related.
