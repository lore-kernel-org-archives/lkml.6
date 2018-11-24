Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D1720663
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amFD8K47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D1720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeKXPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 10:33:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44402 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbeKXPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 10:33:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so12146148lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 20:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwL+uTqoULJRP/wlKmnrLAip98cxafdXhNpq3LGDt7U=;
        b=amFD8K47mQSieu22uNZyShZcPpHoPoUAw1PJ4eMiUeklPBc/XpCOmh25+C/Cv2QwP3
         gn6MDLoT49yS4efRjuB5vsC0hWU96yx1JAEr2FTw7FGhJWy2g4dy1oi9W+bhiYhokYVh
         SCp6xnrBM+BEaWNJFO7b9QJBRRWFTXrbnTkhv0AkU+z9Qt3kP0rK9V3OQGWZZZVUGl2O
         HdmcUBLRMQTi9yCMoEMI5if9rZ4Fb8M8IhSUHn3rxjZbrMYzF5+oegK7idaHFfHgmg+r
         q45bhEgepca5x0qhsp26IjHC43jAulvp5D7hk+7YaAXXzquZzzu21TYVcsqneaOWEtV6
         CiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwL+uTqoULJRP/wlKmnrLAip98cxafdXhNpq3LGDt7U=;
        b=RD4fBooqv4jK4cZfxe3LKiezYPGjU7tgZMRY5lz9A4dt1bFZsmFZuhy4VtpeJXb+fW
         1btWXNHFhesUm2VX4CRFLna+rGyKP2uWqg3MPlEPEv4VWocO+dHY4BV8wkEF/gqew2eX
         xTINz4P5C0UWtC+oUIbFRim060u5WdKCJfm1aM8x0SetqauIjFvd812oLpDTUHorzm/J
         tAKkrcitbv9qAeMxJRKXc+d3qdmKwxisATJ585wEIckQnc3aUE9G8C0wn3bo3YflXjzW
         OLjVm25yPEmqfMTR63eNYT1j6+YgmTPyjjuydXO+DxQtifr4NqNzuhtfPzpv6RZJidln
         0cDA==
X-Gm-Message-State: AA+aEWZApPIKqTDZmiKcGlgs0k8U4Br1oesSvJUoxeS84qZdNV3V+fbO
        Gz9kqPqRUiwz33MxcsQ0ADsoUCG0+1m/E1mkp88=
X-Google-Smtp-Source: AFSGD/V2iHJgXmWZzEkeG7AlipUVZXpImcOPguKbR1UQOMplZGdKuI1HyHJt6+O4V6Fec4iVx4rLdquYLAz03zNqoC4=
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr11487072ljw.75.1543034781802;
 Fri, 23 Nov 2018 20:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC> <20181115014737.GA2353@rapoport-lnx>
In-Reply-To: <20181115014737.GA2353@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 24 Nov 2018 10:16:06 +0530
Message-ID: <CAFqt6zbOgSm9omt+6iV0GJtZdZ_qyTr9Jte9ZGYRQ1M4CdB-mA@mail.gmail.com>
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

On Thu, Nov 15, 2018 at 7:17 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Nov 06, 2018 at 05:36:42PM +0530, Souptick Joarder wrote:
> > Page fault handlers are supposed to return VM_FAULT codes,
> > but some drivers/file systems mistakenly return error
> > numbers. Now that all drivers/file systems have been converted
> > to use the vm_fault_t return type, change the type definition
> > to no longer be compatible with 'int'. By making it an unsigned
> > int, the function prototype becomes incompatible with a function
> > which returns int. Sparse will detect any attempts to return a
> > value which is not a VM_FAULT code.
> >
> > VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
> > to avoid conflict with other VM_FAULT codes.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> For the docs part
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
>
> > ---
> > v2: Updated the change log and corrected the document part.
> >     name added to the enum that kernel-doc able to parse it.
> >
> > v3: Corrected the documentation.

If no further comment, can we get this patch in queue for 4.21 ?

> >
> >  include/linux/mm.h       | 46 ------------------------------
> >  include/linux/mm_types.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 72 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index fcf9cc9..511a3ce 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1267,52 +1267,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
> >  }
> >
> >  /*
> > - * Different kinds of faults, as returned by handle_mm_fault().
> > - * Used to decide whether a process gets delivered SIGBUS or
> > - * just gets major/minor fault counters bumped up.
> > - */
> > -
> > -#define VM_FAULT_OOM 0x0001
> > -#define VM_FAULT_SIGBUS      0x0002
> > -#define VM_FAULT_MAJOR       0x0004
> > -#define VM_FAULT_WRITE       0x0008  /* Special case for get_user_pages */
> > -#define VM_FAULT_HWPOISON 0x0010     /* Hit poisoned small page */
> > -#define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
> > -#define VM_FAULT_SIGSEGV 0x0040
> > -
> > -#define VM_FAULT_NOPAGE      0x0100  /* ->fault installed the pte, not return page */
> > -#define VM_FAULT_LOCKED      0x0200  /* ->fault locked the returned page */
> > -#define VM_FAULT_RETRY       0x0400  /* ->fault blocked, must retry */
> > -#define VM_FAULT_FALLBACK 0x0800     /* huge page fault failed, fall back to small */
> > -#define VM_FAULT_DONE_COW   0x1000   /* ->fault has fully handled COW */
> > -#define VM_FAULT_NEEDDSYNC  0x2000   /* ->fault did not modify page tables
> > -                                      * and needs fsync() to complete (for
> > -                                      * synchronous page faults in DAX) */
> > -
> > -#define VM_FAULT_ERROR       (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
> > -                      VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
> > -                      VM_FAULT_FALLBACK)
> > -
> > -#define VM_FAULT_RESULT_TRACE \
> > -     { VM_FAULT_OOM,                 "OOM" }, \
> > -     { VM_FAULT_SIGBUS,              "SIGBUS" }, \
> > -     { VM_FAULT_MAJOR,               "MAJOR" }, \
> > -     { VM_FAULT_WRITE,               "WRITE" }, \
> > -     { VM_FAULT_HWPOISON,            "HWPOISON" }, \
> > -     { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" }, \
> > -     { VM_FAULT_SIGSEGV,             "SIGSEGV" }, \
> > -     { VM_FAULT_NOPAGE,              "NOPAGE" }, \
> > -     { VM_FAULT_LOCKED,              "LOCKED" }, \
> > -     { VM_FAULT_RETRY,               "RETRY" }, \
> > -     { VM_FAULT_FALLBACK,            "FALLBACK" }, \
> > -     { VM_FAULT_DONE_COW,            "DONE_COW" }, \
> > -     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> > -
> > -/* Encode hstate index for a hwpoisoned large page */
> > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> > -
> > -/*
> >   * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
> >   */
> >  extern void pagefault_out_of_memory(void);
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5ed8f62..cb25016 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -22,7 +22,6 @@
> >  #endif
> >  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
> >
> > -typedef int vm_fault_t;
> >
> >  struct address_space;
> >  struct mem_cgroup;
> > @@ -609,6 +608,78 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
> >
> >  struct vm_fault;
> >
> > +/**
> > + * typedef vm_fault_t - Return type for page fault handlers.
> > + *
> > + * Page fault handlers return a bitmask of %VM_FAULT values.
> > + */
> > +typedef __bitwise unsigned int vm_fault_t;
> > +
> > +/**
> > + * enum vm_fault_reason - Page fault handlers return a bitmask of
> > + * these values to tell the core VM what happened when handling the
> > + * fault. Used to decide whether a process gets delivered SIGBUS or
> > + * just gets major/minor fault counters bumped up.
> > + *
> > + * @VM_FAULT_OOM:            Out Of Memory
> > + * @VM_FAULT_SIGBUS:         Bad access
> > + * @VM_FAULT_MAJOR:          Page read from storage
> > + * @VM_FAULT_WRITE:          Special case for get_user_pages
> > + * @VM_FAULT_HWPOISON:               Hit poisoned small page
> > + * @VM_FAULT_HWPOISON_LARGE: Hit poisoned large page. Index encoded
> > + *                           in upper bits
> > + * @VM_FAULT_SIGSEGV:                segmentation fault
> > + * @VM_FAULT_NOPAGE:         ->fault installed the pte, not return page
> > + * @VM_FAULT_LOCKED:         ->fault locked the returned page
> > + * @VM_FAULT_RETRY:          ->fault blocked, must retry
> > + * @VM_FAULT_FALLBACK:               huge page fault failed, fall back to small
> > + * @VM_FAULT_DONE_COW:               ->fault has fully handled COW
> > + * @VM_FAULT_NEEDDSYNC:              ->fault did not modify page tables and needs
> > + *                           fsync() to complete (for synchronous page faults
> > + *                           in DAX)
> > + * @VM_FAULT_HINDEX_MASK:    mask HINDEX value
> > + *
> > + */
> > +enum vm_fault_reason {
> > +     VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
> > +     VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
> > +     VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
> > +     VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
> > +     VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
> > +     VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
> > +     VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
> > +     VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
> > +     VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
> > +     VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> > +     VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> > +     VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> > +     VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> > +     VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
> > +};
> > +
> > +/* Encode hstate index for a hwpoisoned large page */
> > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> > +
> > +#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |     \
> > +                     VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |  \
> > +                     VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
> > +
> > +#define VM_FAULT_RESULT_TRACE \
> > +     { VM_FAULT_OOM,                 "OOM" },        \
> > +     { VM_FAULT_SIGBUS,              "SIGBUS" },     \
> > +     { VM_FAULT_MAJOR,               "MAJOR" },      \
> > +     { VM_FAULT_WRITE,               "WRITE" },      \
> > +     { VM_FAULT_HWPOISON,            "HWPOISON" },   \
> > +     { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },     \
> > +     { VM_FAULT_SIGSEGV,             "SIGSEGV" },    \
> > +     { VM_FAULT_NOPAGE,              "NOPAGE" },     \
> > +     { VM_FAULT_LOCKED,              "LOCKED" },     \
> > +     { VM_FAULT_RETRY,               "RETRY" },      \
> > +     { VM_FAULT_FALLBACK,            "FALLBACK" },   \
> > +     { VM_FAULT_DONE_COW,            "DONE_COW" },   \
> > +     { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> > +
> >  struct vm_special_mapping {
> >       const char *name;       /* The name, e.g. "[vdso]". */
> >
> > --
> > 1.9.1
> >
>
> --
> Sincerely yours,
> Mike.
>
