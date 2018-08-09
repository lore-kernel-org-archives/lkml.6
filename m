Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B62238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpCmIiPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B62238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeHIVsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:48:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeHIVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so6067692wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VF0nRIiNwsRgtxZxCam3wcoWu6FgQBt9JWN6ZbYEIxE=;
        b=QpCmIiPMHe6+oM4RZShxaxZZNbTQRBzBBSRaY11nA6pHh6Cplzw0n7Bv2ZKvLSc+Z4
         4UHKKdRN140+D0usZ8bvkHnWnG8txA0JlSKLpWAQfuza/22n8fTJiK0/0pYWU3wYztfI
         imwCswDdjh8G72+vHnwhhEr+krHLWPfXvoJeBVl8horIV9DgQ3aUKbkBKZWci/UtBDYA
         PL0EQx54VrD05gyV+JikLNQvat9nDkHWRVe9t+VM5PtRt2mCIrCx1YRfqVdZ9scLkicl
         DbwqIS5YQJecOXU2pSRkfwTgR/fmR0bIo8aT7DX//C7AsNUp8s3K7DafoAwaXJJicyGk
         TwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VF0nRIiNwsRgtxZxCam3wcoWu6FgQBt9JWN6ZbYEIxE=;
        b=omNevmuV026E8knJutP1H5BDM8jIL8dcCHy4sH8xdMo5I8GakG74J/f1n7BayQTbrY
         t9zGkQLpk+LlKwQtbvVIjTuCxQ4rtasY96IYR+BWgCm4oRRJg0ok59QfNe849/roOqLL
         JxNDtYQG5mq+MVBt16/Li5F6Ix5Xwj853ipOSTU8BwHpuKIe+ZiCtKYpIv1zp8ttyWgp
         Dki3u+NeSxbaq324VTHL2WwfJgZYyFT58qtQdHDnayQBSxvfzZU3ka/sQP2Vktri6jwI
         g1uIR2BPYBow8qT1lYwIrcHFqCoxZ+gk+9TWGpP4KqyRCKgDsuElpaRyth1X5vklu2lR
         rwpw==
X-Gm-Message-State: AOUpUlFExdQBRM0IQImzXuCXPIBRpZQh7Ci3+m6i58CkiyiGt7qo9DBk
        y+6B7vXLkDoq5BVfvj1gD0e9VQ==
X-Google-Smtp-Source: AA+uWPxhYsId7VaUHrC78gT2n+1+K1ulTL3bbqXgHVcHJ0gFRtLR022OJpGJB7i55vRAGW0nyD8Atg==
X-Received: by 2002:a5d:6401:: with SMTP id z1-v6mr2271039wru.64.1533842488063;
        Thu, 09 Aug 2018 12:21:28 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:27 -0700 (PDT)
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
Subject: [PATCH v5 08/18] khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
Date:   Thu,  9 Aug 2018 21:21:00 +0200
Message-Id: <625d42d5cb7f20bb54ce7af2c4b87910b1474c74.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
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
 mm/slab.c | 6 +++++-
 mm/slub.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 6fdca9ec2ea4..3b4227059f2e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -403,7 +403,11 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
 				 unsigned int idx)
 {
-	return page->s_mem + cache->size * idx;
+	void *obj;
+
+	obj = page->s_mem + cache->size * idx;
+	obj = khwasan_preset_slab_tag(cache, idx, obj);
+	return obj;
 }
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index 8fa21afcd3fb..a891bc49dc38 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1532,12 +1532,14 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	/* First entry is used as the base of the freelist */
 	cur = next_freelist_entry(s, page, &pos, start, page_limit,
 				freelist_count);
+	cur = khwasan_preset_slub_tag(s, cur);
 	page->freelist = cur;
 
 	for (idx = 1; idx < page->objects; idx++) {
 		setup_object(s, page, cur);
 		next = next_freelist_entry(s, page, &pos, start, page_limit,
 			freelist_count);
+		next = khwasan_preset_slub_tag(s, next);
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
@@ -1614,8 +1616,10 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	shuffle = shuffle_freelist(s, page);
 
 	if (!shuffle) {
+		start = khwasan_preset_slub_tag(s, start);
 		for_each_object_idx(p, idx, s, start, page->objects) {
 			setup_object(s, page, p);
+			p = khwasan_preset_slub_tag(s, p);
 			if (likely(idx < page->objects))
 				set_freepointer(s, p, p + s->size);
 			else
-- 
2.18.0.597.ga71716f1ad-goog

