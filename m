Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA1BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087EC20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/oxOrN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087EC20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbeITAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbeITAee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so6898800wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRTggFtQ5Xof0bdpE6trnqe/KQMT5YATFM7eSCvBAOE=;
        b=b/oxOrN65ba3FkcfZ2rFk/U//pgLsJhOJqSgx6/bVZO7dAe8XpR+r9MKsZ+EhAMzd6
         F8j0gHTQORVFzJ/G8j3QHlxTriBz4n6iOR9sEGqx4ykMuyqHm6wD2otk1fbcciHVRcx9
         TF/WhauK2uM9LGI7Zf0HPXltws79YU1D9IHHnMbkDEqdyCcGmeKL8LKnhpU3qgBAiOOQ
         z3yAKeCgdq5hSYtWPyvE2e818NqwPNnSUeTDxgJcDkdSIG/aOh4l1Uxq4P0B1GLXqn6i
         8sgmAvE/YejHR7OKDCAHBn1FsK3JC7WYYsCr++MTr6qDjp0Am/TaPUBEz2pxALKJtV46
         TstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRTggFtQ5Xof0bdpE6trnqe/KQMT5YATFM7eSCvBAOE=;
        b=KbecKWJnZ5gSVq8VqMUo6C2hYjzJl3VWw7+fULp8ivemRHqemjq0if7MZWRw1XNbL2
         VefxiCj2LPocQ4jTSda4Zf2uY1pPRmTqPDQPhLgDsJFFMUQttfQGIaPms46tAoY4LfI2
         KPqcAvc1S2BofYFVC/CriS4CieATBXH6YKkEPvunFgyXTH43WBP0U91ZM3IOaNGpvGc3
         u11aTt6fryhf4ilXuohARwM5nAHkRmJ1ZTinqTzeNYTp4d+3aYRzFIgSLoBFGxOAiMdP
         I/5jfz0nSA52mYBuu8vZLyd3UES32y0ZVn8ohcYo0+BYvp88KrgPgXwPidfe+pdv67Kj
         koJQ==
X-Gm-Message-State: APzg51D5rFGSEvBPYVZmat4FaU8KvyR9x9LHYdDtpAH9wx2VMotNfl/F
        6YcqK74JlaWWEyZ0If1SJffuHg==
X-Google-Smtp-Source: ANB0VdYyUSbjWAVxz/tZw9sJ0Nn/OHR0lGdwfdGP/aqrt1Zlm7xgeFQykgyrZTq/UUXdEolG+C4GSw==
X-Received: by 2002:a5d:63c4:: with SMTP id c4-v6mr5404693wrw.106.1537383318103;
        Wed, 19 Sep 2018 11:55:18 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:17 -0700 (PDT)
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
Subject: [PATCH v8 09/20] kasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
Date:   Wed, 19 Sep 2018 20:54:48 +0200
Message-Id: <d74e710797323db0e43f047ea698fbc85060fc57.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c |  2 +-
 mm/slub.c | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 6fdca9ec2ea4..fe0ddf08aa2c 100644
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
index c4d5f4442ff1..75fc76e42a1e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1413,16 +1413,17 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
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
@@ -1530,16 +1531,16 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
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
@@ -1561,7 +1562,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct page *page;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
-	void *start, *p;
+	void *start, *p, *next;
 	int idx, order;
 	bool shuffle;
 
@@ -1613,13 +1614,16 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
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
2.19.0.397.gdd90340f6a-goog

