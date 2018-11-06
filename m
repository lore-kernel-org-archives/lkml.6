Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C9C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8410A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvmCGUI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8410A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbeKGC5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34974 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbeKGC5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so5131668wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8r2DFMCmgv2dbc3cAFakXBt3nELpcd/DvTnHXWqU0so=;
        b=lvmCGUI+87O0ce35KSXHBahMKJ94XjvOa/lc1RzDbLGdAMVgMJf/dEKG+kDc4wjr/N
         SH5DgfCv1uex78tmHBn1CeQ5oQRZiRfXq/oKbb7MwNqgo7XFo3Ij8Xt2OkMIZcBGxroH
         Z/00EW3ffnxNitl5dpxL53MIFDWucsW4MYcyodfy1MDGc5Z22Ei6D6VBvF1sAl+/TYWN
         ijYS5Ns+oGXcEid8nTSC8bHf98JDq+0qw+Nb2NvtyLZwfcOpsuogr4u5sZiBj622KHoW
         uxrlLbnWhzVexMHZMYlJhh+n7eisaAq6BmCE62Q7AbeW/FS0QBTGrwU+FaWIrry5HC16
         rLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8r2DFMCmgv2dbc3cAFakXBt3nELpcd/DvTnHXWqU0so=;
        b=dnliopQS2Cr5WdUaJ/Mkd5C4KizApakgeWqDj8E2OmQ+cLOFrQgXplkt1bT6cdgdef
         JeWiwrs83UIUvRCULgY2uiDbtNe2FtnMODtpSfl5iU/7SqrNtPZHf3r7nNHjQd8DLtsg
         dag3RQ4gfYhEPDyNx2rOnKQkx/l8y/4+p06FD/7wolPWIEs3XzBVkTUpZoMUJs2SPa33
         JSnsDQ89MJ8pORASrkroVUAptfE1vl88uv6sLjXYudIigVd6vaxdwplUpiYXhEXdjAeY
         kqo7YsbRaQgU1rCVgifzpqUKwjTsESLmVmt3HlafKPZlLZzJYRHXkiZIDXB1XBBKpROV
         X8cA==
X-Gm-Message-State: AGRZ1gIx/OINmLCd1ANWdBonB33P2oFKgW1jmkTOD5Mq8vdBkMNNJmkP
        GZNQqskcGk5iGJA6uvbR6J8tfA==
X-Google-Smtp-Source: AJdET5esDe6ZtATwtaDTsbSQ9FhotCf4hRaEsVPOy3OZwBrbEtOas7y6YubwybzaHKnZJ0hspUDlEg==
X-Received: by 2002:a1c:a141:: with SMTP id k62-v6mr2678368wme.68.1541525474870;
        Tue, 06 Nov 2018 09:31:14 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:31:14 -0800 (PST)
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
Subject: [PATCH v10 20/22] kasan: add __must_check annotations to kasan hooks
Date:   Tue,  6 Nov 2018 18:30:35 +0100
Message-Id: <b1fb38e57c70462fb7369b237cd04ff36fdae0b7.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __must_check annotations to kasan hooks that return a
pointer to make sure that a tagged pointer always gets propagated.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 16 ++++++++++------
 mm/kasan/common.c     | 14 ++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d5a2a7f1f72c..a8ee04b3d1c1 100644
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
2.19.1.930.g4563a0d9d0-goog

