Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C5DC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFD120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di4syaCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfBTP1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:27:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39020 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfBTP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:26:56 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so16352753iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3rcc1J3JYmhQ8I9Kj9zrtQwsXCqvPQGRbAEOF7N32c=;
        b=Di4syaCE6cY7NdUtClREQ9635jCzT/aky8NSZ2p+MkN6ZRnJz78M4NYTmhSNCpjEVf
         M87nR+Of2Vu95I4auVIlZwOJsNz6GevjzUyLn2O8R+RMm6A8T0GYE8MNPLktFpiLK/7b
         G0EfT25Mf0sv/NYJg2Bvbcltd/mX88hCp0RX4f8eAcX4EtaQ2HWjTGNfPCDrYrp1SzQU
         f/z9N9nJXCQkd1qJyl1dfe/i9vnfFRS0uoWTBfYuqY/UqLz48AiQG7fsu/Me8MYLc6zQ
         QOvPrBdfBhkxpQUaR6XEx8j+5voeFe7pOqBNte3sVsmNTdoF9MCKLTAnR1lg3QwWcdIT
         MOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3rcc1J3JYmhQ8I9Kj9zrtQwsXCqvPQGRbAEOF7N32c=;
        b=D6hjufdlzARxH/xX0UvJWR8JjnScUcNHIt4bIbNyLa+7k/NYYJPfi2Zt2e6Bbl0fp+
         0Voq8w2SSltk4RO4f/wkSACc1J4mT9wKSlokJA9SbBfxGxK+CeYfim0acY8c3Iaiyyap
         nU5WYhMampfOaLPTeGWne/Bg1Y5uSMcPOOMUux7gHutZr9Jc91vsD4Ccv+cXHB0ylPPd
         0E3tleE36QVR3DU3IdPz1RtWq8OeSDM1R+LfAbV4OZlqhfONMf059hAdk8WUiuNHVG+e
         x6lrC6/UWZ5EoXCKWiMobo1TLyz50eMcMoGAUCE+gAVPQAb6yx1DQkE9EkDA7CEJc9nI
         64Vg==
X-Gm-Message-State: AHQUAuby35e6oXHhgxLsON65LvVGuTjZUdAqo8UQlSbDFG/jsMdLW2Ox
        gIMSccwMUff6luDbzOHPZTkAqB3yE0f9U8ae+3keSg==
X-Google-Smtp-Source: AHgI3IbaYSSQLgGtSbTgMMhR//wi3Ym7eDLfRZg5qbKdyKKR6BDZzIc+Cat5KJ5wvcWMIGgdcntKRKYAt4Ec9oSpzCU=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr20053036ior.11.1550676415483;
 Wed, 20 Feb 2019 07:26:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000195e0e057063783e@google.com>
In-Reply-To: <000000000000195e0e057063783e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 16:26:44 +0100
Message-ID: <CACT4Y+bA05uP7xbNdEfhEz=HL9mUO7xPcTmgX=4_kXp81Zx-0A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cma_acquire_dev
To:     syzbot <syzbot+908eac39ffdc39221032@syzkaller.appspotmail.com>
Cc:     danielj@mellanox.com, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        monis@mellanox.com, parav@mellanox.com,
        swise@opengridcomputing.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 9:10 AM syzbot
<syzbot+908eac39ffdc39221032@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    fc36def997cf mm: teach dump_page() to correctly output poi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1378110c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=908eac39ffdc39221032
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+908eac39ffdc39221032@syzkaller.appspotmail.com
>
> netlink: 4 bytes leftover after parsing attributes in process
> `syz-executor0'.
> QAT: Invalid ioctl
> capability: warning: `syz-executor0' uses deprecated v2 capabilities in a
> way that may be insecure
> ==================================================================
> BUG: KASAN: use-after-free in rdma_ip2gid include/rdma/ib_addr.h:143
> [inline]
> BUG: KASAN: use-after-free in cma_acquire_dev+0xe56/0xea0
> drivers/infiniband/core/cma.c:654
> Read of size 2 at addr ffff88019c561360 by task syz-executor2/8894


This seems to have been fixed by:

#syz fix: ucma: fix a use-after-free in ucma_resolve_ip()

So let's close the bug. Pile of neglected bug reports is not too useful.



> CPU: 1 PID: 8894 Comm: syz-executor2 Not tainted 4.18.0-rc3+ #131
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>   __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:431
>   rdma_ip2gid include/rdma/ib_addr.h:143 [inline]
>   cma_acquire_dev+0xe56/0xea0 drivers/infiniband/core/cma.c:654
>   rdma_bind_addr+0x248/0x23b0 drivers/infiniband/core/cma.c:3388
>   cma_bind_addr drivers/infiniband/core/cma.c:2930 [inline]
>   rdma_resolve_addr+0x500/0x28a0 drivers/infiniband/core/cma.c:2942
>   ucma_resolve_ip+0x242/0x2a0 drivers/infiniband/core/ucma.c:711
>   ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
>   __vfs_write+0x117/0x9f0 fs/read_write.c:485
>   vfs_write+0x1f8/0x560 fs/read_write.c:549
>   ksys_write+0x101/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x455ba9
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fb04c987c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fb04c9886d4 RCX: 0000000000455ba9
> RDX: 0000000000000048 RSI: 00000000200002c0 RDI: 0000000000000015
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c7f98 R14: 00000000004d4160 R15: 0000000000000000
>
> Allocated by task 8894:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>   kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>   kmalloc include/linux/slab.h:513 [inline]
>   kzalloc include/linux/slab.h:707 [inline]
>   __rdma_create_id+0xdf/0x720 drivers/infiniband/core/cma.c:780
>   ucma_create_id+0x399/0x9d0 drivers/infiniband/core/ucma.c:502
>   ucma_write+0x336/0x420 drivers/infiniband/core/ucma.c:1680
>   __vfs_write+0x117/0x9f0 fs/read_write.c:485
>   vfs_write+0x1f8/0x560 fs/read_write.c:549
>   ksys_write+0x101/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 8905:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kfree+0xd9/0x260 mm/slab.c:3813
>   rdma_destroy_id+0x8cd/0xe60 drivers/infiniband/core/cma.c:1703
>   ucma_close+0x100/0x300 drivers/infiniband/core/ucma.c:1759
>   __fput+0x355/0x8b0 fs/file_table.c:209
>   ____fput+0x15/0x20 fs/file_table.c:243
>   task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>   exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff88019c561340
>   which belongs to the cache kmalloc-2048 of size 2048
> The buggy address is located 32 bytes inside of
>   2048-byte region [ffff88019c561340, ffff88019c561b40)
> The buggy address belongs to the page:
> page:ffffea0006715800 count:1 mapcount:0 mapping:ffff8801da800c40
> index:0xffff88019c560240 compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea00066fb108 ffffea000670dc08 ffff8801da800c40
> raw: ffff88019c560240 ffff88019c560240 0000000100000002 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff88019c561200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88019c561280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > ffff88019c561300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                         ^
>   ffff88019c561380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88019c561400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000195e0e057063783e%40google.com.
> For more options, visit https://groups.google.com/d/optout.
