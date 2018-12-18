Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A203721852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDjcJXXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeLRM6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:58:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36179 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeLRM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:58:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so14129795ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJEXeZy7r0kYuKM3hPFGswkGYVdPGlEwNSsUSbfadm8=;
        b=cDjcJXXxCqen79XtD8Eix24NpVMSUzZxn384UkAKmRCmq1v6wldgZEpj7uppmDQfUk
         lprFRzF1bSYLx3s4wPPJWpkO5Ag90kGJ8kxxvPx3eiqZXY+msiVZUCygUQC2uYwWlUVt
         bRJxDBlu5z6K0N0KojeXDy+FnEhAVf874SD83FzfFuWXJk+95BIltIf36IGx9zCd7S4Y
         NRjZcdEf4wH5kmk+Sdy70AzQLXJeZAIEO7P+sMRSqFlrDmEH+hTDHaCq7ZZspYQIJ+Vb
         lajs0tnqnckYIGF6dqp1qoge1YmIx+qnkzngzhe6el+i2mPPuXHKw4qiBdzNiTbwoY3v
         2URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJEXeZy7r0kYuKM3hPFGswkGYVdPGlEwNSsUSbfadm8=;
        b=TatGiNiRZml5hBkcTBtNURdGVAK0IYPbLHwkBBIEwB/aPmZtFQATNC2/oheOiU8IXK
         mSJWIxrKvghcGivh6iK/NmlNexu7VSue/0syN+SwFPe+GW5AX3upmB6LWx6r6Zb8HXrQ
         hHOug+3UHCvVa3O7BiUaURspmpzSWHAL4h+AutEPxVSfyf9yDSEY4JrzZPKv1vg0litC
         dsx+qwpQU6AO8sx+sGq1qZqAiSkSQzejr63lRBj+oiliVi6nthyWHzNLurBpxWeLuzpX
         8RfPt2g/GtwWRC46ZWwlydhCJzFZNheCC0Zti2pcF+qYIXGx+wmtDM0xcZdSrYJ5w84g
         X5Pg==
X-Gm-Message-State: AA+aEWZ/NUiqJ9YRaGHhA5E2hK9UcP6wnOijUB4EBr13l/rjiSsFcP5v
        mLkR8FbSipz2cC2Om8WMT18vlskx3T+NP6cUjUM=
X-Google-Smtp-Source: AFSGD/X1xQ2Y9yxGJNmnMra79GQM3gQrWIMtM2z1d/6UhNzHyUugtcxF1fs5kkuErNtpFv8H03bwisOZxtLr8o/ws2A=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr921004lji.93.1545137879090;
 Tue, 18 Dec 2018 04:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20181217202209.GA8859@jordon-HP-15-Notebook-PC> <20181218093754.GI26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218093754.GI26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 18 Dec 2018 18:27:45 +0530
Message-ID: <CAFqt6zbQkFbX57D2kJqZa_gMH7tGzY6FGUJE7Y14kmiiHEv1AA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 3:08 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:52:09AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 661fe48..7cbcde5 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
> >                   void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                   unsigned long attrs)
> >  {
> > -     unsigned long uaddr = vma->vm_start;
> > -     unsigned long usize = vma->vm_end - vma->vm_start;
> > +     unsigned long page_count = vma_pages(vma);
> >       struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> >       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >       unsigned long off = vma->vm_pgoff;
> > +     int err;
> >
> >       if (!pages)
> >               return -ENXIO;
> >
> > -     if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> > +     if (off >= nr_pages)
> >               return -ENXIO;
>
> Are you sure you can make this change?
>
> You are restricting the offset to be within 0..nr_pages which ensures
> that the initial struct page that is passed to vm_insert_range() is
> valid, but I think the removal of the following check is unsafe.
>
> Your new vm_insert_range() function only checks page_count <=
> vma_pages(vma), which it will be since it _is_ vma_pages(vma).  With
> the removal of the second condition, there will be nothing checking
> that (eg) off may be nr_pages - 1, and page_count=50, meaning that
> vm_insert_range() will walk off the end of the page array.
>
> Please take another look at this.

This check shouldn't be removed.
>
> What about the other callsites of your new function - do they have
> the same issue?

I think other callsites don't have the same issue.

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
