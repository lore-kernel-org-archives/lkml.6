Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87403ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8482154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Kqpx3nqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8482154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391379AbeIVBhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:37:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40805 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbeIVBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:37:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id g14-v6so500576otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81aUO94kBFH0F5nOFClBLzweldrs8pPhe8kUFURAxgo=;
        b=Kqpx3nqpaWsOZL96D5vQPcovFJBc1GetsccwQzEfuf3aAOTyKq/F9QRKqMVViJ+oYt
         w5GgMBocTeEJMCeTnBpMdXUGsT5Ud9PHFYZVfxBvB5u1HHzRmadVblG0O9MWpeLgBk/1
         vqzLEVU6V+CkNQTjKP6WKnCfaL+moRLpYXptG9+wHhdGxn3TRDyJs8SVBRgjSUYoHYH2
         sm9Rntc2fT7o4gTPF0ddqKDrpXVC83a+LL2HiYgGNEulv+kPBiyXJtNaNhZ0SQm2rKSp
         zwj7E15jU4u5BTS/QTWnsi84Gae1j7e3QXzn/HN0UqunrjwMexjvBP1G5a5uqyvR2guk
         XNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81aUO94kBFH0F5nOFClBLzweldrs8pPhe8kUFURAxgo=;
        b=RE4g4qDBk8RR9uBm+FJZu9ALPbGPpXXMB2djvWlepMviU56Xx3zWHL2mg0fqozUEfF
         3YS1ZCflzbxBjewkey4DqYy25CgRNw8je1+Ba7Kg0pv3UqlqTZWR8EAGbYJb9tzgo9IH
         JOP0XT/rEjCJWNpdnm6UOfio8etXidBAkN1iX1xXAlLxTnkv9Y7HFQELlaH1b4iLeZGH
         Fj8ITRfDibqDfkZIHP32zXAWjrDX110iyTKfC/Fb2UXjaiCv8u5Doz4YaLFjAU17vzib
         SGbUvS987PeAFRNEIDiyBwv5eFmA5oLt9VKBy1m2y5ZBddZZYVYNDhAS/QvFsHkrHiJ+
         /OPg==
X-Gm-Message-State: APzg51CzdBmCJ94kbzEkOGc+lpCKMM2mXWOn/DkaNGZMgwDpAHzl0XQE
        CcKiIPN3v/Yiu4pZYOyU/tV98aK+ePz6rSHH9qYyDA==
X-Google-Smtp-Source: ANB0VdaVyGcXEAGJlQ+BPkfkM8lT7k0bAUekn/RcEmuUGh63QPFoHD6N2rLfbO6awnJwWENuvzvFU4kKYnRcg5u8Bsg=
X-Received: by 2002:a9d:128a:: with SMTP id g10-v6mr25170762otg.119.1537559206238;
 Fri, 21 Sep 2018 12:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180920200358.31680-1-keith.busch@intel.com> <20180920200358.31680-7-keith.busch@intel.com>
 <CAPcyv4iq+9xCfUi4PMtrjPiBOB5fbtiycp3jX5mkchEgcLNgFg@mail.gmail.com>
In-Reply-To: <CAPcyv4iq+9xCfUi4PMtrjPiBOB5fbtiycp3jX5mkchEgcLNgFg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 12:46:30 -0700
Message-ID: <CAPcyv4g+KV94dcXy+cfrws4fHZ6WkiUvy89ViKz4-WdfFf57Ag@mail.gmail.com>
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

On Fri, Sep 21, 2018 at 12:45 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Sep 20, 2018 at 1:03 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > This will make it easier to add new parameters that we may wish to
> > thread through these function calls.
> >
> > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  include/linux/huge_mm.h |  12 +--
> >  include/linux/hugetlb.h |   2 +-
> >  include/linux/mm.h      |  21 ++++-
> >  mm/gup.c                | 238 +++++++++++++++++++++++-------------------------
> >  mm/huge_memory.c        |  32 +++----
> >  mm/nommu.c              |   6 +-
> >  6 files changed, 151 insertions(+), 160 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 99c19b06d9a4..7d22e2c7f154 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -212,10 +212,8 @@ static inline int hpage_nr_pages(struct page *page)
> >         return 1;
> >  }
> >
> > -struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> > -               pmd_t *pmd, int flags);
> > -struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> > -               pud_t *pud, int flags);
> > +struct page *follow_devmap_pmd(struct follow_page_context *ctx, pmd_t *pmd);
> > +struct page *follow_devmap_pud(struct follow_page_context *ctx, pud_t *pud);
> >
> >  extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
> >
> > @@ -343,14 +341,12 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
> >         return;
> >  }
> >
> > -static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> > -               unsigned long addr, pmd_t *pmd, int flags)
> > +static inline struct page *follow_devmap_pmd(struct gup_context *ctx, pmd_t *pmd)
> >  {
> >         return NULL;
> >  }
> >
> > -static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
> > -               unsigned long addr, pud_t *pud, int flags)
> > +static inline struct page *follow_devmap_pud(struct gup_context *ctx, pud_t *pud)
> >  {
> >         return NULL;
> >  }
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 6b68e345f0ca..64b675863793 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -180,7 +180,7 @@ static inline void hugetlb_report_meminfo(struct seq_file *m)
> >  static inline void hugetlb_show_meminfo(void)
> >  {
> >  }
> > -#define follow_huge_pd(vma, addr, hpd, flags, pdshift) NULL
> > +#define follow_huge_pd(ctx, hpd, pdshift)      NULL
> >  #define follow_huge_pmd(mm, addr, pmd, flags)  NULL
> >  #define follow_huge_pud(mm, addr, pud, flags)  NULL
> >  #define follow_huge_pgd(mm, addr, pgd, flags)  NULL
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a61ebe8ad4ca..f1fd241c9071 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -378,6 +378,13 @@ struct vm_fault {
> >                                          */
> >  };
> >
> > +struct follow_page_context {
> > +       struct vm_area_struct *vma;
> > +       unsigned long address;
> > +       unsigned int page_mask;
> > +       unsigned int flags;
> > +};
>
> I was thinking that the context would only contain the in/out
> parameters of page_mask and pgmap. I don't think we plan to have more
> parameters beyond this one addition and from a code readability
> standpoint the less "ctx->" the better.

Also, the next version of this series should be copied to linux-mm.
