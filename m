Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2065208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkxKD78S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2065208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeGIF7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:59:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38138 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeGIF7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:59:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so5515130pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BZmmO9IcV1dl85vm1A1EdNk7XEQa370NCINfVIn4MmU=;
        b=mkxKD78SH9kfo+gWX4CNpJ5OUhnhg8YQ8eyJpo6UaCa61WS9pDlkRmJUA347h+XtpN
         V9mQz2YwqUyB3Hz0txqLz7bC7KCxeZSOBheb2jtom5CZf+DpRZ46aYcAhzFX/Azvq99z
         WS61V9eYv9bIxKdWVhg8BRId0ZhR7P488VnZ2MEkwDp7CuPfEALTF+b1zq0vddVsvKrc
         DVtPRgBPOYT01jb1YX5Dv8WjasRYbIyE/sfVbHSLSaxks4SWwuLXI10+LJ0zTjFbQhrA
         Z/tXcbqjtuooRWVghV5YwFxbDNN4gQm7haWJbQRFZDt1qCQC86mD3WKnkn+dykEj8/E7
         4kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BZmmO9IcV1dl85vm1A1EdNk7XEQa370NCINfVIn4MmU=;
        b=snZ4bawWusrPzVNjL7fEVQi2blF/34CnTVly3N1Z6bWPmqahzD5BHtVB7Ktiru6sk4
         VrEmLG4IOhrTKXjW3dO8vQeyKxxzY8gxKPLa1h8p0IoqZ2fqKEh9zs1whgOLvEkrnQhh
         HXwTovg+AO87HzFu0153rge2LZl05PGbd7+Ae0lnE+vO0Xni8xaa0fOX64dmluTmdBd7
         FnEieHi1hsWDX5gJFxy3rWRjsgfDhSWOTwc76zff7IzbYEao/3eKVRV6Pl2Qbjx+Dpmg
         EioLZ5jWAWrC/yjOfxQfxBES4lJ2KTXByK6RFaNYANkM0xWXKU2XNowRGaNfTxYG7eSz
         nxhQ==
X-Gm-Message-State: APt69E2YoAyeT5SwJvxaHKuLuNqugxe0Me0XaHNx8250wpv7jz7g5C1I
        RZBn0VjmpPRmwioQ0uyX1bsrKBFzalcNe19W7sDugA==
X-Google-Smtp-Source: AAOMgpeEL2D3VnAJTpeSTgjcXT7uYV8157991OIoC78PpKX9tvkrwBggNGMfCavNUz8iDj0V3xShZUbcY+d8p9Bb1wY=
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr19234460plo.117.1531115972114;
 Sun, 08 Jul 2018 22:59:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:59:11
 -0700 (PDT)
In-Reply-To: <000000000000f98bc70570885526@google.com>
References: <000000000000f98bc70570885526@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 07:59:11 +0200
Message-ID: <CACT4Y+byr3eykkrP6=hX+G8bpzwUvY259FphK9k+UGG677kGfw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fscache_alloc_cookie
To:     syzbot <syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>,
        Eric Van Hensbergen <ericvh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:09 AM, syzbot
<syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ca04b3cca11a Merge tag 'armsoc-fixes' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e382e0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=a95b989b2dde8e806af8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1097c6fc400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152d29b2400000

+9p maintianers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com
>
> sshd (4453) used greatest stack depth: 17048 bytes left
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in fscache_set_key fs/fscache/cookie.c:120
> [inline]
> BUG: KASAN: slab-out-of-bounds in fscache_alloc_cookie+0x7a9/0x880
> fs/fscache/cookie.c:171
> Read of size 4 at addr ffff8801d3cc8bb4 by task syz-executor907/4466
>
> CPU: 1 PID: 4466 Comm: syz-executor907 Not tainted 4.18.0-rc3+ #40
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  fscache_set_key fs/fscache/cookie.c:120 [inline]
>  fscache_alloc_cookie+0x7a9/0x880 fs/fscache/cookie.c:171
>  __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
>  fscache_acquire_cookie include/linux/fscache.h:338 [inline]
>  v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
>  v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
>  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>  mount_fs+0xae/0x328 fs/super.c:1277
>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0x581/0x30e0 fs/namespace.c:2848
>  __do_compat_sys_mount fs/compat.c:125 [inline]
>  __se_compat_sys_mount fs/compat.c:92 [inline]
>  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f17cb9
> Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b
> 5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffafd7dc EFLAGS: 00000286 ORIG_RAX: 0000000000000015
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000020000280
> RDX: 00000000200002c0 RSI: 0000000000800000 RDI: 0000000020000340
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 4466:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc mm/slab.c:3718 [inline]
>  __kmalloc+0x14e/0x760 mm/slab.c:3727
>  kmalloc include/linux/slab.h:518 [inline]
>  kzalloc include/linux/slab.h:707 [inline]
>  fscache_set_key fs/fscache/cookie.c:101 [inline]
>  fscache_alloc_cookie+0x701/0x880 fs/fscache/cookie.c:171
>  __fscache_acquire_cookie+0x230/0xb00 fs/fscache/cookie.c:303
>  fscache_acquire_cookie include/linux/fscache.h:338 [inline]
>  v9fs_cache_session_get_cookie+0xc4/0x270 fs/9p/cache.c:73
>  v9fs_session_init+0x1013/0x1a80 fs/9p/v9fs.c:464
>  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
>  mount_fs+0xae/0x328 fs/super.c:1277
>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0x581/0x30e0 fs/namespace.c:2848
>  __do_compat_sys_mount fs/compat.c:125 [inline]
>  __se_compat_sys_mount fs/compat.c:92 [inline]
>  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
>
> Freed by task 1:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  __kthread_create_on_node+0x34a/0x4c0 kernel/kthread.c:337
>  kthread_create_on_node+0xb1/0xe0 kernel/kthread.c:373
>  cryptomgr_schedule_test crypto/algboss.c:255 [inline]
>  cryptomgr_notify+0x5ac/0xb90 crypto/algboss.c:276
>  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
>  __blocking_notifier_call_chain kernel/notifier.c:317 [inline]
>  blocking_notifier_call_chain+0x147/0x190 kernel/notifier.c:328
>  crypto_probing_notify+0x26/0x80 crypto/api.c:254
>  crypto_wait_for_test+0x42/0xe0 crypto/algapi.c:361
>  crypto_register_alg+0xc0/0xe0 crypto/algapi.c:392
>  crypto_register_shash+0x35/0x50 crypto/shash.c:494
>  crypto_register_shashes+0x5d/0xe0 crypto/shash.c:509
>  register_sha512_ssse3 arch/x86/crypto/sha512_ssse3_glue.c:136 [inline]
>  sha512_ssse3_mod_init+0xc4/0x282 arch/x86/crypto/sha512_ssse3_glue.c:316
>  do_one_initcall+0x127/0x913 init/main.c:884
>  do_initcall_level init/main.c:952 [inline]
>  do_initcalls init/main.c:960 [inline]
>  do_basic_setup init/main.c:978 [inline]
>  kernel_init_freeable+0x49b/0x58e init/main.c:1135
>  kernel_init+0x11/0x1b3 init/main.c:1061
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>
> The buggy address belongs to the object at ffff8801d3cc8b80
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 52 bytes inside of
>  64-byte region [ffff8801d3cc8b80, ffff8801d3cc8bc0)
> The buggy address belongs to the page:
> page:ffffea00074f3200 count:1 mapcount:0 mapping:ffff8801da800340 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea000750d208 ffffea00074b1f08 ffff8801da800340
> raw: 0000000000000000 ffff8801d3cc8000 0000000100000020 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d3cc8a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801d3cc8b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>
>> ffff8801d3cc8b80: 00 00 00 00 00 00 07 fc fc fc fc fc fc fc fc fc
>
>                                      ^
>  ffff8801d3cc8c00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>  ffff8801d3cc8c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f98bc70570885526%40google.com.
> For more options, visit https://groups.google.com/d/optout.
