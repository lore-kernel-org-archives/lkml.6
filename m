Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD332183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6HuAhFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBTMps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:45:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfBTMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:45:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so6320157wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQB33hyusb/Aumyn6Q8kWmHk/TEqVmhId57aQJXdZ/s=;
        b=X6HuAhFzVyDsIJPV/pL41HvGaDjlO0vTjXr2OZYAtADiu/Lz72YRfW1+XD9Kdt1DGo
         ghaPVtBevuMsjzRo5NRUgcGyU1fFMsSNZ/LRvovoxzUvGIVFHnqrcxEMrJ6T5B5iZY2S
         hGCTxP/7qnF8GV1WG/B+RacmVNJAHrbTmi3UPnWjdWHBHjUZ6cNdUqkGBBhFTJW+I22Q
         wnNLhzebb6NpoY+sHoNkDH45qrl5ETQMktoHEyMw9VhTZCXBjQONgHOi9gp8rEUMp9w7
         4CzMQhjHcfURWYGvo2aRaj1na8HB27pSa4QKQO39LnpskYbUWfDhfVukRRSU3jECiRUP
         qDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQB33hyusb/Aumyn6Q8kWmHk/TEqVmhId57aQJXdZ/s=;
        b=Q8LPaBwVPtBiXtksWi6wKraiwGRODFe4j68oQNITOU6XbTyz57CFXG2yhAphBjvUhl
         cjJj9Mx45aQvoDavKZregQigmtLL0GnVghxrNjA5ctwKFCmuZWnone5DY/4eMfdGBtGG
         qTPj1snwse71Mw26yQAWj6S7Bb65H+hKuaWbmpnuoxKVoN6vky5FuxMseY8x1P8z9XPh
         Cg816Zlqsl8d+Skk5aKHcPLOl0mH5M+YzqSJYWaSOvaPVV+7y/qH9Gw5hP6vj128Zew7
         BTf3DlcJYXq1FMuW1HO+bhsjHEV5xaKiNr01hFmyIzwmEyP/KLYk++EOH46nISroQ/KO
         jzLw==
X-Gm-Message-State: AHQUAuYVDzNeRLzGCaq6jFXc0R1UimGhWLONgkvV3SxfAj5h9Xdghaux
        +QrGWDwyrlOyUU85QZUIXKnReA==
X-Google-Smtp-Source: AHgI3IabI55h01GTJOovj1LFUoTaAv7IadDL/Z17sRBOfQGy3+UYf/86H6vdZ96ggIYEFKXQhNkZ0g==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr6011804wmb.10.1550666737166;
        Wed, 20 Feb 2019 04:45:37 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id f196sm6378889wme.36.2019.02.20.04.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:45:35 -0800 (PST)
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
Subject: [PATCH 3/4] kasan, slab: make freelist stored without tags
Date:   Wed, 20 Feb 2019 13:45:28 +0100
Message-Id: <dfb53b44a4d00de3879a05a9f04c1f55e584f7a1.1550602886.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
References: <9c4c3ce5ccfb894c7fe66d91de7c1da2787b4da4.1550602886.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to 680c37ae ("kasan, slub: move kasan_poison_slab hook before
page_address"), move kasan_poison_slab() before alloc_slabmgmt(), which
calls page_address(), to make page_address() return value to be
non-tagged. This, combined with calling kasan_reset_tag() for off-slab
slab management object, leads to freelist being stored non-tagged.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index c84458281a88..4ad95fcb1686 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2359,7 +2359,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
 	void *freelist;
 	void *addr = page_address(page);
 
-	page->s_mem = kasan_reset_tag(addr) + colour_off;
+	page->s_mem = addr + colour_off;
 	page->active = 0;
 
 	if (OBJFREELIST_SLAB(cachep))
@@ -2368,6 +2368,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
 		/* Slab management obj is off-slab. */
 		freelist = kmem_cache_alloc_node(cachep->freelist_cache,
 					      local_flags, nodeid);
+		freelist = kasan_reset_tag(freelist);
 		if (!freelist)
 			return NULL;
 	} else {
@@ -2681,6 +2682,13 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 
 	offset *= cachep->colour_off;
 
+	/*
+	 * Call kasan_poison_slab() before calling alloc_slabmgmt(), so
+	 * page_address() in the latter returns a non-tagged pointer,
+	 * as it should be for slab pages.
+	 */
+	kasan_poison_slab(page);
+
 	/* Get slab management. */
 	freelist = alloc_slabmgmt(cachep, page, offset,
 			local_flags & ~GFP_CONSTRAINT_MASK, page_node);
@@ -2689,7 +2697,6 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 
 	slab_map_pages(cachep, page, freelist);
 
-	kasan_poison_slab(page);
 	cache_init_objs(cachep, page);
 
 	if (gfpflags_allow_blocking(local_flags))
-- 
2.21.0.rc0.258.g878e2cd30e-goog

