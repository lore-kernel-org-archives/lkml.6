Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8993208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoLyGFQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8993208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeGIFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:45:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41336 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeGIFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:45:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so8212154pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4BXHDbF3iCFKwJ8C+/SQPfHezkiU50gPGvZRbnneipU=;
        b=QoLyGFQfOX/7rEPZRRVhRAKuz4iWrtrVE+4t4t4C190YDlhWQprXU/pXX2NChUamNe
         9VP+h1BXEeV5OuSzk60DyhFB+qAqqOFh5A3FQCr2tXbfHOP1D6GA9G+wnEtz/9to4HIl
         Ay8TMWNPpzG3bExdti2kPYTcClzYtDca/XS6/kmEnmlxGAuSmAz+MTalpu9nrlZyKpFy
         +64CBYmUYcFVkp8Lj+ITtt7F/Qoeji/e6YBHIbqeT98WNUcUkk35MtHAdRZKvFXeTtAW
         HhgRhpVLVmWsElDfEEK5EUxQIj6F/4bvsFKAK14TaDt0ax7tys0USyjHWxAK7O57f6UO
         POEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4BXHDbF3iCFKwJ8C+/SQPfHezkiU50gPGvZRbnneipU=;
        b=lM87e6XQbW61c8ZqzFa1hKWwJb17lz4K5dXDw5vhOBHIigW4JGicuiC+Q6R3adDBwL
         4z/e2pUEOfumu8cAgAmKdOqbn5I4XdZyUqnJG4E86j/imtiiv6hfsq5SG5FxbinBIDTM
         2Oel3TZTI7e5VN84SDXi9JxcTEeOy0gwPbecUVUEI29CztD8LikxhKuEQH1c1kCkY1L+
         /HsnKHzCkYkjNq+o/FfyeWK45Kt7BeavR45BCYionp0yP7XG/p58uw3cwmX5JXM6h5i/
         MiBYFNZG2rW+vmfJfhBxTAWtWChEXZEoeM+ZWPfOU1Tth8FsylIga1HQOeOIXSY0/3zO
         yYcA==
X-Gm-Message-State: APt69E2eZhgNzHhnfdWg+9HI7vnk0pklH+i3G5Ml2gdV18PJyLJGqDmL
        bSW7XctvvTehFkgS2xk7ouXbX9jNP7JdovhnLeKO4A==
X-Google-Smtp-Source: AAOMgpcRK5TZXIC45zXzjfKP8DfF+M5Iok+lEY/5KlB72mnjjww1YyiZy69cCQk3NNnBhzSMjkPe2ZD7FF3TfUGjIHc=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr18145393pgh.216.1531115113112;
 Sun, 08 Jul 2018 22:45:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:44:52
 -0700 (PDT)
In-Reply-To: <0000000000000311c905708856bf@google.com>
References: <0000000000000311c905708856bf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 07:44:52 +0200
Message-ID: <CACT4Y+YM0jW3jGAv3fmKJuTAd2Mb-ZjOMAgcCADLNfi9LuAmJw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in add_wait_queue
To:     syzbot <syzbot+b1b8812f7c2ce78da0e5@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        sudipm.mukherjee@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        zhong jiang <zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:09 AM, syzbot
<syzbot+b1b8812f7c2ce78da0e5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123180c8400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=b1b8812f7c2ce78da0e5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16dc56d0400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170f4f48400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b1b8812f7c2ce78da0e5@syzkaller.appspotmail.com

#syz fix: bpf: sockhash, disallow bpf_tcp_close and update in parallel

> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in __lock_acquire+0x3829/0x5020
> kernel/locking/lockdep.c:3314
> Read of size 8 at addr ffff8801a91dc738 by task syz-executor471/4532
>
> CPU: 0 PID: 4532 Comm: syz-executor471 Not tainted 4.18.0-rc3+ #137
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __lock_acquire+0x3829/0x5020 kernel/locking/lockdep.c:3314
>  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>  add_wait_queue+0x92/0x2b0 kernel/sched/wait.c:22
>  do_wait+0x1bf/0xb80 kernel/exit.c:1505
>  kernel_wait4+0x247/0x3f0 kernel/exit.c:1665
>  __do_sys_wait4+0x137/0x150 kernel/exit.c:1677
>  __se_sys_wait4 kernel/exit.c:1673 [inline]
>  __x64_sys_wait4+0x97/0xf0 kernel/exit.c:1673
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x405faa
> Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 0e cc 2d 00 85
> c0 75 36 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff
> 77 06 c3 0f 1f 44 00 00 48 c7 c2 d0 ff ff ff f7
> RSP: 002b:00007fff2e852408 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
> RAX: ffffffffffffffda RBX: 00000000000007b5 RCX: 0000000000405faa
> RDX: 0000000040000001 RSI: 00007fff2e85241c RDI: ffffffffffffffff
> RBP: 00000000000007b5 R08: 0000000000000001 R09: 00000000023e4880
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000291
> R13: 000000000001b4c3 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 4531:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>  kmem_cache_zalloc include/linux/slab.h:697 [inline]
>  copy_signal+0x175/0xc10 kernel/fork.c:1443
>  copy_process.part.39+0x2137/0x7220 kernel/fork.c:1800
>  copy_process kernel/fork.c:1616 [inline]
>  _do_fork+0x291/0x12a0 kernel/fork.c:2099
>  __do_sys_clone kernel/fork.c:2206 [inline]
>  __se_sys_clone kernel/fork.c:2200 [inline]
>  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 0:
> (stack is not available)
>
> The buggy address belongs to the object at ffff8801a91dc700
>  which belongs to the cache signal_cache of size 1296
> The buggy address is located 56 bytes inside of
>  1296-byte region [ffff8801a91dc700, ffff8801a91dcc10)
> The buggy address belongs to the page:
> page:ffffea0006a47700 count:1 mapcount:0 mapping:ffff8801da97be40 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea0006b3ca88 ffffea0006b2f888 ffff8801da97be40
> raw: 0000000000000000 ffff8801a91dc140 0000000100000005 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801a91dc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801a91dc680: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2
>>
>> ffff8801a91dc700: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
>
>                                         ^
>  ffff8801a91dc780: f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
>  ffff8801a91dc800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000311c905708856bf%40google.com.
> For more options, visit https://groups.google.com/d/optout.
