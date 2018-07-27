Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F8FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0800B20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2rMDtEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0800B20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeG0Kkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:40:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40927 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbeG0Kkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:40:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so2890686pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=20Wx9riSuDYbJooR8gj1Ouq+57hcSNEZmF4g+H3EHxs=;
        b=e2rMDtEkaTMhRkwGBH4pMtreT6YY8ui4QaGZO+xI/9u/t5mslk9Lt93CNrZ1X5A6wM
         494AHDoqkYoHJv/1m8uDm6lqnHfh8arH7sifWEHv8N9XmA5Cnskd7G7R1zE8FBhm9GcJ
         gtOppsLABQvGzBOmKnxV7Ssv5xFDH2I3iNN8vy9374bCBUamgCK+17oJqNkjozS1XkYk
         ZoIy2bkwR5vElrWf60kV2hXLQ+faV+QIoCUKpHNyucpo6OFc/Y6JFc5KER98eEGToiQ6
         6WlACmEBPNPKL6VVDatdRtHS1123uQsStejZZhjwNRuz1BE4pMXotCCzjZEuTdLRdzTv
         EJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=20Wx9riSuDYbJooR8gj1Ouq+57hcSNEZmF4g+H3EHxs=;
        b=FN6osPa3cviC8ClxDe28LFfyiPhSGm7Nh0jFxygM51SJK0fGeAfrEC8fMbAn5O4LDq
         G9geZWpfO8XhGCYQnKL8EOUpJAKYxxgyAer+S/97yDdkEKBSJ2iYIUdmRKodeK7I2Xr3
         g8jfImAPk2ooRJ+Y/WBK9JRNCeOGlvAMuB3De9FNBTW9l5QaJCBkQlWvc9ByGmdiN9xy
         xz8lePheo4jcPYqVzrbFlVzAWuOAPgBQCjECI/t5ST12xVf/8dA2Kv+DtP6pCAWLI2zG
         EofStQZvBE+lLLEfM0Zg9e/huxyhQ7M9lNwgmSmP7p7t+m6Ks5Cnyj9ZIzVKgKUAyB3S
         MLXg==
X-Gm-Message-State: AOUpUlHqgEsCC+r9CqnJmafiEYs24YcYoUIEiaiuma603nw6ZJRKLQEJ
        POqHVBeEWMZoKSwWgZEJcC8=
X-Google-Smtp-Source: AAOMgpfM6wKZOHiPhU+7+RVDJ41pulix73tIcyxzXYlt2BziphI1F61s8xbVQWxXKZ7KCztETMeXtQ==
X-Received: by 2002:a63:1015:: with SMTP id f21-v6mr5396346pgl.354.1532683172936;
        Fri, 27 Jul 2018 02:19:32 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id r1-v6sm9955933pfi.17.2018.07.27.02.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 02:19:32 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: [PATCH] mm: terminate the reclaim early when direct reclaiming
Date:   Fri, 27 Jul 2018 17:19:25 +0800
Message-Id: <1532683165-19416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to let the direct reclaim finish earlier than it used
to be. The problem comes from We observing that the direct reclaim
took a long time to finish when memcg is enabled. By debugging, we
find that the reason is the softlimit is too low to meet the loop
end criteria. So we add two barriers to judge if it has reclaimed
enough memory as same criteria as it is in shrink_lruvec:
1. for each memcg softlimit reclaim.
2. before starting the global reclaim in shrink_zone.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
---
 include/linux/memcontrol.h |  3 ++-
 mm/memcontrol.c            |  3 +++
 mm/vmscan.c                | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb11..cdf5de6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -325,7 +325,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
-
+bool direct_reclaim_reach_sflimit(pg_data_t *pgdat, unsigned long nr_reclaimed,
+			unsigned long nr_scanned, gfp_t gfp_mask, int order);
 static struct mem_cgroup_per_node *
 mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b..4e38223 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2577,6 +2577,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			(next_mz == NULL ||
 			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
 			break;
+		if (direct_reclaim_reach_sflimit(pgdat, nr_reclaimed,
+					*total_scanned, gfp_mask, order))
+			break;
 	} while (!nr_reclaimed);
 	if (next_mz)
 		css_put(&next_mz->memcg->css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..77fcda4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2518,12 +2518,36 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 		(memcg && memcg_congested(pgdat, memcg));
 }
 
+bool direct_reclaim_reach_sflimit(pg_data_t *pgdat, unsigned long nr_reclaimed,
+		unsigned long nr_scanned, gfp_t gfp_mask,
+		int order)
+{
+	struct scan_control sc = {
+		.gfp_mask = gfp_mask,
+		.order = order,
+		.priority = DEF_PRIORITY,
+		.nr_reclaimed = nr_reclaimed,
+		.nr_scanned = nr_scanned,
+	};
+	if (!current_is_kswapd() && !should_continue_reclaim(pgdat,
+				sc.nr_reclaimed, sc.nr_scanned, &sc))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(direct_reclaim_reach_sflimit);
+
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	unsigned long nr_reclaimed, nr_scanned;
 	bool reclaimable = false;
 
+	if (!current_is_kswapd() && !should_continue_reclaim(pgdat,
+		sc->nr_reclaimed, sc->nr_scanned, sc)) {
+
+		return !!sc->nr_reclaimed;
+	}
+
 	do {
 		struct mem_cgroup *root = sc->target_mem_cgroup;
 		struct mem_cgroup_reclaim_cookie reclaim = {
-- 
1.9.1

