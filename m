Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5912192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYYeAnj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440048AbfBNUmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:42:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45436 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503031AbfBNUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:42:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id y195so4414234qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tdPfvjucDJWmTxVIS5xUUyl1y3h6VQ7HyjoqYFGpRU=;
        b=mYYeAnj4iFKjHqIwjEZqFQ2zp4nez6K3XLzEPtux8rA1kZe8FkvanKP2ueAIhDK6PP
         duxaBMSNl7c6cbTnNRSKutNrMNWyjWvx1g6MbjtUtLHk40L3JHUIlG/X66+RbANV2ww4
         MPqIIQz3r8sahFuZ6RAGGkIHtJqt6vGNqiYKsX0k52KbkuqJC+VHjJHYvyxUQxxjS2yD
         QXCjaNXZoxqJWJDC62lbo1nSJDvpk8kq6LDidEACwxmv34/6TlCsXZbw++94V4itb0rR
         i0YNPssflLkNrvpAfWGSrzDizd5wockL1EcH1HVr/Zr95y+tyUyI67EkBTWZT1Z4a5cB
         uXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tdPfvjucDJWmTxVIS5xUUyl1y3h6VQ7HyjoqYFGpRU=;
        b=b+KDazn1upNSfddmsghjpVxTO5CGWGrbquMDsSM2B7jjqWw7wVObOJ96eGl+vedxIg
         o8CFTCWm1C00LCbrGrKBLNNnBvLurAiyCzHV0s/Qb7pmTwKxdnyuXLFexXt8tdnN1XRo
         VKuTsv7AROBaaSv2ojeBi4JvYUt5vLuSQUa9ok1CUoQ7RTL/7V8xtOi74ZJABxSvzPL5
         Ct4w2IRsKEHMjjB0LV72kaflXmy3P30XG5TU9lzVNCZGMrmupZE0SA9kqI8OSl6O3zDB
         vutPTECNFCVlbf1mo65HsgQv4w97iOpjOBG+vrCB+2w7S/brTFBTtXK8ILhWUS9duyeH
         yvhA==
X-Gm-Message-State: AHQUAuZiwP9zEYu8sBtvbaszGbFvR3Vm3zcAXuXxITMU00xfyFTCdIfl
        b2ychrLk1p3YGklZuoBQis95fobCAMGHlXWrtP66Ag==
X-Google-Smtp-Source: AHgI3IbaVczY3AhbvUlChEKT6hGdp+qnKUbLg1OIhTp9WocphwwY0QMn8VA7JTSwIX+Yz+gcrOq20Wyprt3SFzWnEZ4=
X-Received: by 2002:a37:cf56:: with SMTP id e83mr4529242qkj.101.1550176958663;
 Thu, 14 Feb 2019 12:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20190208183520.30886-1-tkjos@google.com> <20190208183520.30886-2-tkjos@google.com>
 <20190214194540.GA185075@google.com>
In-Reply-To: <20190214194540.GA185075@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Feb 2019 12:42:27 -0800
Message-ID: <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] binder: create userspace-to-binder-buffer copy function
To:     Joel Fernandes <joelaf@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:45 AM Joel Fernandes <joelaf@google.com> wrote:
>
> Hi Todd,
>
> One quick question:
>
> On Fri, Feb 08, 2019 at 10:35:14AM -0800, Todd Kjos wrote:
> > The binder driver uses a vm_area to map the per-process
> > binder buffer space. For 32-bit android devices, this is
> > now taking too much vmalloc space. This patch removes
> > the use of vm_area when copying the transaction data
> > from the sender to the buffer space. Instead of using
> > copy_from_user() for multi-page copies, it now uses
> > binder_alloc_copy_user_to_buffer() which uses kmap()
> > and kunmap() to map each page, and uses copy_from_user()
> > for copying to that page.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
> > v2: remove casts as suggested by Dan Carpenter
> >
> >  drivers/android/binder.c       |  29 +++++++--
> >  drivers/android/binder_alloc.c | 113 +++++++++++++++++++++++++++++++++
> >  drivers/android/binder_alloc.h |   8 +++
> >  3 files changed, 143 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 5f6ef5e63b91e..ab0b3eec363bc 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -3078,8 +3078,12 @@ static void binder_transaction(struct binder_proc *proc,
> >                                     ALIGN(tr->data_size, sizeof(void *)));
> >       offp = off_start;
> >
> > -     if (copy_from_user(t->buffer->data, (const void __user *)(uintptr_t)
> > -                        tr->data.ptr.buffer, tr->data_size)) {
> > +     if (binder_alloc_copy_user_to_buffer(
> > +                             &target_proc->alloc,
> > +                             t->buffer, 0,
> > +                             (const void __user *)
> > +                                     (uintptr_t)tr->data.ptr.buffer,
> > +                             tr->data_size)) {
> >               binder_user_error("%d:%d got transaction with invalid data ptr\n",
> >                               proc->pid, thread->pid);
> >               return_error = BR_FAILED_REPLY;
> > @@ -3087,8 +3091,13 @@ static void binder_transaction(struct binder_proc *proc,
> >               return_error_line = __LINE__;
> >               goto err_copy_data_failed;
> >       }
> > -     if (copy_from_user(offp, (const void __user *)(uintptr_t)
> > -                        tr->data.ptr.offsets, tr->offsets_size)) {
> > +     if (binder_alloc_copy_user_to_buffer(
> > +                             &target_proc->alloc,
> > +                             t->buffer,
> > +                             ALIGN(tr->data_size, sizeof(void *)),
> > +                             (const void __user *)
> > +                                     (uintptr_t)tr->data.ptr.offsets,
> > +                             tr->offsets_size)) {
> >               binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
> >                               proc->pid, thread->pid);
> >               return_error = BR_FAILED_REPLY;
> > @@ -3217,6 +3226,8 @@ static void binder_transaction(struct binder_proc *proc,
> >                       struct binder_buffer_object *bp =
> >                               to_binder_buffer_object(hdr);
> >                       size_t buf_left = sg_buf_end - sg_bufp;
> > +                     binder_size_t sg_buf_offset = (uintptr_t)sg_bufp -
> > +                             (uintptr_t)t->buffer->data;
> >
> >                       if (bp->length > buf_left) {
> >                               binder_user_error("%d:%d got transaction with too large buffer\n",
> > @@ -3226,9 +3237,13 @@ static void binder_transaction(struct binder_proc *proc,
> >                               return_error_line = __LINE__;
> >                               goto err_bad_offset;
> >                       }
> > -                     if (copy_from_user(sg_bufp,
> > -                                        (const void __user *)(uintptr_t)
> > -                                        bp->buffer, bp->length)) {
> > +                     if (binder_alloc_copy_user_to_buffer(
> > +                                             &target_proc->alloc,
> > +                                             t->buffer,
> > +                                             sg_buf_offset,
> > +                                             (const void __user *)
> > +                                                     (uintptr_t)bp->buffer,
> > +                                             bp->length)) {
> >                               binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
> >                                                 proc->pid, thread->pid);
> >                               return_error_param = -EFAULT;
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 022cd80e80cc3..94c0d85c4e75b 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -29,6 +29,8 @@
> >  #include <linux/list_lru.h>
> >  #include <linux/ratelimit.h>
> >  #include <asm/cacheflush.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/highmem.h>
> >  #include "binder_alloc.h"
> >  #include "binder_trace.h"
> >
> > @@ -1053,3 +1055,114 @@ int binder_alloc_shrinker_init(void)
> >       }
> >       return ret;
> >  }
> > +
> > +/**
> > + * check_buffer() - verify that buffer/offset is safe to access
> > + * @alloc: binder_alloc for this proc
> > + * @buffer: binder buffer to be accessed
> > + * @offset: offset into @buffer data
> > + * @bytes: bytes to access from offset
> > + *
> > + * Check that the @offset/@bytes are within the size of the given
> > + * @buffer and that the buffer is currently active and not freeable.
> > + * Offsets must also be multiples of sizeof(u32). The kernel is
>
> In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
> is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
> alignment instead of u32?

But there are other callers of check_buffer() later in the series that
don't require pointer-size alignment. u32 alignment is consistent with
the alignment requirements of the binder driver before this change.
The copy functions don't actually need to insist on alignment, but
these binder buffer objects have always used u32 alignment which has
been checked in the driver. If user code misaligned it, then errors
are returned. The alignment checks are really to be consistent with
previous binder driver behavior.

-Todd

>
> thanks,
>
>  - Joel
>
