Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D8720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opB0LILt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfAOFmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:42:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45956 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfAOFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:42:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so1044928lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5U4Yr+jS2JUdn/D+ygFqqoeUDxn+oxmgJpsC2yObEJM=;
        b=opB0LILtjOwB4hb42JKCpZE4Vs5XNkvxk0O3/UNZ3WLPXcdQA73iwKl29YrZA9d3L1
         8SYhAKEJ+NkJ4fESoaOHLpGIwJmCf+vLZfi0f+lg5Ys8NLLYSk0slaL0ai2pp8D0KE4b
         DnVqr7YBDo9B8pSz18T9jviys2CSqrndoW3SEYNTfqJgJ+HKGfq6MzrvbJS1FihcUe5G
         r+6b366ncZ2Qpy3LtTQQLDN3djzMmTLMxKzof/RcKVvta1n+mLO4hGax2pt/sq2aGIls
         5cMgxzgmJ8dyRiAY+FSgbTw1QdtV0NpuxoBp/DdNlpAdkwEAHjhtvRTWUXc3wSPdvM27
         qHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5U4Yr+jS2JUdn/D+ygFqqoeUDxn+oxmgJpsC2yObEJM=;
        b=HKsm0Ax0bXmYs/pU9CJy5y//b/F5H2DCvLfrdDYpmYBejdPNG5UWedoNcWZU14yhJ7
         /kj7Qm6I3q+NHLsylyQLt7vjngtCINcKMe75/4TaNK18dISqFO2Nv9aKIQgiYgK0ZMGx
         QB3JV1FKaHOkAvVYXwHfwcLPq8GwiaKzR+HRDvbT03md48hvVHRU33E8fjDWHZmVCc5P
         BDArk4tNJTZuRcLMTMRr6BJbdWko3ZJnYakku4dwGyH+fURsimyrsSd9dkePJCtJ7OV4
         CoaezbU2KBPam0QvgVaUwUi+nXg9FY2gSgrdz8Se/s5Mt5eiEIDRvarB6nXvn3hnWvPz
         96Qw==
X-Gm-Message-State: AJcUukfNlOsRGqWRItAiJVZG5kP1/GtBnknbDTbBIE7Qislx5NXe5pKv
        7zyI68PY+JACDAskh+pOsmXWRU28XVtqsGWUWD0=
X-Google-Smtp-Source: ALg8bN5rZ5g/mEr7KbXdsOB6SSm+HbAlmtg/Yt2PUrKntnU6562AUYnfG+mCjdaLAMtyhWRlNypsFZ41BnXTWPKxLHA=
X-Received: by 2002:a19:2906:: with SMTP id p6mr1442310lfp.17.1547530928341;
 Mon, 14 Jan 2019 21:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20190111151326.GA2853@jordon-HP-15-Notebook-PC> <8b0e0809-8e66-079d-1186-90b3f2df7a38@oracle.com>
In-Reply-To: <8b0e0809-8e66-079d-1186-90b3f2df7a38@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 15 Jan 2019 11:11:56 +0530
Message-ID: <CAFqt6zbgrdhoaZXW+5vHu2kV-LmtXMGAcmrv+28i78x0z4Fweg@mail.gmail.com>
Subject: Re: [PATCH 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range_buggy
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 5:01 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 1/11/19 10:13 AM, Souptick Joarder wrote:
> > Convert to use vm_insert_range_buggy() to map range of kernel
> > memory to user vma.
> >
> > This driver has ignored vm_pgoff. We could later "fix" these drivers
> > to behave according to the normal vm_pgoff offsetting simply by
> > removing the _buggy suffix on the function name and if that causes
> > regressions, it gives us an easy way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/xen/privcmd-buf.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
> > index de01a6d..a9d7e97 100644
> > --- a/drivers/xen/privcmd-buf.c
> > +++ b/drivers/xen/privcmd-buf.c
> > @@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
> >       if (vma_priv->n_pages != count)
> >               ret = -ENOMEM;
> >       else
> > -             for (i = 0; i < vma_priv->n_pages; i++) {
> > -                     ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
> > -                                          vma_priv->pages[i]);
> > -                     if (ret)
> > -                             break;
> > -             }
> > +             ret = vm_insert_range_buggy(vma, vma_priv->pages,
> > +                                             vma_priv->n_pages);
>
> This can use the non-buggy version. But since the original code was
> indeed buggy in this respect I can submit this as a separate patch later.
>
> So
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks Boris.
>
>
> >
> >       if (ret)
> >               privcmd_buf_vmapriv_free(vma_priv);
>
