Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E640208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vjkKAP6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E640208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbeHARD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47090 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389704AbeHARD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so20256339qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPzbJJIeJgfn8++cxkOJb5Dz/B61/Buo1muVR4A4+7E=;
        b=vjkKAP6ubSVRmeQnLIA1gqmu8OAqsEHegFTBIDM1/gU9CHgInYOeLeKoL9P1dcM5B8
         F/g3ROFEMdcJg5dDR13yU3joj5UQWsjMnRDx0MouUUBe7DxHXOPd32pQJYysbbJZLLgH
         xlEMIfX9TjiQ+72+ycMhG1eMvquOXetDj2NhDc9pedmsJU9lRUIPuf8Q0mfCT+Z74Pjf
         yCDRJ+CA+TaGOqToLtodun/RLgCBPA0aO6HVisiIC05uiTi+4FORM5tjzYEcsdrHNd6T
         wvNUSYsmzHT8lv5HXIX1e6XMrF/B/D9vp76MjyyLkRYtFV2y5qHoKO2H9z/aPvzbK0ua
         6Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPzbJJIeJgfn8++cxkOJb5Dz/B61/Buo1muVR4A4+7E=;
        b=i/fFfMKdhavFAKUKzWaJSVhIIjOGd1c8Hzkm4u9DtWGWddouuJtDurEKluvQnG8B6g
         dC194Yb69gJp/cHB3DGd6rJUk1LC5jHRRlUYE5VEURviux95VShqyF65epW2mj11i+vK
         e+vSmtR73WhvX5uF1Kf5g0nFr/htnnb3ThkBsyXvRvZ9TOjMd/IT+BKeVhfQsN+qhh4T
         t4mfpDGYbVBtQKipZZekPC9jSLAX/c9mRAnaNvWVBcFrSS5HTzVmZUTXRz0fG2HCWeGI
         jDywGD3Vb9ukn4id56qNzyiG43IpP7j/AbrPt3KjvBfaeafZ2m+UaIRY3Nxn46jRBdN2
         Rjsw==
X-Gm-Message-State: AOUpUlFFhwMf7uAOWUusXJYUwFEpzXe+/uzbj+gBnsCbfj6HInhgjTGD
        0SHjPoB8vTVIuCguIkYOboWl1A==
X-Google-Smtp-Source: AAOMgpcPejOKXggv4n4mtOX7TLOUkJf2P1Z5h5cgj8sR5QAuAUlmFjmyKcvWXIdnmZyAlGMFPVa2rw==
X-Received: by 2002:ac8:28ca:: with SMTP id j10-v6mr26812646qtj.9.1533136636070;
        Wed, 01 Aug 2018 08:17:16 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id 127-v6sm10610783qkn.78.2018.08.01.08.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:17:15 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/9] mm: workingset: don't drop refault information prematurely
Date:   Wed,  1 Aug 2018 11:19:50 -0400
Message-Id: <20180801151958.32590-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801151958.32590-1-hannes@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <jweiner@fb.com>

If we keep just enough refault information to match the CURRENT page
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

