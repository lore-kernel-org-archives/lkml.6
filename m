Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED32C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405420870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpBgI4rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfAUPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:50:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44921 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfAUPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:50:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so20870007otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1UbmoNU2Elrtyi+ikkL7Tod5Yv+X3eL2cyfpgQGaQ8=;
        b=ZpBgI4rIvFYQFFiygIquZ4ddgJy+2NXAAhvTyq3Ey5teg741IR0sDrKcE27cYKvn1b
         PWqSZA1RoSj+BxAEZ8zjlYWdfRIU5RnRywak/eehXLJm6m7ulzxp7yFaXD8r9KUTowYo
         wyLFbWw2QXYrFS/yhfi6Fvs9nptz3ZIQeX1GkaIOm0/8O57tOHwL+Mxbf+Jes7SNj0nK
         0GqFZ8ekJSzhn/ephf63YoBfRn82xwjLCeMEiJY6ZKUoa0UKFuRzrjAKvc/WOhWQ2tEU
         I52MYKJrGqmMUc8biEO13oDevHne8se9JewVoachHBDwvCezEJSzBvq7KS+UASQmwNee
         uA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1UbmoNU2Elrtyi+ikkL7Tod5Yv+X3eL2cyfpgQGaQ8=;
        b=coTW19Qnxc2tlG5gdfEBNcJ6iz4H8b7cP7I02r0kTayHGcopvnXYjlciUO1yeo5Nz6
         IPDYWbjVnvA/ldYJ8/1tenTFLcmnMUAmkSY+kRPH7MenYyTeCZbx138xoR+LNMUtDE+N
         3yF8RUils06jRxS0ctl+2xsCoFOnrpbObpTLvNffYhini0CyQeLsv8Zvt6vW7o8khpp8
         i9afNY2ghib1TK2ki9JaKenZ/8KXo5hHFuGOo9TfyvNDjorcdaSgEFOCXrzlxfxH3Sr3
         0Jszf1hgZiIl1cOVY96dB/HuqAVPc6QigkisC8VkjCrFpyNCH/3H6KG0yAZL1Ygp7Iq+
         0moQ==
X-Gm-Message-State: AJcUukeZTedIn5pfex0+g/DIwqTy3TU0f6wDk47scNyiIDB4d2p9Hfmp
        NVGPnCToDgIXdjqBU0i3cj/2eLJTQJOY+FbM2b42ag==
X-Google-Smtp-Source: ALg8bN5iYE9kcinOlkEBOxuVXK+mnFT5aeKQv3PB14xrPAvIw7mtJENT4Cyr40+UXty9tElIG6HbgqBnQzeZAvk7FCs=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr19960250otf.242.1548085811510;
 Mon, 21 Jan 2019 07:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20190118161440.220134-1-jannh@google.com> <20190118161440.220134-3-jannh@google.com>
 <20190120224059.GA4205@dastard>
In-Reply-To: <20190120224059.GA4205@dastard>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Jan 2019 16:49:45 +0100
Message-ID: <CAG48ez3SgejgGbctHwxON1B1k26xk-z16xdozKZkx7=-Li0aHw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fs: let filldir_t return bool instead of an error code
To:     Dave Chinner <david@fromorbit.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 11:41 PM Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Jan 18, 2019 at 05:14:40PM +0100, Jann Horn wrote:
> > As Al Viro pointed out, many filldir_t functions return error codes, but
> > all callers of filldir_t functions just check whether the return value is
> > non-zero (to determine whether to continue reading the directory); more
> > precise errors have to be signalled via struct dir_context.
> > Change all filldir_t functions to return bool instead of int.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/alpha/kernel/osf_sys.c | 12 +++----
> >  fs/afs/dir.c                | 30 +++++++++--------
> >  fs/ecryptfs/file.c          | 13 ++++----
> >  fs/exportfs/expfs.c         |  8 ++---
> >  fs/fat/dir.c                |  8 ++---
> >  fs/gfs2/export.c            |  6 ++--
> >  fs/nfsd/nfs4recover.c       |  8 ++---
> >  fs/nfsd/vfs.c               |  6 ++--
> >  fs/ocfs2/dir.c              | 10 +++---
> >  fs/ocfs2/journal.c          | 14 ++++----
> >  fs/overlayfs/readdir.c      | 24 +++++++-------
> >  fs/readdir.c                | 64 ++++++++++++++++++-------------------
> >  fs/reiserfs/xattr.c         | 20 ++++++------
> >  fs/xfs/scrub/dir.c          |  8 ++---
> >  fs/xfs/scrub/parent.c       |  4 +--
> >  include/linux/fs.h          | 10 +++---
> >  16 files changed, 125 insertions(+), 120 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> > index db1c2144d477..14e5ae0dac50 100644
> > --- a/arch/alpha/kernel/osf_sys.c
> > +++ b/arch/alpha/kernel/osf_sys.c
> > @@ -108,7 +108,7 @@ struct osf_dirent_callback {
> >       int error;
> >  };
> >
> > -static int
> > +static bool
> >  osf_filldir(struct dir_context *ctx, const char *name, int namlen,
> >           loff_t offset, u64 ino, unsigned int d_type)
> >  {
> > @@ -120,14 +120,14 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
> >
> >       buf->error = check_dirent_name(name, namlen);
> >       if (unlikely(buf->error))
> > -             return -EFSCORRUPTED;
> > +             return false;
> >       buf->error = -EINVAL;   /* only used if we fail */
> >       if (reclen > buf->count)
> > -             return -EINVAL;
> > +             return false;
>
> Oh, it's because the error being returned is being squashed by
> dir_emit():

Yeah.

> >  struct dir_context {
> > @@ -3469,17 +3471,17 @@ static inline bool dir_emit(struct dir_context *ctx,
> >                           const char *name, int namelen,
> >                           u64 ino, unsigned type)
> >  {
> > -     return ctx->actor(ctx, name, namelen, ctx->pos, ino, type) == 0;
> > +     return ctx->actor(ctx, name, namelen, ctx->pos, ino, type);
> >  }
>
> /me wonders if it would be cleaner to do:
>
> static inline bool dir_emit(...)
> {
>         buf->error = ctx->actor(....)
>         if (buf->error)
>                 return false;
>         return true;
> }
>
> And clean up all filldir actors just to return the error state
> rather than have to jump through hoops to stash the error state in
> the context buffer and return the error state?

One negative thing about that, IMO, is that it mixes up the request
for termination of the loop and the presence of an error. The current
code returns fake errors that never reach userspace in various places
to terminate the loop, e.g. fillonedir() has a "return -EINVAL" to
terminate the loop if at least one element has been read already, and
filldir() has a "return -EINTR" on signal_pending() that explicitly
only happens if at least one element has been read already.

But really, I don't have strong feelings about this, I just want to
get the "fs: don't let getdents return bogus names" patch in. :P

> That then allows callers who want/need the full error info can
> continue to call ctx->actor directly,

"continue to call ctx->actor directly"? I don't remember any code that
calls ctx->actor directly.

> while all those that just want
> to terminate their loops on error can continue just to call
> dir_emit()...
