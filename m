Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD71C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DB8222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ilv2Gp6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfBKPkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:40:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50369 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388980AbfBKPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:40:50 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so27398945iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDVxsTuKdnGShSt0ku7ayxKgZZdwZTYhLiVprOro4N0=;
        b=ilv2Gp6tEpNeHCJPjIU7WbJ7o/5wCpY6wipt2Njm/LpcJD8oiaXL0P/jkwu4S+6Ssp
         hvvgujcj2qYktuthuxjur5/gQIWpnKt+R6yj8WHfikxmLiCAs4Sju9xf+CFRfSxvjkWJ
         HneOfM0wq/86GOK2ELMu1IlMqlzpvjw4jgQRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDVxsTuKdnGShSt0ku7ayxKgZZdwZTYhLiVprOro4N0=;
        b=F7jmoPVPQIZtAamApKcjp2KE+9lVpu6bys+HXPHkL9XtwEl/AU2izD8UlR0jDs6fDM
         fbjAjRSSOrlDK2z17Ju5pgzGZlvWFQktcmNbTJgF3hE6vDm4k/xEn7tSrFsVWqM0X7wR
         x+1b52kDI/fg401tPD1CdCpiYf8d5h21gwAb9NW+M9eOOR57b/g0uB4qyECIBfXPxItU
         fqCGHeGzhGWbRCaweOwFsSxJRtrYwlcRn2J/TVMMRBKVAHO3mUPlmpyAnUZE/Yf5LvOv
         bKtQ9ct8D0ODIu/4krmSGO6+OQJxWUO2ucimGDL0ZQRxPeUX1+CO3+L3zuPyt1yg1NHM
         dV4g==
X-Gm-Message-State: AHQUAubS1kktsHe+LsKoAjc97SzKJ3EqB2tPbQfwq4KnIxo8a6umtNCd
        Gd3EpalDRaKgg9tHmCDJpntzaqAsIxjSGRMOG7vZJA==
X-Google-Smtp-Source: AHgI3IYpNRfj/dAOLyQgihdAQaGGIb1//oNoYzS21jHHl9tCVGnZvE64xB2vejDig5mfOkTtUGBHxXArurG1i5vgU5I=
X-Received: by 2002:a5e:de45:: with SMTP id e5mr13930462ioq.294.1549899649431;
 Mon, 11 Feb 2019 07:40:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
 <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com>
 <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
 <CAOQ4uxj0nKK1csWGxxLT-EvC3hv8Zz5-HpvMF_a2r2iVcLXt1A@mail.gmail.com>
 <CAJfpegsadeK=3EON9HgZ8rLCDWCJXR9QrXxA3ZZjdjzq6FDRjw@mail.gmail.com> <CAOQ4uxhnK2-1jsNQPkfzF84-ZcLgroakSd4JDR62mM-h1Z6r4Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnK2-1jsNQPkfzF84-ZcLgroakSd4JDR62mM-h1Z6r4Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Feb 2019 16:40:37 +0100
Message-ID: <CAJfpegstnt2tyhZuQ+DnR3rfn7B6xo9JhcBnb=GJV11i8013gA@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:07 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 4:33 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Feb 11, 2019 at 2:08 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 2:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 1:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Mon, Feb 11, 2019 at 8:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 10, 2019 at 8:23 PM syzbot
> > > > > > <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > > -> #1 (&ovl_i_mutex_key[depth]){+.+.}:
> > > > > > >         down_write+0x38/0x90 kernel/locking/rwsem.c:70
> > > > > > >         inode_lock include/linux/fs.h:757 [inline]
> > > > > > >         ovl_write_iter+0x148/0xc20 fs/overlayfs/file.c:231
> > > > > > >         call_write_iter include/linux/fs.h:1863 [inline]
> > > > > > >         new_sync_write fs/read_write.c:474 [inline]
> > > > > > >         __vfs_write+0x613/0x8e0 fs/read_write.c:487
> > > > > > > kobject: 'loop4' (000000009e2b886d): kobject_uevent_env
> > > > > > >         __kernel_write+0x110/0x3b0 fs/read_write.c:506
> > > > > > >         write_pipe_buf+0x15d/0x1f0 fs/splice.c:797
> > > > > > >         splice_from_pipe_feed fs/splice.c:503 [inline]
> > > > > > >         __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
> > > > > > >         splice_from_pipe+0x108/0x170 fs/splice.c:662
> > > > > > >         default_file_splice_write+0x3c/0x90 fs/splice.c:809
> > > > >
> > > > > Irrelevant to the lockdep splat, but why isn't there an
> > > > > ovl_splice_write() that just recurses into realfile->splice_write()?
> > > > > Sounds like a much more efficient way to handle splice read and
> > > > > write...
> > > > >
> > > > > [...]
> > > > >
> > > > > > Miklos,
> > > > > >
> > > > > > Its good that this report popped up again, because I went to
> > > > > > look back at my notes from previous report [1].
> > > > > > If I was right in my previous analysis then we must have a real
> > > > > > deadlock in current "lazy copy up" WIP patches. Right?
> > > > >
> > > > > Hmm, AFAICS this circular dependency translated into layman's terms:
> > > > >
> > > > > pipe lock -> ovl inode lock  (splice to ovl file)
> > > > >
> > > > > ovl inode lock -> upper freeze lock (truncate of ovl file)
> > > > >
> > > > > upper freeze lock -> pipe lock (splice to upper file)
> > > >
> > > > So what can we do with this?
> > > >
> > > > The "freeze lock -> inode lock" dependency is fixed.   This is
> > > > reversed in overlay to "ovl inode lock -> upper freeze lock", which is
> > > > okay, because this is a nesting that cannot be reversed.   But in
> > > > splice the pipe locks comes in between: "freeze lock -> pipe lock ->
> > > > inode lock" which breaks this nesting direction and creates a true
> > > > reverse dependency between ovl inode lock and upper freeze lock.
> > > >
> > > > The only way I see this could be fixed is to move the freeze lock
> > > > inside the pipe lock.  But that would mean splice/sendfile/etc could
> > > > be frozen with the pipe lock held.  It doesn't look nice.
> > > >
> > > > Any other ideas?
> > > >
> > >
> > > [CC Jan]
> > >
> > > I think we are allowed to file_start_write_trylock(upper)
> > > before ovl_inode_lock(). This in ONLY needed to cover the corner
> > > case of upper being frozen in between "upper freeze lock -> pipe lock"
> > > and thread B being in between "ovl inode lock -> upper freeze lock".
> > > Is it OK to return a transient error in this corner copy up case?
> >
> > This case shouldn't happen assuming adherence to the "upper shall not
> > be modified while part of the overlay" rule.
> >
>
> Right. And unfreezing upper should untangle this deadlock,
> because both thread A and B are taking a shared sb_writers lock.

I don't think that'll work.   The deadlock would involve freezing for
sure, otherwise sb_start_write() won't block.  But there's no way to
cancel sb_wait_write() once it's called, so the deadlock is permanent.

> > Side note: I don't see that it has anything to do with copy-up, but I
> > may be missing something.
> >
>
> You are right. I was confusing your "ovl inode lock" with ovl_inode_lock(),
> but the latter is taken after upper freeze lock, so irrelevant.
>
> > My other thought is that perhaps sb_start_write() should invoke
> > s_ops->start_write() so that overlay can do the freeze protection on
> > the upper early.
> >
>
> Sorry, I don't see how that solves anything expect for the lockdep
> warning. In both cases threads A and B would block until upper
> in unfrozen, only without a lockdep warning.
> Also, I am quite sure that taking upper freeze lock early will generate
> many new lockdep warnings.

My thinking was to make the lock order:

  ovl freeze lock -> upper freeze lock -> ovl inode lock -> upper inode lock


> Anyway, what about the recursive do_splice_direct() issue
> with lazy copy up, do you have an easy solution for that?

Not sure.  I think splice_direct_to_actor() should be able to deal
with it.  E.g.

    pipe = current->splice_pipe;
    if (unlikely(!pipe)) {
        pipe = alloc_pipe_info();
        ...
    } else {
        current->splice_pipe = NULL;
    }

    ... do the actual splicing ...

    if (!current->splice_pipe) {
        current->splice_pipe = pipe
    } else {
        free_pipe_info(pipe);
    }

Thanks,
Miklos
