Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A11C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD020844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkV86TRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfBECdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:33:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBECdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:33:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so1597671ljd.12;
        Mon, 04 Feb 2019 18:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9UkLfdgvyCBzr2dwRvBxCIf8dscsvUaA9fcVhxkDkw=;
        b=pkV86TRF6rziuDnwGcEaMbnZ/mZUH7PwFsKlP7AOC7F3LY6/Z3dX6mmgd+efstCbT3
         GFUemIlmfc6o55IiT3RGmSISjcI+FyW56WdLg069WJSJfx9RZ6gLwog2Qul0AcsbvHZt
         p3kJulJHk3/kAr/lB2mcVMAwSD1QgmMjQotr6hanXW0o6CCl5/MVWaODk+OmmMLfKBQp
         bJDvl+Gxlocg1xqEf6HyQNXWdAMdqjPUqBS866lPJckcgwBUlUzkfdbvWR24ExClB4zt
         9J35xt4m+5WNDg/pOzniaLydYBWseMiY/Np+z4mx2XfjFLHXJEKKvWvQ9JLSiX9/McHY
         06NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9UkLfdgvyCBzr2dwRvBxCIf8dscsvUaA9fcVhxkDkw=;
        b=pgZDcJ2W1/XDxHbb25DOAws/jyxQ3z7FQPd7fNNkfArgpTiqWSyPiEEwC+zvrFgzz4
         xyPlB15KpridVdyBJPdx4U1uaHFC/7l2UcP5lS27fmE7OmF7I0XB7zi84ZcqwbogogLJ
         sHCGzYNZyCTc9/glWwcfulCGDEjBplnp2fTldJJ8nlTkmv//dZlV7mAKwhBUP9qKkb4I
         fajNhh1ddVyWtuJ/BDEWzz86KrpUlb3TJSzTEBX0OZejz39Lv2XurhCoL+uU4uVtVy9u
         VSdVdarP5yfyo2hiSDUeckhPdB2nA40M+71Rgq1Ci2N4Uq2RzMJ/rGkrPU4UqBIzeJF9
         Ap0A==
X-Gm-Message-State: AHQUAua78/K1f84rWqekWbRssOFgsX4sN9D/XpkUtAM+antggM+UfziB
        SCvi9EPbdlh2Op6pob5wme8uGDLXu0UgWsiU2sVKcw==
X-Google-Smtp-Source: AHgI3Ia41T5cdDALoADs4YN8rznkbU3YOdIH9cXJsRuke9caVsx2y1P1B7ftxTB7R+DSYFhaw8ekeTA9soTLHZrOKf8=
X-Received: by 2002:a2e:1552:: with SMTP id 18-v6mr1395230ljv.68.1549334030090;
 Mon, 04 Feb 2019 18:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20190104192410.GA11084@jordon-HP-15-Notebook-PC>
 <20190114085839.GA13316@quack2.suse.cz> <CAPcyv4hV0VQv9bMz9FWW_n734KiHY-HfLMHW_atG8Wqbnrf34A@mail.gmail.com>
In-Reply-To: <CAPcyv4hV0VQv9bMz9FWW_n734KiHY-HfLMHW_atG8Wqbnrf34A@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 5 Feb 2019 08:03:43 +0530
Message-ID: <CAFqt6zYZdpckNPFGx2+nbNs=1UKSGtFvMc5YMvPEnmK4PJyGMQ@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Convert to use vmf_error()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Tue, Jan 15, 2019 at 4:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Jan 14, 2019 at 12:59 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 05-01-19 00:54:11, Souptick Joarder wrote:
> > > This code is converted to use vmf_error().
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> > Dan, you are merging DAX patches these days. So probably you should add
> > yourself to 'FILESYSTEM DIRECT ACCESS (DAX)' in MAINTAINERs.
>
> Sounds good, I'll merge this and get MAINTAINERs fixed up.

This is not reflecting in linux-next. Is this queued for 5.1 ?

>
> > Or I can start
> > picking patches for fsdax to my tree if you are too busy but I think your
> > tree is easier as there are less chances for conflicts etc.
> >
> > In either case this patch looks OK to me so feel free to add
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> >                                                                 Honza
> >
> > > ---
> > >  fs/dax.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 48132ec..ed39161 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -1220,9 +1220,7 @@ static vm_fault_t dax_fault_return(int error)
> > >  {
> > >       if (error == 0)
> > >               return VM_FAULT_NOPAGE;
> > > -     if (error == -ENOMEM)
> > > -             return VM_FAULT_OOM;
> > > -     return VM_FAULT_SIGBUS;
> > > +     return vmf_error(error);
> > >  }
> > >
> > >  /*
> > > --
> > > 1.9.1
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
