Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C651C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2702192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="b1VUPdwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfBOSOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:14:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36770 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbfBOSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:40 -0500
Received: by mail-yw1-f66.google.com with SMTP id 189so4048968ywi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xWYBy7FokRZPZ5ORH4t2tIovmpTYMvN2BW/u6oRAco=;
        b=b1VUPdwiUPbev9Zpm14NFF7dG9RjRJ3CzCdRRh5szC6PsrCzTDT8Xq0B2F1nEGlhxg
         qLhGQzYmivMBrSqb1WHcfnJaVtqKBqsYcBHRV4yQm+PMcovxgqEyKvjTF3SBy9eqKQbd
         Lm96Dn86Q1ft5hiblalQn3NM7tmzMYt1R3rWpT0M8h+pBwAqTSYMf91gdqc8HhOAu2QG
         +9shVyCnT2FUiU6uA36Dr3ebjESZRYa3f92YsgtnnKh4zE35w+MtNwG65NANGZLesYqd
         O0A1bV3uYF8ost+QXKnAa+CYQvmbBuk36tzQdSADml/ekVJPwD4FM3LK4Npp7pBx/UEc
         UsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xWYBy7FokRZPZ5ORH4t2tIovmpTYMvN2BW/u6oRAco=;
        b=ALtvEq2dRhuui7WLWp9IfX88L7yRmiZJTvHFm4T9qrynvTuSfWmaJG0HU7Gp0UIJVv
         EZ5MHhl3E9lACo2K+vHMIzW4fIyzR16C5qEbXUYK8yGNVsn33jx4Qed9y8zpljFxz66P
         o98tRfuZqwagB2Akqp/69DUeLltif6SR4JYLIyWyGG/DY1EzplgE5REIbFWZRBGre7gH
         S2Dcz70qpw7Yx0UwgWhgpSJeWOZ9E3JCl047uTkks7W+RjDMkriyW0n1tUzGp0zLNrVR
         UtvJxg7rhlmZGRfrWOG8+yUObOXoehi+mR9QHcL6j3AL9EuKRaDn+2JjI8IqWoL6+93s
         Xtkg==
X-Gm-Message-State: AHQUAuZev6RF7Zw/qcuWvUBiOAElC8Pv1/PGN8+rISnCg/jrX1w5Ek5T
        /5TQjaS68UF7ZTDD0bDh7GxzcH8qa+0=
X-Google-Smtp-Source: AHgI3IalZFEfXkNtqFL/VZxIILPlv28xJ58YSrr+lhW3IaKqKL+TVYkZ/rvDyirah3zdTh0tQ48cFg==
X-Received: by 2002:a81:7a50:: with SMTP id v77mr8974055ywc.223.1550254479646;
        Fri, 15 Feb 2019 10:14:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id j22sm1915745ywj.37.2019.02.15.10.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:39 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] mm: memcontrol: quarantine the mem_cgroup_[node_]nr_lru_pages() API
Date:   Fri, 15 Feb 2019 13:14:25 -0500
Message-Id: <20190215181425.32624-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215181425.32624-1-hannes@cmpxchg.org>
References: <20190215181425.32624-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only memcg_numa_stat_show() uses those wrappers and the lru bitmasks,
group them together.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  5 ----
 mm/memcontrol.c        | 67 +++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 842f9189537b..a93921ba7bd6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -247,11 +247,6 @@ struct lruvec {
 #endif
 };
 
-/* Mask used at gathering information at once (see memcontrol.c) */
-#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
-#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
-#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
-
 /* Isolate unmapped file */
 #define ISOLATE_UNMAPPED	((__force isolate_mode_t)0x2)
 /* Isolate for asynchronous migration */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6d0c3374669f..20fb3de8bde4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -718,37 +718,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->stat_cpu->nr_page_events, nr_pages);
 }
 
-static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask)
-{
-	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	VM_BUG_ON((unsigned)nid >= nr_node_ids);
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
-static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-			unsigned int lru_mask)
-{
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
@@ -3328,6 +3297,42 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 #endif
 
 #ifdef CONFIG_NUMA
+
+#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
+#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
+#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
+
+static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+					   int nid, unsigned int lru_mask)
+{
+	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	VM_BUG_ON((unsigned)nid >= nr_node_ids);
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
+
+static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
+					     unsigned int lru_mask)
+{
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
+
 static int memcg_numa_stat_show(struct seq_file *m, void *v)
 {
 	struct numa_stat {
-- 
2.20.1

