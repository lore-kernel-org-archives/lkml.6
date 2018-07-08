Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDDC6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFE2208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/edCGE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFE2208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeGHA7l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 20:59:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44049 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754249AbeGHA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 20:59:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so4452196pls.11;
        Sat, 07 Jul 2018 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VvskSDf0GGTRL9G1vjy5nDTQFWByM1PSAWMpvk70Xws=;
        b=C/edCGE3IjCNHDvd5ZXKZDAv6Aw1FXfOuwNosJDLUxQY4muxOntLHazHD/x0mBOuKy
         oyGT6ayzyevsDqQ7YAlXqEMk5fpEy70MC119hJzov5LgwQfE6A2hDnZfzJcYogS4MzrZ
         Z+XJ5iO+pcU+FIDiA1KkYYjcK+udKR4FoM0N3PdJUJ91CTPoWXVUWKtshwicro4on9/g
         PtPW5DdyEJI0G+SBNYD+/QCdHbPbZKCAnhO4BMNqgrlwVJZUCVviRiW/MWbjD0/DL579
         J7EkbEqK3V+3ZKvlszRyVS9Mmuc6QAXy5nclBonYXAKtEwGypTdWuvG6O9D23JU0wH8Q
         xSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VvskSDf0GGTRL9G1vjy5nDTQFWByM1PSAWMpvk70Xws=;
        b=GM8TYKvRTqiKSg0wj5vR8wS/OICGugv38WMyru84zjKOKLUfIB1tUuRTVvdWHrRuNV
         bxd1mr6Tbv1Of75qoaJoe4fk4fJUl14fdcLCi3pLTfk8T8NxLjONR7OJORp+YAVTFtj7
         alWfsvGj9gyJHjA0pQBRhqe5hfwb+nZQXNpO10olVMk6GlxU1HPHCNTHS1vd0XV6vHq/
         R/iOWq8uqgg1C2tx8g8p8k4WLtCmNG5a/bKRtxuCaHbvMKd8preypuWSOePykSq2mCiL
         qsGsXJejexEhk+HcQZJJ7QA62G1e+YeA4Z7fB5OBXXOadqcP9qF2oQLFeqN4qNrOS1EM
         WXdg==
X-Gm-Message-State: APt69E05NTR4VoZeSviAWCcui8eZ635pjwobyWvivnBiMWjetZ3W+gO3
        8cS2isu/ENqsnDcMSk0nt6Y=
X-Google-Smtp-Source: AAOMgpcbFIXnpjHJ9ecIT4s4rVC37HEfvEol5yTsZmjDd8taY3hrnmrLeIrsOgN1OICpreF6yrjIJg==
X-Received: by 2002:a17:902:8c95:: with SMTP id t21-v6mr6459935plo.306.1531011578828;
        Sat, 07 Jul 2018 17:59:38 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id n9-v6sm21502677pgu.77.2018.07.07.17.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 17:59:37 -0700 (PDT)
Date:   Sat, 7 Jul 2018 17:59:35 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+c6f45f6af72a45097be2@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Song Liu <songliubraving@fb.com>
Subject: Re: KASAN: use-after-free Read in iput
Message-ID: <20180708005935.GA710@sol.localdomain>
References: <000000000000b607cf056a150083@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b607cf056a150083@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 06:02:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018 +0000)
> Merge branch 'parisc-4.17-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=c6f45f6af72a45097be2
> 
> So far this crash happened 2 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5638195895074816
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5154296156913664
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5743820952043520
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c6f45f6af72a45097be2@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> VFS: Busy inodes after unmount of fuse. Self-destruct in 5 seconds.  Have a
> nice day...
> ==================================================================
> BUG: KASAN: use-after-free in iput_final fs/inode.c:1489 [inline]
> BUG: KASAN: use-after-free in iput+0xa05/0xa80 fs/inode.c:1545
> Read of size 8 at addr ffff8801d9752770 by task syzkaller802106/4482
> 
> CPU: 1 PID: 4482 Comm: syzkaller802106 Not tainted 4.17.0-rc1+ #6
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  iput_final fs/inode.c:1489 [inline]
>  iput+0xa05/0xa80 fs/inode.c:1545
>  free_trace_uprobe+0xe2/0x1f0 kernel/trace/trace_uprobe.c:292
>  destroy_local_trace_uprobe+0x63/0x7e kernel/trace/trace_uprobe.c:1395
>  perf_uprobe_destroy+0xf2/0x130 kernel/trace/trace_event_perf.c:342
>  _free_event+0x3ff/0x1430 kernel/events/core.c:4445
>  put_event+0x48/0x60 kernel/events/core.c:4531
>  perf_event_release_kernel+0x8bd/0xf90 kernel/events/core.c:4637
>  perf_release+0x37/0x50 kernel/events/core.c:4647
>  __fput+0x34d/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  get_signal+0x886/0x1960 kernel/signal.c:2469
>  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4457b9
> RSP: 002b:00007f98cec58da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00000000004457b9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000006dac3c
> RBP: 00000000006dac3c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac38
> R13: 0030656c69662f2e R14: 00007f98cec599c0 R15: 0000000000000001
> 
> Allocated by task 4481:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  alloc_super fs/super.c:186 [inline]
>  sget_userns+0x1c7/0xf20 fs/super.c:503
>  sget+0x10b/0x150 fs/super.c:558
>  mount_nodev+0x33/0x110 fs/super.c:1206
>  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1192
>  mount_fs+0xae/0x328 fs/super.c:1268
>  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0x564/0x3070 fs/namespace.c:2847
>  ksys_mount+0x12d/0x140 fs/namespace.c:3063
>  __do_sys_mount fs/namespace.c:3077 [inline]
>  __se_sys_mount fs/namespace.c:3074 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 25:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  destroy_super_work+0x40/0x50 fs/super.c:149
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> 
> The buggy address belongs to the object at ffff8801d9752740
>  which belongs to the cache kmalloc-4096 of size 4096
> The buggy address is located 48 bytes inside of
>  4096-byte region [ffff8801d9752740, ffff8801d9753740)
> The buggy address belongs to the page:
> page:ffffea000765d480 count:1 mapcount:0 mapping:ffff8801d9752740 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801d9752740 0000000000000000 0000000100000001
> raw: ffffea000765a1a0 ffffea00076665a0 ffff8801dac00dc0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801d9752600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801d9752680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801d9752700: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                              ^
>  ffff8801d9752780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d9752800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

This was a reference counting bug in kernel/trace/trace_uprobe.c,
fixed by commit 0c92c7a3c5d416:

#syz fix: tracing: Fix bad use of igrab in trace_uprobe.c

- Eric
