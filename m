Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997BE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpw16FtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997BE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeIMOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:32:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40192 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeIMOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:32:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so4052419edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FDrJxJ5V45cJk2jIRSmMUn/nju6fLSnYkZcnSiG4fBc=;
        b=tpw16FtV5IboCC+QKY5b3ip3QtCzNclXMfxrLw9bhXHDdu4x6Vbf/ytoeTiTKuCKAu
         buq2XKD/PJy1UMPIcJx4YjU1o8XyZDI0CK7Etg1EuIVVHoDqVGdZwfaJzeo2dCei8tEI
         On5JbsdzshJ5t5bxSGn9/HocW0fFD5pHJd/Xv2zOc1JFtyoI0aBzKY9bgWkmwcFHDDTY
         iZdIejuLq9rq+OimoRGct4RKpu4RjyX/X7Y44uVegCqoDJa48UBJExShWS0BmNn5Y0dI
         Ffg8fOhojRoqwVZqPv2JfVI3kpV3FUwT/DjKj23PmEyFNnuxuGpaNfmdd83TPPhWrTEG
         /aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FDrJxJ5V45cJk2jIRSmMUn/nju6fLSnYkZcnSiG4fBc=;
        b=Rfxx83bdsCtusy5FaI6y4Ogayy8dhg1yxycB8reCSWomRGk700o3fuUanQ9h6l29bT
         7bXqIkRhRcInVW6T40KZRUJb+jSmt/fiDuzInVw6TRJGegvO3O+ZCsmXBJgpp2FF9grK
         NU/JJVQhDjGoJqk0+CuXYfzX8bi1FCW8UIEKNFu6hcQqqie5cKIVgCtGJKHHhsscrjgo
         CoA4v5/gzkPftGMNNCi+kT2LEGIg+lNy1e3V6hBiTyh9S8deTmpCX2mHnGI2lg4Kxoa0
         Sd/ppa36UG6cA9odgEYOgpvU8S1FA5lRdSDedYLNDrMS75fyNGKJN2Rt2Zep7ufixhNQ
         +46A==
X-Gm-Message-State: APzg51DXR2uQPeYMh7UcLJcDYMz2hDbrUbQc6ikWuh3hHZxz6Qsu/LcA
        aD+PoH71RJVb6Zn3uQW6QeIkjgDNmn+H7Y3olMOcAA==
X-Google-Smtp-Source: ANB0VdZuF8balbyyftbUlsSr6MhS9L+CPTrhHdqXrCNkif+B2EzpnRT00CFIPZnZHofe+YWsKKJSzTo0WVTyhzpkijA=
X-Received: by 2002:a50:87fb:: with SMTP id 56-v6mr9440897edz.68.1536830628603;
 Thu, 13 Sep 2018 02:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016eb330575bd2fab@google.com>
In-Reply-To: <00000000000016eb330575bd2fab@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Sep 2018 11:23:37 +0200
Message-ID: <CAG_fn=WwdgnCQ2fOw_LEXwv7Fdbmshxo57XJXNbfbawDndJZ_Q@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in copy_page_to_iter (2)
To:     syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz,
        jlayton@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, bart.vanassche@wdc.com,
        axboe@kernel.dk, matias.bjorling@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:18 AM syzbot
<syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kms=
a..
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1249fcb840000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D848e40757852a=
f3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2dcfeaf8cb49b05=
e8f1a
> compiler:       clang version 7.0.0 (trunk 334104)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D116ef050400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D122870ff80000=
0
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KMSAN: kernel-infoleak in copyout lib/iov_iter.c:140 [inline]
> BUG: KMSAN: kernel-infoleak in copy_page_to_iter_iovec lib/iov_iter.c:212
> [inline]
> BUG: KMSAN: kernel-infoleak in copy_page_to_iter+0x754/0x1b70
> lib/iov_iter.c:716
> CPU: 0 PID: 4516 Comm: blkid Not tainted 4.17.0+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>   kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
>   kmsan_internal_check_memory+0x17e/0x1f0 mm/kmsan/kmsan.c:1238
>   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
>   copyout lib/iov_iter.c:140 [inline]
>   copy_page_to_iter_iovec lib/iov_iter.c:212 [inline]
>   copy_page_to_iter+0x754/0x1b70 lib/iov_iter.c:716
>   generic_file_buffered_read mm/filemap.c:2185 [inline]
>   generic_file_read_iter+0x2ef8/0x44d0 mm/filemap.c:2362
>   blkdev_read_iter+0x20d/0x280 fs/block_dev.c:1930
>   call_read_iter include/linux/fs.h:1778 [inline]
>   new_sync_read fs/read_write.c:406 [inline]
>   __vfs_read+0x775/0x9d0 fs/read_write.c:418
>   vfs_read+0x36c/0x6b0 fs/read_write.c:452
>   ksys_read fs/read_write.c:578 [inline]
>   __do_sys_read fs/read_write.c:588 [inline]
>   __se_sys_read fs/read_write.c:586 [inline]
>   __x64_sys_read+0x1bf/0x3e0 fs/read_write.c:586
>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fdeff68f310
> RSP: 002b:00007ffe999660b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdeff68f310
> RDX: 0000000000000100 RSI: 0000000001e78df8 RDI: 0000000000000003
> RBP: 0000000001e78dd0 R08: 0000000000000028 R09: 0000000001680000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001e78030
> R13: 0000000000000100 R14: 0000000001e78080 R15: 0000000001e78de8
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
>   kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:819
>   kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:889
>   __alloc_pages_nodemask+0xf7b/0x5cc0 mm/page_alloc.c:4402
>   alloc_pages_current+0x6b1/0x970 mm/mempolicy.c:2093
>   alloc_pages include/linux/gfp.h:494 [inline]
>   __page_cache_alloc+0x95/0x320 mm/filemap.c:946
>   pagecache_get_page+0x52b/0x1450 mm/filemap.c:1577
>   grab_cache_page_write_begin+0x10d/0x190 mm/filemap.c:3089
>   block_write_begin+0xf9/0x3a0 fs/buffer.c:2068
>   blkdev_write_begin+0xf5/0x110 fs/block_dev.c:584
>   generic_perform_write+0x438/0x9d0 mm/filemap.c:3139
>   __generic_file_write_iter+0x43b/0xa10 mm/filemap.c:3264
>   blkdev_write_iter+0x3a8/0x5f0 fs/block_dev.c:1910
>   do_iter_readv_writev+0x81c/0xa20 include/linux/fs.h:1778
>   do_iter_write+0x30d/0xd50 fs/read_write.c:959
>   vfs_writev fs/read_write.c:1004 [inline]
>   do_writev+0x3be/0x820 fs/read_write.c:1039
>   __do_sys_writev fs/read_write.c:1112 [inline]
>   __se_sys_writev fs/read_write.c:1109 [inline]
>   __x64_sys_writev+0xe1/0x120 fs/read_write.c:1109
>   do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Bytes 4-255 of 256 are uninitialized
> Memory access starts at ffff8801b9903000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This particular report was caused by the repro program writing a byte
to /dev/nullb0 and /sbin/blkid reading from that device in the
background.
But it turns out that simply running `cat /dev/nullb0` already prints
uninitialized kernel memory.
Is this the intended behavior of the null block driver?
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
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000016eb330575bd2fab%40google.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
