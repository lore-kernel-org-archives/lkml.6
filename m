Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9BC41518
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF62196E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfAYH6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:58:34 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:39325 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbfAYH6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:58:34 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 2152C4045; Fri, 25 Jan 2019 08:58:33 +0100 (CET)
Date:   Fri, 25 Jan 2019 08:58:33 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-ID: <20190125075830.6mqw2io4rwz7wxx5@d104.suse.de>
References: <20190122154407.18417-1-osalvador@suse.de>
 <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5368e2b4-5aca-40dd-fe18-67d861a04a29@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:33:56AM +0100, David Hildenbrand wrote:
> If you use {} for the else case, please also do so for the if case.

Diff on top:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 25aee4f04a72..d5810e522b72 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1338,9 +1338,9 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 				struct page *head = compound_head(page);
 
 				if (hugepage_migration_supported(page_hstate(head)) &&
-				    page_huge_active(head))
+				    page_huge_active(head)) {
 					return pfn;
-				else {
+				} else {
 					unsigned long skip;
 
 					skip = (1 << compound_order(head)) - (page - head);

> Apart from that this looks good to me
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks David ;-)

-- 
Oscar Salvador
SUSE L3
