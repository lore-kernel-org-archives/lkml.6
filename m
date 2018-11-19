Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C693C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930E213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJUIqqcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3930E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404361AbeKTDw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:52:29 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54224 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404884AbeKTDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:58 -0500
Received: by mail-wm1-f42.google.com with SMTP id g131so5752862wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Hsa8V5cyqurd6qNrrNh17vMgQf+VOFwFcgWWUblsJY=;
        b=eJUIqqcTCwdMK+Ze5U3tBDmP7zaYnnM7KjIf6MsdirCNEMcg85CW5ArsNDzJefv3Ow
         NxAFPAWc1lKeYz6XKKw/SNzpF6BbaxAPiCkfCF1fq0i8Df5tOVzMQY7L92FIapGg9vGi
         ewUGbGFHEdxAYMerulbTxKoMAJ0HKJdiC/m6cJTlDPNL8kr5xGlc0jCfEChyFnoXnp+B
         pOkxzznQGcKOfZ+Mro5UO/JZtO+069vPnr6TzWgUvL6om1WY/aDrURMVklzJlu9rxwva
         ZcDEm53f3Z8HN2tUnkRyIfYCMGWVZb1J6JE3obCk0EMXovqNXVcPqWj8byicTzfJWSE0
         2ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Hsa8V5cyqurd6qNrrNh17vMgQf+VOFwFcgWWUblsJY=;
        b=aovP83ZD8zoEASUwiwWfJv5VSk6GeHGzztNNHwpSsCyEdtIM+9d8pgEYzhiTuz92om
         n+AV+drzNrrlGQe57cGn34ZaBwvtka1OurxLVe7uaG0nGVwXJBH5zvq4U0Ud5M45jdtm
         gweaMioLTcaDpdx4GfSqKr7SEcS+Cq/BT84mn4xOoovB94SVH+h32XO99zQTASV8WaMB
         VggOaPWDwLkSFIh7huZFHlsFhX84xz77EwGgyUZ+wRQ8xIDRUOn4s62IShe+V/2QFk1A
         k8+F9y4Y7TqfzXuFykNwBViow1+EpUJL9j3NFUHZvPZCRkYRo/eRzmP45gfNT7jngJ7Z
         fm0w==
X-Gm-Message-State: AA+aEWbdZERrFqhnoOlYKnYdR+aKr1BFwE4swJ1MKLHvuaUmaVjvmcHh
        Mv3Vfo/IcqMckdE79thXgNY4mQ==
X-Google-Smtp-Source: AJdET5fanlhsIp0g/xpGFrbxrhl1+EyGkJqzbcRiaBt+vYNbFkmdxUN2MTjJ3If/N5HOS7n3bvTZnw==
X-Received: by 2002:a1c:110b:: with SMTP id 11mr5140713wmr.83.1542648451862;
        Mon, 19 Nov 2018 09:27:31 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:31 -0800 (PST)
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
Subject: [PATCH v11 22/24] kasan: add __must_check annotations to kasan hooks
Date:   Mon, 19 Nov 2018 18:26:38 +0100
Message-Id: <0a0cabf188838f1d42b417f6aadc97b8fcf5c60b.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __must_check annotations to kasan hooks that return a
pointer to make sure that a tagged pointer always gets propagated.

Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 16 ++++++++++------
 mm/kasan/common.c     | 14 ++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 8da7b7a4397a..b40ea104dd36 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -49,16 +49,20 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 void kasan_poison_slab(struct page *page);
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
 void kasan_poison_object_data(struct kmem_cache *cache, void *object);
-void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
+void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
+					const void *object);
 
-void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
+						gfp_t flags);
 void kasan_kfree_large(void *ptr, unsigned long ip);
 void kasan_poison_kfree(void *ptr, unsigned long ip);
-void *kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
-		  gfp_t flags);
-void *kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
+void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
+					size_t size, gfp_t flags);
+void * __must_check kasan_krealloc(const void *object, size_t new_size,
+					gfp_t flags);
 
-void *kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
+					gfp_t flags);
 bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
 
 struct kasan_cache {
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 195ca385cf7a..ba8e78eb0c67 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -373,7 +373,7 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object, bool new)
 #endif
 }
 
-void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
+void * __must_check kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_info;
 
@@ -389,7 +389,8 @@ void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	return (void *)object;
 }
 
-void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
+void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
+					gfp_t flags)
 {
 	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
@@ -449,8 +450,8 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
-		   gfp_t flags)
+void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
+					size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -482,7 +483,8 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
+						gfp_t flags)
 {
 	struct page *page;
 	unsigned long redzone_start;
@@ -506,7 +508,7 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 	return (void *)ptr;
 }
 
-void *kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
-- 
2.19.1.1215.g8438c0b245-goog

