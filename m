Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B8C2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="a5f7aXi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfBOSPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:15:01 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46732 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbfBOSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id n12so4022664ywn.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjS/0oY9wwLINvtO7eIortkRmYdX1ic59VaG6ceBez0=;
        b=a5f7aXi3TT8/yuiVA43lpvDIByTjBfBUd1PDUinv5LHcx+bFHBP4zO587KDnz0R/kN
         TEoZi1rdgOC3047+bHpcrBiAyVPsAPpTsKs6ewUl4TSe+/djHoSAr49wBwzffHjBEozt
         TnJYNfBu0e4kntec1YDy2OAqtaeZcg/lE8fbplc082JcDj8VE+pkZDse/RdBl6Ytp4XH
         iCHkx6yRCbA2d5bNwB9lltewmxn/sWkbXfbHjeca79jqED5sY10/KFYwhdbD6DQsbD5y
         09455famEavd9FgM96WVtwZi1U2BMJDMXcLQE+Is5EDN46bvB8wa3n+qaJOXAV/3m0MM
         2YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjS/0oY9wwLINvtO7eIortkRmYdX1ic59VaG6ceBez0=;
        b=pbP4ZxYfiiZyzE8+bok5gWR3Q+3neeIaJksBzm6moffU4mIJu8d8ia8APReAwn18KE
         OeVr8Dumm+RB7ngn4T8TS348x4xNomgobBBJyL0qeLSb97y7cYKM3Vooum90TsrFvBw0
         rMbecZ/8lq8iRnKfUkPrY6FYP+39S+FzasoBICZf+8onAurqjV+hOo6RWKWObu/2U8AW
         grfG6djaGWRTcW5wG1KeQ3GmJCaHyMGksVgbotehx3cPt690Pf4agYQLlXvhYDujmP46
         PbwGVInLLcK4ioRfbS/gJhkqxfa4rlzANWlGCRUAMpF22SwGQrwMk+4qRALwOAFmUbDj
         bXog==
X-Gm-Message-State: AHQUAuY9u7nQyFZqjWaSwTfRzoCeJk+Ryx4vta8o7wmcDD8eGDxfo17W
        W2ANy2QHx+ny7O7LexBD5/Jf8g==
X-Google-Smtp-Source: AHgI3IaTs3l6l3o0r57AsapVmdI1i/rDDUCcCVFJ3a4eYlNp4dSi6HTTnSBprSZTOVICUY1w6xMeGw==
X-Received: by 2002:a81:1cc1:: with SMTP id c184mr9371591ywc.360.1550254476411;
        Fri, 15 Feb 2019 10:14:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id n67sm2023613ywn.1.2019.02.15.10.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:35 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/6] mm: memcontrol: push down mem_cgroup_node_nr_lru_pages()
Date:   Fri, 15 Feb 2019 13:14:23 -0500
Message-Id: <20190215181425.32624-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215181425.32624-1-hannes@cmpxchg.org>
References: <20190215181425.32624-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_node_nr_lru_pages() is just a convenience wrapper around
lruvec_page_state() that takes bitmasks of lru indexes and aggregates
the counts for those.

Replace callsites where the bitmask is simple enough with direct
lruvec_page_state() calls.

This removes the last extern user of mem_cgroup_node_nr_lru_pages(),
so make that function private again, too.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 10 ----------
 mm/memcontrol.c            | 10 +++++++---
 mm/workingset.c            |  5 +++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 206090de5d7c..6bf06b9d0260 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -496,9 +496,6 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 		int zid, int nr_pages);
 
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask);
-
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
@@ -941,13 +938,6 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	return 0;
 }
 
-static inline unsigned long
-mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-			     int nid, unsigned int lru_mask)
-{
-	return 0;
-}
-
 static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d573f4e1759..73eb8333bc73 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -718,7 +718,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->stat_cpu->nr_page_events, nr_pages);
 }
 
-unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 					   int nid, unsigned int lru_mask)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
@@ -1413,11 +1413,15 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
 		int nid, bool noswap)
 {
-	if (mem_cgroup_node_nr_lru_pages(memcg, nid, LRU_ALL_FILE))
+	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
+
+	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
 		return true;
 	if (noswap || !total_swap_pages)
 		return false;
-	if (mem_cgroup_node_nr_lru_pages(memcg, nid, LRU_ALL_ANON))
+	if (lruvec_page_state(lruvec, NR_INACTIVE_ANON) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_ANON))
 		return true;
 	return false;
 
diff --git a/mm/workingset.c b/mm/workingset.c
index dcb994f2acc2..dbc333a21254 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -427,10 +427,11 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 #ifdef CONFIG_MEMCG
 	if (sc->memcg) {
 		struct lruvec *lruvec;
+		int i;
 
-		pages = mem_cgroup_node_nr_lru_pages(sc->memcg, sc->nid,
-						     LRU_ALL);
 		lruvec = mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
+		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
+			pages += lruvec_page_state(lruvec, NR_LRU_BASE + i);
 		pages += lruvec_page_state(lruvec, NR_SLAB_RECLAIMABLE);
 		pages += lruvec_page_state(lruvec, NR_SLAB_UNRECLAIMABLE);
 	} else
-- 
2.20.1

