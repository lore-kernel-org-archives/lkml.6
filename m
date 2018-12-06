Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39095C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E945520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW/3SMqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E945520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeLFMZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:54 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43555 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbeLFMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:26 -0500
Received: by mail-wr1-f52.google.com with SMTP id r10so267467wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZfZTLqWsknIvYMLnZdolPQtd9B+6yIRrKwPZ48RLc4=;
        b=EW/3SMqpcTiMhWNm2orG3EvbNyLZ48vaZIbUCv4K7/oj7HRZ9uPY1RH0eYr1rAgVW0
         jyMP2dxynkJIJWAOyFDrXOO+bxX/RQl8Uyo6CKjDuuK1f5Yt+om29IOR4qfuWKYTdBa6
         HSbK7N4y6Wq1gjNxQBTGM2y0gddfv8BnrSJP27jRBzimexVneU2mKh133NTPYQ2fqCvG
         CPhOs/+CryNsf6lHjyX+rz5v7pe0z3I5TS14++RGHvLCAQL4JcZIvyC/7qVGdYVi9+AZ
         yENfqxMnbM8uAyVl4QWMFZDJgy1UENGmTQUl26yxkghXpslYWoLlLUoaBcjn9yfCweYI
         TAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZfZTLqWsknIvYMLnZdolPQtd9B+6yIRrKwPZ48RLc4=;
        b=jsX+91yB1VPwbUC/N0rsoNvM2NYipd/oGI7qgwPZAuuvRfZI4y63UxB7hQ5lHVGdAi
         EHKCWWc3GBJmnGaZljoOpNBhq3aiX/bg4+TF0Z6q2PPCEEg3BuKzKTa2VGmGCTX6fQ/R
         LPHNoUR1SMyFSB3todqLPphIGLU7A+cPSbrvrZbukRT+4UhbpioVRf3j1dBoNziSyiI/
         vl1T0+2v/rDO5KaB123C4wr1CKnePEWcZUqrmEZGa6g1RxUREfp+OW4U2QII9IHG4E3p
         JqexWZppdo22ke8HgrWhk7zUHmwFk52yqpB6+j2uDgqOx+lKoq4dHdA+2UT/iG9Htij8
         QlOQ==
X-Gm-Message-State: AA+aEWYOuMllAKJFb4V4rMn3xvnYHpTIn33FJOtShw0rJdqbZC1P4jXu
        vs62Aa16ljRhIRpxtF010O9+IQ==
X-Google-Smtp-Source: AFSGD/W3yTLYMQBOaLzTZ5SXjxjDat4MU8wRZ1yiVk7CrJyHq5HLrO5lLxvOMClpJkkFYNGGBhGn+A==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr20884354wrq.265.1544099124211;
        Thu, 06 Dec 2018 04:25:24 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:23 -0800 (PST)
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
Subject: [PATCH v13 22/25] kasan: add __must_check annotations to kasan hooks
Date:   Thu,  6 Dec 2018 13:24:40 +0100
Message-Id: <03b269c5e453945f724bfca3159d4e1333a8fb1c.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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
 mm/kasan/common.c     | 15 +++++++++------
 2 files changed, 19 insertions(+), 12 deletions(-)

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
index 195ca385cf7a..1144e741feb6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -373,7 +373,8 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object, bool new)
 #endif
 }
 
-void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
+void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
+						const void *object)
 {
 	struct kasan_alloc_meta *alloc_info;
 
@@ -389,7 +390,8 @@ void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	return (void *)object;
 }
 
-void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
+void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
+					gfp_t flags)
 {
 	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
@@ -449,8 +451,8 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
-		   gfp_t flags)
+void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
+					size_t size, gfp_t flags)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -482,7 +484,8 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
+						gfp_t flags)
 {
 	struct page *page;
 	unsigned long redzone_start;
@@ -506,7 +509,7 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 	return (void *)ptr;
 }
 
-void *kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

