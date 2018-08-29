Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDB820862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGIcisOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDB820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeH2PcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54287 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbeH2PcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so4939040wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tx0f81qpatBTU8Zf6Dt4IAw08NEBAMzFHV/7KuZJzc4=;
        b=tGIcisOz2STm0aJshASbTJeJ69RT8JMoAH3f4aCxVwgBItaA52XRJ9qdZYIaZsI2u5
         84WxLKUwRjMLHaDEbGCci5rvpBoXQf4II3EtOgQRIvriYehFbI+64zM0dxij1O8dZcgA
         0d4nuejpivMGGQO1gx9cPHhEWv7CdpbHsbyN8BudnoODPUQmrsBQrUnuYsKojZIqQrCt
         Y9gel9LN3l73cl3wtQZRwiyWtT1nUqrnnz+hgzlv/Tl+9TGC4ePGJhT2Lb0s6waiatxg
         2jcKeIiW7gFzRHE/xwny+3A+SxEd+mYTqitxyw5Ii/nxehKFNx+YeMhys9uxy7VlTNq1
         bVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tx0f81qpatBTU8Zf6Dt4IAw08NEBAMzFHV/7KuZJzc4=;
        b=RCge9wnY/9K8WsPznOfDlaV2sKZFfJiw+oUucMGVQy6RPqgfvZpu/P81YKeSTE/b3r
         8QynsHg7nrMBOdKIcNoZ2MYJ0HWHbYKiYJBIfLm6+ZriHsEK2govF+HBETMRGzXfoYKz
         bLWV+QFWlYvG78SLDkVv/CQvPtwcq2RzRudR5/+Tg1xnCfbqJEpRbZvPTkknh0TR7h8O
         bYBzb5Q84YHV+6gwYGJulAn2YN3Ifa++hPTonsyXUxwrGcJUKNsA6cOWIzr7ywitIbpP
         DVtP6np9d2ObE3To2Ar+oXvtEkK9+lBAGOzetIbXpaQATaqbfjLP9uYrfmDOYbuk8DBF
         9ZQQ==
X-Gm-Message-State: APzg51AKsIFDSflttYNCZbE2u8cbVK6duFJ95H3/ajEyG59coUCZorSR
        g0zF9jHGfHc8b6k19dPGS0YLCA==
X-Google-Smtp-Source: ANB0VdY0nxFKwxx75PWHyKBWLlnvXmuWojLgvitD/kFGr51SPbBFXRZ2fLWPnFpHFc/eIOY2zo7EzA==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr4162464wmt.94.1535542540551;
        Wed, 29 Aug 2018 04:35:40 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:39 -0700 (PDT)
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
Subject: [PATCH v6 08/18] khwasan: preassign tags to objects with ctors or SLAB_TYPESAFE_BY_RCU
Date:   Wed, 29 Aug 2018 13:35:12 +0200
Message-Id: <95b5beb7ec13b7e998efe84c9a7a5c1fa49a9fe3.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
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
index 4206e1b616e7..086d6558a6b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1531,12 +1531,14 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
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
@@ -1613,8 +1615,10 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
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
2.19.0.rc0.228.g281dcd1b4d0-goog

