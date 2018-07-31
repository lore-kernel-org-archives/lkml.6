Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583A208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihnk5AOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5583A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGaMt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:49:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34328 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:49:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so8903425pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2WvnA6eI9cUHIsdEP7c7f7BrbwUfvvtbYh8dMg2a8tM=;
        b=ihnk5AOpjjIVz/umuEbrSJ9sj9cpJ2/G0Gl6M0A5YxIsqsQEGhYGqVj41W23e3d1M+
         omtSBfdOSDwOoAvKS/aySkqfb6TpRp2Q8rNwSW5DAsUe6hiXMlTreoHiKOXG4C2HyPGO
         Mt8G5qo8qimIvmp3+VwYg7oyvE0YCKgI+cn1/xKm9GOtop5BLJV7CXKhg4vnHKD+Utfy
         kXwEhO/lFTRRsNpJTdElTXOsvSc8pgJt1tR1+gS+LTiN3SQdOnXrlmbpXqm+srZ0yAjH
         SMnUiU2HE1X77kXv0Xs7TkicuOOFmISZRt6FmwcM4Uu+dTkeCmJVb5COpgA79dkxUxFr
         RNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2WvnA6eI9cUHIsdEP7c7f7BrbwUfvvtbYh8dMg2a8tM=;
        b=tcv+0j6YjBmEVNPhTRBw5o9qMcXJU/sNYr9TZ+0fSsOsEUEg5t/+qkFXmwQYxyeO12
         iCC83c4yP399oIb6NLi/iXkzA2vRXRnvTM2tuPu3uIsKHdQPjjufLl1RoRAMo7n0esB5
         eHuAnx8MrTk3o4blNEAD+I51UIjz9wYFV024+yUF8fkjNqIz3AHFLxM/BWtRKBKAlC+h
         LDxuyy2E3VEqDjj41E+2y9Sa7rCWGJHgK7qzm38oDQKJgTnMZYrkjP6OWi/qRQHJpT5J
         K7NaRjpt6Ib4EMjN/ZTgpe8qhFOegkRRBNde8NQcuDnnxH9/rfU8VztIS35I3YTeBIzd
         q+AQ==
X-Gm-Message-State: AOUpUlGjSl8AxIlUV/qeWNBw7LUhhkAyEgSEnPiXYSHVYnIUIlCoD2dK
        De3GZ2hlXtt5E58jxswzeS4=
X-Google-Smtp-Source: AAOMgpe0mN0r5Z3yJ5qwue6LJbsohulVzj60oOlaUWMm6IIez03NrxXK6eudXNe1I1T2qxpO7AOcpA==
X-Received: by 2002:a62:c8c2:: with SMTP id i63-v6mr21847671pfk.73.1533035378480;
        Tue, 31 Jul 2018 04:09:38 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z10-v6sm19147154pfh.83.2018.07.31.04.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 04:09:37 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: [PATCH v2] mm: terminate the reclaim early when direct reclaiming
Date:   Tue, 31 Jul 2018 19:09:28 +0800
Message-Id: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com>
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
 mm/vmscan.c                | 38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb11..a7e82c7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -325,7 +325,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
-
+bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
+			unsigned long nr_scanned, gfp_t gfp_mask, int order);
 static struct mem_cgroup_per_node *
 mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b..e4efd46 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2577,6 +2577,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 			(next_mz == NULL ||
 			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
 			break;
+		if (direct_reclaim_reach_watermark(pgdat, nr_reclaimed,
+					*total_scanned, gfp_mask, order))
+			break;
 	} while (!nr_reclaimed);
 	if (next_mz)
 		css_put(&next_mz->memcg->css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..19503f3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2518,6 +2518,34 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
 		(memcg && memcg_congested(pgdat, memcg));
 }
 
+bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
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
+	if (!current_is_kswapd())
+		return false;
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		return false;
+	/*
+	 * In fact, we add 1 to nr_reclaimed and nr_scanned to let should_continue_reclaim
+	 * NOT return by finding they are zero, which means compaction_suitable()
+	 * takes effect here to judge if we have reclaimed enough pages for passing
+	 * the watermark and no necessary to check other memcg anymore.
+	 */
+	if (!should_continue_reclaim(pgdat,
+				sc.nr_reclaimed + 1, sc.nr_scanned + 1, &sc))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(direct_reclaim_reach_watermark);
+
 static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -2802,7 +2830,15 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			sc->nr_scanned += nr_soft_scanned;
 			/* need some check for avoid more shrink_zone() */
 		}
-
+		/*
+		 * we maybe have stolen enough pages from soft limit reclaim, so we return
+		 * back if we are direct reclaim
+		 */
+		if (direct_reclaim_reach_watermark(zone->zone_pgdat, sc->nr_reclaimed,
+						sc->nr_scanned, sc->gfp_mask, sc->order)) {
+			sc->gfp_mask = orig_mask;
+			return;
+		}
 		/* See comment about same check for global reclaim above */
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
-- 
1.9.1

