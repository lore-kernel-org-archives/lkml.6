Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3567C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA920879
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRxOfQrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BA920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeLLBMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:12:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40331 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeLLBMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:12:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so14148951edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wvomT6YCL5jie4R3emDK4qRvqtVZHVPbsU1Bl0mVH9A=;
        b=TRxOfQrxXXnnz3VQ0tTA+JNUK0y+IciOfFiAFFW2DKl0iRyEmUJGjZ2RMijRfh9FgE
         fv4b32kdKobfFyJrtYjPpQccpG0S8uxdMYroi78pg1IxXe5AD5gbDV3kvekz2+R/Pq6g
         Ly3bzN4xzFpdNwCsU0/mJyPMXjB0rOkRa49+dYlBr5+LWojVqBcgqSA5LToOR8xrBTKM
         0I/82hQuRCsCb/2K0ZfiCBCY32/gM90/P1h5NmrJCyqqCvMmVwvxT/vn/M3iAoRzDicJ
         y1K8B2PtOnS5iha7BfeeKS/SyVMXdKOwDRgmX0ernuUx87N1+m19Zc904wvf/VpVvjUY
         R+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvomT6YCL5jie4R3emDK4qRvqtVZHVPbsU1Bl0mVH9A=;
        b=GhxRHsxxUsr1z9zfxYs+pO51gdQomvyWIBA2Zoc0wuAQzWxSCkD4vFdBQ74CBkGTbp
         NDuzKIUOOOcJnifgnY0I1lswQRGfgRkRdz0Z2kEVY85nHLDVGPpZOy3jgFUp5YVKxyO5
         C05kmvgFT63qsqW3eOo2vtbnpbeTT9NylpKqhZwoVocNE8HCQZU9xup6U4UuT3QquGmB
         ENHG1V5GQzeYVCzLesa7sHUP/8tJbHoUeDwBPe+IqvwpLSVrIIc8ej72ZGh/fQ1XDREs
         q2iw6g9kq52LCjE2HoWswagElbal2c1p/zuI4tT7t0EG9lzgsU3NPueWGo1+PbGmkNsw
         h5Gw==
X-Gm-Message-State: AA+aEWYrF6GAC+DLpsWKzpkapUad62hfdQ7ohTbRVrTleOZRmliwHKU0
        g5BffM3ilWuRcEpyg2V7WDU=
X-Google-Smtp-Source: AFSGD/XXXgBsMa3n7AhrI5cZ9/bBrsG52Ox0TKwZYx+PVzsU+/3opcvlx/TH3NMoR71cvuZWbJYqTw==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr17224668edk.242.1544577173039;
        Tue, 11 Dec 2018 17:12:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r18-v6sm2414900ejz.22.2018.12.11.17.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 17:12:52 -0800 (PST)
Date:   Wed, 12 Dec 2018 01:12:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 1/3] mm, memory_hotplug: try to migrate full pfn range
Message-ID: <20181212011251.6wchg5kr2ngp5niq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181211142741.2607-1-mhocko@kernel.org>
 <20181211142741.2607-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211142741.2607-2-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:27:39PM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>do_migrate_range has been limiting the number of pages to migrate to 256
>for some reason which is not documented. Even if the limit made some
>sense back then when it was introduced it doesn't really serve a good
>purpose these days. If the range contains huge pages then
>we break out of the loop too early and go through LRU and pcp
>caches draining and scan_movable_pages is quite suboptimal.
>
>The only reason to limit the number of pages I can think of is to reduce
>the potential time to react on the fatal signal. But even then the
>number of pages is a questionable metric because even a single page
>might migration block in a non-killable state (e.g. __unmap_and_move).
>
>Remove the limit and offline the full requested range (this is one
>membblock worth of pages with the current code). Should we ever get a

s/membblock/memblock/

Or memory block is more accurate? May memblock confuse audience with
lower level facility?

>report that offlining takes too long to react on fatal signal then we
>should rather fix the core migration to use killable waits and bailout
>on a signal.
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: Michal Hocko <mhocko@suse.com>
>---
> mm/memory_hotplug.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index c82193db4be6..6263c8cd4491 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1339,18 +1339,16 @@ static struct page *new_node_page(struct page *page, unsigned long private)
> 	return new_page_nodemask(page, nid, &nmask);
> }
> 
>-#define NR_OFFLINE_AT_ONCE_PAGES	(256)
> static int
> do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> {
> 	unsigned long pfn;
> 	struct page *page;
>-	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
> 	int not_managed = 0;
> 	int ret = 0;
> 	LIST_HEAD(source);
> 
>-	for (pfn = start_pfn; pfn < end_pfn && move_pages > 0; pfn++) {
>+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 		if (!pfn_valid(pfn))
> 			continue;
> 		page = pfn_to_page(pfn);
>@@ -1362,8 +1360,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 				ret = -EBUSY;
> 				break;
> 			}
>-			if (isolate_huge_page(page, &source))
>-				move_pages -= 1 << compound_order(head);
>+			isolate_huge_page(page, &source);
> 			continue;
> 		} else if (PageTransHuge(page))
> 			pfn = page_to_pfn(compound_head(page))
>@@ -1382,7 +1379,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 		if (!ret) { /* Success */
> 			put_page(page);
> 			list_add_tail(&page->lru, &source);
>-			move_pages--;
> 			if (!__PageMovable(page))
> 				inc_node_page_state(page, NR_ISOLATED_ANON +
> 						    page_is_file_cache(page));
>-- 
>2.19.2

-- 
Wei Yang
Help you, Help me
