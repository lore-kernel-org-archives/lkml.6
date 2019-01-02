Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CF7218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfY4hwPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfABSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:54:15 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39483 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:54:14 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so39901098itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpZaDSXKmf2eWiwDqA8ccRYA77ziert7SwXxKnpAWWs=;
        b=AfY4hwPD0kChEQ1mvrgwILTn/fRzd8Ys3WN0x5GzQIKc8fBZNeBMQqh/Bn4tLs7V35
         ewJqNeeKzYaMuST71JISEAKFHQw4sklt8v8xuRlBaBuHXaEu3kMj8dJfW/p858kX3Xbb
         OarxlgHdloF60ukNbhjojuyA+TJ2NXBUoMJVDTe3wIHq+UGU018SuLvA/FSN6FqeNjD+
         hzSDskcXXWH4A5NUdCbI/eOhMBWB+w8RfFXJYfG39cjHDKr0l8Zq0d0nOWb7nt7nfDvd
         nywHEQ8qh8gqN0Umw5FB7B1T0MpoI/dgiD52hmnd2kp6psDXYouq7ppmSnNbgIU07DTz
         gmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpZaDSXKmf2eWiwDqA8ccRYA77ziert7SwXxKnpAWWs=;
        b=oBpw2OP9Y5wdTGiUDgsiYDViNRVBElDUExAKU82nebp/9SF+lONOeHF5GqucRvmrn4
         5eTDrvigxgF6Y+5Wuu2O6UKr70ToGJsAY6qezmijGnbndsnRXv1NoLwo0p/fnwR0TBpW
         FrGBMHZr/pBRVkgq/vAs5mjvUXKvhV3pI/joOiBQU8CGmmXXca/UwSpfN9bxVcE5KPsL
         6Zi28mgaajphjB0iP+FhNnijDMtxuhaNiNPeqplqa6vBjZ8TFeHnM8nvUP5z2LyTSLTC
         aQzOEzMNxN5EHidUaISheMRU5lMMvUhuRQ0hRYkCBB3Vdwyocu/EMzMG+Fr3f/h3r8kU
         ZIEw==
X-Gm-Message-State: AJcUukf9QqgqCIZ0gR7CqigIJX6ujorgiAKx9Hjdb4+BRoZgD1AtiFuA
        C9VYuddr2Tuk5NtcZXbIPVkAVjc4qbswOBX9Z8G4nQ==
X-Google-Smtp-Source: ALg8bN6T4xETv6tyCC5bGX3lsYThmwCPQduTCIKmK+Esp24tURCdqz1Mv7p5L0bfCTyarocC6VxxbBb6AB4sW7DOtxw=
X-Received: by 2002:a24:6511:: with SMTP id u17mr6570919itb.12.1546455253130;
 Wed, 02 Jan 2019 10:54:13 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a415f5057e772463@google.com> <9546892a26b5d933132d733468550a232df60e17.camel@kernel.org>
 <CACT4Y+auMcSDNggu5GkJ==yg05Dj9zZxdsx5HO9FMSLHdvAecQ@mail.gmail.com>
In-Reply-To: <CACT4Y+auMcSDNggu5GkJ==yg05Dj9zZxdsx5HO9FMSLHdvAecQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 19:54:02 +0100
Message-ID: <CACT4Y+aBb1sGMoJS5+WC1CZRShuh2T-0V6mbcCKGkSjYAAGoXQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in posix_lock_inode
To:     Jeff Layton <jlayton@kernel.org>
Cc:     syzbot <syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 2, 2019 at 7:20 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Wed, 2019-01-02 at 02:31 -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16bb4c4b400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c6a26e22579190b
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=239d99847eb49ecb3899
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128aa377400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com
> > >
> > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> > > 8021q: adding VLAN 0 to HW filter on device batadv0
> > > 8021q: adding VLAN 0 to HW filter on device batadv0
> > > ==================================================================
> > > BUG: KASAN: use-after-free in what_owner_is_waiting_for fs/locks.c:1000
> > > [inline]
> > > BUG: KASAN: use-after-free in posix_locks_deadlock fs/locks.c:1023 [inline]
> > > BUG: KASAN: use-after-free in posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
> > > Read of size 8 at addr ffff88808791b000 by task syz-executor2/10100
> > >
> > > CPU: 1 PID: 10100 Comm: syz-executor2 Not tainted 4.20.0+ #3
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> > >   what_owner_is_waiting_for fs/locks.c:1000 [inline]
> > >   posix_locks_deadlock fs/locks.c:1023 [inline]
> > >   posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
> > >   posix_lock_file fs/locks.c:1346 [inline]
> > >   vfs_lock_file fs/locks.c:2314 [inline]
> > >   vfs_lock_file+0xc7/0xf0 fs/locks.c:2309
> > >   do_lock_file_wait.part.0+0xe5/0x260 fs/locks.c:2328
> > >   do_lock_file_wait fs/locks.c:2324 [inline]
> > >   fcntl_setlk+0x2f1/0xfe0 fs/locks.c:2413
> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x457ec9
> > > Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > > ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007f58bbb50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> > > RDX: 0000000020000140 RSI: 0000000000000007 RDI: 0000000000000003
> > > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58bbb516d4
> > > R13: 00000000004be5f0 R14: 00000000004ceab0 R15: 00000000ffffffff
> > >
> > > Allocated by task 10100:
> > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> > >   set_track mm/kasan/common.c:85 [inline]
> > >   kasan_kmalloc mm/kasan/common.c:482 [inline]
> > >   kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
> > >   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:397
> > >   kmem_cache_alloc+0x12d/0x710 mm/slab.c:3541
> > >   kmem_cache_zalloc include/linux/slab.h:730 [inline]
> > >   locks_alloc_lock+0x8e/0x2f0 fs/locks.c:344
> > >   fcntl_setlk+0xa9/0xfe0 fs/locks.c:2362
> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > > Freed by task 10100:
> > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> > >   set_track mm/kasan/common.c:85 [inline]
> > >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
> > >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
> > >   __cache_free mm/slab.c:3485 [inline]
> > >   kmem_cache_free+0x86/0x260 mm/slab.c:3747
> > >   locks_free_lock+0x27a/0x3f0 fs/locks.c:381
> > >   fcntl_setlk+0x7b5/0xfe0 fs/locks.c:2439
> > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > > The buggy address belongs to the object at ffff88808791b000
> > >   which belongs to the cache file_lock_cache of size 264
> > > The buggy address is located 0 bytes inside of
> > >   264-byte region [ffff88808791b000, ffff88808791b108)
> > > The buggy address belongs to the page:
> > > page:ffffea00021e46c0 count:1 mapcount:0 mapping:ffff8880aa16a1c0 index:0x0
> > > flags: 0x1fffc0000000200(slab)
> > > raw: 01fffc0000000200 ffffea0002333508 ffffea00021d76c8 ffff8880aa16a1c0
> > > raw: 0000000000000000 ffff88808791b000 000000010000000c 0000000000000000
> > > page dumped because: kasan: bad access detected
> > >
> > > Memory state around the buggy address:
> > >   ffff88808791af00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
> > >   ffff88808791af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > ffff88808791b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >                     ^
> > >   ffff88808791b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >   ffff88808791b100: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
> > > ==================================================================
> > >
> > >
> >
> > I've given this a harder look and I really don't quite grok what
> > this output is telling me:
> >
> > All 3 stack traces say they come from PID 10100, but the use-after-free
> > seems to occur well before the free could have occurred in the context
> > of the current fcntl call.
>
> Interestingly it is the case in all crashes for this bug. It may be
> something inherent, or maybe just the particular program that
> triggered this is such that these accesses happen in the same thread.
>
> > So, I guess that leaves the possibility that we freed a lock request
> > from an earlier fcntl call without removing it properly from the tree,
> > but (a) I don't see how that could happen, _and_ (b) why didn't that
> > trip the BUG_ONs in locks_free_lock?
> >
> > I'll keep looking at this, but I'm a bit stumped at the moment.
>
> The simplest repro for this is:
>
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
> r0 = epoll_create1(0x0)
> fcntl$lock(r0, 0x7, &(0x7f0000000080))
> fcntl$lock(r0, 0x7, &(0x7f0000000140)={0x1000000000001, 0x0, 0x1000000})
>
> "collide":true means that the 2 fcntl's were executed in parallel. But
> still the alloc/free/access always happened in the same thread, so the
> thread interaction seems to be somewhat unusual.

Looking at frequency of this crash, repro properties and some other
signals my money are on a race/atomicity violation with a narrow
inconsistency window. E.g. unlock something and then expect things
have not changed after re-lock, or remove from list and reset a
pointer few instructions later.
