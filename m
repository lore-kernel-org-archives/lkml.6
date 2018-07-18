Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9ACECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0055B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0055B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeGRPuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:50:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36301 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbeGRPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:50:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so3289183wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiTp/QPwxlU6Kfz9q14e/0xmHpkGJGdDCL629dIVa/0=;
        b=ATvBFbXBA2yGLbNPGKxDNqpdhEa/o/R7JS9UiYw/PnAu9dMZkGAI09HSOIL81DvZhU
         k2jX9VM9agDwdDlyYzh61yvuwhj1B0agdkU5D+F+vVhaSFwQyBQhARaykX+NJ76I4d9f
         A200rLdK7UbSnm8jvJ7+OfxZFg1yYLbYAhSPjIxbo9CY9ZB0+FhAFvnllWj6b8Qhc2yZ
         tKJdtcSKbxiuXzXRX8nIXHcWEG3z7AFmOMpVTGlgoEbvlGzqEFEXXmSxoQwEoiO3/Fsg
         o/EGEsKPj5Hq7KVx76H57nUPQGpUJiHfYTd5aqJSkhTRFBgzc1/oBEAynlwZqKuq9Dhp
         kacA==
X-Gm-Message-State: AOUpUlElN5jYe9tK6p5Tvkh40sMGmp9nxuW4IO1OMDaAcpLKCya/ARij
        7PUFP5Ktq9j9ATJyHkTV5Xc=
X-Google-Smtp-Source: AAOMgpc311EbtiJc8/mmfJJTmz5FbJFdrqo/i3pnPNLk/oLVJBaZ4EpICa3wHBNggBdLPLcLZbHp5g==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr2010950wmf.17.1531926716332;
        Wed, 18 Jul 2018 08:11:56 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 14-v6sm6187958wmg.0.2018.07.18.08.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:11:55 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 042CA1240EB; Wed, 18 Jul 2018 17:11:54 +0200 (CEST)
Date:   Wed, 18 Jul 2018 17:11:54 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/3] mm/page_alloc: Refactor free_area_init_core
Message-ID: <20180718151154.GA2875@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-3-osalvador@techadventures.net>
 <20180718133647.GD7193@dhcp22.suse.cz>
 <20180718141226.GA2588@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718141226.GA2588@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:12:26PM +0200, Oscar Salvador wrote:
> On Wed, Jul 18, 2018 at 03:36:47PM +0200, Michal Hocko wrote:
> > I really do not like this if node is offline than only perform half of
> > the function. This will generate more mess in the future. Why don't you
> > simply. If we can split out this code into logical units then let's do
> > that but no, please do not make random ifs for hotplug code paths.
> > Sooner or later somebody will simply don't know what is needed and what
> > is not.
> 
> Yes, you are right.
> I gave it another thought and it was not a really good idea.
> Although I think the code from free_area_init_core can be simplified.
> 
> I will try to come up with something that makes more sense.

I guess we could so something like:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a73305f7c55..70fe4c80643f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,6 +6237,40 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
+static unsigned long calc_remaining_pages(enum zone_type type, unsigned long freesize,
+								unsigned long size)
+{
+	unsigned long memmap_pages = calc_memmap_size(size, freesize);
+
+	if(!is_highmem_idx(type)) {
+		if (freesize >= memmap_pages) {
+			freesize -= memmap_pages;
+			if (memmap_pages)
+				printk(KERN_DEBUG
+					"  %s zone: %lu pages used for memmap\n",
+					zone_names[type], memmap_pages);
+		} else
+			pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				zone_names[type], memmap_pages, freesize);
+	}
+
+	/* Account for reserved pages */
+	if (type == 0 && freesize > dma_reserve) {
+		freesize -= dma_reserve;
+		printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
+		zone_names[0], dma_reserve);
+	}
+
+	if (!is_highmem_idx(type))
+		nr_kernel_pages += freesize;
+	/* Charge for highmem memmap if there are enough kernel pages */
+	else if (nr_kernel_pages > memmap_pages * 2)
+		nr_kernel_pages -= memmap_pages;
+	nr_all_pages += freesize;
+
+	return freesize;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -6267,43 +6301,12 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
+		unsigned long size = zone->spanned_pages;
+		unsigned long freesize = zone->present_pages;
 		unsigned long zone_start_pfn = zone->zone_start_pfn;
 
-		size = zone->spanned_pages;
-		freesize = zone->present_pages;
-
-		/*
-		 * Adjust freesize so that it accounts for how much memory
-		 * is used by this zone for memmap. This affects the watermark
-		 * and per-cpu initialisations
-		 */
-		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
-			if (freesize >= memmap_pages) {
-				freesize -= memmap_pages;
-				if (memmap_pages)
-					printk(KERN_DEBUG
-					       "  %s zone: %lu pages used for memmap\n",
-					       zone_names[j], memmap_pages);
-			} else
-				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
-					zone_names[j], memmap_pages, freesize);
-		}
-
-		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
-					zone_names[0], dma_reserve);
-		}
-
-		if (!is_highmem_idx(j))
-			nr_kernel_pages += freesize;
-		/* Charge for highmem memmap if there are enough kernel pages */
-		else if (nr_kernel_pages > memmap_pages * 2)
-			nr_kernel_pages -= memmap_pages;
-		nr_all_pages += freesize;
+		if (freesize)
+

 
So we just do the calculations with the pages (nr_kernel_pages, nr_all_pages, memmap_pages, etc...) 
if freesize is not 0.
Otherwise it does not make sense to do it (AFAICS).
-- 
Oscar Salvador
SUSE L3
