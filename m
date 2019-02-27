Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA841C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZRjqpNhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfB0SQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:16:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39952 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfB0SQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:16:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id x187so14224387oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jduC5z2C7V6sAQFmlj3QowckWvFnK+wIh47Kw//a90k=;
        b=ZRjqpNhiDpAW/JYX2jEYW9MyYvr9j8EyohjSFh+tEF/tbUhxvCZ35z2pWtXJvmp5gW
         UoHkd1GXosRpf8Pa+aQm2tkGvEYZjsuUofV0nbl58AiBetV8AqKfNN9+hYdRAXEXVwI8
         H1FMfDOS4HNbnRL3uP5tyMqKCF/DNN5/JTDtP/3s55mGfBhAsMYypGFs8Abejx41KnQ5
         cljdqwN6prKzdE2hL+2yMoEB++7j5OAH0FpmWEDRh4JTB6ohfLRMua2jg6A0zBRxbVa4
         yIUSgM14hLi4KTTyiGVlyc4mwfv8w0r4W/CQw/4HXyoJndn20UW29NrIcm0r3SAWAcYW
         CKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jduC5z2C7V6sAQFmlj3QowckWvFnK+wIh47Kw//a90k=;
        b=ZUI1gc7ThUUkWxg+2qCmnVoc14/FIZlccN/9RisO0FWltQAvT2Q/UralZD3T9zQCWI
         BVa38kXikpNxGCWK+Rl29ACYCcpcCsTpOVJKoYvbmUtcnqyIWwRHGfIXygZ+laMWg+4b
         9wWRzJpLYNuJSlTZgh9CaGpVY2H99ZAqtjSWo2USG8EV961cEp0g6grW/jXrJAkhg3gJ
         AiZAW6bEcHJpGri9uzY2fUHhYdf//xf6Lgu6AaSDmaJUAxiQFvrHuf89C1Aip7Fir3rs
         /yEG2kwhXJJ3l+hSd6gXVSYjanOrkQXft0oA6eSzGO82fsG85/DTwl30Du91s64DpLWR
         tTEw==
X-Gm-Message-State: AHQUAuYMaW0w10zwtKkhXZkso4uizeMv3wQJ1mWh/aP6ceteLqo8YZjU
        5KI45D9L//75nPwGpepGho9ILD64U5O+UFK8i5z+lg==
X-Google-Smtp-Source: AHgI3Ib1BE59qyBQBuiCi3sBVRCL5KDOlm/7PidJE0VrGtB3oddJC/s6afaZ8c4kclho7H94t0XnXFYvKo/Yp4PHYzA=
X-Received: by 2002:aca:4a10:: with SMTP id x16mr363905oia.73.1551291409967;
 Wed, 27 Feb 2019 10:16:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
 <20190216153511.GM12668@bombadil.infradead.org> <20190216172948.GN12668@bombadil.infradead.org>
In-Reply-To: <20190216172948.GN12668@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Feb 2019 10:16:28 -0800
Message-ID: <CAPcyv4jMP5sB7Sz9b1y7r7+SCBJuGizViLNW-4=amc9JXCWMSQ@mail.gmail.com>
Subject: Re: find_get_entries_tag regression bisected
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 9:29 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Feb 16, 2019 at 07:35:11AM -0800, Matthew Wilcox wrote:
> > Another way to fix this would be to mask the address in dax_entry_mkclean(),
> > but I think this is cleaner.
>
> That's clearly rubbish, dax_entry_mkclean() can't possibly mask the
> address.  It might be mis-aligned in another process.  But ... if it's
> misaligned in another process, dax_entry_mkclean() will only clean the first
> PTE associated with the PMD; it won't clean the whole thing.  I think we need
> something like this:
>
> (I'll have to split it apart to give us something to backport)

Looks good to me, care to send a formal patch?

Tested-by: Dan Williams <dan.j.williams@intel.com>


>
> diff --git a/fs/dax.c b/fs/dax.c
> index 6959837cc465..09680aa0481f 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -768,7 +768,7 @@ unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
>
>  /* Walk all mappings of a given index of a file and writeprotect them */
>  static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
> -               unsigned long pfn)
> +               pgoff_t end, unsigned long pfn)
>  {
>         struct vm_area_struct *vma;
>         pte_t pte, *ptep = NULL;
> @@ -776,7 +776,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>         spinlock_t *ptl;
>
>         i_mmap_lock_read(mapping);
> -       vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
> +       vma_interval_tree_foreach(vma, &mapping->i_mmap, index, end) {
>                 struct mmu_notifier_range range;
>                 unsigned long address;
>
> @@ -843,9 +843,9 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>                 struct address_space *mapping, void *entry)
>  {
> -       unsigned long pfn;
> +       unsigned long pfn, index;
>         long ret = 0;
> -       size_t size;
> +       unsigned long count;
>
>         /*
>          * A page got tagged dirty in DAX mapping? Something is seriously
> @@ -894,17 +894,18 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>         xas_unlock_irq(xas);
>
>         /*
> -        * Even if dax_writeback_mapping_range() was given a wbc->range_start
> -        * in the middle of a PMD, the 'index' we are given will be aligned to
> -        * the start index of the PMD, as will the pfn we pull from 'entry'.
> +        * If dax_writeback_mapping_range() was given a wbc->range_start
> +        * in the middle of a PMD, the 'index' we are given needs to be
> +        * aligned to the start index of the PMD.
>          * This allows us to flush for PMD_SIZE and not have to worry about
>          * partial PMD writebacks.
>          */
>         pfn = dax_to_pfn(entry);
> -       size = PAGE_SIZE << dax_entry_order(entry);
> +       count = 1UL << dax_entry_order(entry);
> +       index = xas->xa_index &~ (count - 1);
>
> -       dax_entry_mkclean(mapping, xas->xa_index, pfn);
> -       dax_flush(dax_dev, page_address(pfn_to_page(pfn)), size);
> +       dax_entry_mkclean(mapping, index, index + count - 1, pfn);
> +       dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
>         /*
>          * After we have flushed the cache, we can clear the dirty tag. There
>          * cannot be new dirty data in the pfn after the flush has completed as
> @@ -917,8 +918,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>         xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
>         dax_wake_entry(xas, entry, false);
>
> -       trace_dax_writeback_one(mapping->host, xas->xa_index,
> -                       size >> PAGE_SHIFT);
> +       trace_dax_writeback_one(mapping->host, xas->xa_index, count);
>         return ret;
>
>   put_unlocked:
>
