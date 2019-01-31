Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A92C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CA3218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb3HMJC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfAaL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:28:41 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52104 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:28:40 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so3201836ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x28I4IWF6Q/l22JSKAjCTLHrN3NmiC3ThdCWbh3Y43A=;
        b=Bb3HMJC21yJ13M/sPD7eJyHnH2xm0fuLtoAS6pG08XCoJ16mQjSFNpWaC+igpvoEdU
         la5/uNN9xTZcMzV5jVsyxdbHjrOETEnXvrfFuMwG8FIkdaNwF6Rkoss+6QS77ONytkBI
         tLBrIFXYQUS6qTtAhooa4BiwtponjTwXTE40h24bjEFyZypf2ExhAzhTDbDPZ1XJU3jc
         rsWPkkOzezqpf0k3GlA9ofu32a/g1pv3LXRYWU/vnOkS5rCByXbvkaoQPgmXC8UQvBLS
         pUDHivFlJKZL7i3i3ypr03Q++5qldDKYGayfpyHF8yvqFG/R5Rh9zZYtYVsgvMa7gUoS
         cKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x28I4IWF6Q/l22JSKAjCTLHrN3NmiC3ThdCWbh3Y43A=;
        b=NZ5wg9fmK5cB6ErNzpFjTprDt/Y0IsoKkItZ5PDCnAKEdvhcLetqrPM311nV/3R2aG
         JMLrkZ4HYqrPvXvp69uoj2kIUzhDatOof2GbG5t92Co7o+sBvVSvz9wJh9bCU/zafhi/
         9lqqkZftJiQBlop9g/2LNgZKUgBH5l3SfoAXMjVt4K4PEH/hVc6GsQFOzLC+DJ5nmHZN
         KjpViuhablXdeBLoLn2lQLUNAyFZRS+FlxK/uGRfS+88wWjTO3ElnM6f6T/7U9uBqjez
         IfvxZg7jeyeHhnHzh8/SXbl1L3i414k1QighsEc5MDsthsurzjwKEkNK9iWnJF7DXLE8
         OSvg==
X-Gm-Message-State: AJcUukerVXbK7eM6lSocN7ctvykBlzeB+bC7kKicXwiYufWGVVtKHzKg
        8000B57N+OAPtO5zd8XgBVplgfaR3gYfJ3Hdw/reXQ==
X-Google-Smtp-Source: ALg8bN5MXa/AkbtUMD1Pt/f2zyXAcuJVNGoP8Tsp6FPk0QKQHjmEg0NTleMAIJFdhCOVBuoGollBHsgd7CqxKrT5RlI=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr19482426jan.72.1548934118831;
 Thu, 31 Jan 2019 03:28:38 -0800 (PST)
MIME-Version: 1.0
References: <00000000000074cbc30580b16bc3@google.com> <CAGXu5j+UzHKQk81RKsk39vx5WHi_CONzP4rU2fyuH-z_YB7CKw@mail.gmail.com>
 <20190131105152.GB13686@kroah.com> <CACT4Y+ZtG6Ef4vRApPuZsG0pquCV94Hg0KYBxpgpQueaG8STHA@mail.gmail.com>
 <20190131112241.GA8383@kroah.com>
In-Reply-To: <20190131112241.GA8383@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 31 Jan 2019 12:28:27 +0100
Message-ID: <CACT4Y+Z+WYVYZue7c3yjtCUDJJ_v5CG8XmkONJa7LR0MMqdW5Q@mail.gmail.com>
Subject: Re: general protection fault in relay_open_buf
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Jan 31, 2019 at 12:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 12:16:42PM +0100, Dmitry Vyukov wrote:
> > On Thu, Jan 31, 2019 at 11:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jan 31, 2019 at 10:54:18PM +1300, Kees Cook wrote:
> > > > On Thu, Jan 31, 2019 at 7:53 AM syzbot
> > > > <syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12cf10df400000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=16c3a70e1e9b29346c43
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13266698c00000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715bb64c00000
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+16c3a70e1e9b29346c43@syzkaller.appspotmail.com
> > > > >
> > > > > kasan: CONFIG_KASAN_INLINE enabled
> > > > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > > > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > > > > CPU: 0 PID: 8092 Comm: syz-executor405 Not tainted 5.0.0-rc4-next-20190130
> > > > > #22
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > Google 01/01/2011
> > > > > RIP: 0010:relay_set_buf_dentry kernel/relay.c:412 [inline]
> > > >
> > > > static inline void relay_set_buf_dentry(struct rchan_buf *buf,
> > > >                                         struct dentry *dentry)
> > > > {
> > > >         buf->dentry = dentry;
> > > >         d_inode(buf->dentry)->i_size = buf->early_bytes; <--
> > > > }
> > > >
> > > > Doing a bisect landed on this:
> > > >
> > > > ff9fb72bc07705c00795ca48631f7fffe24d2c6b ("debugfs: return error
> > > > values, not NULL")
> > > >
> > > > If I revert this patch, I can't reproduce any more. I don't see a
> > > > relationship, though...
> > > >
> > > > My crash appears as:
> > > > [  121.934378] BUG: unable to handle kernel NULL pointer dereference
> > > > at 0000000000000047
> > > > [  121.937187] #PF error: [normal kernel read fault]
> > > > [  121.938824] PGD 800000041f699067 P4D 800000041f699067 PUD 42d08f067 PMD 0
> > > > [  121.941166] Oops: 0000 [#1] SMP PTI
> > > > [  121.942381] CPU: 2 PID: 3134 Comm: relay Not tainted
> > > > 5.0.0-rc4-next-20190130 #1020
> > > > [  121.943873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > BIOS 1.10.2-1ubuntu1 04/01/2014
> > > > [  121.945395] RIP: 0010:relay_open_buf.part.10+0x2b8/0x330
> > > > ...
> > > > [  121.960021] Call Trace:
> > > > [  121.960453]  relay_open+0x18e/0x2c0
> > > > [  121.961070]  __blk_trace_setup+0x1af/0x350
> > > > [  121.961777]  blk_trace_ioctl+0x93/0x100
> > > >
> > > >
> > > > $ ./scripts/faddr2line vmlinux relay_open_buf.part.10+0x2b8/0x330
> > > > relay_open_buf.part.10+0x2b8/0x330:
> > > > relay_set_buf_dentry at kernel/relay.c:412
> > > > (inlined by) relay_open_buf at kernel/relay.c:458
> > > >
> > > > So it's the same location, but not sure about 0x47 offset. d_inode is
> > > > 0x58 from dentry. And i_size is 0x50 from inode. If this isn't NULL,
> > > > but rather an ERR_PTR, the errno is either:
> > > >
> > > > EBADF 9 Bad file descriptor
> > > > EEXIST 17 File exists
> > > >
> > > > Neither are used in the debugfs patch, but debugfs is clearly used in
> > > > do_blk_trace_setup():
> > > >
> > > >         if (!blk_debugfs_root)
> > > >                 return -ENOENT;
> > > > ...
> > > >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > > >         if (!dir)
> > > >                 bt->dir = dir = debugfs_create_dir(buts->name,
> > > > blk_debugfs_root);
> > > >         if (!dir)
> > > >                 goto err;
> > > > ...
> > > >         bt->rchan = relay_open("trace", dir, buts->buf_size,
> > > >                                 buts->buf_nr, &blk_relay_callbacks, bt);
> > > >
> > > > Which is confirmed by the next line in my traceback:
> > > >
> > > > $ ./scripts/faddr2line vmlinux __blk_trace_setup+0x1af/0x350
> > > > __blk_trace_setup+0x1af/0x350:
> > > > do_blk_trace_setup at kernel/trace/blktrace.c:534
> > > > (inlined by) __blk_trace_setup at kernel/trace/blktrace.c:577
> > >
> > > Can you test the patch below?
> >
> >
> > This can be done as self-service by saying:
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > master
> >
> > (is it the right tree/base commit for your change? a patch can
> > generally be applied only to the tree/base commit that you used to
> > obtain the diff)
>
> It was close, wrong tree, try this:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-linus
>
> And let's see if it works :)

Just in case, you can actually post patches inline, it should work.
It's just my client is incapable of preserving whitespaces, so I have
to re-attach them (they are also applied with --ignore-whitespace, but
just to be safe).
