Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51400ECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331D214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="q1WF876n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1331D214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJJCGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:06:38 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38324 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:06:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id e190-v6so1105270ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tna855SkPJ6zYFOEu1mpIZPvXX+jOZfy3FmFArQWAbk=;
        b=q1WF876nhlbyKtvMhfR0OHFYV+tN6WzFjXq9mfW/WofE2vNw11mls/DaXKi3PsVf5K
         Cwsn0hgXBM8SJdQ3Tb6/o/9p0arMyyLmOI5y0p+1a/UxB1iiT1b/T/+UPO4PAptmlKwl
         Q46Ibp3kVYUyogtr6imYiaJtCKGNWsrsTGMnpemZVR1RxLquBg56ToXyo0jfmJAZyx6Y
         qcGeVVWmXhW8f+rrJYZ9dXN5fMl7zkkfIpd1+a6yDlkuf0N7M36RWyd8i3PCmbw4ENjl
         wiZ+kW8DWh5fNvz7cvbM6tznpLhBqCVFx9GhtpLUsU6k/OXQZsl1BAYYIcKehEhGrG8F
         5yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tna855SkPJ6zYFOEu1mpIZPvXX+jOZfy3FmFArQWAbk=;
        b=d5jdLvYIPElLv822SpioKmWvFfrCI1lillsCXb9F0nKm7hNGByzmRO+MvggB0+I67G
         7byAqqv+wB/ZN6BVc41G0xf4kFQ0rm9k/uM1T3pYq6nm/8Ff63MlBcVaK+pvqDrVG73V
         /QT/eoRFfn930/5JmVJ4jDrKjzfIoAQfemPl3KqIlaK6SXoElqnMFkz0lTk7ut1FWsnK
         yZye8nW3H/IK0TUoXkJi5oxCA6vu/jr1k4nkv7INviWZo4Oi5gkwCEL4H9szLymWEGdW
         qezD03J618zqjQ9RDRV1lEpmPal0y4KWFHs/Lt/V1BCvx9nz32kiD+vrZ4Lkk0gsSGbl
         DC3w==
X-Gm-Message-State: ABuFfogBmljaIqHREZDzxZkb4GiRzb5jBnXCvwBhzzEcCRtdZy7QmKBl
        lyOPAsZI6b/uPUNUNEfiBotEsA==
X-Google-Smtp-Source: ACcGV61NpOFRd7f6oU6wl2iozn2f50mVxftcibOyxiAUnAeB6uGQt7UX/2EPdAIfEew1wsTlD+GhGg==
X-Received: by 2002:a25:3a86:: with SMTP id h128-v6mr16695599yba.89.1539110895132;
        Tue, 09 Oct 2018 11:48:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:14c5])
        by smtp.gmail.com with ESMTPSA id r8-v6sm15176136ywa.56.2018.10.09.11.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:48:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] mm: workingset: don't drop refault information prematurely fix
Date:   Tue,  9 Oct 2018 14:47:30 -0400
Message-Id: <20181009184732.762-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009184732.762-1-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shadow shrinker is invoked per NUMA node, but the shadow limit
enforced for cgroups is based on the page counter, which isn't NUMA
aware. Instead of shrinking shadow pages to desired_size, we end up
with desired_size * nr_online_nodes.

Switch to NUMA-aware lru and slab counters to approximate cgroup size.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/workingset.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 1d111913929d..e5c70bc94077 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -418,9 +418,15 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	 * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
 	 */
 #ifdef CONFIG_MEMCG
-	if (sc->memcg)
-		pages = page_counter_read(&sc->memcg->memory);
-	else
+	if (sc->memcg) {
+		struct lruvec *lruvec;
+
+		pages = mem_cgroup_node_nr_lru_pages(sc->memcg, sc->nid,
+						     LRU_ALL);
+		lruvec = mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
+		pages += lruvec_page_state(lruvec, NR_SLAB_RECLAIMABLE);
+		pages += lruvec_page_state(lruvec, NR_SLAB_UNRECLAIMABLE);
+	} else
 #endif
 		pages = node_present_pages(sc->nid);
 
-- 
2.19.0

