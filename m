Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1068C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711352146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBmZWPeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbeLQNTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:19:50 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40176 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeLQNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:47 -0500
Received: by mail-wr1-f53.google.com with SMTP id p4so12238571wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24TWKfLCm9Mq6sUAdL70RSKMspAFdzQ/I/d2TuqHegE=;
        b=pBmZWPeNEwXd23/Px+RUkv+tCadDxU06ezvMGXbdyemxnGaLogHkL6yxNz5STSjzXK
         YmtyceWFrHW4Ru5qWOWb9/DbBOz6Ap7vlPHTWsQ9YDf0qIREu94rEc1f5tt1ktiDluIL
         50ZAOLTYf//tWHQotr5Zt6XsTMGSgceonkKZKIAUWSXwA6GFeXdXRil0oUKmqoARqeer
         M1dLmpXDn1eAHRMoIshiKb7dyR8P6MR8sSpSd07azHHL4hS1H58leSM5Znb9lVhKCyZq
         DkEx36PpjGNQ0xvAiVCO9/qZK7udnz2oNvRylMbmFm1/ly70ljIWqu+vXbwSZOxoWgAz
         FoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24TWKfLCm9Mq6sUAdL70RSKMspAFdzQ/I/d2TuqHegE=;
        b=XuB8R+Q8nXksGRyHi3VU93HStJwNkvTomDprYFZbMkq9JB8O96YehKXN7Jcar83YNU
         FbKJlaqSk9NAL0wswp/WmJC41Tg8UNX1RM1cetOcB1gMZnteKc2P7JsTg4xFX4AELuts
         yotARNhjxXIV6LyrSwPTL0BAxIZibgRDf267cnqcGQB1QnKSxSA68w+qsxrl6RQASbeF
         Lzm6RnJggtV6VAK3zO0VRDt+sGakCOqrAnV/DoqZvlnhkH243Xd+IyaJc4o5mBS0Pgk4
         RyczIkJzgGkdGi+Y/DI53Kzcga7LSM0E6DAwW9MPCP1SbkeQj28CMGHDrAzJh9zanabr
         ocYw==
X-Gm-Message-State: AA+aEWbIQT36SoNREPv8f0clRwLrfzi4b1hwYRdRVpQJ/ZslY+9DJddw
        vCXguUMqLE8Q6nijp1pCYg==
X-Google-Smtp-Source: AFSGD/Wap6EwWZ9GJVh0YspB3j6D0Dry52+8vNN/H4+OhltUBNiwXtH/Ab1BlDiQUnNaElcSBPAW0w==
X-Received: by 2002:adf:f101:: with SMTP id r1mr10882477wro.32.1545052783787;
        Mon, 17 Dec 2018 05:19:43 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:42 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 4/7] Generic radix trees
Date:   Mon, 17 Dec 2018 08:19:26 -0500
Message-Id: <20181217131929.11727-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
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
 Documentation/core-api/generic-radix-tree.rst |  12 +
 Documentation/core-api/index.rst              |   1 +
 include/linux/generic-radix-tree.h            | 231 ++++++++++++++++++
 lib/Makefile                                  |   3 +-
 lib/generic-radix-tree.c                      | 217 ++++++++++++++++
 5 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/generic-radix-tree.rst
 create mode 100644 include/linux/generic-radix-tree.h
 create mode 100644 lib/generic-radix-tree.c

diff --git a/Documentation/core-api/generic-radix-tree.rst b/Documentation/core-api/generic-radix-tree.rst
new file mode 100644
index 0000000000..80fd27440f
--- /dev/null
+++ b/Documentation/core-api/generic-radix-tree.rst
@@ -0,0 +1,12 @@
+=================================                                                                                                      
+Generic radix trees/sparse arrays                                                                                                      
+=================================                                                                                                      
+                                                                                                                                       
+.. kernel-doc:: include/linux/generic-radix-tree.h                                                                                     
+   :doc: Generic radix trees/sparse arrays                                                                                             
+                                                                                                                                       
+generic radix tree functions                                                                                                           
+----------------------------                                                                                                           
+                                                                                                                                       
+.. kernel-doc:: include/linux/generic-radix-tree.h                                                                                     
+   :functions:   
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 3adee82be3..6870baffef 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -28,6 +28,7 @@ Core utilities
    errseq
    printk-formats
    circular-buffers
+   generic-radix-tree
    memory-allocation
    mm-api
    gfp_mask-from-fs-io
diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
new file mode 100644
index 0000000000..3a91130a4f
--- /dev/null
+++ b/include/linux/generic-radix-tree.h
@@ -0,0 +1,231 @@
+#ifndef _LINUX_GENERIC_RADIX_TREE_H
+#define _LINUX_GENERIC_RADIX_TREE_H
+
+/**
+ * DOC: Generic radix trees/sparse arrays:
+ *
+ * Very simple and minimalistic, supporting arbitrary size entries up to
+ * PAGE_SIZE.
+ *
+ * A genradix is defined with the type it will store, like so:
+ *
+ * static GENRADIX(struct foo) foo_genradix;
+ *
+ * The main operations are:
+ *
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
+struct genradix_root;
+
+struct __genradix {
+	struct genradix_root __rcu	*root;
+};
+
+/*
+ * NOTE: currently, sizeof(_type) must not be larger than PAGE_SIZE:
+ */
+
+#define __GENRADIX_INITIALIZER					\
+	{							\
+		.tree = {					\
+			.root = NULL,				\
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
+ * @_radix: the genradix to free
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
+ * genradix_ptr_alloc - get a pointer to a genradix entry, allocating it
+ *			if necessary
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
+ * @_idx:	index to start iterating from
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
+#define genradix_for_each_from(_radix, _iter, _p, _start)	\
+	for (_iter = genradix_iter_init(_radix, _start);	\
+	     (_p = genradix_iter_peek(&_iter, _radix)) != NULL;	\
+	     genradix_iter_advance(&_iter, _radix))
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
+	genradix_for_each_from(_radix, _iter, _p, 0)
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
index db06d12378..f48beff23b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -38,7 +38,8 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
+	 generic-radix-tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
new file mode 100644
index 0000000000..a7bafc4137
--- /dev/null
+++ b/lib/generic-radix-tree.c
@@ -0,0 +1,217 @@
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
+static inline int genradix_depth_shift(unsigned depth)
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
+/* depth that's needed for a genradix that can address up to ULONG_MAX: */
+#define GENRADIX_MAX_DEPTH	\
+	DIV_ROUND_UP(BITS_PER_LONG - PAGE_SHIFT, GENRADIX_ARY_SHIFT)
+
+#define GENRADIX_DEPTH_MASK				\
+	((unsigned long) (roundup_pow_of_two(GENRADIX_MAX_DEPTH + 1) - 1))
+
+unsigned genradix_root_to_depth(struct genradix_root *r)
+{
+	return (unsigned long) r & GENRADIX_DEPTH_MASK;
+}
+
+struct genradix_node *genradix_root_to_node(struct genradix_root *r)
+{
+	return (void *) ((unsigned long) r & ~GENRADIX_DEPTH_MASK);
+}
+
+/*
+ * Returns pointer to the specified byte @offset within @radix, or NULL if not
+ * allocated
+ */
+void *__genradix_ptr(struct __genradix *radix, size_t offset)
+{
+	struct genradix_root *r = READ_ONCE(radix->root);
+	struct genradix_node *n = genradix_root_to_node(r);
+	unsigned level		= genradix_root_to_depth(r);
+
+	if (ilog2(offset) >= genradix_depth_shift(level))
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
+	struct genradix_root *v = READ_ONCE(radix->root);
+	struct genradix_node *n, *new_node = NULL;
+	unsigned level;
+
+	/* Increase tree depth if necessary: */
+	while (1) {
+		struct genradix_root *r = v, *new_root;
+
+		n	= genradix_root_to_node(r);
+		level	= genradix_root_to_depth(r);
+
+		if (n && ilog2(offset) < genradix_depth_shift(level))
+			break;
+
+		if (!new_node) {
+			new_node = (void *)
+				__get_free_page(gfp_mask|__GFP_ZERO);
+			if (!new_node)
+				return NULL;
+		}
+
+		new_node->children[0] = n;
+		new_root = ((struct genradix_root *)
+			    ((unsigned long) new_node | (n ? level + 1 : 0)));
+
+		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
+			v = new_root;
+			new_node = NULL;
+		}
+	}
+
+	while (level--) {
+		struct genradix_node **p =
+			&n->children[offset >> genradix_depth_shift(level)];
+		offset &= genradix_depth_size(level) - 1;
+
+		n = READ_ONCE(*p);
+		if (!n) {
+			if (!new_node) {
+				new_node = (void *)
+					__get_free_page(gfp_mask|__GFP_ZERO);
+				if (!new_node)
+					return NULL;
+			}
+
+			if (!(n = cmpxchg_release(p, NULL, new_node)))
+				swap(n, new_node);
+		}
+	}
+
+	if (new_node)
+		free_page((unsigned long) new_node);
+
+	return &n->data[offset];
+}
+EXPORT_SYMBOL(__genradix_ptr_alloc);
+
+void *__genradix_iter_peek(struct genradix_iter *iter,
+			   struct __genradix *radix,
+			   size_t objs_per_page)
+{
+	struct genradix_root *r;
+	struct genradix_node *n;
+	unsigned level, i;
+restart:
+	r = READ_ONCE(radix->root);
+	if (!r)
+		return NULL;
+
+	n	= genradix_root_to_node(r);
+	level	= genradix_root_to_depth(r);
+
+	if (ilog2(iter->offset) >= genradix_depth_shift(level))
+		return NULL;
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
+	struct genradix_root *r = xchg(&radix->root, NULL);
+
+	genradix_free_recurse(genradix_root_to_node(r),
+			      genradix_root_to_depth(r));
+}
+EXPORT_SYMBOL(__genradix_free);
-- 
2.20.1

