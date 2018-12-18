Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D65C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C571520874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ex17ZL3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeLRM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:28:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50488 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:28:02 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so3846778iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgMsFjTx2DjS7LVuCFMOd4u5fx6hDXFJIdQHm7xowQk=;
        b=ex17ZL3pEJUfkLfOWT1sIEOUrNNF9soOakWue07LRP9Lkt2SGlwanD7k4q+RPKyMOC
         rD+AK0TM23nuA/PxhmluJ6v7XfkejuY0zbR/fZC0lzClPX16xu95wo4cCgKCaONbaeho
         KHSB7rwNkG6q1k5ZLDhAd9avIppEHgiS5aAa8pFXzcM2za+kNkrPxd0dZFo1dqRaih0f
         yDR0nNejqLR0J9HjedGm56t/1pJF+LJ3PrW1m/y9krzmF9+pyUtFyKREokQBoRJVRMUV
         bzpFf8eAVhBBmdhttygg4xpW9ld2oYffNVgmxr/mLm8USZjqiqCNoCEuEnoRpVXM3/p2
         bRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgMsFjTx2DjS7LVuCFMOd4u5fx6hDXFJIdQHm7xowQk=;
        b=mCCZihHTsceuAGdu8FSptZwGo0p4ECducCbyKqpI8ZAQmrmfSkJ4pVceUvqR7WdXkW
         y9IPvB3zcg9LQZoa8Gu7oYvXrwy/V41p8DKeBY3R06SUiqtu/3VMHz7v0gN1DpDHE378
         WA4vS1ku44YnJsnaE0emAZe3YSIeotNK1NGLBBvKZf/WD4nXSOn39yOKXxRDcAAsFHGT
         LKnPHiX2uTedWJZ8ZNaQ8vrZcFpNtWCwnGcajECO1TP9XGkqVv+onUF0jGDRhchS00L/
         cK6jysx+s48LDc8ddMIbAe448GAJJkVs4+xSiKvIZK0xcRoyAYQwQpCgf3thDBTY3boP
         IRGw==
X-Gm-Message-State: AA+aEWYHIuiprokDHSvo+MDMurEoNdW9OcbZbm47eDuSc83wD/rHLygC
        tyLFziUm5vu8s1aOi3uSxez7Yfjkp956nOESfp30tg==
X-Google-Smtp-Source: AFSGD/XET9/1CFYQGtzbg1v6RRHZr8i8+JsjN3U0EdLuWdgbSsFLPQUQ7Si5b3e1I1UuxhjzqZqGQDW106H5YNEz2QU=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr2469386iti.166.1545136080858;
 Tue, 18 Dec 2018 04:28:00 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <20181217072144.GQ2217@ZenIV.linux.org.uk>
 <95ae4c9893c89189d4309fe673ade6f389280101.camel@themaw.net> <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
In-Reply-To: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 13:27:49 +0100
Message-ID: <CACT4Y+a+UAFqOvd8BJ4KB0+48NhoKf0717hdY6XHEcvwG7DJkQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2018-12-18 at 18:42 +0800, Ian Kent wrote:
> > On Mon, 2018-12-17 at 07:21 +0000, Al Viro wrote:
> > > On Sun, Dec 16, 2018 at 10:11:04PM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13706347400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > > >
> > > >  slab_pre_alloc_hook mm/slab.h:423 [inline]
> > > >  slab_alloc mm/slab.c:3365 [inline]
> > > >  kmem_cache_alloc+0x2c4/0x730 mm/slab.c:3539
> > > >  __d_alloc+0xc8/0xb90 fs/dcache.c:1599
> > > > ------------[ cut here ]------------
> > > > kernel BUG at fs/inode.c:1566!
> > > >  d_alloc_anon fs/dcache.c:1698 [inline]
> > > >  d_make_root+0x43/0xc0 fs/dcache.c:1885
> > > >  autofs_fill_super+0x6f1/0x1c30 fs/autofs/inode.c:273
> > >
> > > Huh?  BUG is in iput(), AFAICS, so the stack trace is rather misreported.
> > > iput() can be called by d_make_root(), provided that dentry allocation
> > > fails.  So the most straightforward interpretation would be that we
> > > had an allocation failure (injected?), followed by iput() of the inode
> > > passed to d_make_root().  Which happened to find I_CLEAR in ->i_state
> > > of that inode somehow, which should be impossible short of seriously
> > > buggered inode refcounting somewhere - the inode has just been returned
> > > by new_inode(), which clears i_state, and it would have to have passed
> > > clear_inode() (i.e. has been through inode eviction) since then...
> >
> > Sorry Al, that's my bad.
> >
> > See
> > https://www.ozlabs.org/~akpm/mmotm/broken-out/autofs-fix-possible-inode-leak-in-autofs_fill_super.patch
> >
> > I think this will fix it, I'll forward it to Andrew if you agree:
>
> Actually, looking at it again the above patch is plain not needed,
> dropping it and updating the patch which follows it in the series
> is what needs to be done.
>
> Andrew, what should I do to make this easiest for you to handle,
> a respost with v2 in the subject of the patch affected by dropping
> the above patch?
>
> Or I could repost the series with above patch dropped and the affected
> patch corrected?

Hi Ian,

If you going to amend any commits, please add:
    Tested-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
otherwise:
    Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com

Thanks

> > autofs - fix handling of d_make_root() return in autofs_fill_super()
> >
> > From: Ian Kent <raven@themaw.net>
> >
> > A previous change to handle a possible inode leak in autofs_fill_super()
> > added an iput() on d_make_root() failure but d_make_root() already puts
> > the passed in inode on failure.
> >
> > Reported-by: syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/autofs/inode.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> > index 501833cc49a8..953f76b95172 100644
> > --- a/fs/autofs/inode.c
> > +++ b/fs/autofs/inode.c
> > @@ -271,7 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data,
> > int silent)
> >       }
> >       root = d_make_root(root_inode);
> >       if (!root)
> > -             goto fail_iput;
> > +             goto fail_ino;
> >       pipe = NULL;
> >
> >       root->d_fsdata = ino;
> > @@ -347,8 +347,6 @@ int autofs_fill_super(struct super_block *s, void *data,
> > int silent)
> >  fail_dput:
> >       dput(root);
> >       goto fail_free;
> > -fail_iput:
> > -     iput(root_inode);
> >  fail_ino:
> >       autofs_free_ino(ino);
> >  fail_free:
> >
>
