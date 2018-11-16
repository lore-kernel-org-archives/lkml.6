Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3669C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F182087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4VA7sdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F182087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeKPPlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:41:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34135 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKPPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:41:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so15774803lfc.1;
        Thu, 15 Nov 2018 21:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn6Qmrrkwk7bdO+YdJWJlXcHgGp+deTEH+pMCz3lb7I=;
        b=i4VA7sdPX5L0u8TQSv6bgoo29Hu6OMJIMheha8rXFFomD/85LN3lXPJnqOQI9qXB/8
         13VyuEZk8VB57HQXKi97hwTe/9C9M//BvN246MyTSUWbQz4dlG5x/8Leabfa4DpXDd2R
         yPeX/jVjkpkGz8BlAzZaRx5Ahx56g1otpGeJV4JBJkc/FKTsHNcHDjNC5B6Ca83p71N3
         svUSHah24Q/fN5ExEvoELTwT4u7D/vCc0rVdKVfSMvKC2XNQ5AA63enb5jBhVhAPOQcw
         8N+2xbZpMaSqkqvfVRzL9OpkK3hWAWd7JyRgatYiVIJTrIZwAPPDmlK5y0NocLQyQ5hM
         wGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn6Qmrrkwk7bdO+YdJWJlXcHgGp+deTEH+pMCz3lb7I=;
        b=FFPeFmAzy9/3O7xuusg1VYs6ZphQywvnZCGO+LjK+lEYV//ceosyXJAZRq9/4PwLCY
         c8JivzoT8bXj8VW7/eYKFWbZnAD14/grMwmm2uIL7WywHhSp7IIPMaQKBFOMJjIYtd+F
         EZp/c9fQriP4rktw89K2pw2OihNwYmlFdLhRSGjcJ+SHoFWxe++VkChE50V5nryM33rQ
         RaWtMWaHjO1EG+aeP3BSOfl1U5ewzHoloLsnYuJIfXiFSJxBvnXvlTyG7tPAtdMcBYvH
         WRYKVfz6wNi+OCdUd1kmSAP2zXLTw4I3lYZKJOHtrUzHimladodZK3lfCfxkU8saMXGj
         EWKg==
X-Gm-Message-State: AGRZ1gK58pDFIaf/ZFBxfQkndMthtwM9RMEJvOMexGDYb4wofWti1KdJ
        owj3DD+6LZv98HDf6Uh1PV0T/xZCEi1CQ278mk4=
X-Google-Smtp-Source: AJdET5d/w+x+P5hlZuT4E/hxQ+Tr4LNPY9TtY4ChpVCuwkULg5fuk9LWwLzWwdL2gKfWDh0R2fN7xz1/Aq5sMuURsUw=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr5055400lfk.77.1542346243900;
 Thu, 15 Nov 2018 21:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC> <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
In-Reply-To: <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 16 Nov 2018 11:00:30 +0530
Message-ID: <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating a new function and use it across
> > the drivers.
> >
> > vm_insert_range is the new API which will be used to map a
> > range of kernel memory/pages to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  include/linux/mm_types.h |  3 +++
> >  mm/memory.c              | 28 ++++++++++++++++++++++++++++
> >  mm/nommu.c               |  7 +++++++
> >  3 files changed, 38 insertions(+)
>
> Hi,
>
> What is the opposite of vm_insert_range() or even of vm_insert_page()?
> or is there no need for that?

There is no opposite function of vm_insert_range() / vm_insert_page().
My understanding is, in case of any error, mmap handlers will return the
err to user process and user space will decide the next action. So next
time when mmap handler is getting invoked it will map from the beginning.
Correct me if I am wrong.
>
>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 15c417e..da904ed 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >
> >  /**
> > + * vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @pages: pointer to array of source kernel pages
> > + * @page_count: no. of pages need to insert into user vma
>
> s/no./number/

I didn't get it ??
>
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma. This is a generic function which drivers can use
> > + * rather than using their own way of mapping range of kernel pages into
> > + * user vma.
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     unsigned long uaddr = addr;
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < page_count; i++) {
> > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > +             if (ret < 0)
> > +                     return ret;
>
> For a non-trivial value of page_count:
> Is it a problem if vm_insert_page() succeeds for several pages
> and then fails?

No, it will be considered as total failure and mmap handler will return
the err to user space.
>
> > +             uaddr += PAGE_SIZE;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> >   * vm_insert_page - insert single page into user vma
> >   * @vma: user vma to map to
> >   * @addr: target user address of this page
>
>
> thanks.
> --
> ~Randy
