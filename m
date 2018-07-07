Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A0C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F906208A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIILAAky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F906208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754424AbeGGXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 19:23:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37753 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeGGXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 19:23:06 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so13975073ioh.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zR2EK1IXekiwZXi1ed05RYOYPIy2NQuN9vwRO80F7U=;
        b=MIILAAkyJuRlm8oFdAzpSlQ2QSQPaZu1UotqOfZyIF5eC7EA89Gt9ohKPzT9jShp9y
         r9Uiq7s2GHmACXTWfBqO/jZ/oVE89euKaRqACS3/HruXOqwhqdnPxnrPHfgY1ZvocbXL
         IbB/9yOerJ6IWUgsAY7GC0Vfjcs3DINgRpOAIoBvfKNvYg/Y2pDIP/1huM22kWi2liJ4
         CyfbifQkmOmE3m5QC0nFGl8V9jugPVIrh9SaxTPsPQeke+Tr52OglXt3vl1XdNp44pLx
         79aGm9ITwQwf2WIt5ano+Py3bHURxJyfPMg1MvUU0ccw1yRBxhPoSHZPOPlf1Q7Sf2Z5
         i7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zR2EK1IXekiwZXi1ed05RYOYPIy2NQuN9vwRO80F7U=;
        b=iOmu0R+BBN3Kl72oTvAwjSVIhxZ1eG0qbKxyHaSXg+QSysxx+XFxHbkGX7TUXCZ6/f
         VqCDxjSmY8SEKN84vWu6fWK7Q1KD+GK5y3hOXkQ6UMPr0uw/nbRCU/pzPhvVLfi3hIEh
         bigYA3S8DwUTlBAFfXkPMOqyeotitAN1gPA/tifeqlMeNWxKVivuLF2CrLDMCvsC9gS/
         f0E12A/JNUd2RFrvotO6gPqusCV/KAe6x6UyWylXIQbCcw8tsUQ34/6jATjOH5kvsMWa
         kDLnS3+RThe4LbyGni0SGI8gczv04WCWtaP9IAmIsgsahvP4n/PVyzFQEXa2nsqN1fpU
         WPIA==
X-Gm-Message-State: AOUpUlFRnvvrdmHcAI+fDapS/J3B8mrRhjPHZL9o1onGNNq9i7sOLUk9
        jgplxm5oIZ/kJLwVgBHy1+LgWUcnc5rlM0NVytY=
X-Google-Smtp-Source: AAOMgpdKy35aFiTnVOA9iyvhGQE25FhBe+oNE+ijyQpKGERoFO5CnYz2cAcgi3KNiiyfu1QOsIobJrcDQrkAN84fUH4=
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr4360552iov.56.1531005785987;
 Sat, 07 Jul 2018 16:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180622035151.6676-1-ying.huang@intel.com> <20180622035151.6676-4-ying.huang@intel.com>
In-Reply-To: <20180622035151.6676-4-ying.huang@intel.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Sat, 7 Jul 2018 16:22:54 -0700
Message-ID: <CAA9_cmc2YteXBhrLOFN0rAZ4UFDRPcXaE1OPNv06P+Fu9e+zeA@mail.gmail.com>
Subject: Re: [PATCH -mm -v4 03/21] mm, THP, swap: Support PMD swap mapping in swap_duplicate()
To:     ying.huang@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, hughd@google.com,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, zi.yan@cs.rutgers.edu,
        daniel.m.jordan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> From: Huang Ying <ying.huang@intel.com>
>
> To support to swapin the THP as a whole, we need to create PMD swap
> mapping during swapout, and maintain PMD swap mapping count.  This
> patch implements the support to increase the PMD swap mapping
> count (for swapout, fork, etc.)  and set SWAP_HAS_CACHE flag (for
> swapin, etc.) for a huge swap cluster in swap_duplicate() function
> family.  Although it only implements a part of the design of the swap
> reference count with PMD swap mapping, the whole design is described
> as follow to make it easy to understand the patch and the whole
> picture.
>
> A huge swap cluster is used to hold the contents of a swapouted THP.
> After swapout, a PMD page mapping to the THP will become a PMD
> swap mapping to the huge swap cluster via a swap entry in PMD.  While
> a PTE page mapping to a subpage of the THP will become the PTE swap
> mapping to a swap slot in the huge swap cluster via a swap entry in
> PTE.
>
> If there is no PMD swap mapping and the corresponding THP is removed
> from the page cache (reclaimed), the huge swap cluster will be split
> and become a normal swap cluster.
>
> The count (cluster_count()) of the huge swap cluster is
> SWAPFILE_CLUSTER (= HPAGE_PMD_NR) + PMD swap mapping count.  Because
> all swap slots in the huge swap cluster are mapped by PTE or PMD, or
> has SWAP_HAS_CACHE bit set, the usage count of the swap cluster is
> HPAGE_PMD_NR.  And the PMD swap mapping count is recorded too to make
> it easy to determine whether there are remaining PMD swap mappings.
>
> The count in swap_map[offset] is the sum of PTE and PMD swap mapping
> count.  This means when we increase the PMD swap mapping count, we
> need to increase swap_map[offset] for all swap slots inside the swap
> cluster.  An alternative choice is to make swap_map[offset] to record
> PTE swap map count only, given we have recorded PMD swap mapping count
> in the count of the huge swap cluster.  But this need to increase
> swap_map[offset] when splitting the PMD swap mapping, that may fail
> because of memory allocation for swap count continuation.  That is
> hard to dealt with.  So we choose current solution.
>
> The PMD swap mapping to a huge swap cluster may be split when unmap a
> part of PMD mapping etc.  That is easy because only the count of the
> huge swap cluster need to be changed.  When the last PMD swap mapping
> is gone and SWAP_HAS_CACHE is unset, we will split the huge swap
> cluster (clear the huge flag).  This makes it easy to reason the
> cluster state.
>
> A huge swap cluster will be split when splitting the THP in swap
> cache, or failing to allocate THP during swapin, etc.  But when
> splitting the huge swap cluster, we will not try to split all PMD swap
> mappings, because we haven't enough information available for that
> sometimes.  Later, when the PMD swap mapping is duplicated or swapin,
> etc, the PMD swap mapping will be split and fallback to the PTE
> operation.
>
> When a THP is added into swap cache, the SWAP_HAS_CACHE flag will be
> set in the swap_map[offset] of all swap slots inside the huge swap
> cluster backing the THP.  This huge swap cluster will not be split
> unless the THP is split even if its PMD swap mapping count dropped to
> 0.  Later, when the THP is removed from swap cache, the SWAP_HAS_CACHE
> flag will be cleared in the swap_map[offset] of all swap slots inside
> the huge swap cluster.  And this huge swap cluster will be split if
> its PMD swap mapping count is 0.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  include/linux/huge_mm.h |   5 +
>  include/linux/swap.h    |   9 +-
>  mm/memory.c             |   2 +-
>  mm/rmap.c               |   2 +-
>  mm/swap_state.c         |   2 +-
>  mm/swapfile.c           | 287 +++++++++++++++++++++++++++++++++---------------
>  6 files changed, 214 insertions(+), 93 deletions(-)

I'm probably missing some background, but I find the patch hard to
read. Can you disseminate some of this patch changelog into kernel-doc
commentary so it's easier to follow which helpers do what relative to
THP swap.

>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index d3bbf6bea9e9..213d32e57c39 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -80,6 +80,11 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>
> +static inline bool thp_swap_supported(void)
> +{
> +       return IS_ENABLED(CONFIG_THP_SWAP);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
>  #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f73eafcaf4e9..57aa655ab27d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -451,8 +451,8 @@ extern swp_entry_t get_swap_page_of_type(int);
>  extern int get_swap_pages(int n, bool cluster, swp_entry_t swp_entries[]);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
> -extern int swap_duplicate(swp_entry_t);
> -extern int swapcache_prepare(swp_entry_t);
> +extern int swap_duplicate(swp_entry_t *entry, bool cluster);

This patch introduces a new flag to swap_duplicate(), but then all all
usages still pass 'false' so why does this patch change the argument.
Seems this change belongs to another patch?

> +extern int swapcache_prepare(swp_entry_t entry, bool cluster);

Rather than add a cluster flag to these helpers can the swp_entry_t
carry the cluster flag directly?
