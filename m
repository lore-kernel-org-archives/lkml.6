Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828360; cv=none;
        d=google.com; s=arc-20160816;
        b=iH2jeZuIWOfMAffOaB6ybGmWcCoTl438Bf9d6V5oPuSgefpJaW9lwccELdcJ2+G+Js
         c4DhWayOdG8Csgj2eDUfnlFyAuGSxeaEu3ViRLL3JZ7MJYvXtg3rbaBiWa6f2J4YT1CX
         NdSWdkLH5wPTCcl+V3XvdV5A13Sw4jZGaOIZ/0cmGGpKmQhaOQOfgf9NcH9dc7+L7yeV
         Prm7DKsIJuZjLxcktht/yvVaoB9A2YXi1UmZ0vHhXzInBFf+T6U5wqf9PklK7h/uUgof
         hJX0jB/c+Qu54Rza07Bnh4N/Cm+PePt/t5n7dEADpRjWcKAWgIhasJqdmhER70HjzrXo
         /tHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XEy68RBkfEashFrKGcH1uJEVuBlNlnzcGMXgwTtONjg=;
        b=ZKa9LvSkkDjwAaclIEPmoJ8jhlZUyDbs4npRIpgJWsBs+iqnkbHJIh38BYPEQFHOSX
         2a7k46hTNj7X+KehbOU4jXPcVQfqWaE2aRWiKdXpptzf7NLASHI9qL2nr0JRDycOrXzC
         g4TYCwT10QhV6Lj6nTp4ij9BeF3sVzHgNirHY//85jCVzgG/cd9cR0NlQM3eMHso98dS
         qmkec4ZpBAX7nyieUcO3OP6Tm/X63ZbR4oQKBNuK1twaLyZai6KVv4fdNoBw81qNRlnA
         6S3CDAPcxMGUSrtqkemsZOcPqrVg82+WAdG02sn2MsbrFfTmB2I0lq6D9GiTwl6sfQzN
         Mc6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=i0KSv3oP;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=i0KSv3oP;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsmymWeFrZYtvufjyXiHDDe+XWp9Gef5lOcUIfPjF651xyMlSrbDp96fFRvGhCS88CkQ2W3Xw==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	"GitAuthor : Andrey Konovalov" <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: [RFC PATCH v2 01/15] khwasan, mm: change kasan hooks signatures
Date: Fri, 23 Mar 2018 19:05:37 +0100
Message-Id: <c88fd6894c2e17be5b1f20f6d6feca3a8dda8d32.1521828273.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752694971708059?=
X-GMAIL-MSGID: =?utf-8?q?1595752694971708059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KHWASAN will change the value of the top byte of pointers returned from the
kernel allocation functions (such as kmalloc). This patch updates KASAN
hooks signatures and their usage in SLAB and SLUB code to reflect that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 34 +++++++++++++++++++++++-----------
 mm/kasan/kasan.c      | 24 ++++++++++++++----------
 mm/slab.c             | 12 ++++++------
 mm/slab.h             |  2 +-
 mm/slab_common.c      |  4 ++--
 mm/slub.c             | 16 ++++++++--------
 6 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index adc13474a53b..3bfebcf7ad2b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -53,14 +53,14 @@ void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
 void kasan_poison_object_data(struct kmem_cache *cache, void *object);
 void kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
 void kasan_kfree_large(void *ptr, unsigned long ip);
 void kasan_poison_kfree(void *ptr, unsigned long ip);
-void kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
 		  gfp_t flags);
-void kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
+void *kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
 
-void kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+void *kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
 bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
 
 struct kasan_cache {
@@ -105,16 +105,28 @@ static inline void kasan_poison_object_data(struct kmem_cache *cache,
 static inline void kasan_init_slab_obj(struct kmem_cache *cache,
 				const void *object) {}
 
-static inline void kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags) {}
+static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
+{
+	return ptr;
+}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
-static inline void kasan_kmalloc(struct kmem_cache *s, const void *object,
-				size_t size, gfp_t flags) {}
-static inline void kasan_krealloc(const void *object, size_t new_size,
-				 gfp_t flags) {}
+static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
+				size_t size, gfp_t flags)
+{
+	return (void *)object;
+}
+static inline void *kasan_krealloc(const void *object, size_t new_size,
+				 gfp_t flags)
+{
+	return (void *)object;
+}
 
-static inline void kasan_slab_alloc(struct kmem_cache *s, void *object,
-				   gfp_t flags) {}
+static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
+				   gfp_t flags)
+{
+	return object;
+}
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 				   unsigned long ip)
 {
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index e13d911251e7..d8cb63bd1ecc 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -484,9 +484,9 @@ void kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 }
 
-void kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
+void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
 {
-	kasan_kmalloc(cache, object, cache->object_size, flags);
+	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
 
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
@@ -527,7 +527,7 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		   gfp_t flags)
 {
 	unsigned long redzone_start;
@@ -537,7 +537,7 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		quarantine_reduce();
 
 	if (unlikely(object == NULL))
-		return;
+		return NULL;
 
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
@@ -550,10 +550,12 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 
 	if (cache->flags & SLAB_KASAN)
 		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
+
+	return (void *)object;
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 {
 	struct page *page;
 	unsigned long redzone_start;
@@ -563,7 +565,7 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 		quarantine_reduce();
 
 	if (unlikely(ptr == NULL))
-		return;
+		return NULL;
 
 	page = virt_to_page(ptr);
 	redzone_start = round_up((unsigned long)(ptr + size),
@@ -573,21 +575,23 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 	kasan_unpoison_shadow(ptr, size);
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_PAGE_REDZONE);
+
+	return (void *)ptr;
 }
 
-void kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void *kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
-		return;
+		return ZERO_SIZE_PTR;
 
 	page = virt_to_head_page(object);
 
 	if (unlikely(!PageSlab(page)))
-		kasan_kmalloc_large(object, size, flags);
+		return kasan_kmalloc_large(object, size, flags);
 	else
-		kasan_kmalloc(page->slab_cache, object, size, flags);
+		return kasan_kmalloc(page->slab_cache, object, size, flags);
 }
 
 void kasan_poison_kfree(void *ptr, unsigned long ip)
diff --git a/mm/slab.c b/mm/slab.c
index 324446621b3e..ec6a9e8696ab 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3538,7 +3538,7 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc(_RET_IP_, ret,
 			       cachep->object_size, cachep->size, flags);
 
@@ -3604,7 +3604,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 
 	ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(_RET_IP_, ret,
 		      size, cachep->size, flags);
 	return ret;
@@ -3628,7 +3628,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
@@ -3647,7 +3647,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 
 	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, cachep->size,
 			   flags, nodeid);
@@ -3666,7 +3666,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
 	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 
 	return ret;
 }
@@ -3702,7 +3702,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 		return cachep;
 	ret = slab_alloc(cachep, flags, caller);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(caller, ret,
 		      size, cachep->size, flags);
 
diff --git a/mm/slab.h b/mm/slab.h
index 51813236e773..8a588d9d89a0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -440,7 +440,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 
 		kmemleak_alloc_recursive(object, s->object_size, 1,
 					 s->flags, flags);
-		kasan_slab_alloc(s, object, flags);
+		p[i] = kasan_slab_alloc(s, object, flags);
 	}
 
 	if (memcg_kmem_enabled())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 10f127b2de7c..a33e61315ca6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1164,7 +1164,7 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	ret = page ? page_address(page) : NULL;
 	kmemleak_alloc(ret, size, 1, flags);
-	kasan_kmalloc_large(ret, size, flags);
+	ret = kasan_kmalloc_large(ret, size, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order);
@@ -1442,7 +1442,7 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 		ks = ksize(p);
 
 	if (ks >= new_size) {
-		kasan_krealloc((void *)p, new_size, flags);
+		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index f111c2a908b9..4a856512f225 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1350,10 +1350,10 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  */
-static inline void kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
+static inline void kmalloc_large_node_hook(void **ptr, size_t size, gfp_t flags)
 {
-	kmemleak_alloc(ptr, size, 1, flags);
-	kasan_kmalloc_large(ptr, size, flags);
+	kmemleak_alloc(*ptr, size, 1, flags);
+	*ptr = kasan_kmalloc_large(*ptr, size, flags);
 }
 
 static __always_inline void kfree_hook(void *x)
@@ -2758,7 +2758,7 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
@@ -2786,7 +2786,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
 
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
@@ -3767,7 +3767,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
@@ -3784,7 +3784,7 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	if (page)
 		ptr = page_address(page);
 
-	kmalloc_large_node_hook(ptr, size, flags);
+	kmalloc_large_node_hook(&ptr, size, flags);
 	return ptr;
 }
 
@@ -3812,7 +3812,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
-- 
2.17.0.rc0.231.g781580f067-goog
