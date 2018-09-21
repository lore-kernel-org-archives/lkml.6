Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A130FECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513D2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZr1l6Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5513D2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390643AbeIUVD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:03:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44935 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390865AbeIUVDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:03:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so13213761wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hO7cmdJIadnfEdKyPe4txnXVBC1YpbB0zh8lfgmkasM=;
        b=WZr1l6JoY+I0VxauNdDkNf5GbEjoBY448dSPfl6A/EwVGXDZXLzizhBatYrXgDgJ+p
         KTgu+UF7i1DJRCIsAG7F8dscP6Rl8uiTZxk6+Xx7W2BA5DUX9mAf1icqxX/KTD/Ta/Rl
         wJ5/g+GfWMk5uZl0iLUk3Wj7Osat6QvSbQB4yOUvmCGaaK6QNVebHsIzc2rpCyZwY4oL
         Z4QM5Y/hq5Y7An9eBAxqHA9RdBAlGTBhdrUNFnPARYlsc6cJUGb3l8VPf813j7Y6FwTt
         Io+7WeFgT9a4CiU88YOPH8tg0GiEQtlAS3cySWe2bCgSmPXmahDbcqBsBG59zf7I3VDe
         wLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hO7cmdJIadnfEdKyPe4txnXVBC1YpbB0zh8lfgmkasM=;
        b=VYUlFTq8xUifot76/l95hn0TJtj1Fuh3i+5T2i37mKX992w9MBfEOuWf75Q7QCCsmo
         S3kCgV/ZVJBhY+raeE5ryeyVJ5l4lgNP63eGX6JBG6wRtRwGFv2jR54ZvGSTblJmwHwW
         JSCKLTjsPn6k516p0VXEf91TwZgdT3o6PNyGCditC1/bIA+tguHEqKdvnHHLyViC15QB
         NNHVJ/jlD5nhLzBbHntdVdZknM3fE1jtUH2e0f4NjCHRLtePX+3KsTBNR+2ePrtAe9Hb
         CChnSpBC/J3GNlqBX7dkTOaOoyqOGa/FjN2JHmOcU5L/hJ7RFpGY+rhnw0klmMKle9nv
         rMjw==
X-Gm-Message-State: ABuFfoh9bX/fkyACWgUt0xrv2CuqRPOuwmVpFx+VvqYJZa+1oT550nQf
        UicFBUSozcscKc4GMmwCqoqnSw==
X-Google-Smtp-Source: ACcGV62HGuXDmfLPQoXZKl+/GDSgQWuvhepQk59IFa9Kr66tHi0cJhwaP86aGB6dF1ZWELIwPOT/hg==
X-Received: by 2002:adf:ad29:: with SMTP id p38-v6mr1807954wrc.25.1537542844026;
        Fri, 21 Sep 2018 08:14:04 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id e7-v6sm27990271wru.46.2018.09.21.08.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:14:02 -0700 (PDT)
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
Subject: [PATCH v9 10/20] mm: move obj_to_index to include/linux/slab_def.h
Date:   Fri, 21 Sep 2018 17:13:32 +0200
Message-Id: <9d62f917393456653c1d38c7173dc876cef03c93.1537542735.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <cover.1537542735.git.andreyknvl@google.com>
References: <cover.1537542735.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While with SLUB we can actually preassign tags for caches with contructors
and store them in pointers in the freelist, SLAB doesn't allow that since
the freelist is stored as an array of indexes, so there are no pointers to
store the tags.

Instead we compute the tag twice, once when a slab is created before
calling the constructor and then again each time when an object is
allocated with kmalloc. Tag is computed simply by taking the lowest byte of
the index that corresponds to the object. However in kasan_kmalloc we only
have access to the objects pointer, so we need a way to find out which
index this object corresponds to.

This patch moves obj_to_index from slab.c to include/linux/slab_def.h to
be reused by KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/slab_def.h | 13 +++++++++++++
 mm/slab.c                | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 3485c58cfd1c..9a5eafb7145b 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -104,4 +104,17 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
 		return object;
 }
 
+/*
+ * We want to avoid an expensive divide : (offset / cache->size)
+ *   Using the fact that size is a constant for a particular cache,
+ *   we can replace (offset / cache->size) by
+ *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
+ */
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct page *page, void *obj)
+{
+	u32 offset = (obj - page->s_mem);
+	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
+}
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/mm/slab.c b/mm/slab.c
index fe0ddf08aa2c..6d8de7630944 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -406,19 +406,6 @@ static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
 	return page->s_mem + cache->size * idx;
 }
 
-/*
- * We want to avoid an expensive divide : (offset / cache->size)
- *   Using the fact that size is a constant for a particular cache,
- *   we can replace (offset / cache->size) by
- *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
- */
-static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct page *page, void *obj)
-{
-	u32 offset = (obj - page->s_mem);
-	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
-}
-
 #define BOOT_CPUCACHE_ENTRIES	1
 /* internal cache of cache description objs */
 static struct kmem_cache kmem_cache_boot = {
-- 
2.19.0.444.g18242da7ef-goog

