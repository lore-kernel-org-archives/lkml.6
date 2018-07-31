Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD1208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDD1208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeGaL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:57:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43593 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbeGaL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:57:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so16026400wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 03:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Qvhtu/kuImYR1f9bmeOGsu+i3EojwhRgshDrSEs+5s=;
        b=V3jJzUMY4Wpq3ww0iAHoGionLXZy5WCJmqZQmg3ZbWYE6CWZrq6AEJqg975uvpVogm
         kuVBWLOMdPT3Bv4NBCIfR7bqeMAei/6XpatcaQ7gYOMS47/+Z1SyjzDAZj9Wfsxhd0c2
         nYehNrsQXxswinczl2tN5mSKjTR4QUSXnA4n17m4IPXC000hofnKtCkbiDm+QgnnAAmv
         nNlIheGcjzn84cqUvmbFhubbU6kDs2zA+8Fz46gv1LB6DIOH1IgPYwcUdRfIX/uFz+Zk
         3f3e/D66acpL70I31ixFazaD26MwS8OqPJqFTR2jq4fV8CloryPyvtldGBmthN7IBOkc
         cqfg==
X-Gm-Message-State: AOUpUlFATfObYSx2ipsGa+4i1esKEU7MYln1qT6FzcIUJzdlCydz15mI
        t2USQs0c64pJqYexYqLTXKE=
X-Google-Smtp-Source: AAOMgpdw9R7z70OIk4HLcQed6i/CVklO+eQmC3QzzNSkEsUtV3EwRmGFjEKuw7v36ANa8XRh18P0CA==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr20992538wrc.10.1533032274546;
        Tue, 31 Jul 2018 03:17:54 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j3-v6sm21267312wrt.70.2018.07.31.03.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 03:17:53 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 16F401244CD; Tue, 31 Jul 2018 12:17:52 +0200 (CEST)
Date:   Tue, 31 Jul 2018 12:17:52 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v5 4/4] mm/page_alloc: Introduce
 free_area_init_core_hotplug
Message-ID: <20180731101752.GA473@techadventures.net>
References: <20180730101757.28058-1-osalvador@techadventures.net>
 <20180730101757.28058-5-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730101757.28058-5-osalvador@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:17:57PM +0200, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
...
> Also, since free_area_init_core/free_area_init_node will now only get called during early init, let us replace
> __paginginit with __init, so their code gets freed up.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Andrew, could you please fold the following cleanup into this patch?
thanks

Pavel, since this has your Reviewed-by, are you ok with the following on top?

set_pageblock_order() is only called from free_area_init_core() and sparse_init().
sparse_init() is only called during early init, and the same applies for free_area_init_core()
from now on (with this patchset)

The same goes for calc_memmap_size().

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bb11cc23b862..c1cf088607c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6142,7 +6142,7 @@ static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
-void __paginginit set_pageblock_order(void)
+void __init set_pageblock_order(void)
 {
 	unsigned int order;
 
@@ -6170,13 +6170,13 @@ void __paginginit set_pageblock_order(void)
  * include/linux/pageblock-flags.h for the values of pageblock_order based on
  * the kernel config
  */
-void __paginginit set_pageblock_order(void)
+void __init set_pageblock_order(void)
 {
 }
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-static unsigned long __paginginit calc_memmap_size(unsigned long spanned_pages,
+static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
 						   unsigned long present_pages)
 {
 	unsigned long pages = spanned_pages;
@@ -6448,7 +6448,7 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
  * may be accessed (for example page_to_pfn() on some configuration accesses
  * flags). We must explicitly zero those struct pages.
  */
-void __paginginit zero_resv_unavail(void)
+void __init zero_resv_unavail(void)
 {
 	phys_addr_t start, end;
 	unsigned long pfn;

Thanks
-- 
Oscar Salvador
SUSE L3
