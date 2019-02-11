Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B894C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC91218E2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNkhOp+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfBKWAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:00:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33506 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBKWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:00:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so515601wrw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CMPZjRzPxA9yWJGkQniQIkHzZh/Nj3CjJ78bKTFu6c=;
        b=KNkhOp+FwwqqWNp0rVoktr8lfQk/kt4OYWfZh0XzvAGg0XcRsG1vZ9foQ6V5/GjZQS
         ZtJd4pn78QAAV9XHc7Hx7Po325azOyAcAntab5T7pxquIxMo4L5vhod2HvO4oM0JS1sJ
         5wW/NCzntc/d2udqR3ieGxAD/HSjnEhECEe9Jtfv+F4yBFFMKB35cnTfuEvhVsSWOeVu
         +GBkc+Dm/3w7rbgZQAzXnDfuP3Nz8Rm1s91ixQQMVwwZfyBKL+2PEnZWizwZGxiicisf
         k+fqqLG5MgEygXacHs7JJeAcrMzplL/EfvnKRModlnR+xpLr0M1favDp3jNGs1v8W9MD
         FtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CMPZjRzPxA9yWJGkQniQIkHzZh/Nj3CjJ78bKTFu6c=;
        b=UTAmigGM38x4+C+0msaEiFyLfzYFhbV3zKUNRcCkPGVrPJQJKqrJ7mGGrSwEi0phLR
         UEEhkizfrqqS2B0EaZD15Fi4yNpqoOyH0gRN+KBenTQX2PNY5OU0wPpyHAqwvCCfMkyR
         LrqOH2OE5HlLmeROljAt/TW5vGI0mwAzr5mVn4w+/gECm2x3D+6FrpNWfpXEDkvFq9Ye
         MDETsU8zWbZpZAiSAvE4D12pYPbAMFs/nFR1ILpDu1ew+Fm+4YAQE78CWy6deJOANt6A
         wmJQDRW7HxTA7QRE874S7T8H68CPwPXUyAf7NuiPyE31t2b53L/CXvSYP8MhWwsivSMc
         Gofg==
X-Gm-Message-State: AHQUAuZBqKg/SCDWy3Wz3b3C1J7/hhstIP57H8d6C17NuzMDf30sLRcF
        1O4PpFuekiEx43AJ4YS0cvZD/w==
X-Google-Smtp-Source: AHgI3Ia32u1Rwu6dEWF9OS009TTKjKG2ZLzjUiuLH7ytuQiqzKENoj77khlFOGtz0NDNmqx4HNgfdg==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr284447wrn.45.1549922400500;
        Mon, 11 Feb 2019 14:00:00 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id c186sm762685wmf.34.2019.02.11.13.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:59:59 -0800 (PST)
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
Subject: [PATCH 1/5] kasan: fix assigning tags twice
Date:   Mon, 11 Feb 2019 22:59:50 +0100
Message-Id: <ce8c6431da735aa7ec051fd6497153df690eb021.1549921721.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1549921721.git.andreyknvl@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an object is kmalloc()'ed, two hooks are called: kasan_slab_alloc()
and kasan_kmalloc(). Right now we assign a tag twice, once in each of
the hooks. Fix it by assigning a tag only in the former hook.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 73c9cbfdedf4..09b534fbba17 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -361,10 +361,15 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
  *    get different tags.
  */
 static u8 assign_tag(struct kmem_cache *cache, const void *object,
-			bool init, bool krealloc)
+			bool init, bool keep_tag)
 {
-	/* Reuse the same tag for krealloc'ed objects. */
-	if (krealloc)
+	/*
+	 * 1. When an object is kmalloc()'ed, two hooks are called:
+	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
+	 *    tag only in the first one.
+	 * 2. We reuse the same tag for krealloc'ed objects.
+	 */
+	if (keep_tag)
 		return get_tag(object);
 
 	/*
@@ -405,12 +410,6 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
-					gfp_t flags)
-{
-	return kasan_kmalloc(cache, object, cache->object_size, flags);
-}
-
 static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
 {
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
@@ -467,7 +466,7 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 }
 
 static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
-				size_t size, gfp_t flags, bool krealloc)
+				size_t size, gfp_t flags, bool keep_tag)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -485,7 +484,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_SHADOW_SCALE_SIZE);
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		tag = assign_tag(cache, object, false, krealloc);
+		tag = assign_tag(cache, object, false, keep_tag);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
 	kasan_unpoison_shadow(set_tag(object, tag), size);
@@ -498,10 +497,16 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	return set_tag(object, tag);
 }
 
+void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
+					gfp_t flags)
+{
+	return __kasan_kmalloc(cache, object, cache->object_size, flags, false);
+}
+
 void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags)
 {
-	return __kasan_kmalloc(cache, object, size, flags, false);
+	return __kasan_kmalloc(cache, object, size, flags, true);
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-- 
2.20.1.791.gb4d0f1c61a-goog

