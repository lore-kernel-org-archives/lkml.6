Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3981C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329192083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmn53wZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329192083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIGVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:38:40 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45998 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIGVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:38:38 -0400
Received: by mail-vk1-f194.google.com with SMTP id b78-v6so1088343vka.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zP4e3VGpL4AfY3LmW/Dccb168S39DPOI7mrlEXUy4hA=;
        b=Pmn53wZECiD8VepOEmgkGLuXNGWDsnxmpKVQibxB40bHV6WsUg94wuojMVFIHyPWm0
         Pz9zDF4y/jQP3d0xye+rDgGoDhaGtEKajSRWlN7b1Bflog0p5FksRpM5mPFrUGyuJSxA
         PHgyz8pN+i9CsX4DtciVoZLiOm5Pp5zS9H8ADtZuGrD5AmDGOtvgQ8apqNRkZU9zU7/b
         Uvz6UmuwK0goCL75qwYuTBTDieiopI3CRgGIusyjBuUASxOwrJ+vnjlUlGwZipDV/SIg
         RU+uz9zfxPx5YmSuR0K18a6PpJOJGcuU6QjmovNPHtO202pv9yetXKo+lXlK9ZeQKvto
         kvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zP4e3VGpL4AfY3LmW/Dccb168S39DPOI7mrlEXUy4hA=;
        b=i1/mBfFT2XJHsw/zQeogEtM17OHu1FyheS0fOPMClTUh4JrGH9ofSk13K7zXcqzv5E
         qKIbZ4k7FFf/d9bjLmSLE2X8BLORj692TZMB7MZrH3k7Mfiy8UzZnTSnKekl/qD9Cl4u
         bjwZkWzyWpUy/kAZrPnqrzhZi2fzjA1IYO+vLP2hlfws4hiskKUY3YC+18EjTU1rOapv
         j4vVHuRE3a2nMOxHgZD3AiuvmlnfrFKB44FS9h1AKvpVht3fWEFIXi24+wWt38bhoI0j
         qnBPyD/xWHJfbuyYN6BIFeKeMl/nMX0cFlqoroWFqbxJ8TEaKHTAAoTVk/uAZOFjFa8k
         fJ1Q==
X-Gm-Message-State: APzg51A+drNxVJlnfESzRJ/UddZZ/7vHvo4QSuK8wbtFPr1GI7XWuOJu
        NNQ/Vh6scR72llkIoxod4LCTLQc=
X-Google-Smtp-Source: ANB0VdbPay4kMOhhNJAGi+NCKAWswZyzE4dPlAyh0K0nEvvpsTgb1CDQu/S8ovlsUd4WRdQSg2eLog==
X-Received: by 2002:a1f:fe47:: with SMTP id l68-v6mr3127608vki.108.1536339407565;
        Fri, 07 Sep 2018 09:56:47 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id q202-v6sm1039619vke.53.2018.09.07.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:56:46 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4/6] Generic radix trees
Date:   Fri,  7 Sep 2018 12:56:33 -0400
Message-Id: <20180907165635.8469-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180907165635.8469-1-kent.overstreet@gmail.com>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very simple radix tree implementation that supports storing arbitrary
size entries, up to PAGE_SIZE - upcoming patches will convert existing
flex_array users to genradixes. The new genradix code has a much simpler
API and implementation, and doesn't have a hard limit on the number of
elements like flex_array does.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/generic-radix-tree.h | 222 +++++++++++++++++++++++++++++
 lib/Makefile                       |   3 +-
 lib/generic-radix-tree.c           | 180 +++++++++++++++++++++++
 3 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/generic-radix-tree.h
 create mode 100644 lib/generic-radix-tree.c

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
new file mode 100644
index 0000000000..3328813322
--- /dev/null
+++ b/include/linux/generic-radix-tree.h
@@ -0,0 +1,222 @@
+#ifndef _LINUX_GENERIC_RADIX_TREE_H
+#define _LINUX_GENERIC_RADIX_TREE_H
+
+/*
+ * Generic radix trees/sparse arrays:
+ *
+ * Very simple and minimalistic, supporting arbitrary size entries up to
+ * PAGE_SIZE.
+ *
+ * A genradix is defined with the type it will store, like so:
+ * static GENRADIX(struct foo) foo_genradix;
+ *
+ * The main operations are:
+ * - genradix_init(radix) - initialize an empty genradix
+ *
+ * - genradix_free(radix) - free all memory owned by the genradix and
+ *   reinitialize it
+ *
+ * - genradix_ptr(radix, idx) - gets a pointer to the entry at idx, returning
+ *   NULL if that entry does not exist
+ *
+ * - genradix_ptr_alloc(radix, idx, gfp) - gets a pointer to an entry,
+ *   allocating it if necessary
+ *
+ * - genradix_for_each(radix, iter, p) - iterate over each entry in a genradix
+ *
+ * The radix tree allocates one page of entries at a time, so entries may exist
+ * that were never explicitly allocated - they will be initialized to all
+ * zeroes.
+ *
+ * Internally, a genradix is just a radix tree of pages, and indexing works in
+ * terms of byte offsets. The wrappers in this header file use sizeof on the
+ * type the radix contains to calculate a byte offset from the index - see
+ * __idx_to_offset.
+ */
+
+#include <asm/page.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+
+struct genradix_node;
+
+struct __genradix {
+	struct genradix_node		*root;
+	size_t				depth;
+};
+
+#define __GENRADIX_INITIALIZER					\
+	{							\
+		.tree = {					\
+			.root = NULL,				\
+			.depth = 0,				\
+		}						\
+	}
+
+/*
+ * We use a 0 size array to stash the type we're storing without taking any
+ * space at runtime - then the various accessor macros can use typeof() to get
+ * to it for casts/sizeof - we also force the alignment so that storing a type
+ * with a ridiculous alignment doesn't blow up the alignment or size of the
+ * genradix.
+ */
+
+#define GENRADIX(_type)						\
+struct {							\
+	struct __genradix	tree;				\
+	_type			type[0] __aligned(1);		\
+}
+
+#define DEFINE_GENRADIX(_name, _type)				\
+	GENRADIX(_type) _name = __GENRADIX_INITIALIZER
+
+/**
+ * genradix_init - initialize a genradix
+ * @_radix:	genradix to initialize
+ *
+ * Does not fail
+ */
+#define genradix_init(_radix)					\
+do {								\
+	*(_radix) = (typeof(*_radix)) __GENRADIX_INITIALIZER;	\
+} while (0)
+
+void __genradix_free(struct __genradix *);
+
+/**
+ * genradix_free: free all memory owned by a genradix
+ *
+ * After freeing, @_radix will be reinitialized and empty
+ */
+#define genradix_free(_radix)	__genradix_free(&(_radix)->tree)
+
+static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
+{
+	if (__builtin_constant_p(obj_size))
+		BUILD_BUG_ON(obj_size > PAGE_SIZE);
+	else
+		BUG_ON(obj_size > PAGE_SIZE);
+
+	if (!is_power_of_2(obj_size)) {
+		size_t objs_per_page = PAGE_SIZE / obj_size;
+
+		return (idx / objs_per_page) * PAGE_SIZE +
+			(idx % objs_per_page) * obj_size;
+	} else {
+		return idx * obj_size;
+	}
+}
+
+#define __genradix_cast(_radix)		(typeof((_radix)->type[0]) *)
+#define __genradix_obj_size(_radix)	sizeof((_radix)->type[0])
+#define __genradix_idx_to_offset(_radix, _idx)			\
+	__idx_to_offset(_idx, __genradix_obj_size(_radix))
+
+void *__genradix_ptr(struct __genradix *, size_t);
+
+/**
+ * genradix_ptr - get a pointer to a genradix entry
+ * @_radix:	genradix to access
+ * @_idx:	index to fetch
+ *
+ * Returns a pointer to entry at @_idx, or NULL if that entry does not exist.
+ */
+#define genradix_ptr(_radix, _idx)				\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx)))
+
+void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
+
+/**
+ * genradix_ptr - get a pointer to a genradix entry, allocating it if necessary
+ * @_radix:	genradix to access
+ * @_idx:	index to fetch
+ * @_gfp:	gfp mask
+ *
+ * Returns a pointer to entry at @_idx, or NULL on allocation failure
+ */
+#define genradix_ptr_alloc(_radix, _idx, _gfp)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr_alloc(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx),	\
+			_gfp))
+
+struct genradix_iter {
+	size_t			offset;
+	size_t			pos;
+};
+
+/**
+ * genradix_iter_init - initialize a genradix_iter
+ * @_radix:	genradix that will be iterated over
+ * @_idx	index to start iterating from
+ */
+#define genradix_iter_init(_radix, _idx)			\
+	((struct genradix_iter) {				\
+		.pos	= (_idx),				\
+		.offset	= __genradix_idx_to_offset((_radix), (_idx)),\
+	})
+
+void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
+
+/**
+ * genradix_iter_peek - get first entry at or above iterator's current
+ *			position
+ * @_iter:	a genradix_iter
+ * @_radix:	genradix being iterated over
+ *
+ * If no more entries exist at or above @_iter's current position, returns NULL
+ */
+#define genradix_iter_peek(_iter, _radix)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_iter_peek(_iter, &(_radix)->tree,		\
+			      PAGE_SIZE / __genradix_obj_size(_radix)))
+
+static inline void __genradix_iter_advance(struct genradix_iter *iter,
+					   size_t obj_size)
+{
+	iter->offset += obj_size;
+
+	if (!is_power_of_2(obj_size) &&
+	    (iter->offset & (PAGE_SIZE - 1)) + obj_size > PAGE_SIZE)
+		iter->offset = round_up(iter->offset, PAGE_SIZE);
+
+	iter->pos++;
+}
+
+#define genradix_iter_advance(_iter, _radix)			\
+	__genradix_iter_advance(_iter, __genradix_obj_size(_radix))
+
+/**
+ * genradix_for_each - iterate over entry in a genradix
+ * @_radix:	genradix to iterate over
+ * @_iter:	a genradix_iter to track current position
+ * @_p:		pointer to genradix entry type
+ *
+ * On every iteration, @_p will point to the current entry, and @_iter.pos
+ * will be the current entry's index.
+ */
+#define genradix_for_each(_radix, _iter, _p)			\
+	for (_iter = genradix_iter_init(_radix, 0);		\
+	     _p = genradix_iter_peek(&(_iter), _uradix);	\
+	     genradix_iter_advance(&(_iter), _uradix))
+
+int __genradix_prealloc(struct __genradix *, size_t, gfp_t);
+
+/**
+ * genradix_prealloc - preallocate entries in a generic radix tree
+ * @_radix:	genradix to preallocate
+ * @_nr:	number of entries to preallocate
+ * @_gfp:	gfp mask
+ *
+ * Returns 0 on success, -ENOMEM on failure
+ */
+#define genradix_prealloc(_radix, _nr, _gfp)			\
+	 __genradix_prealloc(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _nr + 1),\
+			_gfp)
+
+
+#endif /* _LINUX_GENERIC_RADIX_TREE_H */
diff --git a/lib/Makefile b/lib/Makefile
index 90dc5520b7..3038c54d6e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -38,7 +38,8 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
+	 generic-radix-tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
new file mode 100644
index 0000000000..4537c7c62c
--- /dev/null
+++ b/lib/generic-radix-tree.c
@@ -0,0 +1,180 @@
+
+#include <linux/export.h>
+#include <linux/generic-radix-tree.h>
+#include <linux/gfp.h>
+
+#define GENRADIX_ARY		(PAGE_SIZE / sizeof(struct genradix_node *))
+#define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
+
+struct genradix_node {
+	union {
+		/* Interior node: */
+		struct genradix_node	*children[GENRADIX_ARY];
+
+		/* Leaf: */
+		u8			data[PAGE_SIZE];
+	};
+};
+
+static inline unsigned genradix_depth_shift(unsigned depth)
+{
+	return PAGE_SHIFT + GENRADIX_ARY_SHIFT * depth;
+}
+
+/*
+ * Returns size (of data, in bytes) that a tree of a given depth holds:
+ */
+static inline size_t genradix_depth_size(unsigned depth)
+{
+	return 1UL << genradix_depth_shift(depth);
+}
+
+/*
+ * Returns pointer to the specified byte @offset within @radix, or NULL if not
+ * allocated
+ */
+void *__genradix_ptr(struct __genradix *radix, size_t offset)
+{
+	size_t level = radix->depth;
+	struct genradix_node *n = radix->root;
+
+	if (offset >= genradix_depth_size(radix->depth))
+		return NULL;
+
+	while (1) {
+		if (!n)
+			return NULL;
+		if (!level)
+			break;
+
+		level--;
+
+		n = n->children[offset >> genradix_depth_shift(level)];
+		offset &= genradix_depth_size(level) - 1;
+	}
+
+	return &n->data[offset];
+}
+EXPORT_SYMBOL(__genradix_ptr);
+
+/*
+ * Returns pointer to the specified byte @offset within @radix, allocating it if
+ * necessary - newly allocated slots are always zeroed out:
+ */
+void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
+			   gfp_t gfp_mask)
+{
+	struct genradix_node **n;
+	size_t level;
+
+	/* Increase tree depth if necessary: */
+
+	while (offset >= genradix_depth_size(radix->depth)) {
+		struct genradix_node *new_root =
+			(void *) __get_free_page(gfp_mask|__GFP_ZERO);
+
+		if (!new_root)
+			return NULL;
+
+		new_root->children[0] = radix->root;
+		radix->root = new_root;
+		radix->depth++;
+	}
+
+	n = &radix->root;
+	level = radix->depth;
+
+	while (1) {
+		if (!*n) {
+			*n = (void *) __get_free_page(gfp_mask|__GFP_ZERO);
+			if (!*n)
+				return NULL;
+		}
+
+		if (!level)
+			break;
+
+		level--;
+
+		n = &(*n)->children[offset >> genradix_depth_shift(level)];
+		offset &= genradix_depth_size(level) - 1;
+	}
+
+	return &(*n)->data[offset];
+}
+EXPORT_SYMBOL(__genradix_ptr_alloc);
+
+void *__genradix_iter_peek(struct genradix_iter *iter,
+			   struct __genradix *radix,
+			   size_t objs_per_page)
+{
+	struct genradix_node *n;
+	size_t level, i;
+
+	if (!radix->root)
+		return NULL;
+restart:
+	if (iter->offset >= genradix_depth_size(radix->depth))
+		return NULL;
+
+	n	= radix->root;
+	level	= radix->depth;
+
+	while (level) {
+		level--;
+
+		i = (iter->offset >> genradix_depth_shift(level)) &
+			(GENRADIX_ARY - 1);
+
+		while (!n->children[i]) {
+			i++;
+			iter->offset = round_down(iter->offset +
+					   genradix_depth_size(level),
+					   genradix_depth_size(level));
+			iter->pos = (iter->offset >> PAGE_SHIFT) *
+				objs_per_page;
+			if (i == GENRADIX_ARY)
+				goto restart;
+		}
+
+		n = n->children[i];
+	}
+
+	return &n->data[iter->offset & (PAGE_SIZE - 1)];
+}
+EXPORT_SYMBOL(__genradix_iter_peek);
+
+static void genradix_free_recurse(struct genradix_node *n, unsigned level)
+{
+	if (level) {
+		unsigned i;
+
+		for (i = 0; i < GENRADIX_ARY; i++)
+			if (n->children[i])
+				genradix_free_recurse(n->children[i], level - 1);
+	}
+
+	free_page((unsigned long) n);
+}
+
+int __genradix_prealloc(struct __genradix *radix, size_t size,
+			gfp_t gfp_mask)
+{
+	size_t offset;
+
+	for (offset = 0; offset < size; offset += PAGE_SIZE)
+		if (!__genradix_ptr_alloc(radix, offset, gfp_mask))
+			return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL(__genradix_prealloc);
+
+void __genradix_free(struct __genradix *radix)
+{
+	genradix_free_recurse(radix->root, radix->depth);
+
+	radix->root = NULL;
+	radix->depth = 0;
+}
+EXPORT_SYMBOL(__genradix_free);
-- 
2.19.0.rc2

