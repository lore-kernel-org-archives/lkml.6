Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0328AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3EE2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eqt65Lkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfA3AcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:32:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36574 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfA3AcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:32:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so16075022lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 16:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJdxBl0FXEBbBQkxJGgEZNdwVSWPPhCpq4GcSMBRZrs=;
        b=Eqt65LkbQ/EShVVCRdk80YW6QFI2o+gu55YswsK80D+rWsBpGPGqHsmEWi4y+LbjpM
         pADmpMLKe9UX7V8kmL7B+1+FOt8rlyBFtGQBEuiJeq8ABV26u0r06fTcoSoElr4p0c9w
         tlYSI4ZCh04oAokkAY/fSac75IFjHOek92gU3cRYw5jo7YHP5rpga2UnXfo3BFP3hO0l
         FQZR42eJUgaS5cj89vaUpovSPAym8meY0T1W5HI5gCkdnFur1JWgiAeV2lHrNRLbFTeR
         aHL0n0tbaorTuCmhAivPZJMUw+n+jLAv7Uaz4mUlVkg4C6Mo3d2NB7xLJqaleoPb0hGJ
         +kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJdxBl0FXEBbBQkxJGgEZNdwVSWPPhCpq4GcSMBRZrs=;
        b=P+ol3F/8NuozR+So6dnQVXNJpDt5RkPQOwAyl2vNFKALgh2geG6oPX9mYnO/QjhfKB
         61BxMwkzJfEAKxVoLuTR3kZO+OWDp5V7rYiJWK73XhgJAlRaQAPEZfR5tdUYrUYthxpf
         kPY70rVfJtPoPPCw+c45zfeaPS2y3GLUM4N9ewVEiGUj8BztXVbZWBSEyIIaO0gN/MRH
         X3eGhze5IPJXQZTt19yKAsKPYUkeZHnDxTx6n5yDMuKP/ekvl5PuDm3AWdISK+MRLyLZ
         NkKxKiet2/pzv3BFk9xrg5To9el4AAi6LmRY8tloRPMXhKfYwvxGcZFDV0kOAsXMVZMl
         vKWQ==
X-Gm-Message-State: AJcUukdEjseF1sbfA4d2c3Z29GyFgMJqaIKzPcdDjBY5mN5GEfG5J75L
        ZH+F9PjEa9HtxUvYuoGckm3oX0+ox/ND7ouvObuHYw==
X-Google-Smtp-Source: ALg8bN7a90ffD2oAnZFfJMLAaX4U+cLVS/7mO+DlABmePvEmmzKjm0RIU9gjkyt+xn9Lj4i4QOh3aWoIBUe29KKcToY=
X-Received: by 2002:a19:2106:: with SMTP id h6mr21509066lfh.29.1548808340395;
 Tue, 29 Jan 2019 16:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20190129004934.85885-1-tkjos@google.com> <20190129004934.85885-2-tkjos@google.com>
 <20190129081218.GL1795@kadam>
In-Reply-To: <20190129081218.GL1795@kadam>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 29 Jan 2019 16:32:09 -0800
Message-ID: <CAHRSSEzjgtrouqJkhduaZt99RbmtA5a4Lc2xgyp_pt4cg7Vpmg@mail.gmail.com>
Subject: Re: [PATCH 1/7] binder: create userspace-to-binder-buffer copy function
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:12 AM Dan Carpenter <dan.carpenter@oracle.com> w=
rote:
>
> On Mon, Jan 28, 2019 at 04:49:28PM -0800, Todd Kjos wrote:
> > +/**
> > + * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
> > + * @alloc: binder_alloc for this proc
> > + * @buffer: binder buffer to be accessed
> > + * @buffer_offset: offset into @buffer data
> > + * @from: userspace pointer to source buffer
> > + * @bytes: bytes to copy
> > + *
> > + * Copy bytes from source userspace to target buffer.
> > + *
> > + * Return: bytes remaining to be copied
> > + */
> > +unsigned long
> > +binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
> > +                              struct binder_buffer *buffer,
> > +                              binder_size_t buffer_offset,
> > +                              const void __user *from,
> > +                              size_t bytes)
> > +{
> > +     if (!check_buffer(alloc, buffer, buffer_offset, bytes))
> > +             return bytes;
> > +
> > +     while (bytes) {
> > +             unsigned long size;
> > +             unsigned long ret;
> > +             struct page *page;
> > +             pgoff_t pgoff;
> > +             void *kptr;
> > +
> > +             page =3D binder_alloc_get_page(alloc, buffer,
> > +                                          buffer_offset, &pgoff);
> > +             size =3D min(bytes, (size_t)(PAGE_SIZE - pgoff));
>
> This code has so much more casting than necessary.  To me casting says
> that we haven't got the types correct or something.  I've just pulled
> this function out as an example really, but none of the casts here are
> required...  This could just be:
>
>                 size =3D min(bytes, PAGE_SIZE - pgoff);

Dan,

Thanks for the feedback.

The one above: "size =3D min(bytes, PAGE_SIZE - pgoff);", results in
32-bit compile warnings:

./include/linux/kernel.h:846:29: warning: comparison of distinct
pointer types lacks a cast
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
[...]
drivers/android/binder_alloc.c:1157:10: note: in expansion of macro =E2=80=
=98min=E2=80=99
   size =3D min(bytes, PAGE_SIZE - pgoff);

so, I took your suggestion:

  size =3D min_t(size_t, bytes, PAGE_SIZE - pgoff);

>
> Btw, if you really need to do a cast inside a min() (you don't in this
> cast) then use min_t().
>
> > +             kptr =3D (void *)((uintptr_t)kmap(page) + pgoff);
>
> This would be a lot cleaner as:
>
>                 kptr =3D kmap(page) + pgoff;

It definitely is cleaner, but the clean version is doing arithmetic on
a void pointer which is generally not considered good practice (but is
supported by gcc). Is this acceptable in the kernel? I don't see any
statement on it in Documentation/process/coding-style.rst.

If so, I agree a bunch of these casts can go as you suggest.

-Todd

[...]

>
> regards,
> dan carpenter
>
