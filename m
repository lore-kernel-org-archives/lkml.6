Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89B2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39DA2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/FPUkyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbfBMN6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35649 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbfBMN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so2628073wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72pG1JXx9pTwwdTmZ4N/9abSJyq1vghQRBkOj2XfeKw=;
        b=v/FPUkyA+O8nQlrSyFo2Do+uc3abWZyy1VkLzISNPUV32Z/g2SLr6DHt8F+aP9bCca
         X2sNVYq2Mqqq8c4uFELjHM1pNYrSQZrmWsTqpS/+W0+iqYB1rcMY2GrZOVdPmvBcbP/3
         TIuUgcggk7jOZIwAgIkAqMisw0W50xiT50cphfZzTkQ2G5LO/8PFp9yGtIX8z1FDtrfz
         5V3QXmRkOhUlo00MvEKLq0FWK99shrVA2r3UxY28O6wNA+OSaq9GYNIN0lofvzfZaEYB
         3RivTm0ZInQzS2WCLBpGCahZRFX00KCUTqm1Q4ZU/LpgjOmS6s3zupxYOq/uEpYz2SNu
         7IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72pG1JXx9pTwwdTmZ4N/9abSJyq1vghQRBkOj2XfeKw=;
        b=mJjLpKutjVetjX6FgedbQtr0wYJ+emq7B0AT6N1sVvkMmebXFs1AWynu37Zq+WZjq1
         8DwK5YGDiAMyyZfczhikGemax7u4ATOlK+wEngpGvcpk07Or4wpjGKvPOOtz5KbYZf0V
         i70t237YzgtbjIPlc4zOfM1go+Sahx7QgDzJqnl+bcBMEgQruHQbHk78D1oyrorNqpbW
         2Esf1wTwGFlSQ5xfqEWNghXXw8sl3pvmjcanOpm9NDNqAp0+6Jkl/0lJTJsrvqiSBbOS
         zoQ8IBUT2MbeaDHhqD6Jg6VTgcRN1QmjwkN6NS6hDXYuLyCnxeIH0YCx/7gssE+L2ir7
         DtSw==
X-Gm-Message-State: AHQUAubYeiWJaUc6D61F22Gkgp1odN8xjs9wfDToPX/1l+4bmUJGaQtE
        uDpfk5anABiI3xGvmtxlohvoUA==
X-Google-Smtp-Source: AHgI3Ia8YJ65gI15fHc64dlpvyIVgpUQffLxwgRbwKBMOlnrlali2Rni0LlhcKEeodCN68fd3eD1yg==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr492470wrw.87.1550066325440;
        Wed, 13 Feb 2019 05:58:45 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id v9sm11195866wrt.82.2019.02.13.05.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:58:44 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 5/5] kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED
Date:   Wed, 13 Feb 2019 14:58:30 +0100
Message-Id: <d32495edd0fbef075ff7082dc691294b5477cec3.1550066133.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1550066133.git.andreyknvl@google.com>
References: <cover.1550066133.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SLAB_FREELIST_HARDENED hashes freelist pointer with the address
of the object where the pointer gets stored. With tag based KASAN we don't
account for that when building freelist, as we call set_freepointer() with
the first argument untagged. This patch changes the code to properly
propagate tags throughout the loop.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a7e7c7f719f9..80da3a40b74d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -303,11 +303,6 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 		__p < (__addr) + (__objects) * (__s)->size; \
 		__p += (__s)->size)
 
-#define for_each_object_idx(__p, __idx, __s, __addr, __objects) \
-	for (__p = fixup_red_left(__s, __addr), __idx = 1; \
-		__idx <= __objects; \
-		__p += (__s)->size, __idx++)
-
 /* Determine object index from a given position */
 static inline unsigned int slab_index(void *p, struct kmem_cache *s, void *addr)
 {
@@ -1664,17 +1659,16 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	shuffle = shuffle_freelist(s, page);
 
 	if (!shuffle) {
-		for_each_object_idx(p, idx, s, start, page->objects) {
-			if (likely(idx < page->objects)) {
-				next = p + s->size;
-				next = setup_object(s, page, next);
-				set_freepointer(s, p, next);
-			} else
-				set_freepointer(s, p, NULL);
-		}
 		start = fixup_red_left(s, start);
 		start = setup_object(s, page, start);
 		page->freelist = start;
+		for (idx = 0, p = start; idx < page->objects - 1; idx++) {
+			next = p + s->size;
+			next = setup_object(s, page, next);
+			set_freepointer(s, p, next);
+			p = next;
+		}
+		set_freepointer(s, p, NULL);
 	}
 
 	page->inuse = page->objects;
-- 
2.20.1.791.gb4d0f1c61a-goog

