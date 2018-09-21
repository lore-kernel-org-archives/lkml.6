Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA2A2154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Aq+gRgBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA2A2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbeIVBf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:35:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42739 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbeIVBf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:35:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id v198-v6so12367436oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/8YhKWCfEG0Imi4gGYHLHbRKNj4VkcPJBdZJGV9Tzw=;
        b=Aq+gRgBMxK5tVyVaOMp+pPJuly0tu7HGa0lTKNLY6bosTCegmHYzM9e67MMA12sBAf
         X2vvOUn2LB4lAflMJvhLW0nk/RkU8QdttEjXkAC1ZsZDmfpALOH7veMbkbCbUqUb1XMb
         m/o5D3ZChylulNtktahNMQMYuk2fXzsO6HSn7HIcODYuhAH0rqpAoJM8tQDSIwcYL9ZR
         9Y461HrUorIZsPVDSPN+iajxBpSCku0e1gEMyqtRgm/rtYgSIHzLGnr3pV7OrRA11gXx
         5+JwTEbVrP9tk4PcUEyxvqPyXA7x5XOGgQ6tzbLjM3cJVv7KKJpNAOGpkNf2k5OguM+8
         eeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/8YhKWCfEG0Imi4gGYHLHbRKNj4VkcPJBdZJGV9Tzw=;
        b=i/1YJFuE4PeEeu3nCYGdL0Sy/YjVzzpEJVbKwmVbXiOSKIpfeUsHSCqw2WGBs+hF4M
         OXJ1OhKuav0GAWdjoWeex0dbL6pYRmXl33rBz/mY2+XPIdBdjoziBfpGT3EW8t9BWlgj
         JfHt/YH9eAw+M5tm07gE4AuVm3A5ntEPzh6S8N7IRToIXVGB/+q0MCaCHUy2iOqH6Go9
         N/ouR4+50UVsGfe0LVMY9zotCGTG6LdZJAB9XQ/XjUFgrMHj2XzWwVYmYhxbL/PD62QI
         0HhceilDizVGr2i2xio8+dy0vxGaReStA7wv/68pOSxg3Z1Q2N4RMyG6HHv8AZ+Vrnbs
         lkMg==
X-Gm-Message-State: APzg51B5RxvkxF5ZfjbDkodAk4sdZd5FoqafbWDJgcQtXBAQxcgHS7+Q
        RIxEgqns72qvrkqt1dwlsum2+q49NdfWnkbvgXQzQg==
X-Google-Smtp-Source: ANB0VdaJHQCUQZnOfjZRyhJ5Jc1Rc7LFybsKjpekjiYx38Ve47pl0PXzMfm+77SE8yYvXeUJO6QW/qOIM83pv+SmdmU=
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr43933oie.215.1537559135145;
 Fri, 21 Sep 2018 12:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180920200358.31680-1-keith.busch@intel.com> <20180920200358.31680-7-keith.busch@intel.com>
In-Reply-To: <20180920200358.31680-7-keith.busch@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 12:45:23 -0700
Message-ID: <CAPcyv4iq+9xCfUi4PMtrjPiBOB5fbtiycp3jX5mkchEgcLNgFg@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] mm/gup: Combine parameters into struct
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 1:03 PM Keith Busch <keith.busch@intel.com> wrote:
>
> This will make it easier to add new parameters that we may wish to
> thread through these function calls.
>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  include/linux/huge_mm.h |  12 +--
>  include/linux/hugetlb.h |   2 +-
>  include/linux/mm.h      |  21 ++++-
>  mm/gup.c                | 238 +++++++++++++++++++++++-------------------------
>  mm/huge_memory.c        |  32 +++----
>  mm/nommu.c              |   6 +-
>  6 files changed, 151 insertions(+), 160 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 99c19b06d9a4..7d22e2c7f154 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -212,10 +212,8 @@ static inline int hpage_nr_pages(struct page *page)
>         return 1;
>  }
>
> -struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> -               pmd_t *pmd, int flags);
> -struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> -               pud_t *pud, int flags);
> +struct page *follow_devmap_pmd(struct follow_page_context *ctx, pmd_t *pmd);
> +struct page *follow_devmap_pud(struct follow_page_context *ctx, pud_t *pud);
>
>  extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
>
> @@ -343,14 +341,12 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
>         return;
>  }
>
> -static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> -               unsigned long addr, pmd_t *pmd, int flags)
> +static inline struct page *follow_devmap_pmd(struct gup_context *ctx, pmd_t *pmd)
>  {
>         return NULL;
>  }
>
> -static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
> -               unsigned long addr, pud_t *pud, int flags)
> +static inline struct page *follow_devmap_pud(struct gup_context *ctx, pud_t *pud)
>  {
>         return NULL;
>  }
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6b68e345f0ca..64b675863793 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -180,7 +180,7 @@ static inline void hugetlb_report_meminfo(struct seq_file *m)
>  static inline void hugetlb_show_meminfo(void)
>  {
>  }
> -#define follow_huge_pd(vma, addr, hpd, flags, pdshift) NULL
> +#define follow_huge_pd(ctx, hpd, pdshift)      NULL
>  #define follow_huge_pmd(mm, addr, pmd, flags)  NULL
>  #define follow_huge_pud(mm, addr, pud, flags)  NULL
>  #define follow_huge_pgd(mm, addr, pgd, flags)  NULL
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a61ebe8ad4ca..f1fd241c9071 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -378,6 +378,13 @@ struct vm_fault {
>                                          */
>  };
>
> +struct follow_page_context {
> +       struct vm_area_struct *vma;
> +       unsigned long address;
> +       unsigned int page_mask;
> +       unsigned int flags;
> +};

I was thinking that the context would only contain the in/out
parameters of page_mask and pgmap. I don't think we plan to have more
parameters beyond this one addition and from a code readability
standpoint the less "ctx->" the better.
