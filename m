Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34813C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5086208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC5hyMhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5086208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKSVFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:05:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeKSVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:05:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so20946401lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhIQpz1YPcCamr54Ouju0Ce6xCXXnDMZHCQXgqmI7vM=;
        b=UC5hyMhQjvohJTPXNIn0Tx3cPe9huGYgXbXMCieMOpx0lkAXRbei48BmJu3djLKypv
         0gcU49/7SytX4FsNp4AVgvZJEiiabJSMVBl5NS2C4zmXIc3WWrZ3evEWp4+yOkEhI5rK
         y9s+24Gk7udINcWC3Twcp139eX5cD2AWhHIn/meEfJHIcG4VNzTGdGNOjXjhfQGXrX/d
         oC+R2C8KGtvqUzuLUpO/yOmr+uyhS4ldae5vWJjnS0G5m4Au8rw7xjzHzvVAap3J8Oq1
         L+rs8nrAk91jO76C2TsoVp79UxVXFP3BvygOHBObDEOrbTV8TXKdpBcCVmQX74NxuLrp
         3mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhIQpz1YPcCamr54Ouju0Ce6xCXXnDMZHCQXgqmI7vM=;
        b=p5Ti4fzXN5mqoD31NeIB92keRIB1ZifewKws+sm0C/EYgAEp3EDoVZa34JGQov7xlB
         ExUogwsKBvuhHXzFVClEOku102mdQkF0iwf+wF9ZKJdFXqoD4U2jGsVYnohxnJd5b4G6
         lqrC+zsn9y3GvBv8sxgi+yHjnULcP49geoMvBk3C2+6BE4S66UC0cuB5EjZvcaIz7hzo
         QD/TmrttaMNtEp6WEJ++SjOL3LDEIGWCpmuHSe/OOQeQqMr5bFZiPbLeyThHc9sEUZY2
         WSMxSaf8Qwnp/m0FnZt2mnK9DPIW0gNw5LXyp1m9aUMIL7wRiDy+znJ/maMEAPnINmbh
         vkeA==
X-Gm-Message-State: AGRZ1gIxa6hTUiW1UAQ0+De9HNQ64sdjdv3jq2ZhgD3KF+8kNrWLpwRq
        rgisUGnK5DcXlX1JCIA0mbmjWX0SD5CEJldF/AE=
X-Google-Smtp-Source: AJdET5dr65RL6kCywAuJXeMkDKlyJkkay3cScfV0PJUHCW1OFIIl6a8DC2DvgMbpMywJ2gUTTB22zhc5367O+NrQFyo=
X-Received: by 2002:a19:c70a:: with SMTP id x10mr10158569lff.88.1542624136458;
 Mon, 19 Nov 2018 02:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20181115154912.GA27969@jordon-HP-15-Notebook-PC> <ed294bea-bf07-6a4d-51ec-9e7082703b61@gmail.com>
In-Reply-To: <ed294bea-bf07-6a4d-51ec-9e7082703b61@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 19 Nov 2018 16:12:03 +0530
Message-ID: <CAFqt6zZ_FnWg2K3Lh=-1KFOk1XteHnroua6QzJrKo+khZTgieg@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to
 use vm_insert_range
To:     andr2000@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 3:22 PM Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
>
> On 11/15/18 5:49 PM, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >   drivers/gpu/drm/xen/xen_drm_front_gem.c | 20 ++++++--------------
> >   1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > index 47ff019..a3eade6 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > @@ -225,8 +225,7 @@ struct drm_gem_object *
> >   static int gem_mmap_obj(struct xen_gem_object *xen_obj,
> >                       struct vm_area_struct *vma)
> >   {
> > -     unsigned long addr = vma->vm_start;
> > -     int i;
> > +     int err;
> I would love to keep ret, not err

Sure, will add it in v2.
But I think, err is more appropriate here.

> >
> >       /*
> >        * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
> > @@ -247,18 +246,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
> >        * FIXME: as we insert all the pages now then no .fault handler must
> >        * be called, so don't provide one
> >        */
> > -     for (i = 0; i < xen_obj->num_pages; i++) {
> > -             int ret;
> > -
> > -             ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
> > -             if (ret < 0) {
> > -                     DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
> > -                     return ret;
> > -             }
> > -
> > -             addr += PAGE_SIZE;
> > -     }
> > -     return 0;
> > +     err = vm_insert_range(vma, vma->vm_start, xen_obj->pages,
> > +                             xen_obj->num_pages);
> > +     if (err < 0)
> > +             DRM_ERROR("Failed to insert pages into vma: %d\n", err);
> > +     return err;
> >   }
> >
> >   int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>
> With the above fixed,
>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
