Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C7E20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAVVx376"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeLNFFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:05:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34620 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNFFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:05:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so3826281ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO/wyL1jZxZpm/vBJ7z2cLH23eSJ+crN6kEHVRF8aJU=;
        b=oAVVx376UuQhe/lxvn9BllKKfibHOxZYjw+qu9rm4cnusZpYILQn39McUlkwRt+bR3
         tjfq7PA/CJL1E5tomq+o1znHxlMBqHZfeB4Jdgf4OIiEzmBDJnPIY70OUGRCXiM2bltj
         An5M7UA3j9daJdzuyIh0NPX2xzzHDxx8emS3bwJAhsz3leYAUyb+STRFY1Qgh/+tiLUO
         tRaszDGRKveh7tY7rWZdExK9aFGhosntgGv9EUnGrHy/r4TptyL+OI7R/rv67cOBCxG4
         LTs4Dod8c1ZzTp3dDJ5Vd/n7/VJBfps8SLdOvK/FbexvMDvRBq0GdzIazRp12WMDX7a2
         xyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO/wyL1jZxZpm/vBJ7z2cLH23eSJ+crN6kEHVRF8aJU=;
        b=EWZ1Ugy9YeBGU46TQauxXg7v/AZ7oWijUsP90KsHtTk3S74XCn+c/5gfU9uhdclBCj
         ZHyds3Raly1XjwB8MiJTsTSt5rzYgvqsf4harySOIqrsWnVlKsD77AOK8UmcrY8ilLsK
         epQlIDGpbWBnFNTL86gwM6uJ2MKTf2WT3I0GFhb7Uu6R10wQbV3sYeo/T1ApItVgZaH9
         TgSTJ/+iDOYtPbQxS0u1cDhhqJ8/nH0Mc2tY+mutmCMjtGbxk9xJzXNAoOjSP7JylnzN
         aTcUd92TLZTbYVdzD6iu1+Kn6N/YLyi5RpwspDd2j9WiAEeRBwj5JVOgI0Cf6uetHsT8
         7ETw==
X-Gm-Message-State: AA+aEWaWn6+yo/gAuGpj2/KjArVEVUlsgohucwVCj3Thodx4utNt/gkE
        tTUs0yu/xroiVXoIwaeUCPtnauTDJ1sWDdmnEN9ttQ==
X-Google-Smtp-Source: AFSGD/VXmF7X4AJ6GUzggC7NEibX8csm32FyuxxJcsNXWLxEVHec0eo1oqcBrKbEm/2y1gd5DBpDtzT3JB6XyEopBUk=
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr691233ljk.99.1544763948111;
 Thu, 13 Dec 2018 21:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
 <20181115014737.GA2353@rapoport-lnx> <CAFqt6zbOgSm9omt+6iV0GJtZdZ_qyTr9Jte9ZGYRQ1M4CdB-mA@mail.gmail.com>
In-Reply-To: <CAFqt6zbOgSm9omt+6iV0GJtZdZ_qyTr9Jte9ZGYRQ1M4CdB-mA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 14 Dec 2018 10:35:35 +0530
Message-ID: <CAFqt6zZ67tFA8FjFZ4xM+YUAez9EdPHinx0ky0X5sQHyZ9nkLg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
To:     rppt@linux.ibm.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, vbabka@suse.cz,
        riel@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Nov 24, 2018 at 10:16 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 7:17 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Nov 06, 2018 at 05:36:42PM +0530, Souptick Joarder wrote:
> > > Page fault handlers are supposed to return VM_FAULT codes,
> > > but some drivers/file systems mistakenly return error
> > > numbers. Now that all drivers/file systems have been converted
> > > to use the vm_fault_t return type, change the type definition
> > > to no longer be compatible with 'int'. By making it an unsigned
> > > int, the function prototype becomes incompatible with a function
> > > which returns int. Sparse will detect any attempts to return a
> > > value which is not a VM_FAULT code.
> > >
> > > VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
> > > to avoid conflict with other VM_FAULT codes.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> > For the docs part
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > > ---
> > > v2: Updated the change log and corrected the document part.
> > >     name added to the enum that kernel-doc able to parse it.
> > >
> > > v3: Corrected the documentation.
>
> If no further comment, can we get this patch in queue for 4.21 ?

Do I need to make any further improvement for this patch ?
>
> > >
> > >  include/linux/mm.h       | 46 ------------------------------
> > >  include/linux/mm_types.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 72 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index fcf9cc9..511a3ce 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -1267,52 +1267,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
> > >  }
> > >
> > >  /*
> > > - * Different kinds of faults, as returned by handle_mm_fault().
> > > - * Used to decide whether a process gets delivered SIGBUS or
> > > - * just gets major/minor fault counters bumped up.
> > > - */
> > > -
> > > -#define VM_FAULT_OOM 0x0001
> > > -#define VM_FAULT_SIGBUS      0x0002
> > > -#define VM_FAULT_MAJOR       0x0004
> > > -#define VM_FAULT_WRITE       0x0008  /* Special case for get_user_pages */
> > > -#define VM_FAULT_HWPOISON 0x0010     /* Hit poisoned small page */
> > > -#define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
> > > -#define VM_FAULT_SIGSEGV 0x0040
> > > -
> > > -#define VM_FAULT_NOPAGE      0x0100  /* ->fault installed the pte, not return page */
> > > -#define VM_FAULT_LOCKED      0x0200  /* ->fault locked the returned page */
> > > -#define VM_FAULT_RETRY       0x0400  /* ->fault blocked, must retry */
> > > -#define VM_FAULT_FALLBACK 0x0800     /* huge page fault failed, fall back to small */
> > > -#define VM_FAULT_DONE_COW   0x1000   /* ->fault has fully handled COW */
> > > -#define VM_FAULT_NEEDDSYNC  0x2000   /* ->fault did not modify page tables
> > > -                                      * and needs fsync() to complete (for
> > > -                                      * synchronous page faults in DAX) */
> > > -
> > > -#define VM_FAULT_ERROR       (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
> > > -                      VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
> > > -                      VM_FAULT_FALLBACK)
> > > -
> > > -#define VM_FAULT_RESULT_TRACE \
> > > -     { VM_FAULT_OOM,                 "OOM" }, \
> > > -     { VM_FAULT_SIGBUS,              "SIGBUS" }, \
> > > -     { VM_FAULT_MAJOR,               "MAJOR" }, \
> > > -     { VM_FAULT_WRITE,               "WRITE" }, \
> > > -     { VM_FAULT_HWPOISON,            "HWPOISON" }, \
> > > -     { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" }, \
> > > -     { VM_FAULT_SIGSEGV,             "SIGSEGV" }, \
> > > -     { VM_FAULT_NOPAGE,              "NOPAGE" }, \
> > > -     { VM_FAULT_LOCKED,              "LOCKED" }, \
> > > -     { VM_FAULT_RETRY,               "RETRY" }, \
> > > -     { VM_FAULT_FALLBACK,            "FALLBACK" }, \
> > > -     { VM_FAULT_DONE_COW,            "DONE_COW" }, \
> > > -     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> > > -
> > > -/* Encode hstate index for a hwpoisoned large page */
> > > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> > > -
> > > -/*
> > >   * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
> > >   */
> > >  extern void pagefault_out_of_memory(void);
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 5ed8f62..cb25016 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -22,7 +22,6 @@
> > >  #endif
> > >  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
> > >
> > > -typedef int vm_fault_t;
> > >
> > >  struct address_space;
> > >  struct mem_cgroup;
> > > @@ -609,6 +608,78 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
> > >
> > >  struct vm_fault;
> > >
> > > +/**
> > > + * typedef vm_fault_t - Return type for page fault handlers.
> > > + *
> > > + * Page fault handlers return a bitmask of %VM_FAULT values.
> > > + */
> > > +typedef __bitwise unsigned int vm_fault_t;
> > > +
> > > +/**
> > > + * enum vm_fault_reason - Page fault handlers return a bitmask of
> > > + * these values to tell the core VM what happened when handling the
> > > + * fault. Used to decide whether a process gets delivered SIGBUS or
> > > + * just gets major/minor fault counters bumped up.
> > > + *
> > > + * @VM_FAULT_OOM:            Out Of Memory
> > > + * @VM_FAULT_SIGBUS:         Bad access
> > > + * @VM_FAULT_MAJOR:          Page read from storage
> > > + * @VM_FAULT_WRITE:          Special case for get_user_pages
> > > + * @VM_FAULT_HWPOISON:               Hit poisoned small page
> > > + * @VM_FAULT_HWPOISON_LARGE: Hit poisoned large page. Index encoded
> > > + *                           in upper bits
> > > + * @VM_FAULT_SIGSEGV:                segmentation fault
> > > + * @VM_FAULT_NOPAGE:         ->fault installed the pte, not return page
> > > + * @VM_FAULT_LOCKED:         ->fault locked the returned page
> > > + * @VM_FAULT_RETRY:          ->fault blocked, must retry
> > > + * @VM_FAULT_FALLBACK:               huge page fault failed, fall back to small
> > > + * @VM_FAULT_DONE_COW:               ->fault has fully handled COW
> > > + * @VM_FAULT_NEEDDSYNC:              ->fault did not modify page tables and needs
> > > + *                           fsync() to complete (for synchronous page faults
> > > + *                           in DAX)
> > > + * @VM_FAULT_HINDEX_MASK:    mask HINDEX value
> > > + *
> > > + */
> > > +enum vm_fault_reason {
> > > +     VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
> > > +     VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
> > > +     VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
> > > +     VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
> > > +     VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
> > > +     VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
> > > +     VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
> > > +     VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
> > > +     VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
> > > +     VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> > > +     VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> > > +     VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> > > +     VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> > > +     VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
> > > +};
> > > +
> > > +/* Encode hstate index for a hwpoisoned large page */
> > > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> > > +
> > > +#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |     \
> > > +                     VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |  \
> > > +                     VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
> > > +
> > > +#define VM_FAULT_RESULT_TRACE \
> > > +     { VM_FAULT_OOM,                 "OOM" },        \
> > > +     { VM_FAULT_SIGBUS,              "SIGBUS" },     \
> > > +     { VM_FAULT_MAJOR,               "MAJOR" },      \
> > > +     { VM_FAULT_WRITE,               "WRITE" },      \
> > > +     { VM_FAULT_HWPOISON,            "HWPOISON" },   \
> > > +     { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },     \
> > > +     { VM_FAULT_SIGSEGV,             "SIGSEGV" },    \
> > > +     { VM_FAULT_NOPAGE,              "NOPAGE" },     \
> > > +     { VM_FAULT_LOCKED,              "LOCKED" },     \
> > > +     { VM_FAULT_RETRY,               "RETRY" },      \
> > > +     { VM_FAULT_FALLBACK,            "FALLBACK" },   \
> > > +     { VM_FAULT_DONE_COW,            "DONE_COW" },   \
> > > +     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> > > +
> > >  struct vm_special_mapping {
> > >       const char *name;       /* The name, e.g. "[vdso]". */
> > >
> > > --
> > > 1.9.1
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
