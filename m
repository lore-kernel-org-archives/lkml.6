Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE34218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz+RD29b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfABKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:10:05 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34633 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfABKKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:10:04 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so6477187vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=So3sVy2xR+VxO4sb+ze1AumiRsZSdHxsEHnLAMncwsk=;
        b=lz+RD29b52BCEUSQyxB+egjvdGV0ZCrsFrAj1of35D4YZEuVDBQU0eQBtpEF0hLTIW
         r7HBlJxxBqRYzIlrOZ43EJiBpWPTcAFdop7Ek7NK40ijUxN5TSHlIeC5gGKqb3XD9lsz
         mbvOfIbIIR6/Yi0ewOFM2RRbjhO8X2YRux04ylbhtbBsZ6zrdefTuYJ3Wia3kj8+6AEV
         Tl3umWW+85rAOA9w0woDyEUEhPdWH5a+nh6fJvvK/oJa+CBRtpncUBQXr4k0zNj4C48+
         z1utET5RVc4QHeqbBww910YS3exbUMxWjQA9hXbrGMojqo0heRfumdVnGfjlEssdi9qE
         T9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=So3sVy2xR+VxO4sb+ze1AumiRsZSdHxsEHnLAMncwsk=;
        b=bWv/jaM4PLK22psMG3HVf2tG/pgOV8svW2ovLLZpvmxXZm4ezzvMemHICq/yxm7M2b
         jUu3APU8aBgiQRkrh4BH89qzIiERehGxXlUPTtQrMKbcTlMoLRY1OY3guLrDuzn/JoGu
         JZpUg7HsPmLHM3HGFRMbPqqjocZ0oi6PI/z3gTzlKQ8A/jaApMML1ykkmbLOn4vMDwbt
         UHBTuK5XuVt+2eoK88/usDoIyfi0XV8IeG7rdxf+c1SpQuvQGq7r36WswtaFBLyaLZfR
         g7FUiGZkL4C021FE3HpFrejfwMYb9fi1AMIIBOrd4aBfUPqmiw0cffffiMXJs0Hp5Pz5
         7tMg==
X-Gm-Message-State: AJcUukdI8ZNCz3+5bDh2p6j2TLiT7Fu7K15rWfKbRJY8Dbepr8FXjmXg
        9iPFPFsXSaFcKc2w6VRp3dIGvpRYhNiky0gmy0utAxSrI0w=
X-Google-Smtp-Source: ALg8bN7r+DtM+DuL2f5JrRDB7RFuscu0lueXYOsNkz5zuGGnLUftvT8Nk1xwXjGh/RKznmEi3kWmeGUGycAMhtqTQGs=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr14674710vkd.64.1546423802798;
 Wed, 02 Jan 2019 02:10:02 -0800 (PST)
MIME-Version: 1.0
References: <00000000000016eb330575bd2fab@google.com> <CAG_fn=WwdgnCQ2fOw_LEXwv7Fdbmshxo57XJXNbfbawDndJZ_Q@mail.gmail.com>
 <CAG_fn=UjeL9BmAq+FDK01n4mH7ieQXpxkRRxAbDPd5UcC7eZPw@mail.gmail.com> <06a3b403-7fe3-24fd-0ce2-9a604f3bbe62@kernel.dk>
In-Reply-To: <06a3b403-7fe3-24fd-0ce2-9a604f3bbe62@kernel.dk>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 2 Jan 2019 11:09:51 +0100
Message-ID: <CAG_fn=UgdYm4YHpWkwv=Us1m1Fms64JCPEOkUR1+6pxJako7bg@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in copy_page_to_iter (2)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bart.vanassche@wdc.com,
        matias.bjorling@wdc.com, Andi Kleen <ak@linux.intel.com>,
        jack@suse.cz, jlayton@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 2:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/19/18 3:23 AM, Alexander Potapenko wrote:
> > On Thu, Sep 13, 2018 at 11:23 AM Alexander Potapenko <glider@google.com=
> wrote:
> >>
> >> On Thu, Sep 13, 2018 at 11:18 AM syzbot
> >> <syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()=
/kmsa..
> >>> git tree:       https://github.com/google/kmsan.git/master
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1249fcb84=
00000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D848e40757=
852af3e
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2dcfeaf8cb4=
9b05e8f1a
> >>> compiler:       clang version 7.0.0 (trunk 334104)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D116ef05=
0400000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D122870ff8=
00000
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> >>> Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
> >>>
> >>> random: sshd: uninitialized urandom read (32 bytes read)
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
> >>> BUG: KMSAN: kernel-infoleak in copy_page_to_iter_iovec lib/iov_iter.c=
:212
> >>> [inline]
> >>> BUG: KMSAN: kernel-infoleak in copy_page_to_iter+0x754/0x1b70
> >>> lib/iov_iter.c:716
> >>> CPU: 0 PID: 4516 Comm: blkid Not tainted 4.17.0+ #9
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS
> >>> Google 01/01/2011
> >>> Call Trace:
> >>>   __dump_stack lib/dump_stack.c:77 [inline]
> >>>   dump_stack+0x185/0x1d0 lib/dump_stack.c:113
> >>>   kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
> >>>   kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:1238
> >>>   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
> >>>   copyout lib/iov_iter.c:140 [inline]
> >>>   copy_page_to_iter_iovec lib/iov_iter.c:212 [inline]
> >>>   copy_page_to_iter+0x754/0x1b70 lib/iov_iter.c:716
> >>>   generic_file_buffered_read mm/filemap.c:2185 [inline]
> >>>   generic_file_read_iter+0x2ef8/0x44d0 mm/filemap.c:2362
> >>>   blkdev_read_iter+0x20d/0x280 fs/block_dev.c:1930
> >>>   call_read_iter include/linux/fs.h:1778 [inline]
> >>>   new_sync_read fs/read_write.c:406 [inline]
> >>>   __vfs_read+0x775/0x9d0 fs/read_write.c:418
> >>>   vfs_read+0x36c/0x6b0 fs/read_write.c:452
> >>>   ksys_read fs/read_write.c:578 [inline]
> >>>   __do_sys_read fs/read_write.c:588 [inline]
> >>>   __se_sys_read fs/read_write.c:586 [inline]
> >>>   __x64_sys_read+0x1bf/0x3e0 fs/read_write.c:586
> >>>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
> >>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> RIP: 0033:0x7fdeff68f310
> >>> RSP: 002b:00007ffe999660b8 EFLAGS: 00000246 ORIG_RAX: 000000000000000=
0
> >>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdeff68f310
> >>> RDX: 0000000000000100 RSI: 0000000001e78df8 RDI: 0000000000000003
> >>> RBP: 0000000001e78dd0 R08: 0000000000000028 R09: 0000000001680000
> >>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001e78030
> >>> R13: 0000000000000100 R14: 0000000001e78080 R15: 0000000001e78de8
> >>>
> >>> Uninit was created at:
> >>>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
> >>>   kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:819
> >>>   kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:889
> >>>   __alloc_pages_nodemask+0xf7b/0x5cc0 mm/page_alloc.c:4402
> >>>   alloc_pages_current+0x6b1/0x970 mm/mempolicy.c:2093
> >>>   alloc_pages include/linux/gfp.h:494 [inline]
> >>>   __page_cache_alloc+0x95/0x320 mm/filemap.c:946
> >>>   pagecache_get_page+0x52b/0x1450 mm/filemap.c:1577
> >>>   grab_cache_page_write_begin+0x10d/0x190 mm/filemap.c:3089
> >>>   block_write_begin+0xf9/0x3a0 fs/buffer.c:2068
> >>>   blkdev_write_begin+0xf5/0x110 fs/block_dev.c:584
> >>>   generic_perform_write+0x438/0x9d0 mm/filemap.c:3139
> >>>   __generic_file_write_iter+0x43b/0xa10 mm/filemap.c:3264
> >>>   blkdev_write_iter+0x3a8/0x5f0 fs/block_dev.c:1910
> >>>   do_iter_readv_writev+0x81c/0xa20 include/linux/fs.h:1778
> >>>   do_iter_write+0x30d/0xd50 fs/read_write.c:959
> >>>   vfs_writev fs/read_write.c:1004 [inline]
> >>>   do_writev+0x3be/0x820 fs/read_write.c:1039
> >>>   __do_sys_writev fs/read_write.c:1112 [inline]
> >>>   __se_sys_writev fs/read_write.c:1109 [inline]
> >>>   __x64_sys_writev+0xe1/0x120 fs/read_write.c:1109
> >>>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
> >>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>
> >>> Bytes 4-255 of 256 are uninitialized
> >>> Memory access starts at ffff8801b9903000
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> This particular report was caused by the repro program writing a byte
> >> to /dev/nullb0 and /sbin/blkid reading from that device in the
> >> background.
> >> But it turns out that simply running `cat /dev/nullb0` already prints
> >> uninitialized kernel memory.
> >> Is this the intended behavior of the null block driver?
> > A friendly ping, this bug is still reproducible on syzbot.
>
> Does this fix it?
There must be something wrong with my tool, as it stops reporting this
bug when I apply your patch.
However when I run `cat /dev/nullb0 | strings` and wait long enough I
start seeing meaningful strings (file names, env dumps etc.)
I suspect this is still unexpected, right?
>
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c
> index 62c9654b9ce8..08808c572692 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -655,7 +655,7 @@ static struct nullb_page *null_alloc_page(gfp_t gfp_f=
lags)
>         if (!t_page)
>                 goto out;
>
> -       t_page->page =3D alloc_pages(gfp_flags, 0);
> +       t_page->page =3D alloc_pages(gfp_flags | __GFP_ZERO, 0);
>         if (!t_page->page)
>                 goto out_freepage;
>
>
> --
> Jens Axboe
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
