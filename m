Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D161C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0C02084D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMZn/ghO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfBXMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:34:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBXMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:34:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so3180259pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ugvldidm8y8s0n/p3Bwr6/2IroSyDjrqAPqWfyI4hQA=;
        b=cMZn/ghOVis+vQJBy5AyjcvJO3oUfeQIhP/N8EAe5khMGJLUnJ+pjcDuzDLz+77iE7
         aWkDKpgMy/nlXiTbdrmuB9fIm4Ulcc+WaLgKqzpLLuLjyy7adnT1otiz0O80y9Qp5gkr
         64AuxOzb044cSeNVLuNT8+PnPENYfap1nbA4WIqkumt3WD/TKn9xSI0XPYa8QAZUUHb8
         7gEo3nyyRcMjcMj9EMTsHQyRmZVdkXL8Mw2JPXtaixFJUDJ8SKW2IFfrRThZVIQ7JBX4
         RX5icrMFScd68STF3eajyPao2v2fhVB66P+xRmZRrrg68vwv+2vf4WZ/r+H/k4VUVG3g
         UeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ugvldidm8y8s0n/p3Bwr6/2IroSyDjrqAPqWfyI4hQA=;
        b=ucKW5NpBh2sfwQNU3+s5aWAxBP9LNk6zPdb49B8KgFU+pK+JM88sFsUklgD/4rScqJ
         k2IdP+CtFwKh8iEMfnHaExjkZ2tbNG8gTTk3OwRgXTVvFATrdUhzztEMa027cbzn0ghJ
         KDHysUJ7LRpAayokHcO57SffM5bgVkfo0YrQlVVhH4cjRfJ/UgHTnB3KAaFXTik/woqC
         ZsMRFhtVeuBZBHhReakCYoTXfw6bVnF09UmZ+KhCBL/8OBbc5mChnErdftyUdMSXgmlk
         SHFPZVrELOnyc6SQhk5CZYFoWkOMT6uiTkjwIDuULY29Fj0PfpyzCrT0PorXiKp3uNHo
         vK5g==
X-Gm-Message-State: AHQUAuYVl6FkC2Lej/ciBxLC3rmCvoBuWTUHwJEIYpstTnIlHNC42Mhs
        ZpISwEch971KuYd2xmMXqg==
X-Google-Smtp-Source: AHgI3IaaMGmFqz42VyRjWubPjFaekxnIRYmn3Cp9WJ7o4X5kSGWGaI22WGXOUXgvJaO05xTxZx5sAw==
X-Received: by 2002:a63:4346:: with SMTP id q67mr12530406pga.92.1551011682473;
        Sun, 24 Feb 2019 04:34:42 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:34:41 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/memblock: make full utilization of numa info
Date:   Sun, 24 Feb 2019 20:34:05 +0800
Message-Id: <1551011649-30103-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are numa machines with memory-less node. When allocating memory for
the memory-less node, memblock allocator falls back to 'Node 0' without fully
utilizing the nearest node. This hurts the performance, especially for per
cpu section. Suppressing this defect by building the full node fall back
info for memblock allocator, like what we have done for page allocator.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 include/linux/memblock.h |  3 +++
 mm/memblock.c            | 68 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 64c41cf..ee999c5 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -342,6 +342,9 @@ void *memblock_alloc_try_nid_nopanic(phys_addr_t size, phys_addr_t align,
 void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
 			     phys_addr_t min_addr, phys_addr_t max_addr,
 			     int nid);
+extern int build_node_order(int *node_oder_array, int sz,
+	int local_node, nodemask_t *used_mask);
+void memblock_build_node_order(void);
 
 static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index 022d4cb..cf78850 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1338,6 +1338,47 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
 	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
+static int **node_fallback __initdata;
+
+/*
+ * build_node_order() relies on cpumask_of_node(), hence arch should set up
+ * cpumask before calling this func.
+ */
+void __init memblock_build_node_order(void)
+{
+	int nid, i;
+	nodemask_t used_mask;
+
+	node_fallback = memblock_alloc(MAX_NUMNODES * sizeof(int *),
+		sizeof(int *));
+	for_each_online_node(nid) {
+		node_fallback[nid] = memblock_alloc(
+			num_online_nodes() * sizeof(int), sizeof(int));
+		for (i = 0; i < num_online_nodes(); i++)
+			node_fallback[nid][i] = NUMA_NO_NODE;
+	}
+
+	for_each_online_node(nid) {
+		nodes_clear(used_mask);
+		node_set(nid, used_mask);
+		build_node_order(node_fallback[nid], num_online_nodes(),
+			nid, &used_mask);
+	}
+}
+
+static void __init memblock_free_node_order(void)
+{
+	int nid;
+
+	if (!node_fallback)
+		return;
+	for_each_online_node(nid)
+		memblock_free(__pa(node_fallback[nid]),
+			num_online_nodes() * sizeof(int));
+	memblock_free(__pa(node_fallback), MAX_NUMNODES * sizeof(int *));
+	node_fallback = NULL;
+}
+
 /**
  * memblock_alloc_internal - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
@@ -1370,6 +1411,7 @@ static void * __init memblock_alloc_internal(
 {
 	phys_addr_t alloc;
 	void *ptr;
+	int node;
 	enum memblock_flags flags = choose_memblock_flags();
 
 	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
@@ -1397,11 +1439,26 @@ static void * __init memblock_alloc_internal(
 		goto done;
 
 	if (nid != NUMA_NO_NODE) {
-		alloc = memblock_find_in_range_node(size, align, min_addr,
-						    max_addr, NUMA_NO_NODE,
-						    flags);
-		if (alloc && !memblock_reserve(alloc, size))
-			goto done;
+		if (!node_fallback) {
+			alloc = memblock_find_in_range_node(size, align,
+					min_addr, max_addr,
+					NUMA_NO_NODE, flags);
+			if (alloc && !memblock_reserve(alloc, size))
+				goto done;
+		} else {
+			int i;
+			for (i = 0; i < num_online_nodes(); i++) {
+				node = node_fallback[nid][i];
+				/* fallback list has all memory nodes */
+				if (node == NUMA_NO_NODE)
+					break;
+				alloc = memblock_find_in_range_node(size,
+						align, min_addr, max_addr,
+						node, flags);
+				if (alloc && !memblock_reserve(alloc, size))
+					goto done;
+			}
+		}
 	}
 
 	if (min_addr) {
@@ -1969,6 +2026,7 @@ unsigned long __init memblock_free_all(void)
 
 	reset_all_zones_managed_pages();
 
+	memblock_free_node_order();
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
 
-- 
2.7.4

