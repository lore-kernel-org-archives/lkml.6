Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127EE208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blacklabsystems-com.20150623.gappssmtp.com header.i=@blacklabsystems-com.20150623.gappssmtp.com header.b="p68M01k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127EE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mattface.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeGPQHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:07:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43747 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeGPQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:07:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so30333558ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blacklabsystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ijPU/FKC3gBndCFUUHLD2lRn4M90xVXRPIQ7zzkvYxU=;
        b=p68M01k4xgb1Gx7+dwxgTbCmuq+HckRjHhkzicP19X3MhsFXMYx3/JVYQBJFpP59uj
         m26VXFvUOG8YQKdwfJmG6fmn3X77KPj5nftrkGgH/4bZ/NN7nXpbj2UtpgAwuMI1OT1j
         NV0p+4q6ePsBY1aX7OBP9QjOJFBdbuxBQPLmBoitkz6yGlVsKcNJD9s5HHza6mE1Flup
         GoRUla5yriIlxt6JN/QWzQSbCBr/BgHTTrh+AWyi6VO9QEgImBE6UN6zleUo2Oa/QHYi
         G2raAZx66zhM+0ehS+YCDOB+uIpc9+cfdnJ7KjEjDNPpJocmL4PeY7gL4RqeXa5AdluY
         OjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ijPU/FKC3gBndCFUUHLD2lRn4M90xVXRPIQ7zzkvYxU=;
        b=I7Kgv0G828ojMoFYgg3WzW2uVO8BDm1MC87I3EcrGP2MzObH7pbVePGw25b4QGub1e
         5DXETOnMOUzTCzddRRczm5HnupOVaKFuTF83+t+9abpnarR0RhWXe6fnzXcliBq+klSD
         s82uezunl9bfVNQEF5NmCTZka1+r9Mz8CUHjbCTTC8nH6fcIECPa2EqrB4fJxxO2l7UH
         19rsoIItChte0RX+YcKJT6SkKMOTn7qaSQZ78OuOLNmJ+fqTNKW2q7zHVjDEYfGFIZhr
         dbTrvm/JseVdqgD91OpgHnG6tbLXsGIPkEpkH7OrIjtWL4a0wxuk579UMVgK0XA1JOic
         dAKw==
X-Gm-Message-State: AOUpUlHPfAFYXy871ODOAzowZi1m3bufKJBlCAf2gY8xcOFFrXixRoyi
        4aPT3I+BUjgINBZx/g/dcYUwNXgzSVO5KCp0igORzg==
X-Google-Smtp-Source: AAOMgpcGmcys7uHlowG/N5E2bfVAXzEhSazu/QH+TEBLuQ1Eqt0l3d51NRD/Eozz9xlEUpthTz4hwdFqYxC5E4ryLmk=
X-Received: by 2002:a2e:9645:: with SMTP id z5-v6mr10280901ljh.127.1531755544173;
 Mon, 16 Jul 2018 08:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ac3:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 08:39:03
 -0700 (PDT)
X-Originating-IP: [87.113.1.75]
In-Reply-To: <20180716151630.770-1-pasha.tatashin@oracle.com>
References: <20180716151630.770-1-pasha.tatashin@oracle.com>
From:   Matt Hart <matt@mattface.org>
Date:   Mon, 16 Jul 2018 16:39:03 +0100
X-Google-Sender-Auth: aQZPr_48LfuPA_aryC1aQIJ1N0g
Message-ID: <CAJsfgeVfazk-5hdhB4u+fJPVv92Hh2TZjiMgj9rfQyQvfm2Rcw@mail.gmail.com>
Subject: Re: [PATCH] mm: don't do zero_resv_unavail if memmap is not allocated
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 16:16, Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> Moving zero_resv_unavail before memmap_init_zone(), caused a regression on
> x86-32.

Automated bisection on my boards in KernelCI spotted this regression,
so I did a manual test with this patch and confirm it fixes boots on
my i386 devices.

>
> The cause is that we access struct pages before they are allocated when
> CONFIG_FLAT_NODE_MEM_MAP is used.
>
> free_area_init_nodes()
>   zero_resv_unavail()
>     mm_zero_struct_page(pfn_to_page(pfn)); <- struct page is not alloced
>   free_area_init_node()
>     if CONFIG_FLAT_NODE_MEM_MAP
>       alloc_node_mem_map()
>         memblock_virt_alloc_node_nopanic() <- struct page alloced here
>
> On the other hand memblock_virt_alloc_node_nopanic() zeroes all the memory
> that it returns, so we do not need to do zero_resv_unavail() here.
>
> Fixes: e181ae0c5db9 ("mm: zero unavailable pages before memmap init")
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Tested-by: Matt Hart <matt@mattface.org>

> ---
>  include/linux/mm.h | 2 +-
>  mm/page_alloc.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9ffe380..3982c83fdcbf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2132,7 +2132,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
>                                         struct mminit_pfnnid_cache *state);
>  #endif
>
> -#ifdef CONFIG_HAVE_MEMBLOCK
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
>  void zero_resv_unavail(void);
>  #else
>  static inline void zero_resv_unavail(void) {}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5d800d61ddb7..a790ef4be74e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6383,7 +6383,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
>         free_area_init_core(pgdat);
>  }
>
> -#ifdef CONFIG_HAVE_MEMBLOCK
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
>  /*
>   * Only struct pages that are backed by physical memory are zeroed and
>   * initialized by going through __init_single_page(). But, there are some
> @@ -6421,7 +6421,7 @@ void __paginginit zero_resv_unavail(void)
>         if (pgcnt)
>                 pr_info("Reserved but unavailable: %lld pages", pgcnt);
>  }
> -#endif /* CONFIG_HAVE_MEMBLOCK */
> +#endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
>
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>
> --
> 2.18.0
>



-- 
Matt Hart
