Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F581C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7B6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U47DQmTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfAaJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:54:36 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43484 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbfAaJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:54:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so805039uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMXXNDL4vlOxIktzPaUjuTX14mAzuh3P1R5ncLKExmo=;
        b=U47DQmTxcEufe3tLNOlH1Oz9wlbsDrX3ChWKGDnriwzHR+mINuwCI7seFvym/LG0dB
         k9L1/lHcgF/k79xwnY6xp4cmvwXms1HblXxq3TPokolGlUIQ3QNTqLHJY5fOA67FZosv
         oS6h7GaJoIjH1PvDu7OrWg5O1aeByKYpFGVLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMXXNDL4vlOxIktzPaUjuTX14mAzuh3P1R5ncLKExmo=;
        b=jjCPMdMp8rYAm0g3pjnM+93Mq6juYHEnK211KkQox7VSHcCQ7CaiLdfv4RmLIix5WR
         j0RINf+ZpsyRLC6KcmUc1KGmcSzXs//uL2vmYUM9eSwpRt14ecpv5cmWc1CHObToJApS
         KomH3npxlmUEfZgSrirRigHX/+0EsVro7U26xFxRf5UmyhjIQcsBjSbPrBvD48oB2b8c
         s4zCw8tyWFuOe3gfx+6oVUBe2S93UPcbiQk1ZNlxqNQA6gewk6HkT5tdePa3Vd1VLnAR
         +PAyxEkE/hcSzE4me2xI/fyMidG8oPUkhpTV8c23xQPfs4Y7Zgl8HHwDWr2jIWTwqZzv
         UiXQ==
X-Gm-Message-State: AJcUukdWRN9oiYsUp+YhXu2G5CdX/u6H8PU+1OyE3h4L0/YQnwqWBw4x
        C/CnqBMc9hfExpm1FJrNhRDuLgEtoys=
X-Google-Smtp-Source: ALg8bN7GaO3NDGT2NLawQFihcI2XZZwihzy2lo9aBmNpTm2pvisOoRPdwqri00UGMRYnivAT9eY1XQ==
X-Received: by 2002:ab0:21c6:: with SMTP id u6mr14104134uan.97.1548928472533;
        Thu, 31 Jan 2019 01:54:32 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 73sm766528vkx.6.2019.01.31.01.54.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:54:31 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id n13so1604092vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:54:30 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr13872780vsd.222.1548928470430;
 Thu, 31 Jan 2019 01:54:30 -0800 (PST)
MIME-Version: 1.0
References: <00000000000074cbc30580b16bc3@google.com>
In-Reply-To: <00000000000074cbc30580b16bc3@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 31 Jan 2019 22:54:18 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
Message-ID: <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
Subject: Re: general protection fault in relay_open_buf
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 7:53 AM syzbot
<syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cf10df400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> dashboard link: https://syzkaller.appspot.com/bug?extid=16c3a70e1e9b29346c43
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13266698c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715bb64c00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8092 Comm: syz-executor405 Not tainted 5.0.0-rc4-next-20190130
> #22
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]

static inline void relay_set_buf_dentry(struct rchan_buf *buf,
                                        struct dentry *dentry)
{
        buf->dentry = dentry;
        d_inode(buf->dentry)->i_size = buf->early_bytes; <--
}

Doing a bisect landed on this:

ff9fb72bc07705c00795ca48631f7fffe24d2c6b ("debugfs: return error
values, not NULL")

If I revert this patch, I can't reproduce any more. I don't see a
relationship, though...

My crash appears as:
[  121.934378] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000047
[  121.937187] #PF error: [normal kernel read fault]
[  121.938824] PGD 800000041f699067 P4D 800000041f699067 PUD 42d08f067 PMD 0
[  121.941166] Oops: 0000 [#1] SMP PTI
[  121.942381] CPU: 2 PID: 3134 Comm: relay Not tainted
5.0.0-rc4-next-20190130 #1020
[  121.943873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[  121.945395] RIP: 0010:relay_open_buf.part.10+0x2b8/0x330
...
[  121.960021] Call Trace:
[  121.960453]  relay_open+0x18e/0x2c0
[  121.961070]  __blk_trace_setup+0x1af/0x350
[  121.961777]  blk_trace_ioctl+0x93/0x100


$ ./scripts/faddr2line vmlinux relay_open_buf.part.10+0x2b8/0x330
relay_open_buf.part.10+0x2b8/0x330:
relay_set_buf_dentry at kernel/relay.c:412
(inlined by) relay_open_buf at kernel/relay.c:458

So it's the same location, but not sure about 0x47 offset. d_inode is
0x58 from dentry. And i_size is 0x50 from inode. If this isn't NULL,
but rather an ERR_PTR, the errno is either:

EBADF 9 Bad file descriptor
EEXIST 17 File exists

Neither are used in the debugfs patch, but debugfs is clearly used in
do_blk_trace_setup():

        if (!blk_debugfs_root)
                return -ENOENT;
...
        dir = debugfs_lookup(buts->name, blk_debugfs_root);
        if (!dir)
                bt->dir = dir = debugfs_create_dir(buts->name,
blk_debugfs_root);
        if (!dir)
                goto err;
...
        bt->rchan = relay_open("trace", dir, buts->buf_size,
                                buts->buf_nr, &blk_relay_callbacks, bt);

Which is confirmed by the next line in my traceback:

$ ./scripts/faddr2line vmlinux __blk_trace_setup+0x1af/0x350
__blk_trace_setup+0x1af/0x350:
do_blk_trace_setup at kernel/trace/blktrace.c:534
(inlined by) __blk_trace_setup at kernel/trace/blktrace.c:577

-Kees

> RIP: 0010:relay_open_buf.part.0+0x7cb/0xb40 kernel/relay.c:458
> Code: c1 ea 03 80 3c 02 00 0f 85 4c 03 00 00 49 8d 7d 58 4d 89 ac 24 90 00
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 1b 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff888088897670 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffff88809f2b3080 RCX: 1ffff110110c6919
> RDX: 0000000000000008 RSI: ffffffff81833b80 RDI: 0000000000000047
> RBP: ffff8880888976e8 R08: 0000000000000006 R09: ffff8880886348c8
> R10: ffff888088634000 R11: 0000000000000000 R12: ffff88809f5ef580
> R13: ffffffffffffffef R14: 0000000000000000 R15: 0000000000000000
> FS:  00000000021c4880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cf090 CR3: 00000000a4ccd000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   relay_open_buf kernel/relay.c:447 [inline]
>   relay_open kernel/relay.c:597 [inline]
>   relay_open+0x5f3/0xaf0 kernel/relay.c:561
>   do_blk_trace_setup+0x50d/0xdb0 kernel/trace/blktrace.c:532
>   __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:577
>   blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:716
>   blkdev_ioctl+0x141/0x2120 block/ioctl.c:591
>   block_ioctl+0xee/0x130 fs/block_dev.c:1914
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
>   ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x444af9
> Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 db ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd22903da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000444af9
> RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
> RBP: 000000000000d8fa R08: 00000000021c4880 R09: 00000000004002e0
> R10: 000000000000000f R11: 0000000000000246 R12: 0000000000401e60
> R13: 0000000000401ef0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace d79fd6b85e15805c ]---
> RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]
> RIP: 0010:relay_open_buf.part.0+0x7cb/0xb40 kernel/relay.c:458
> Code: c1 ea 03 80 3c 02 00 0f 85 4c 03 00 00 49 8d 7d 58 4d 89 ac 24 90 00
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 1b 03 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff888088897670 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: ffff88809f2b3080 RCX: 1ffff110110c6919
> RDX: 0000000000000008 RSI: ffffffff81833b80 RDI: 0000000000000047
> RBP: ffff8880888976e8 R08: 0000000000000006 R09: ffff8880886348c8
> R10: ffff888088634000 R11: 0000000000000000 R12: ffff88809f5ef580
> R13: ffffffffffffffef R14: 0000000000000000 R15: 0000000000000000
> FS:  00000000021c4880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006cf090 CR3: 00000000a4ccd000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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



-- 
Kees Cook
