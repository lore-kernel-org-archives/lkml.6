Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA742088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1VST8BwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA742088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeH1VQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:16:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45528 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH1VQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:16:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id p206-v6so876793ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LP4jYlbkEnBcnLxdEdJzxq3VgpVfWiBPMH3IQ/af2M=;
        b=1VST8BwL/2+J3rqHHlYBmAySQOD3S7m02Nic1jjLJcfoHxI8+mwYve17/BJZ1m03lm
         kRVchpfKFipfKjExKOaozqJk24pyutKM23M0yyaUW1Y75DxmgodD8EBE4FUnPBWGkC3v
         QzJ7JPI6Y8ZyrfJXkJIW9+S/Ack5MkA1EWfKelcFc0/vOtym7aD4kD/Y5UIy9D3Z6LgB
         f4/Gu1Ksf+I26xfika+1g+imCP2BqrH3XjSZPNh+5FfHwOn4qIHdGk2yH5Tl6qR0sYjn
         AcKbmMfJUfgH1sCh6rU1rfM/lFq1Xxgvb/enMbtVwswr2ta+1n4NTADp06MNEhidpYtg
         WNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LP4jYlbkEnBcnLxdEdJzxq3VgpVfWiBPMH3IQ/af2M=;
        b=U+L+HNvQM3ghSGQyF7XSYSkBQVYbsv/ZnfjYNERn5eCyALqKWaxJXx1PJHcZwHoH7P
         krPrv6fJvRuJs1PzT3SXSpW4Gcgo1zbDOGKrn9S5rzD9G9MD4JYVl3xS+I7FYbmaRyIN
         w3H+ApsTVczMEczmsDe900PGEWfdtF43DcM7nn1cDLH8Wnaibx/W3EJD0LE1uwHURfYp
         EwAPkFjHQS5RGVuWC5z91AwaNpcT+DJfb+VWK4kewyk27v8Dgwem4K7NELB/mlhrvFSK
         TF4S/RhrkE2uk6e1tUMkNXaoNgyp9ghMBZOuaIEAg4PXtLGduk4BQLXEpBkVYZPH70VH
         Fl0w==
X-Gm-Message-State: APzg51ABCuL8idt2nuuVyAFe/gaHB1eO8Nfb4K6aKdrNn3RmJT00U16n
        RV9mUvJAeFUQ9wKAbgFquwP+Eg==
X-Google-Smtp-Source: ANB0VdZAij0mXhndy16AixHc4IHud8DBf3FghkG2ia0L7VNTNXix/ML/G1k6yN73Mc8LEYjLfzs8Sw==
X-Received: by 2002:a81:3295:: with SMTP id y143-v6mr1401869ywy.418.1535477001360;
        Tue, 28 Aug 2018 10:23:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id i190-v6sm1129807ywc.60.2018.08.28.10.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:23:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/9] mm: workingset: don't drop refault information prematurely
Date:   Tue, 28 Aug 2018 13:22:50 -0400
Message-Id: <20180828172258.3185-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <jweiner@fb.com>

If we keep just enough refault information to match the *current* page
cache during reclaim time, we could lose a lot of events when there is
only a temporary spike in non-cache memory consumption that pushes out
all the cache. Once cache comes back, we won't see those refaults.
They might not be actionable for LRU aging, but we want to know about
them for measuring memory pressure.

Signed-off-by: Johannes Weiner <jweiner@fb.com>
---
 mm/workingset.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..53759a3cf99a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -364,7 +364,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 {
 	unsigned long max_nodes;
 	unsigned long nodes;
-	unsigned long cache;
+	unsigned long pages;
 
 	/* list_lru lock nests inside the IRQ-safe i_pages lock */
 	local_irq_disable();
@@ -393,14 +393,14 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	 *
 	 * PAGE_SIZE / radix_tree_nodes / node_entries * 8 / PAGE_SIZE
 	 */
-	if (sc->memcg) {
-		cache = mem_cgroup_node_nr_lru_pages(sc->memcg, sc->nid,
-						     LRU_ALL_FILE);
-	} else {
-		cache = node_page_state(NODE_DATA(sc->nid), NR_ACTIVE_FILE) +
-			node_page_state(NODE_DATA(sc->nid), NR_INACTIVE_FILE);
-	}
-	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
+#ifdef CONFIG_MEMCG
+	if (sc->memcg)
+		pages = page_counter_read(&sc->memcg->memory);
+	else
+#endif
+		pages = node_present_pages(sc->nid);
+
+	max_nodes = pages >> (RADIX_TREE_MAP_SHIFT - 3);
 
 	if (nodes <= max_nodes)
 		return 0;
-- 
2.18.0

