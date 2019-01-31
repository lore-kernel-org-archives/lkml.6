Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7542084A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfAaK7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:59:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46622 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAaK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:59:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so2372914otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FMGT/n3ZyraQ3M5Nkpw2+9yIR9HQqR+EaGet6OCvck=;
        b=L/C9MuxPLFEcypUEF2nQyzSH+KvQmr+UxHRPOmE3VwF313weZLNubcJuPV90CHkzYG
         45G31MAZiRbmHxROgWOGjCL7E6ubHVDRXfOkDhBIUJeJInTXn5Dbyc3K8qnjZw771Gu8
         F1CXm0ccWWAJGxsGVAyzeuh2WiAg+M8uvsC19fPPlUUhejbmI+3J2T+3y2YKdlIED/mt
         4xjcfBa2QQifsb/f2E1fQot/C6Z/9lVZYUmQ1F3EEUQOAEQmBDGv+MOEcpxXK5vSRbfn
         LaOkQDsf9DbyRseZFqqkC/vxep79SfpgcNrmcqvbUpfD1mBmbQ/9WV+kVcawXfd3Mn4W
         ZH7g==
X-Gm-Message-State: AJcUukfpc1FZdb/OmUqQELkvz6Wj9LAiy8tDxkQxIxG8P6zvYdNWC1RD
        Iggt62lUBlcXVlA5f0jNHhTt6fdmc0zKhrTG9N8=
X-Google-Smtp-Source: ALg8bN6/TdQt6Iloyk1977Yqn1hf09O+xww9Mrgugyd8G+SvA9b8YFMVUNvp30KfOpRHWlny0NeFf8C4aV5gvHHqs2Q=
X-Received: by 2002:a9d:7503:: with SMTP id r3mr23768446otk.281.1548932351328;
 Thu, 31 Jan 2019 02:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20190118193200.32691-1-malat@debian.org> <CAH7mPvi2TN0b=j-6fqDpjGPkZVSEQnDiT2nj9NWmoBOhUiwKEg@mail.gmail.com>
 <CA+7wUsz6Rm58VOOTRA1+URKvONzsGcUT+A8F_sctyqMEOfs=yw@mail.gmail.com> <CAGXu5j+CQLk6u8iMmOfbvk5=B5PdDvc8qkkHBAjpXquhYgWTwg@mail.gmail.com>
In-Reply-To: <CAGXu5j+CQLk6u8iMmOfbvk5=B5PdDvc8qkkHBAjpXquhYgWTwg@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Thu, 31 Jan 2019 11:58:58 +0100
Message-ID: <CA+7wUsx1KxgetsjZVHD5mh3a0GvaSRqzkx8Z0U39JyAHRMAX=g@mail.gmail.com>
Subject: Re: [PATCH] writeback: tracing: Copy only up to 31 characters in
 strncpy() calls
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Fri, Jan 25, 2019 at 6:06 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 25, 2019 at 9:18 PM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > On Fri, Jan 25, 2019 at 5:26 AM Nick Desaulniers
> > <nick.desaulniers@gmail.com> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 11:32 AM Mathieu Malaterre <malat@debian.org> wrote:
> > > >
> > > > In the past an attempt was made to remove a set of warnings triggered by
> > > > gcc 8.x and W=1 by changing calls to strncpy() into strlcpy(). This was
> > > > rejected as one of the desired behavior is to keep initializing the rest
> > > > of the destination string whenever the source string is less than the
> > > > size.
> > > >
> > > > However the code makes it clear that this is not a desired behavior to
> > > > copy the entire 32 characters into the destination buffer, since it is
> > > > expected that the string is NUL terminated. So change the maximum number
> > > > of characters to be copied to be the size of the destination buffer
> > > > minus 1.
> > > >
> > > > Break long lines and make this patch go through `checkpatch --strict` with
> > > > no errors.
> > > >
> > > > This commit removes the following warnings:
> > > >
> > > >   include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >   include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > > >
> > > > Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > > Link: https://lore.kernel.org/patchwork/patch/910830/
> > > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > > > ---
> > > >  include/trace/events/writeback.h | 30 ++++++++++++++++++++----------
> > > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > > > index 32db72c7c055..7bc58980f84f 100644
> > > > --- a/include/trace/events/writeback.h
> > > > +++ b/include/trace/events/writeback.h
> > > > @@ -67,7 +67,8 @@ TRACE_EVENT(writeback_dirty_page,
> > > >
> > > >         TP_fast_assign(
> > > >                 strncpy(__entry->name,
> > > > -                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> > > > +                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) :
> > > > +                       "(unknown)", sizeof(__entry->name) - 1);
> > >
> > > Does strncpy guarantee that destination will be NULL terminated if
> > > (sizeof(src) > sizeof(dst)) || (32 > sizeof(dst))?
> >
> > No, that's the point here:
> >
> > https://www.kernel.org/doc/htmldocs/kernel-api/API-strncpy.html
> >
> > ...
> > The result is not NUL-terminated if the source exceeds count bytes.
> >
> > In the case where the length of src is less than that of count, the
> > remainder of dest will be padded with NUL.
> > ...
> >
> > One should use strlcpy for the use case you describe:
> >
> > https://www.kernel.org/doc/htmldocs/kernel-api/API-strlcpy.html
>
> Please use strspy() -- strlcpy() will read the source beyond the length limit.
> https://www.kernel.org/doc/htmldocs/kernel-api/API-strscpy.html

Quoting your previous attempt:

> Eric points out this wont initialize the rest of the dest if src if
> less than size.

Could you include 'Eric' in the thread ? I'd like to know his opinion
on a patch with strspy + memset or if strspy is enough here.

> --
> Kees Cook
