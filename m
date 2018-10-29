Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42052080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cY2+bZ6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42052080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJ3HQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:16:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37755 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeJ3HQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:16:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id w66-v6so4331865oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+FNmrGMnhAt1VV5t/xKk65qEiK+YvqDLz2tQRn6SF8=;
        b=cY2+bZ6DdqBMpUFeEZYyVzyfUjOLGuhdJzeB4Wz4NUlgWYTQJ5DdfOFUdU5fG11xF0
         uRI/QmjDT30HXRgfowluVDIoS3ch3EZzxNKi9SyK/tXcsma6ZQWNOryvHoWj4veGymIJ
         2RBRhVfjNTqHNMkL6lCHZPLmZFB8Qe8JxVB4Vj2p+hhz1yczmIJTtSsMReDl4P1hydUm
         4oY3WLwkZz3PFJMB2kLnAu8lx3nG13mxT/qJvH/ZPkyDi2HDogQ2Xg8Mn4IZmYGnYmap
         EzbBApgKJ9AmheVPasvPfDt1XYiIqy8x+Qeq6zVBMN7uZrmxvr7JOXCYyUpIIgGP06Ec
         RRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+FNmrGMnhAt1VV5t/xKk65qEiK+YvqDLz2tQRn6SF8=;
        b=NUw7Jxzp4ujINAYXb0f5Nf2b5YDmOApy/q94MH2vwwgF52WUeEZtA8ahDlrm73FQEY
         t2SNBIXG9LSxlNsLjU+nT6SXQ2t7tGiK14pTga/hxH8ppviaOyZ6N0X5qCv4tLlq6qLf
         PBaQ4iwjv1GGiX+jH6ZUcrYlnEjOqzns4zYLG0VNtWw9tcYuln8ogOooOt8w2p3U7R4M
         03GHeU++exDfiQVuCa0r7L6RYkRWigaH1HwqOoM59rl46Ss11SLA1hECLZmL6z9Mp/GJ
         cHu1HSsKooaM3BaOKScGwGWN8V+qm6Ju53Zd4TxVtnSb3dpVnmtTrWPhcOjA3vJgxF3x
         CBsg==
X-Gm-Message-State: AGRZ1gK8KyqOkIloN6G7S/6DiWHW2Xf928aehAtxUdUfQzWkjewdedVp
        kTDanETRncNqnjctTeqfSq9IDCxT/Hy7q96xUW7pDQ==
X-Google-Smtp-Source: AJdET5e/sjQ/ELXAjtRHUPic1NWLIBYqETclNys6T6w31Zaj2x5O3v4qD4Lgnd9G9HJr9357qULdtn6OUdPNFlHR+WM=
X-Received: by 2002:aca:ead4:: with SMTP id i203-v6mr10088894oih.149.1540851954211;
 Mon, 29 Oct 2018 15:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181029210716.212159-1-brho@google.com>
In-Reply-To: <20181029210716.212159-1-brho@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Oct 2018 15:25:42 -0700
Message-ID: <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
To:     Barret Rhoden <brho@google.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:07 PM Barret Rhoden <brho@google.com> wrote:
>
> This change allows KVM to map DAX-backed files made of huge pages with
> huge mappings in the EPT/TDP.
>
> DAX pages are not PageTransCompound.  The existing check is trying to
> determine if the mapping for the pfn is a huge mapping or not.  For
> non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
>
> For DAX, we can check the page table itself.  Actually, we might always
> be able to walk the page table, even for PageTransCompound pages, but
> it's probably a little slower.
>
> Note that KVM already faulted in the page (or huge page) in the host's
> page table, and we hold the KVM mmu spinlock (grabbed before checking
> the mmu seq).  Based on the other comments about not worrying about a
> pmd split, we might be able to safely walk the page table without
> holding the mm sem.
>
> This patch relies on kvm_is_reserved_pfn() being false for DAX pages,
> which I've hacked up for testing this code.  That change should
> eventually happen:
>
> https://lore.kernel.org/lkml/20181022084659.GA84523@tiger-server/
>
> Another issue is that kvm_mmu_zap_collapsible_spte() also uses
> PageTransCompoundMap() to detect huge pages, but we don't have a way to
> get the HVA easily.  Can we just aggressively zap DAX pages there?
>
> Alternatively, is there a better way to track at the struct page level
> whether or not a page is huge-mapped?  Maybe the DAX huge pages mark
> themselves as TransCompound or something similar, and we don't need to
> special case DAX/ZONE_DEVICE pages.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  arch/x86/kvm/mmu.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index cf5f572f2305..9f3e0f83a2dd 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -3152,6 +3152,75 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>         return -EFAULT;
>  }
>
> +static unsigned long pgd_mapping_size(struct mm_struct *mm, unsigned long addr)
> +{
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       pte_t *pte;
> +
> +       pgd = pgd_offset(mm, addr);
> +       if (!pgd_present(*pgd))
> +               return 0;
> +
> +       p4d = p4d_offset(pgd, addr);
> +       if (!p4d_present(*p4d))
> +               return 0;
> +       if (p4d_huge(*p4d))
> +               return P4D_SIZE;
> +
> +       pud = pud_offset(p4d, addr);
> +       if (!pud_present(*pud))
> +               return 0;
> +       if (pud_huge(*pud))
> +               return PUD_SIZE;
> +
> +       pmd = pmd_offset(pud, addr);
> +       if (!pmd_present(*pmd))
> +               return 0;
> +       if (pmd_huge(*pmd))
> +               return PMD_SIZE;
> +
> +       pte = pte_offset_map(pmd, addr);
> +       if (!pte_present(*pte))
> +               return 0;
> +       return PAGE_SIZE;
> +}
> +
> +static bool pfn_is_pmd_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
> +{
> +       struct page *page = pfn_to_page(pfn);
> +       unsigned long hva, map_sz;
> +
> +       if (!is_zone_device_page(page))
> +               return PageTransCompoundMap(page);
> +
> +       /*
> +        * DAX pages do not use compound pages.  The page should have already
> +        * been mapped into the host-side page table during try_async_pf(), so
> +        * we can check the page tables directly.
> +        */
> +       hva = gfn_to_hva(kvm, gfn);
> +       if (kvm_is_error_hva(hva))
> +               return false;
> +
> +       /*
> +        * Our caller grabbed the KVM mmu_lock with a successful
> +        * mmu_notifier_retry, so we're safe to walk the page table.
> +        */
> +       map_sz = pgd_mapping_size(current->mm, hva);
> +       switch (map_sz) {
> +       case PMD_SIZE:
> +               return true;
> +       case P4D_SIZE:
> +       case PUD_SIZE:
> +               printk_once(KERN_INFO "KVM THP promo found a very large page");

Why not allow PUD_SIZE? The device-dax interface supports PUD mappings.

> +               return false;
> +       }
> +       return false;
> +}

The above 2 functions are  similar to what we need to do for
determining the blast radius of a memory error, see
dev_pagemap_mapping_shift() and its usage in add_to_kill().

> +
>  static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
>                                         gfn_t *gfnp, kvm_pfn_t *pfnp,
>                                         int *levelp)
> @@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
>          */
>         if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
>             level == PT_PAGE_TABLE_LEVEL &&
> -           PageTransCompoundMap(pfn_to_page(pfn)) &&
> +           pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&

I'm wondering if we're adding an explicit is_zone_device_page() check
in this path to determine the page mapping size if that can be a
replacement for the kvm_is_reserved_pfn() check. In other words, the
goal of fixing up PageReserved() was to preclude the need for DAX-page
special casing in KVM, but if we already need add some special casing
for page size determination, might as well bypass the
kvm_is_reserved_pfn() dependency as well.
