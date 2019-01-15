Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B14C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2FE20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVtcuV0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfAOEuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:50:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44906 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfAOEuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:50:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so979606lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 20:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TXiWK8V2OmVXxJRMbWQxDG/DyuoOV26hjhztUIr7v0=;
        b=mVtcuV0EWzi7waFPQ8kYoJPyXBr+5pYoBCie6M0hgYyXy7vhQ5az3gqJxtEbxr3nn2
         j9ilWv71hMMplMbZtgb43pPMZXzFr7wx5xRxPS8DNzutWYmyB9EbCwsRsuXMufbg0xyR
         /YEVGqozNiko6lxpg06VLAT4fpTuQZmDYLb+sIUstV44HcikXtqaXUTSG9GTURBiUSNA
         8BYjInM+97RsYzeR70yuKV67ybVWP0xN7Rx/tFxF+bbrHmJYj33wSR5ZPzMHcXDr0m+1
         2a6FY+nVTaxr2WZQJEJ4B4b10N7sCID+uDbgcnuZjxWcfRn319/fRSQvaJDYttnRfiRL
         kkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TXiWK8V2OmVXxJRMbWQxDG/DyuoOV26hjhztUIr7v0=;
        b=EtCIyp7eiEibH3e2x5G2CI+5CL9uNEFr2Bo51mzvh1ovHLvskQ/aSQtdobYCp2g73d
         b858lDTdj+h3uSg/C0P176dPXBJZU+55v95vAzO+LNUY6ebGOuKSA7S7241wcaT2IUxq
         bJOqTkgNcQ7CCWJncQlZ0566ILdxBoriJ4Pq2ysOYelofI+GyXXMyLfqsyy8gmX0yuvz
         lJqn31i72i/MMZPppQN5S8fnijC1VKbmvrvlUteEHqGdKuljJtQ2bKYrIzX6BujFBwmO
         uSvMHadeYVHShohtAuz/SGAc/dNzSSHTNEdsRY6Z/KEFmHmQk7CFM+AzlQNUbUO8qVpE
         3JdA==
X-Gm-Message-State: AJcUukd67DRpV6NA1DseBPuPzcV6riDNBxuZRY53qaW42Ndo9919oBF6
        qm3BzlvwLxbPlSohdwKolcpF2c38VdJvqLHo/f8=
X-Google-Smtp-Source: ALg8bN6CfyMOSVhkOI4qCOcQDPjp0RDL1herZsjnUL9YRVIr0xZF45WD6Af2cKMyoaJD7PVQHHuyEJcBRGlu746vPaQ=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr1378271lfb.72.1547527808437;
 Mon, 14 Jan 2019 20:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20190111151235.GA2836@jordon-HP-15-Notebook-PC> <f6eef305-daf3-dad8-96e3-d2f93d169fd4@oracle.com>
In-Reply-To: <f6eef305-daf3-dad8-96e3-d2f93d169fd4@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 15 Jan 2019 10:19:55 +0530
Message-ID: <CAFqt6zYFR5FHXTLsSQ2DKgZDQtuNB2jZWK6ZLUAscG9vMnSk3Q@mail.gmail.com>
Subject: Re: [PATCH 8/9] xen/gntdev.c: Convert to use vm_insert_range
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

On Tue, Jan 15, 2019 at 4:58 AM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 1/11/19 10:12 AM, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>
> (although it would be good to mention in the commit that you are also
> replacing count with vma_pages(vma), and why)

The original code was using count ( *count = vma_pages(vma)* )
which is same as this patch. Do I need capture it change log ?

>
>
> > ---
> >  drivers/xen/gntdev.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > index b0b02a5..ca4acee 100644
> > --- a/drivers/xen/gntdev.c
> > +++ b/drivers/xen/gntdev.c
> > @@ -1082,18 +1082,17 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
> >  {
> >       struct gntdev_priv *priv = flip->private_data;
> >       int index = vma->vm_pgoff;
> > -     int count = vma_pages(vma);
> >       struct gntdev_grant_map *map;
> > -     int i, err = -EINVAL;
> > +     int err = -EINVAL;
> >
> >       if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
> >               return -EINVAL;
> >
> >       pr_debug("map %d+%d at %lx (pgoff %lx)\n",
> > -                     index, count, vma->vm_start, vma->vm_pgoff);
> > +                     index, vma_pages(vma), vma->vm_start, vma->vm_pgoff);
> >
> >       mutex_lock(&priv->lock);
> > -     map = gntdev_find_map_index(priv, index, count);
> > +     map = gntdev_find_map_index(priv, index, vma_pages(vma));
> >       if (!map)
> >               goto unlock_out;
> >       if (use_ptemod && map->vma)
> > @@ -1145,12 +1144,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
> >               goto out_put_map;
> >
> >       if (!use_ptemod) {
> > -             for (i = 0; i < count; i++) {
> > -                     err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
> > -                             map->pages[i]);
> > -                     if (err)
> > -                             goto out_put_map;
> > -             }
> > +             err = vm_insert_range(vma, map->pages, map->count);
> > +             if (err)
> > +                     goto out_put_map;
> >       } else {
> >  #ifdef CONFIG_X86
> >               /*
>
