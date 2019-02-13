Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19FC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD824222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZuoEBFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbfBMN6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38969 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbfBMN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id f16so2510606wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xu9/37gH7GsD7XGP+9mY66oknw0IDCzNaIitxBdfe0s=;
        b=LZuoEBFVaWnAkKQXjENcMdC3sNGWcdA3HmBu8uls/pLTXjoBa2auXv/R80mygqnJQK
         +SvuJyoS3RyiqUvljTK731WoOBraKMvm6D7Ej1H743G6t7ktuiXiZnPZ744s2D7m4blq
         YsPq91p3hRdIGpL64p86i0Zmw0/8MuTO7L5usonaP4RP0hzKXLLRg6SWUHk+GxH5mzF6
         nEOg3Q7g/RhGy5whyZE7hQLMEdyr+kpaB9E7eB/EB8r10C5v2/1R+XGFej1BMSkovI23
         Njrmc4/xiClA2MC9bLpqQFPYw8oovAHIcLvHhDmRkbxPAvK5ByKy6i5x2WkPLbxGYv4N
         efiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xu9/37gH7GsD7XGP+9mY66oknw0IDCzNaIitxBdfe0s=;
        b=d3MNMyNrVcoUQOy4AcQfDxznX1CqLczVAmgIeEQ1gc7yZeeiRvL+fNawnZ8st7zMGb
         s7/LYbXyDODSOAuqeJHNsMKIlYelJyxHfz9AQrrdmqYeXfxTrJH++PgIVBgD9iOJaYbX
         cRk/oz3rKbLIeGBRQJeUpKuJTcb2wmxIbPmoynAWGsglsTjY6ARp2C5tjw+L9UL0jGgx
         NT3S9X8Dha1FSjKKL8UXbmlN+TwfHQHeFk5IHDatXkqFZ3sSf+wgl4MxivMRW4iiugsS
         D8MPajaN2H/AiEkXePeclNNd+fsdjg6PCHcfta71Emk9WuwFMmhx8eDrLtyuTlaUefWI
         9vKw==
X-Gm-Message-State: AHQUAuY8mO+cPxAa5bLatihYKblB+QHJYWfzRPLl6N+KNY6ekrZRjvnu
        N63G1T1OwSUixZmirtPXayTtlQ==
X-Google-Smtp-Source: AHgI3IYJPHef5SXRQikCmTo4N6D/LQvbU/67LalinnNI2TP41Ugpf9msJPWIIiTh0Rkcfztcv7jCLA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr442568wmi.3.1550066319928;
        Wed, 13 Feb 2019 05:58:39 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id v9sm11195866wrt.82.2019.02.13.05.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:58:38 -0800 (PST)
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
Subject: [PATCH v2 2/5] kasan, kmemleak: pass tagged pointers to kmemleak
Date:   Wed, 13 Feb 2019 14:58:27 +0100
Message-Id: <cd825aa4897b0fc37d3316838993881daccbe9f5.1550066133.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1550066133.git.andreyknvl@google.com>
References: <cover.1550066133.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we call kmemleak hooks before assigning tags to pointers in
KASAN hooks. As a result, when an objects gets allocated, kmemleak sees
a differently tagged pointer, compared to the one it sees when the object
gets freed. Fix it by calling KASAN hooks before kmemleak's ones.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.h        | 6 ++----
 mm/slab_common.c | 2 +-
 mm/slub.c        | 3 ++-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 4190c24ef0e9..638ea1b25d39 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -437,11 +437,9 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 
 	flags &= gfp_allowed_mask;
 	for (i = 0; i < size; i++) {
-		void *object = p[i];
-
-		kmemleak_alloc_recursive(object, s->object_size, 1,
+		p[i] = kasan_slab_alloc(s, p[i], flags);
+		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
-		p[i] = kasan_slab_alloc(s, object, flags);
 	}
 
 	if (memcg_kmem_enabled())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 81732d05e74a..fe524c8d0246 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1228,8 +1228,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	flags |= __GFP_COMP;
 	page = alloc_pages(flags, order);
 	ret = page ? page_address(page) : NULL;
-	kmemleak_alloc(ret, size, 1, flags);
 	ret = kasan_kmalloc_large(ret, size, flags);
+	kmemleak_alloc(ret, size, 1, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order);
diff --git a/mm/slub.c b/mm/slub.c
index 1e3d0ec4e200..4a3d7686902f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1374,8 +1374,9 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
  */
 static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 {
+	ptr = kasan_kmalloc_large(ptr, size, flags);
 	kmemleak_alloc(ptr, size, 1, flags);
-	return kasan_kmalloc_large(ptr, size, flags);
+	return ptr;
 }
 
 static __always_inline void kfree_hook(void *x)
-- 
2.20.1.791.gb4d0f1c61a-goog

