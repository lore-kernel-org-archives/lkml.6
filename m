Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AA520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRAsbIGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AA520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404756AbeKTDvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:51:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404187AbeKTDvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so18733226wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnKWna4Fxza+RguSxuMKg2MKEZp1kGJKTvVJBWbpyy4=;
        b=oRAsbIGTG+DwdIgakoFqgS2wwrqiL6u/3qXf2aYV0B+JOFEAMq8PpX7k8RvwVAtj4P
         FUkJKTZgCXSTOUJZ96XPqNLsLArvFJV8e/2Mwfi5PzxQTl5c6Ij/T0z+jD8ds9xbc7OC
         Y6JM518vNZqALTyHZXgOsbMJ1wXH+v43rtH+RrV7GySWQIeo/fe27OKiy4I27AKb7P9B
         XACJCvq2frJxIebmbJZLXrXn+OFI4j40xJR99lfzw4S8BP0aKWfMrHSt6ND8ktpE/5O0
         CZ/dPz+wp8hSeEJFMRKQPluNjPND6wZqrgAww9XaoKZqECi2zg4rdly+JhkCid9XqASH
         k+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnKWna4Fxza+RguSxuMKg2MKEZp1kGJKTvVJBWbpyy4=;
        b=OTm3tmHhFhNzKgDmNCdHvxpJUdWPdnQ/HTD51+UVXohCUNUsL5aCmaem6AvABuvA8G
         0Wxo1ES9Gex5k4keJPA2M5aWVZYjrrJgJNp1fWA4QLOnI2QyAnQ7W4zxxNW2sQ1HMNw3
         UyFZ3RgVm8r/9ArimmZhNx49C6W1hyvYLWI5g2jEyoealO4PbGjITy5crcp0bpfnfUm/
         JAzco8eyj0LkjwL85y2yW8q/uQJVBPWVWo45sbQk+9fZC4WTeQOtvTuhzQoImF3y7bLm
         2NP1zMPq4eTXBg7SqYz41lEhKb5UWJLrfdBIrDeAq71AjZ7lD4e69PdTUZ5+9TIeThqF
         fPQw==
X-Gm-Message-State: AGRZ1gJcGMmM7tFPuoPQVxi0zsmXoJz/DqlyjxI6+JzMiO65zG2CNJL8
        JazqWQ3X8HiLSmJCyfAkRTJ56g==
X-Google-Smtp-Source: AJdET5eOHsG65bvoFQR6qqSubK3f30AO88X+3m5RRAiWi3EigIHxArp4k3X75wmHUzj3gP5G1V3N1Q==
X-Received: by 2002:adf:a409:: with SMTP id d9-v6mr19711186wra.190.1542648434312;
        Mon, 19 Nov 2018 09:27:14 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:13 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 12/24] kasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
Date:   Mon, 19 Nov 2018 18:26:28 +0100
Message-Id: <deb5cbe081c8e59d486d163a43f1dce99bc4eed5.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An object constructor can initialize pointers within this objects based on
the address of the object. Since the object address might be tagged, we
need to assign a tag before calling constructor.

The implemented approach is to assign tags to objects with constructors
when a slab is allocated and call constructors once as usual. The
downside is that such object would always have the same tag when it is
reallocated, so we won't catch use-after-frees on it.

Also pressign tags for objects from SLAB_TYPESAFE_BY_RCU caches, since
they can be validy accessed after having been freed.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c |  2 +-
 mm/slub.c | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 26f60a22e5e0..27859fb39889 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2574,7 +2574,7 @@ static void cache_init_objs(struct kmem_cache *cachep,
 
 	for (i = 0; i < cachep->num; i++) {
 		objp = index_to_obj(cachep, page, i);
-		kasan_init_slab_obj(cachep, objp);
+		objp = kasan_init_slab_obj(cachep, objp);
 
 		/* constructor could break poison info */
 		if (DEBUG == 0 && cachep->ctor) {
diff --git a/mm/slub.c b/mm/slub.c
index e739d46600b9..08740c3f3745 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1451,16 +1451,17 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
 #endif
 }
 
-static void setup_object(struct kmem_cache *s, struct page *page,
+static void *setup_object(struct kmem_cache *s, struct page *page,
 				void *object)
 {
 	setup_object_debug(s, page, object);
-	kasan_init_slab_obj(s, object);
+	object = kasan_init_slab_obj(s, object);
 	if (unlikely(s->ctor)) {
 		kasan_unpoison_object_data(s, object);
 		s->ctor(object);
 		kasan_poison_object_data(s, object);
 	}
+	return object;
 }
 
 /*
@@ -1568,16 +1569,16 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	/* First entry is used as the base of the freelist */
 	cur = next_freelist_entry(s, page, &pos, start, page_limit,
 				freelist_count);
+	cur = setup_object(s, page, cur);
 	page->freelist = cur;
 
 	for (idx = 1; idx < page->objects; idx++) {
-		setup_object(s, page, cur);
 		next = next_freelist_entry(s, page, &pos, start, page_limit,
 			freelist_count);
+		next = setup_object(s, page, next);
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
-	setup_object(s, page, cur);
 	set_freepointer(s, cur, NULL);
 
 	return true;
@@ -1599,7 +1600,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct page *page;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
-	void *start, *p;
+	void *start, *p, *next;
 	int idx, order;
 	bool shuffle;
 
@@ -1651,13 +1652,16 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	if (!shuffle) {
 		for_each_object_idx(p, idx, s, start, page->objects) {
-			setup_object(s, page, p);
-			if (likely(idx < page->objects))
-				set_freepointer(s, p, p + s->size);
-			else
+			if (likely(idx < page->objects)) {
+				next = p + s->size;
+				next = setup_object(s, page, next);
+				set_freepointer(s, p, next);
+			} else
 				set_freepointer(s, p, NULL);
 		}
-		page->freelist = fixup_red_left(s, start);
+		start = fixup_red_left(s, start);
+		start = setup_object(s, page, start);
+		page->freelist = start;
 	}
 
 	page->inuse = page->objects;
-- 
2.19.1.1215.g8438c0b245-goog

