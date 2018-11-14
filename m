Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A6422360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmIAewWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A6422360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbeKNPP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:15:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46959 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:15:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so10568739lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/Avvau0ON5h8AbXVf3goWHkkaeAhbWYGrGa4nDyp4U=;
        b=fmIAewWDqmBNncgwJKNTaPlkUAsoI3cFBiXQWCVSmDx4z/Nk0QnFWWLXZNlxzs4980
         NJiKW1lKcs0hWv5Xgv5AYjErZ4wMmyRU1jic9oW27mgERu9fS8TG8uSyeafkmqLgUJlm
         VmX8hiqosLrb0OKJVjfowzh03QSi3J0LNIcrT0rffyS2BCo2hgaDTIXrGSO/2uGmN7a4
         sWWFabzvMgjqn+QoA/Ht+70zHk6N6qXty792W5m3E2OnwCYrbjDbGFbXxP65T93WF/YH
         jh9Hi0z/pMjNCaXalKTONutY+olvIVa3Gjk7R3g4cPlZBYtH3LYMFL2Nite1IOeg3njV
         qMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/Avvau0ON5h8AbXVf3goWHkkaeAhbWYGrGa4nDyp4U=;
        b=PWxj4qAKvXcwm8SU1jUdor65Kk+q2sETDst1xMonzfdT1d1lDRRQY/CLOJJWPlRJWE
         MBusXzWgAF+xxpINPuSXEBIsrhzrv4/IrskD+wJwiNeTfoSIh3p3OOXr1iZtMgVjPDQ1
         lK1YE87SU3mqYDhomav6lZOhoHQRPf0mR7Pqq0/iOw1fbnYQDWXgoqy5vF+gz08uwSfD
         SYijF/zdiA77cbT/sMd90kXRFTred+mEa209OnQjpDyG3CZEmfxNW75RJLh/0WqRBqJs
         e71seEXIdyYYy2IcHnfqSORyihRiD8EJ+JzWwSsmv3XByvDgOHTnKwlSceHjquIsVQzN
         bF8w==
X-Gm-Message-State: AGRZ1gKcvLFAQpkUa9BucussPK8E8HcIfmQcADxro7ygTR5UX2rVkP36
        FwpDxE+pArikgsEFStmMp4azKJ6s8Wp9P0Cul4g=
X-Google-Smtp-Source: AJdET5fiT9RU/uTf4yaMBQD4P71EqsxiK46OZF7SIW2b+ZtjU03BLJeSYlGDeMUDdFAGFL+JptcsEKBU0i4nDkDn3fg=
X-Received: by 2002:a19:6514:: with SMTP id z20mr199969lfb.31.1542172427526;
 Tue, 13 Nov 2018 21:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 14 Nov 2018 10:43:34 +0530
Message-ID: <CAFqt6zbwwkvuZypssKQtsKdfZKk3DEQXpA7Qw6yDNakpu=Jv1w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, vbabka@suse.cz,
        riel@redhat.com, rppt@linux.ibm.com
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 5:33 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Page fault handlers are supposed to return VM_FAULT codes,
> but some drivers/file systems mistakenly return error
> numbers. Now that all drivers/file systems have been converted
> to use the vm_fault_t return type, change the type definition
> to no longer be compatible with 'int'. By making it an unsigned
> int, the function prototype becomes incompatible with a function
> which returns int. Sparse will detect any attempts to return a
> value which is not a VM_FAULT code.
>
> VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
> to avoid conflict with other VM_FAULT codes.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any further comment on this patch ?
> ---
> v2: Updated the change log and corrected the document part.
>     name added to the enum that kernel-doc able to parse it.
>
> v3: Corrected the documentation.
>
>  include/linux/mm.h       | 46 ------------------------------
>  include/linux/mm_types.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 47 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fcf9cc9..511a3ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1267,52 +1267,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
>  }
>
>  /*
> - * Different kinds of faults, as returned by handle_mm_fault().
> - * Used to decide whether a process gets delivered SIGBUS or
> - * just gets major/minor fault counters bumped up.
> - */
> -
> -#define VM_FAULT_OOM   0x0001
> -#define VM_FAULT_SIGBUS        0x0002
> -#define VM_FAULT_MAJOR 0x0004
> -#define VM_FAULT_WRITE 0x0008  /* Special case for get_user_pages */
> -#define VM_FAULT_HWPOISON 0x0010       /* Hit poisoned small page */
> -#define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
> -#define VM_FAULT_SIGSEGV 0x0040
> -
> -#define VM_FAULT_NOPAGE        0x0100  /* ->fault installed the pte, not return page */
> -#define VM_FAULT_LOCKED        0x0200  /* ->fault locked the returned page */
> -#define VM_FAULT_RETRY 0x0400  /* ->fault blocked, must retry */
> -#define VM_FAULT_FALLBACK 0x0800       /* huge page fault failed, fall back to small */
> -#define VM_FAULT_DONE_COW   0x1000     /* ->fault has fully handled COW */
> -#define VM_FAULT_NEEDDSYNC  0x2000     /* ->fault did not modify page tables
> -                                        * and needs fsync() to complete (for
> -                                        * synchronous page faults in DAX) */
> -
> -#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
> -                        VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
> -                        VM_FAULT_FALLBACK)
> -
> -#define VM_FAULT_RESULT_TRACE \
> -       { VM_FAULT_OOM,                 "OOM" }, \
> -       { VM_FAULT_SIGBUS,              "SIGBUS" }, \
> -       { VM_FAULT_MAJOR,               "MAJOR" }, \
> -       { VM_FAULT_WRITE,               "WRITE" }, \
> -       { VM_FAULT_HWPOISON,            "HWPOISON" }, \
> -       { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" }, \
> -       { VM_FAULT_SIGSEGV,             "SIGSEGV" }, \
> -       { VM_FAULT_NOPAGE,              "NOPAGE" }, \
> -       { VM_FAULT_LOCKED,              "LOCKED" }, \
> -       { VM_FAULT_RETRY,               "RETRY" }, \
> -       { VM_FAULT_FALLBACK,            "FALLBACK" }, \
> -       { VM_FAULT_DONE_COW,            "DONE_COW" }, \
> -       { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> -
> -/* Encode hstate index for a hwpoisoned large page */
> -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> -
> -/*
>   * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
>   */
>  extern void pagefault_out_of_memory(void);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f62..cb25016 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -22,7 +22,6 @@
>  #endif
>  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
>
> -typedef int vm_fault_t;
>
>  struct address_space;
>  struct mem_cgroup;
> @@ -609,6 +608,78 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>
>  struct vm_fault;
>
> +/**
> + * typedef vm_fault_t - Return type for page fault handlers.
> + *
> + * Page fault handlers return a bitmask of %VM_FAULT values.
> + */
> +typedef __bitwise unsigned int vm_fault_t;
> +
> +/**
> + * enum vm_fault_reason - Page fault handlers return a bitmask of
> + * these values to tell the core VM what happened when handling the
> + * fault. Used to decide whether a process gets delivered SIGBUS or
> + * just gets major/minor fault counters bumped up.
> + *
> + * @VM_FAULT_OOM:              Out Of Memory
> + * @VM_FAULT_SIGBUS:           Bad access
> + * @VM_FAULT_MAJOR:            Page read from storage
> + * @VM_FAULT_WRITE:            Special case for get_user_pages
> + * @VM_FAULT_HWPOISON:         Hit poisoned small page
> + * @VM_FAULT_HWPOISON_LARGE:   Hit poisoned large page. Index encoded
> + *                             in upper bits
> + * @VM_FAULT_SIGSEGV:          segmentation fault
> + * @VM_FAULT_NOPAGE:           ->fault installed the pte, not return page
> + * @VM_FAULT_LOCKED:           ->fault locked the returned page
> + * @VM_FAULT_RETRY:            ->fault blocked, must retry
> + * @VM_FAULT_FALLBACK:         huge page fault failed, fall back to small
> + * @VM_FAULT_DONE_COW:         ->fault has fully handled COW
> + * @VM_FAULT_NEEDDSYNC:                ->fault did not modify page tables and needs
> + *                             fsync() to complete (for synchronous page faults
> + *                             in DAX)
> + * @VM_FAULT_HINDEX_MASK:      mask HINDEX value
> + *
> + */
> +enum vm_fault_reason {
> +       VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
> +       VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
> +       VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
> +       VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
> +       VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
> +       VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
> +       VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
> +       VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
> +       VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
> +       VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> +       VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> +       VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> +       VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> +       VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
> +};
> +
> +/* Encode hstate index for a hwpoisoned large page */
> +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> +
> +#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |       \
> +                       VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |  \
> +                       VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
> +
> +#define VM_FAULT_RESULT_TRACE \
> +       { VM_FAULT_OOM,                 "OOM" },        \
> +       { VM_FAULT_SIGBUS,              "SIGBUS" },     \
> +       { VM_FAULT_MAJOR,               "MAJOR" },      \
> +       { VM_FAULT_WRITE,               "WRITE" },      \
> +       { VM_FAULT_HWPOISON,            "HWPOISON" },   \
> +       { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },     \
> +       { VM_FAULT_SIGSEGV,             "SIGSEGV" },    \
> +       { VM_FAULT_NOPAGE,              "NOPAGE" },     \
> +       { VM_FAULT_LOCKED,              "LOCKED" },     \
> +       { VM_FAULT_RETRY,               "RETRY" },      \
> +       { VM_FAULT_FALLBACK,            "FALLBACK" },   \
> +       { VM_FAULT_DONE_COW,            "DONE_COW" },   \
> +       { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> +
>  struct vm_special_mapping {
>         const char *name;       /* The name, e.g. "[vdso]". */
>
> --
> 1.9.1
>
