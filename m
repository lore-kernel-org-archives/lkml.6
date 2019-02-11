Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B27C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6766B222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKtM2uod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfBKPHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:14 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35648 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391325AbfBKPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:11 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so2187627ybm.2;
        Mon, 11 Feb 2019 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYpcCCGKp1uj8S0Hv2iqt9xl+QlyUa2jlEtxzpdb5C8=;
        b=FKtM2uodEi328+A3/gUM4pjXqMcWVArPiKdz/8fXCoqdSpGSSByBwAnG32XPSU2atf
         R6+kSJgI4NxiFEyMq5CU2pgj+CjptYjNHc6dG/D5e0ObpcyoEurpRAhpwV0W/zWaKIhL
         0Dg3f4FZqjdxe+kyyFSv4gsack7ndeqgNYSLY69ie5vqgjgczRkx+G3k8k1PcLfeDeKF
         UhcejtQMveYulBTER+VZU78Rl1zjMZe/l6P6fkD6oolXHvYNFf7oIFMfSP/9NjF+wZ2C
         gR9rFwz9DETTDVtHhpdwmHFeKijs12wtHcCaMUwO6m5TFoVY07jQ8zvUx6MYWtKVqpaK
         LxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYpcCCGKp1uj8S0Hv2iqt9xl+QlyUa2jlEtxzpdb5C8=;
        b=YmNt7eEjJcdKvSRGsfi5Kz0P7vo1UOd4kHADYGsHX/LtOW7gUZT8cA4dFIKzsYAXHa
         Eb5VnG0F5A+Y8IcAJz3q/mBXOkktrfX6Oqzk8e0zMe/JbCrEd7nDed4W0bg6p3az0XSp
         q2oLwq8Z1hoXpPelHREoJAjlIyfa15Xq7yacatBo1ETLA3w625Aj1CTC8HBKfZFMnQS8
         lqTLHnjx7khq72rQVSyXDtp7OCY4V1VWg39Y1EsQ87T61XxBVDX3PtxNyFZmirN3/FF6
         plhxyx0jKwJ6BC9efYvnHNKWsZAtJx+7U1/mcXmAtpYaKC0naTr3KBoju2q+tZRklU3c
         sfFw==
X-Gm-Message-State: AHQUAub2CQFxad+TitngAqS/bGYDOvegZVe5faeUAuhBjGl3Q5/y7jfw
        ah5d2I3n0z7f4sjnWIxxfThCJ3EQZdxTOD2Cwr8=
X-Google-Smtp-Source: AHgI3IaYXWJGBM+7RB2ZGcqaFnbKZsL0ouHg+GMZKYrdtvZl88fQ6QOY44Qzyqpan8d5D0GR8lpDrCCFK6ibe7lljZ8=
X-Received: by 2002:a25:ba84:: with SMTP id s4mr29586698ybg.325.1549897629570;
 Mon, 11 Feb 2019 07:07:09 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
 <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com>
 <CAJfpegsJo8X+efgWSa4QwSGpAGADpoossZZg=m7x5ApPXhxCoA@mail.gmail.com>
 <CAOQ4uxj0nKK1csWGxxLT-EvC3hv8Zz5-HpvMF_a2r2iVcLXt1A@mail.gmail.com> <CAJfpegsadeK=3EON9HgZ8rLCDWCJXR9QrXxA3ZZjdjzq6FDRjw@mail.gmail.com>
In-Reply-To: <CAJfpegsadeK=3EON9HgZ8rLCDWCJXR9QrXxA3ZZjdjzq6FDRjw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 11 Feb 2019 17:06:57 +0200
Message-ID: <CAOQ4uxhnK2-1jsNQPkfzF84-ZcLgroakSd4JDR62mM-h1Z6r4Q@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Miklos Szeredi <miklos@szeredi.hu>
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

On Mon, Feb 11, 2019 at 4:33 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Feb 11, 2019 at 2:08 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 2:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 1:06 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 8:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Sun, Feb 10, 2019 at 8:23 PM syzbot
> > > > > <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com> wrote:
> > > >
> > > > > > -> #1 (&ovl_i_mutex_key[depth]){+.+.}:
> > > > > >         down_write+0x38/0x90 kernel/locking/rwsem.c:70
> > > > > >         inode_lock include/linux/fs.h:757 [inline]
> > > > > >         ovl_write_iter+0x148/0xc20 fs/overlayfs/file.c:231
> > > > > >         call_write_iter include/linux/fs.h:1863 [inline]
> > > > > >         new_sync_write fs/read_write.c:474 [inline]
> > > > > >         __vfs_write+0x613/0x8e0 fs/read_write.c:487
> > > > > > kobject: 'loop4' (000000009e2b886d): kobject_uevent_env
> > > > > >         __kernel_write+0x110/0x3b0 fs/read_write.c:506
> > > > > >         write_pipe_buf+0x15d/0x1f0 fs/splice.c:797
> > > > > >         splice_from_pipe_feed fs/splice.c:503 [inline]
> > > > > >         __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
> > > > > >         splice_from_pipe+0x108/0x170 fs/splice.c:662
> > > > > >         default_file_splice_write+0x3c/0x90 fs/splice.c:809
> > > >
> > > > Irrelevant to the lockdep splat, but why isn't there an
> > > > ovl_splice_write() that just recurses into realfile->splice_write()?
> > > > Sounds like a much more efficient way to handle splice read and
> > > > write...
> > > >
> > > > [...]
> > > >
> > > > > Miklos,
> > > > >
> > > > > Its good that this report popped up again, because I went to
> > > > > look back at my notes from previous report [1].
> > > > > If I was right in my previous analysis then we must have a real
> > > > > deadlock in current "lazy copy up" WIP patches. Right?
> > > >
> > > > Hmm, AFAICS this circular dependency translated into layman's terms:
> > > >
> > > > pipe lock -> ovl inode lock  (splice to ovl file)
> > > >
> > > > ovl inode lock -> upper freeze lock (truncate of ovl file)
> > > >
> > > > upper freeze lock -> pipe lock (splice to upper file)
> > >
> > > So what can we do with this?
> > >
> > > The "freeze lock -> inode lock" dependency is fixed.   This is
> > > reversed in overlay to "ovl inode lock -> upper freeze lock", which is
> > > okay, because this is a nesting that cannot be reversed.   But in
> > > splice the pipe locks comes in between: "freeze lock -> pipe lock ->
> > > inode lock" which breaks this nesting direction and creates a true
> > > reverse dependency between ovl inode lock and upper freeze lock.
> > >
> > > The only way I see this could be fixed is to move the freeze lock
> > > inside the pipe lock.  But that would mean splice/sendfile/etc could
> > > be frozen with the pipe lock held.  It doesn't look nice.
> > >
> > > Any other ideas?
> > >
> >
> > [CC Jan]
> >
> > I think we are allowed to file_start_write_trylock(upper)
> > before ovl_inode_lock(). This in ONLY needed to cover the corner
> > case of upper being frozen in between "upper freeze lock -> pipe lock"
> > and thread B being in between "ovl inode lock -> upper freeze lock".
> > Is it OK to return a transient error in this corner copy up case?
>
> This case shouldn't happen assuming adherence to the "upper shall not
> be modified while part of the overlay" rule.
>

Right. And unfreezing upper should untangle this deadlock,
because both thread A and B are taking a shared sb_writers lock.

> Side note: I don't see that it has anything to do with copy-up, but I
> may be missing something.
>

You are right. I was confusing your "ovl inode lock" with ovl_inode_lock(),
but the latter is taken after upper freeze lock, so irrelevant.

> My other thought is that perhaps sb_start_write() should invoke
> s_ops->start_write() so that overlay can do the freeze protection on
> the upper early.
>

Sorry, I don't see how that solves anything expect for the lockdep
warning. In both cases threads A and B would block until upper
in unfrozen, only without a lockdep warning.
Also, I am quite sure that taking upper freeze lock early will generate
many new lockdep warnings.

And yes, I could be missing something...

Anyway, what about the recursive do_splice_direct() issue
with lazy copy up, do you have an easy solution for that?

Thanks,
Amir.
