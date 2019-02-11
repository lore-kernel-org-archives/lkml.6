Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85AE218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXw7e0VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBKWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:00:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfBKWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:00:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so456993wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+CAbD8bU+nyd3L0sYTP0WbxN9sT6g9T2UAB46YxuA8=;
        b=AXw7e0VUVwpxGIBaconhcN6hqrC4WQR4zPt8o0rYjlgynPJ6dGhpuRpD7+aAnAGkqn
         dKfMliiAoNqHNajceLpH3nZ/VwnE9iP8MwkrBmswHsu7N60/z3wXikIVui2Hf/L3bjVU
         rmkXHSaBgSZX+zs0yMP1i3+QHzOtBbNKruR1isCq1cYSSGdDyVjYXn4WRlBTvY6W+eIq
         xKGTI49OWsqkTTjeeWo2X/2xCbVq7p/jp8qnMO0aBqEWhAmXoWNEqSp9t6nbdJC+h9Pt
         +FTBq6sEkiVZ+9tpWtj5WBaTDMnEMuayhPLfyLBnWLIcikTGHPe4mqcefLqMxHmDkgzS
         CAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+CAbD8bU+nyd3L0sYTP0WbxN9sT6g9T2UAB46YxuA8=;
        b=COl/c8/C2LuMZVH6dRPbTl5TArKG+EiGFa/fZ/HXuJTq+ZnPTWvDZnP+kKOKZ2nAkS
         xtLfalLIWxWUsnbiycxO8bZ7WDk09dzEurdVXT65R3CYv/8Ll3sNqo5gQLwKNKhOZm1H
         zTKKtIGr11623sSTtRqNAWs0fE1+5JlKgOLBB4P0+g517mhRWdnlyTTOXefY2GJwPXnY
         1bP/kx/9Mqu0MyO4UmfopGBzlVstoKnCvno/1v291/eizomJ1zVES5g9V87D1zrMXU6E
         iGbkftgQ4/J+C1oyz09w1eqs3x4FL6YFVLSXH0ExqK2v/RfIlqOFjZwCaAd2cTfU4d5U
         qikg==
X-Gm-Message-State: AHQUAuZrQC68e7q95btGp3/qzo3R6UjWq+pKDJeGQURTgAL25581XqQ1
        H9m1uYMRz+KRWxBo5TNyKgEQbw==
X-Google-Smtp-Source: AHgI3Ibr24Su8y7sxS10natSgYZC4T4Yaa/HmavywUcKbRoFeE8GXeKiZeBTQW0K67qDQuE3IdbBbA==
X-Received: by 2002:adf:dd43:: with SMTP id u3mr240892wrm.259.1549922408030;
        Mon, 11 Feb 2019 14:00:08 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id c186sm762685wmf.34.2019.02.11.14.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:00:06 -0800 (PST)
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
Subject: [PATCH 5/5] kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED
Date:   Mon, 11 Feb 2019 22:59:54 +0100
Message-Id: <3df171559c52201376f246bf7ce3184fe21c1dc7.1549921721.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <cover.1549921721.git.andreyknvl@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
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
index ce874a5c9ee7..0d32f8d30752 100644
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
@@ -1655,17 +1650,16 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
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

