Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED6AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960AA20854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AU9Zfpum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960AA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeKQG4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:56:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50601 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeKQG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:56:16 -0500
Received: by mail-it1-f194.google.com with SMTP id k206-v6so36767500ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XAC4GLR+Z4cfhnA9E8k1k/qKUWi6ab+RW2hDopgQw+Q=;
        b=AU9Zfpumm+iP9NVx8Q+CAiHdwojdCudA+X4MXrXK6bZZw6IGLkbOgm5a9ishVdgsN5
         1LOikSD6NX2MqlS592tYfNFi83+IO+xWY+oBtKtF0FeGsELiOHyQdltXPeFTO1WUPXAl
         y8WS57GG4oc+/SSqUTGzcO2AfG3EwyvZA9F5iA/A0sZaEd6y27JVfE+aoPhKdelZcA2I
         gl0w8JDn2UzsNNjGwmy90kpYLfqsrBCdJyl7h7BHlJJNLPIxLf2BXE9Rb3WZDhg2tvnq
         +O6VAuF9usxjb846nlKFDrdTcz35Pp3/p0LN/LOlVqEFZZEdczSmT6mY9ZUz8ZjJo7Ie
         2cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XAC4GLR+Z4cfhnA9E8k1k/qKUWi6ab+RW2hDopgQw+Q=;
        b=FsHoqjzcDRd1QbjcnRiH2YNr7VKAvQhVearYd84kllGvXL4xHJ3Cz5bs3jOheFU1ze
         8G2uOubMtBtXbs+iucR2TjrnmUshycnpDXK4Ou1ENoVdwCwtCHQgy187TGEUbIviZoKt
         hNwvIlMbgvmDSWCklJfXFNfKbS4ff/RMqUEuKGXuPMpwKRafRP+s7TsUElEty5xHGMhm
         Ccn1BhCyDr5VQ5soFO4XzUeOYBteSo4RZqKfN5BLnhJVQfIkx+jlH4Vc7RkciYET+Gs9
         CtTvfzPqSDL0QrrPeYunSTaJFq+vlfFkX0FNRLtVvnWLM9W/A0HP25lep2mMJ6KJE8lA
         IFAQ==
X-Gm-Message-State: AGRZ1gKu3kPcMGam+U8NyVZmM3YyaX4XsCcSnRDPvUMBtyNFDAwpaq6g
        6JMZivELdGs+D7QDo6bTujI5S+W7GvgCT4xdTYHJxA==
X-Google-Smtp-Source: AJdET5dGMEMu4wuP2ezvawjR/YCpHD2bKryf7XdyqN4nxXOsgihnyJsVuets2B9TyJmWKSNQuZ5GHEMJGdYh6uZa9G4=
X-Received: by 2002:a02:6004:: with SMTP id i4-v6mr10536953jac.72.1542400939705;
 Fri, 16 Nov 2018 12:42:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 12:41:59
 -0800 (PST)
In-Reply-To: <0000000000008628be057a0c089f@google.com>
References: <0000000000008628be057a0c089f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 12:41:59 -0800
Message-ID: <CACT4Y+bFQmrE_R2BWRd46sSW=L_aJOYxDcj95B6RgNqdXu8Z7g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in locks_remove_flock
To:     syzbot <syzbot+34a98afb89842107f03f@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:03 PM, syzbot
<syzbot+34a98afb89842107f03f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e42f5b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> dashboard link: https://syzkaller.appspot.com/bug?extid=34a98afb89842107f03f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+34a98afb89842107f03f@syzkaller.appspotmail.com

This is another manifestation of the following report, right?

#syz dup: KASAN: use-after-free Read in locks_delete_block

> ==================================================================
> BUG: KASAN: use-after-free in locks_remove_flock+0x33c/0x350 fs/locks.c:2567
> Read of size 8 at addr ffff8801c92fc040 by task syz-executor1/15515
>
> CPU: 1 PID: 15515 Comm: syz-executor1 Not tainted 4.20.0-rc1-next-20181107+
> #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  locks_remove_flock+0x33c/0x350 fs/locks.c:2567
>  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
>  __fput+0x2f0/0xa70 fs/file_table.c:271
>  ____fput+0x15/0x20 fs/file_table.c:312
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fc1e8ed4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000049
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000457569
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc1e8ed56d4
> R13: 00000000004bdd9e R14: 00000000004ccdb8 R15: 00000000ffffffff
>
> Allocated by task 15515:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
>  kmem_cache_zalloc include/linux/slab.h:731 [inline]
>  locks_alloc_lock+0x9e/0x300 fs/locks.c:304
>  flock_make_lock+0x22c/0x2a0 fs/locks.c:438
>  __do_sys_flock fs/locks.c:2057 [inline]
>  __se_sys_flock fs/locks.c:2038 [inline]
>  __x64_sys_flock+0x12b/0x350 fs/locks.c:2038
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 15515:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x83/0x290 mm/slab.c:3760
>  locks_free_lock+0x295/0x420 fs/locks.c:341
>  __do_sys_flock fs/locks.c:2078 [inline]
>  __se_sys_flock fs/locks.c:2038 [inline]
>  __x64_sys_flock+0x289/0x350 fs/locks.c:2038
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801c92fc000
>  which belongs to the cache file_lock_cache of size 264
> The buggy address is located 64 bytes inside of
>  264-byte region [ffff8801c92fc000, ffff8801c92fc108)
> The buggy address belongs to the page:
> page:ffffea000724bf00 count:1 mapcount:0 mapping:ffff8801d9a1c3c0 index:0x0
> flags: 0x2fffc0000000200(slab)
> raw: 02fffc0000000200 ffff8801d9a82e48 ffffea00075e1608 ffff8801d9a1c3c0
> raw: 0000000000000000 ffff8801c92fc000 000000010000000c 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801c92fbf00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801c92fbf80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>
>> ffff8801c92fc000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                                            ^
>  ffff8801c92fc080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801c92fc100: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
> ==================================================================
> ------------[ cut here ]------------
> downgrading a read lock
> WARNING: CPU: 0 PID: 15521 at kernel/locking/lockdep.c:3556 __lock_downgrade
> kernel/locking/lockdep.c:3556 [inline]
> WARNING: CPU: 0 PID: 15521 at kernel/locking/lockdep.c:3556
> lock_downgrade+0x4d7/0x900 kernel/locking/lockdep.c:3819
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008628be057a0c089f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
