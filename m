Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6552085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udLfAObm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6552085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbeKGC5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39932 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389780AbeKGC5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so13004043wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rI9jB7TmpIHEDx4oMZya4ulbXmsHhxN+ATa3+HN3hoo=;
        b=udLfAObmnevegDvmjvehrjJ6fumrvuolhCuOXNHOAd13A3IJR05UKexovQypoDryBl
         xLOfxlCW403tvGmJitkdVnWP7/inh2psYBnbktlBrzAK8mjKmw6moztKW1XJ6QYWQM1F
         3PRa4CiYmZw0K3YGr1xsblXGBg4vv7sPsZssjowCWXs25jv1SARq4KappkjxjvWnJsDF
         1tuvR5qdMddlKt/5Yj0fwcYGGAnCShDN/OSzNjeL+0o2oVf1rTI++h3oVLiW2rGdCUd2
         hw2TBR1eOAjs9cRRTBWTQw9tCVAM1ZZAc8GBO34Bg7TV9cfuAYpgnPpRsVM/RsfLCtNr
         i8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rI9jB7TmpIHEDx4oMZya4ulbXmsHhxN+ATa3+HN3hoo=;
        b=O92bOhjb00YniqDWqyxy9qfkPaN2bTe7Zfn1yHt9CxERUiDuOt2A1rRfpI4+Y5SzlA
         MV2ADUhd6k6qXoB6BguUR9ohnlr92Yh/vE617BlEAmkZKf+dd8XkfjxG5GB4eUtYLXoX
         9VV++WrtQSvQXdej86TimB6TSmoTLKiWIY9U5SdQuRnnZTo62FkDIYzPzWtoMR6fWddE
         78JqubiizKVS1qtjGe7cwrBXiJo7yfivAKXZQ+CvuvNseE2K1O5g68fVOckcxcsrNIxD
         8KPli6ijEp2I6a1w27BS7IX5YHSQGSNt5kimmDn2U2b1ahIe8bUJjmxBXRuVIoPc0qyR
         2F4w==
X-Gm-Message-State: AGRZ1gKJyiDGVzNoawPKDt+wujAeYRfuB1Iq0CJzMLSGIwBRvzvlSzMz
        XSmGfugBOWISltPmaetd5D31XA==
X-Google-Smtp-Source: AJdET5cXF3fWWc+IszXIBT7xTDA/coT3Nkazw/U/NtSkMe85oUqeoQTw9O2ShjMSgQDgFzZmWWgchA==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr2675547wmc.18.1541525459907;
        Tue, 06 Nov 2018 09:30:59 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:30:58 -0800 (PST)
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
Subject: [PATCH v10 11/22] mm: move obj_to_index to include/linux/slab_def.h
Date:   Tue,  6 Nov 2018 18:30:26 +0100
Message-Id: <c4424b4917e92007a20170909460aac91710f1df.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
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

Acked-by: Christoph Lameter <cl@linux.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
index 27859fb39889..d2f827316dfc 100644
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
2.19.1.930.g4563a0d9d0-goog

