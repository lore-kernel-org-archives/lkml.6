Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11539C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF23D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWNBSsqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF23D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967279AbeFSVeD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:34:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45921 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755540AbeFSVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:34:00 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so521188plz.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AmhTaLNxGC2BAojzV69ygk/jhRntCSeZg+uppgLdQhI=;
        b=QWNBSsqNZ7W3r0JBDt2Cv1pKRNeIgZeFHhm1mEpA2xBDP4PwP4CR37rDt0vwLAT2qG
         VpDSkqeh/xGC5id5P+/neWRvST40Z1OiFZI7EPikHOZWemiNxBC3JOXim6bf/MVa/NKt
         eA4+bfJJUTCrkzSHFp7M9m7vz0VHaIc8baUJ+xsioLPBIjgS0ln41b7duuJ2q3WVLMit
         wP+Of0Y3ZeRklRjRGPB0IcbXA46CRsUO0XX3I/gFQmM56TVbpjjx4k1H3EEz6Q+x/YMq
         yKFiawQhR4T2rsmKrCDzrajTAIPbZ75At2Uj9xFn3jKAn4jfy4X2jW1rRYQHca1DENj+
         K6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AmhTaLNxGC2BAojzV69ygk/jhRntCSeZg+uppgLdQhI=;
        b=bbfUBYawMoJ42fiq525tqYTgVmn4J1ttPcp17brvO1tMuSuK2MQALKgNIBQ2dJmCHJ
         v7/Tl9u6qNU8W4K9jf/svA279NqubSO1Uo+cQo0a9hQvcnY2JqolLvriavRv2Foy+iJR
         kyMtgWP34DPvv55OlyySlLzfePgsfW5J7MfasWmcpzrP8L0YFf/FBwqm1uNROZC8gL5c
         AmY1WapcRXm+YfVD6r9KsJLyEkClmekhtDhxKTBEuIBJak0cILI//JYxS1/XXXWDOg1f
         T7EqawLacRAb69/bFHCWa0olka09FC6nJdhprJDDAPLU75OonRqvLwikLVfuhVPhtjUB
         z6Rw==
X-Gm-Message-State: APt69E2tt+BkysewReZMTYPgiXyZKOomM0M8BJc3tLI3YPazo5LtYSXw
        TETdw384W0kZjrauofpeLbQoYA==
X-Google-Smtp-Source: ADUXVKLFmhpIbQZiyUi4j39mBn/ynTOpGrFDK/zZd38CngUg8xsV1pikySJT5kAQv/DUh/E/qeX6Lg==
X-Received: by 2002:a17:902:583:: with SMTP id f3-v6mr16588987plf.115.1529444039665;
        Tue, 19 Jun 2018 14:33:59 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id k10-v6sm954600pfj.29.2018.06.19.14.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:33:58 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
Date:   Tue, 19 Jun 2018 14:33:52 -0700
Message-Id: <20180619213352.71740-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
allocated per node for a kmem_cache. Thus, slabs_node() in
__kmem_cache_empty() will always return 0. So, in such situation, it is
required to check per-cpu slabs to make sure if a kmem_cache is empty or
not.

Please note that __kmem_cache_shutdown() and __kmem_cache_shrink() are
not affected by !CONFIG_SLUB_DEBUG as they call flush_all() to clear
per-cpu slabs.

Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: Jason A . Donenfeld <Jason@zx2c4.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>
---
 mm/slub.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index a3b8467c14af..731c02b371ae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3673,9 +3673,23 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 
 bool __kmem_cache_empty(struct kmem_cache *s)
 {
-	int node;
+	int cpu, node;
 	struct kmem_cache_node *n;
 
+	/*
+	 * slabs_node will always be 0 for !CONFIG_SLUB_DEBUG. So, manually
+	 * check slabs for all cpus.
+	 */
+	if (!IS_ENABLED(CONFIG_SLUB_DEBUG)) {
+		for_each_online_cpu(cpu) {
+			struct kmem_cache_cpu *c;
+
+			c = per_cpu_ptr(s->cpu_slab, cpu);
+			if (c->page || slub_percpu_partial(c))
+				return false;
+		}
+	}
+
 	for_each_kmem_cache_node(s, node, n)
 		if (n->nr_partial || slabs_node(s, node))
 			return false;
-- 
2.18.0.rc1.244.gcf134e6275-goog

