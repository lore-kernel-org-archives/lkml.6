Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF0FC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2C72075B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htKdKO8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbfBMN6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51622 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfBMN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2579011wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJ19SdNCKgDIE486SghXxp8EeRTbnWgedDgd49Ot8LY=;
        b=htKdKO8vBTjshwQ3AOXHQnliRn0Kc/VxXw/fuELJfZIt5p2O5gZSUsF3Jlhe0FkTeZ
         3M/UhAc0stoT14pdlauSdJf2FZTh0Sda9yQQCgez0E7owtrrPruZySyeFqqo69LLAa8H
         Q360545gVBI9qQ0ZQOYy0wij5E76UXsK6xgkZD+UHJID4L9I0q/hCt3G60FVtLZjmbnO
         45X4MQAtsfktah0kAQEZQVq2fT8Eoa6gR/MTOKnKgIlOj9Ols0BjUSyAfB1rhUGlXexd
         ZJQtEIYllF/hRJwCKNFLRog1j08jsXuRQHVzq18Mj/7Z883WDpVYDrnfrCElgy3Db0sh
         PWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJ19SdNCKgDIE486SghXxp8EeRTbnWgedDgd49Ot8LY=;
        b=ij5q1Ll4TJaFI8TWKjR5D/Qgo4ksDFoFZxFoRvxTY9m7BMAr+seLOjsUKR2ZUHv1Kf
         nBAyoHlNoSlhGx+/K3AMPKnYvI+VHCyD9W1P8+1ZlcLiPzbtqE83IYZrSezomoZHs91P
         35rykFhBH5Ip5ISEYMHY58wONADDj6RtXNNLhBC5q9JEJmTLIhAqkZeM8VuaPMpzKDjO
         rID83TB0yUj3HCtXXsR61GM9jhOwmcK+84IYeV3f/28Z+FoOkcDjOszCHmr6cjlPIO0X
         0KCsGY/rYo6PKYda0hd5zFLafwXtX5bI8TZJVgvQ1mv3b2Be+ifJyE7MPDZhGqe3I4bz
         y2hA==
X-Gm-Message-State: AHQUAuaiGp//9uR+uCrPF55+0WXVc5SWAa7ZOrOgJEmejUha5XdTAq7C
        QJvVt52mh/FolPpyUlbD0MGxWA==
X-Google-Smtp-Source: AHgI3IZzwEwCq280Wk1OdXfBbHFirTmNRy3Kd9bMAGui2G/AoloTA3zMirRTtinqrouFWX4qc+C4Uw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr438129wma.32.1550066323461;
        Wed, 13 Feb 2019 05:58:43 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id v9sm11195866wrt.82.2019.02.13.05.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:58:42 -0800 (PST)
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
Subject: [PATCH v2 4/5] kasan, slub: move kasan_poison_slab hook before page_address
Date:   Wed, 13 Feb 2019 14:58:29 +0100
Message-Id: <ac27cc0bbaeb414ed77bcd6671a877cf3546d56e.1550066133.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1550066133.git.andreyknvl@google.com>
References: <cover.1550066133.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With tag based KASAN page_address() looks at the page flags to see
whether the resulting pointer needs to have a tag set. Since we don't
want to set a tag when page_address() is called on SLAB pages, we call
page_kasan_tag_reset() in kasan_poison_slab(). However in allocate_slab()
page_address() is called before kasan_poison_slab(). Fix it by changing
the order.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f5a451c49190..a7e7c7f719f9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1075,6 +1075,16 @@ static void setup_object_debug(struct kmem_cache *s, struct page *page,
 	init_tracking(s, object);
 }
 
+static void setup_page_debug(struct kmem_cache *s, void *addr, int order)
+{
+	if (!(s->flags & SLAB_POISON))
+		return;
+
+	metadata_access_enable();
+	memset(addr, POISON_INUSE, PAGE_SIZE << order);
+	metadata_access_disable();
+}
+
 static inline int alloc_consistency_checks(struct kmem_cache *s,
 					struct page *page,
 					void *object, unsigned long addr)
@@ -1330,6 +1340,8 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s,
 			struct page *page, void *object) {}
+static inline void setup_page_debug(struct kmem_cache *s,
+			void *addr, int order) {}
 
 static inline int alloc_debug_processing(struct kmem_cache *s,
 	struct page *page, void *object, unsigned long addr) { return 0; }
@@ -1643,12 +1655,11 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (page_is_pfmemalloc(page))
 		SetPageSlabPfmemalloc(page);
 
-	start = page_address(page);
+	kasan_poison_slab(page);
 
-	if (unlikely(s->flags & SLAB_POISON))
-		memset(start, POISON_INUSE, PAGE_SIZE << order);
+	start = page_address(page);
 
-	kasan_poison_slab(page);
+	setup_page_debug(s, start, order);
 
 	shuffle = shuffle_freelist(s, page);
 
-- 
2.20.1.791.gb4d0f1c61a-goog

