Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0066C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52AE218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ri7Tjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfA3KAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:00:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA3KAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:00:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so20115738ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ahPDIIFv/MMPOGpeZxT3pmApwBNz3CD4N0VP4gKld8=;
        b=B2ri7TjmimvAXTVQ6NpGSwysKvPv1hRX+3Oh7rms+F5kl5dzWJHrIFOwJuF4qThTKO
         I04XKp6YookGQQmu5HRlrq8WM8/edqRbmryusF30k9Tmj3RyeHRH1aMeSyc+mATq5BgQ
         Z40SqAe9+PkppudAohfQEIxSSDOoIhBa1tFqVWxK3HgblGGMvyid0d57zye3T4U5GjiD
         3sUbwI3/bkTL+5Nm02NbviKLld0N+TdVirbLuwg+Dmh71heG9+55XVbxGeryWKgXNc5x
         +lferOF3M5QO8an0Kmgzwnfy9oM1GjM2QE8henvXUlnxEA9X8MLoUvsfFTLfaXycLlZ1
         h1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ahPDIIFv/MMPOGpeZxT3pmApwBNz3CD4N0VP4gKld8=;
        b=hTgoDly/w3WcofPxoQlpZqIz+qGirpgijJMuEJ7fcC6pd/Stu8C0C8Sc4UF0a2Lq1G
         xT0z7IYTqk5be5vpIrxjkIXVQv9MFCzQGZWPOKIGxubrTTy/Hpltd6tYRnRvygDWzgeo
         qhXrsyKkmQ3KLe4vEpDXwdZMY1cPe1jmmlRnXugY5XRyzYJ6EDU0jkraSOKJ5nvcAiGr
         w5RzfwKElO4kh/Pzr/B+q4CDD78Y0ZWfZ98bfs6aWE6aNbgdLhjHWNx4NcoFusEFPwTB
         3/OD6bHLOjDPgI16SPYv5jCFwxVb7W06W0N97RwxYIpgDmlOoY3FGSe9ETSb+8ADvEvk
         SgtA==
X-Gm-Message-State: AJcUukeLVrNhG6bTG9N/E8qPHQ1e0zdMTXix6pyeQ4Fy/0vScYwXNs0A
        MpIgmRZh+pG95V93ko8osoo1eMNp0PVvp9wSrro=
X-Google-Smtp-Source: ALg8bN5A2L7T88ZjEk542s9LF+gJzDLfcz24saQivM+b0ybEgO7nrHTut38OlFHM6aQVTbEJTgLEJ+q5EvHTEynOpcQ=
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr25670564ljj.43.1548842406798;
 Wed, 30 Jan 2019 02:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20190111150801.GA2714@jordon-HP-15-Notebook-PC> <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
In-Reply-To: <CAFqt6zZx9qxx_Xv=n-PY45OvS7E8ZBq+ZqaeEKfsaCirwaASSg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 30 Jan 2019 15:29:55 +0530
Message-ID: <CAFqt6zboe40Ss6C6h9zhkO71pxKOkA1zV6OrH-+aU3-1yVzeWA@mail.gmail.com>
Subject: Re: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:54 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 8:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > ---
> >  arch/arm/mm/dma-mapping.c | 22 ++++++----------------
> >  1 file changed, 6 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 78de138..5334391 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
> >                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >                     unsigned long attrs)
> >  {
> > -       unsigned long uaddr = vma->vm_start;
> > -       unsigned long usize = vma->vm_end - vma->vm_start;
> >         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> >         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -       unsigned long off = vma->vm_pgoff;
> > +       int err;
> >
> >         if (!pages)
> >                 return -ENXIO;
> >
> > -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> > +       if (vma->vm_pgoff >= nr_pages)
> >                 return -ENXIO;
> >
> > -       pages += off;
> > -
> > -       do {
> > -               int ret = vm_insert_page(vma, uaddr, *pages++);
> > -               if (ret) {
> > -                       pr_err("Remapping memory failed: %d\n", ret);
> > -                       return ret;
> > -               }
> > -               uaddr += PAGE_SIZE;
> > -               usize -= PAGE_SIZE;
> > -       } while (usize > 0);
> > +       err = vm_insert_range(vma, pages, nr_pages);
> > +       if (err)
> > +               pr_err("Remapping memory failed: %d\n", err);
> >
> > -       return 0;
> > +       return err;
> >  }
> >  static int arm_iommu_mmap_attrs(struct device *dev,
> >                 struct vm_area_struct *vma, void *cpu_addr,
> > --
> > 1.9.1
> >
