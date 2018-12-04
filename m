Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF38C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7943B206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw7KgBl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7943B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLDXoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:44:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36652 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDXoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:44:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so15476884edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c85PNXe6l+L17BqlOtCOgasW3gFlk+BsZs6vVmTDRSE=;
        b=Jw7KgBl3xdzZW5lcMOZvR49wwPOF0jEtEiBXzq9NSl7rBtE5tZz2WcdCZUfse6AdAQ
         gm6Esbv3eOKrf20KAVdsMvvXVraYtZriDcYTxmaDfyXS4rRFWDQ9AgB95LKBxVqHRUa6
         U0WmgfqXgpS8BwYyTejDQmLWksDYAEBAPJCpT3vjUNAfRv+rhLBwrk2xZECnNjtKyQ6C
         ixxebx9Epy5sBBfI2J9xK6D8jNOVf+TXbRpc1KS4h6vquXGNaYZlj+VOaSxdewK4IK4M
         hG2FYwzKMy2cxHC6jnLigc8JbMyZOLzK6Mkg6b41uYpTYfkcotPtuUBkTR6rfNqcBz3N
         cykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c85PNXe6l+L17BqlOtCOgasW3gFlk+BsZs6vVmTDRSE=;
        b=klvuVsSoamSVHtO78RZ99zvH3xT3tzVsKkIJZgcBjWEFkddxVocF6Hozymk8Hb1sEn
         N6NAEj7yHvGu9+Fotanf//6HrjytR3FSh5Nm/D3u7d4xgoLSMm9xvTB0L/7CSPvDFEMp
         H9mAMwNFNAV9dzQ/IVEH1dtvwXlHkpZuIfPJtj/fBo3WxP7KZ7XniD0m5e+9spMcdSkS
         SDm1ZC308lEE3Vl87ORCrgnLDgYvWsk6B9QSWeB7R8RGWUY7zp8U/jKULDQfg9cyAOkR
         PUXF/eCGDHScRE76Rkz+acERp1pU0C+24qnsB4ox+62oGlKcEuXgs/5fZiQ54mZhof1J
         syiw==
X-Gm-Message-State: AA+aEWZoU/eMLuAw9b6MqMmvuOsb/Vog7D8DgUvrzKqBelF1PiYq+v2m
        4mOPfRXhu5Uf4r9IwMw3oU8=
X-Google-Smtp-Source: AFSGD/UQdpP2o2Qiz5eqzA6ZwR2YEbl43x/ZNrYxeKYKF5w+noRBcCaeT7m6sGscer0fVeyFJftfXA==
X-Received: by 2002:a17:906:62cb:: with SMTP id v11-v6mr17205615ejl.56.1543967045536;
        Tue, 04 Dec 2018 15:44:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j8sm5098733ede.55.2018.12.04.15.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:44:04 -0800 (PST)
Date:   Tue, 4 Dec 2018 23:44:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        pavel.tatashin@microsoft.com, vbabka@suse.cz,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, page_alloc: Drop uneeded __meminit and __meminitdata
Message-ID: <20181204234404.smwel3txywvntjpd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181204111507.4808-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204111507.4808-1-osalvador@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:15:07PM +0100, Oscar Salvador wrote:
>Since commit 03e85f9d5f1 ("mm/page_alloc: Introduce free_area_init_core_hotplug"),
>some functions changed to only be called during system initialization.
>In concret, free_area_init_node and and the functions that hang from it.
>
>Also, some variables are no longer used after the system has gone
>through initialization.
>So this could be considered as a late clean-up for that patch.
>
>This patch changes the functions from __meminit to __init, and
>the variables from __meminitdata to __initdata.
>
>In return, we get some KBs back:
>
>Before:
>Freeing unused kernel image memory: 2472K
>
>After:
>Freeing unused kernel image memory: 2480K
>
>Signed-off-by: Oscar Salvador <osalvador@suse.de>

I like this one.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/page_alloc.c | 28 ++++++++++++++--------------
> 1 file changed, 14 insertions(+), 14 deletions(-)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index fee5e9bad0dd..94e16eba162c 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -266,18 +266,18 @@ int watermark_boost_factor __read_mostly = 15000;
> int watermark_scale_factor = 10;
> int fragment_stall_order __read_mostly = (PAGE_ALLOC_COSTLY_ORDER + 1);
> 
>-static unsigned long nr_kernel_pages __meminitdata;
>-static unsigned long nr_all_pages __meminitdata;
>-static unsigned long dma_reserve __meminitdata;
>+static unsigned long nr_kernel_pages __initdata;
>+static unsigned long nr_all_pages __initdata;
>+static unsigned long dma_reserve __initdata;
> 
> #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>-static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __meminitdata;
>-static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __meminitdata;
>+static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initdata;
>+static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __initdata;
> static unsigned long required_kernelcore __initdata;
> static unsigned long required_kernelcore_percent __initdata;
> static unsigned long required_movablecore __initdata;
> static unsigned long required_movablecore_percent __initdata;
>-static unsigned long zone_movable_pfn[MAX_NUMNODES] __meminitdata;
>+static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
> static bool mirrored_kernelcore __meminitdata;
> 
> /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>@@ -6211,7 +6211,7 @@ void __init sparse_memory_present_with_active_regions(int nid)
>  * with no available memory, a warning is printed and the start and end
>  * PFNs will be 0.
>  */
>-void __meminit get_pfn_range_for_nid(unsigned int nid,
>+void __init get_pfn_range_for_nid(unsigned int nid,
> 			unsigned long *start_pfn, unsigned long *end_pfn)
> {
> 	unsigned long this_start_pfn, this_end_pfn;
>@@ -6260,7 +6260,7 @@ static void __init find_usable_zone_for_movable(void)
>  * highest usable zone for ZONE_MOVABLE. This preserves the assumption that
>  * zones within a node are in order of monotonic increases memory addresses
>  */
>-static void __meminit adjust_zone_range_for_zone_movable(int nid,
>+static void __init adjust_zone_range_for_zone_movable(int nid,
> 					unsigned long zone_type,
> 					unsigned long node_start_pfn,
> 					unsigned long node_end_pfn,
>@@ -6291,7 +6291,7 @@ static void __meminit adjust_zone_range_for_zone_movable(int nid,
>  * Return the number of pages a zone spans in a node, including holes
>  * present_pages = zone_spanned_pages_in_node() - zone_absent_pages_in_node()
>  */
>-static unsigned long __meminit zone_spanned_pages_in_node(int nid,
>+static unsigned long __init zone_spanned_pages_in_node(int nid,
> 					unsigned long zone_type,
> 					unsigned long node_start_pfn,
> 					unsigned long node_end_pfn,
>@@ -6326,7 +6326,7 @@ static unsigned long __meminit zone_spanned_pages_in_node(int nid,
>  * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>  * then all holes in the requested range will be accounted for.
>  */
>-unsigned long __meminit __absent_pages_in_range(int nid,
>+unsigned long __init __absent_pages_in_range(int nid,
> 				unsigned long range_start_pfn,
> 				unsigned long range_end_pfn)
> {
>@@ -6356,7 +6356,7 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
> }
> 
> /* Return the number of page frames in holes in a zone on a node */
>-static unsigned long __meminit zone_absent_pages_in_node(int nid,
>+static unsigned long __init zone_absent_pages_in_node(int nid,
> 					unsigned long zone_type,
> 					unsigned long node_start_pfn,
> 					unsigned long node_end_pfn,
>@@ -6408,7 +6408,7 @@ static unsigned long __meminit zone_absent_pages_in_node(int nid,
> }
> 
> #else /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>-static inline unsigned long __meminit zone_spanned_pages_in_node(int nid,
>+static inline unsigned long __init zone_spanned_pages_in_node(int nid,
> 					unsigned long zone_type,
> 					unsigned long node_start_pfn,
> 					unsigned long node_end_pfn,
>@@ -6427,7 +6427,7 @@ static inline unsigned long __meminit zone_spanned_pages_in_node(int nid,
> 	return zones_size[zone_type];
> }
> 
>-static inline unsigned long __meminit zone_absent_pages_in_node(int nid,
>+static inline unsigned long __init zone_absent_pages_in_node(int nid,
> 						unsigned long zone_type,
> 						unsigned long node_start_pfn,
> 						unsigned long node_end_pfn,
>@@ -6441,7 +6441,7 @@ static inline unsigned long __meminit zone_absent_pages_in_node(int nid,
> 
> #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> 
>-static void __meminit calculate_node_totalpages(struct pglist_data *pgdat,
>+static void __init calculate_node_totalpages(struct pglist_data *pgdat,
> 						unsigned long node_start_pfn,
> 						unsigned long node_end_pfn,
> 						unsigned long *zones_size,
>-- 
>2.13.7

-- 
Wei Yang
Help you, Help me
