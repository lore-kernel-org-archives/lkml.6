Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD42089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgBzJGE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFD42089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJPFAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:00:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46634 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeJPFAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:00:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so16261912oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e+RW5SfIZMq0vi7h/h8ea2O0pKuQn4fdOejmufpreo=;
        b=dgBzJGE20jFPcIdoAxfKSr1FyPJoTXaot4yP1u+niSw5ihZ5LkWy/h/FWM85Iwc/kF
         cSt2rD9CooNgitDUo+tM4tyDMsJh7fEWLYSHHEtkbER4TCbuBgE+JvcxGhqq15Qc34vo
         KJzK7xnt3A4rUagh6gu5RDHanTvu/nagwk5hDZ/Kh6a14g11nqInpzi/ZWNr87Rq9byC
         LVySQ7hm8Z1LqoiK+iZSz3MHF6Ph8K3hh107PuG8mB+nCkvKLUwHQ3wJQqVVPBqSkcZ7
         05AOOcZ7KpJI4qLC2Ht26qt/Gqmupl+tsOL/T66qYd4c8ItUBSjZ9tHFYa6OLO5wVLHB
         OxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e+RW5SfIZMq0vi7h/h8ea2O0pKuQn4fdOejmufpreo=;
        b=ZKJ1gOKg2G63TLV1/LwtEiTJ+Fq+bt5pRlIgKrAm4ZUX6mNMikTGqW1tdjO6xEqAS/
         Hd+QHBxLFppPtefJTi2r86enFgG64vVdPugEj8zIv/VT/+MOUj17MhfwwKeKlDnKcZpe
         nbUGPAMvM8W8T8Lut0APF4SqIx0r4i4f9rIiYc55+AZ/w5i1PMjI2x45dBrEWItx6GsI
         Bs1aEWm1pHlrayzg2kFu2wcJIHDXprZqLads9khEGv/lVhbEu7T2emQGMFU8rXn6D3pH
         v2bAASJVDf+ox12qN0yxa9EHQmVcN1VsWld2Sd4EpeRi3/qlAWGlc27mePi3o7fbTAi1
         xhgA==
X-Gm-Message-State: ABuFfojpFTpcyje+fanuxi/Ra+0VnVWJvdYpZ7uh58d6LjveG7kcZXbZ
        xpI2kL/FTRtfUH7+6RmCoeTuD1TmvxvGI8+DPH3WeCqH4rn3IQ==
X-Google-Smtp-Source: ACcGV62kse96o1lwCXhvyos8NuaLyTDFu4Fa6IYLpkjM5kxjGV0I01ys+cadxUWdkrxUH23dr9RGN0CxLxPN+HwXeto=
X-Received: by 2002:aca:674c:: with SMTP id b12-v6mr10549308oiy.157.1539638021067;
 Mon, 15 Oct 2018 14:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181015150420.2096-1-jannh@google.com> <20181015210051.GA20855@gmail.com>
In-Reply-To: <20181015210051.GA20855@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 23:13:14 +0200
Message-ID: <CAG48ez29y=m9iHq5RhMNmJY5UfN1a9WJZrpSdXSJM0D3X-eCqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] splice: don't merge into linked buffers
To:     ebiggers@kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:00 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Oct 15, 2018 at 05:04:18PM +0200, Jann Horn wrote:
> > Before this patch, it was possible for two pipes to affect each other after
> > data had been transferred between them with tee():
> >
> > ============
> > $ cat tee_test.c
> >
> > int main(void) {
> >   int pipe_a[2];
> >   if (pipe(pipe_a)) err(1, "pipe");
> >   int pipe_b[2];
> >   if (pipe(pipe_b)) err(1, "pipe");
> >   if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
> >   if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
> >   if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");
> >
> >   char buf[5];
> >   if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
> >   buf[4] = 0;
> >   printf("got back: '%s'\n", buf);
> > }
> > $ gcc -o tee_test tee_test.c
> > $ ./tee_test
> > got back: 'abxx'
> > $
> > ============
> >
> > Fix it by explicitly marking buffers as mergeable and clearing that flag in
> > splice_pipe_to_pipe() and link_pipe().
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 7c77f0b3f920 ("splice: implement pipe to pipe splicing")
> > Fixes: 70524490ee2e ("[PATCH] splice: add support for sys_tee()")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Cleanup in the next patch, to simplify backporting.
> >
> >  fs/pipe.c                 | 5 +++--
> >  fs/splice.c               | 6 ++++++
> >  include/linux/pipe_fs_i.h | 8 ++++++++
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index bdc5d3c0977d..4e2eee77f855 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -379,7 +379,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >               struct pipe_buffer *buf = pipe->bufs + lastbuf;
> >               int offset = buf->offset + buf->len;
> >
> > -             if (buf->ops->can_merge && offset + chars <= PAGE_SIZE) {
> > +             if (buf->ops->can_merge && offset + chars <= PAGE_SIZE &&
> > +                 (buf->flags & PIPE_BUF_FLAG_MAYMERGE)) {
> >                       ret = pipe_buf_confirm(pipe, buf);
> >                       if (ret)
> >                               goto out;
> > @@ -439,7 +440,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >                       buf->ops = &anon_pipe_buf_ops;
> >                       buf->offset = 0;
> >                       buf->len = copied;
> > -                     buf->flags = 0;
> > +                     buf->flags = PIPE_BUF_FLAG_MAYMERGE;
> >                       if (is_packetized(filp)) {
> >                               buf->ops = &packet_pipe_buf_ops;
> >                               buf->flags = PIPE_BUF_FLAG_PACKET;
> > diff --git a/fs/splice.c b/fs/splice.c
> > index b3daa971f597..111977c80dfd 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -1593,6 +1593,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
> >                        */
> >                       obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
> >
> > +                     /* We can't merge data into a buffer we don't own. */
> > +                     obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
> > +
> >                       obuf->len = len;
> >                       opipe->nrbufs++;
> >                       ibuf->offset += obuf->len;
> > @@ -1667,6 +1670,9 @@ static int link_pipe(struct pipe_inode_info *ipipe,
> >                */
> >               obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
> >
> > +             /* We can't merge data into a buffer we don't own. */
> > +             obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
> > +
> >               if (obuf->len > len)
> >                       obuf->len = len;
> >
> > diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> > index 5a3bb3b7c9ad..8893711f9171 100644
> > --- a/include/linux/pipe_fs_i.h
> > +++ b/include/linux/pipe_fs_i.h
> > @@ -8,6 +8,14 @@
> >  #define PIPE_BUF_FLAG_ATOMIC 0x02    /* was atomically mapped */
> >  #define PIPE_BUF_FLAG_GIFT   0x04    /* page is a gift */
> >  #define PIPE_BUF_FLAG_PACKET 0x08    /* read() as a packet */
> > +/*
> > + * Set this flag if the generic pipe read/write may coalesce data into an
> > + * existing buffer. If this is not set, a new pipe page segment is always used
> > + * for new data.
> > + * When pipe data is copied by reference (as in the tee() syscall), this flag
> > + * must be cleared on the copy.
> > + */
> > +#define PIPE_BUF_FLAG_MAYMERGE       0x10
> >
> >  /**
> >   *   struct pipe_buffer - a linux kernel pipe buffer
> > --
> > 2.19.0.605.g01d371f741-goog
> >
>
> Deja vu... https://marc.info/?l=linux-fsdevel&m=149003133809192

Oh, hah, even the reproducer looks almost the same. I hadn't seen that...

> Thanks for fixing this; I think this is the right fix.
> I verified it works for my reproducer too.
>
> Did you check whether fuse_dev_splice_write() needs to clear
> PIPE_BUF_FLAG_MAYMERGE?

No, I hadn't looked at that. But from what I can tell,
fuse_dev_splice_write() shouldn't write into the provided buffers,
only read from them.
