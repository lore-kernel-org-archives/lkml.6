Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C4EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B4F2536A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQQjKhlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B4F2536A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeFXXjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 19:39:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFXXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 19:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VC3DlzDL0jCqVcqvBGoJsR+U6KuRH+XzoxArmBJ550E=; b=eQQjKhlrW5QLpevD4nQQXbKf5
        iogxTQZH8aIWKkpLdIvTMNrIoWtxWTyUimNWdFl8aDiwarrfYvRmXR8eNa1kLmO9DBUHjDlikf+e+
        qRNeLJ5HFQaVrSjnR23M3lu86HEzYtId+b6j/VgAJ1ZKXB3z5GzhTHNQtT452ZIe2sa3W/ReneHdi
        ks+U/yjx8vwSP6ig0YT9RV2iDfSXbxvLoRpBlKBRkGYe1HG1cjkht8dzupqmiRlg1iQF1AY5jCmpK
        AcpCEEA4GCKVlmogrLegcMMQ/ofSeNqrqC4wdKlb7HjXm31/k0mj6OGTVJ8Nw428gchoHNgnYzNyj
        MhNsEatZQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXEba-00026Q-4E; Sun, 24 Jun 2018 23:39:38 +0000
Date:   Sun, 24 Jun 2018 16:39:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
Message-ID: <20180624233937.GA3533@bombadil.infradead.org>
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180624011703.GH18630@bombadil.infradead.org>
 <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
 <20180624032615.GA32667@bombadil.infradead.org>
 <31d75d3d-2184-6053-5283-f9fe3b10bf82@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d75d3d-2184-6053-5283-f9fe3b10bf82@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 09:01:37PM -0700, Guenter Roeck wrote:
> Yes, that is much better:
> 
> Build reference: next-20180622-1-g023ad92e94da
> 
> Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running .... passed
> Building q800:m68040:mac_defconfig:initrd ... running .... passed
> Building q800:m68040:mac_defconfig:rootfs ... running .... passed

great!  Here's a version which fixes idr_replace() too.

diff --git a/lib/idr.c b/lib/idr.c
index 58b88f5eb672..f16a95cbc527 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -39,8 +39,6 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 	unsigned int base = idr->idr_base;
 	unsigned int id = *nextid;
 
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
-		return -EINVAL;
 	if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
 		idr->idr_rt.xa_flags |= IDR_RT_MARKER;
 
@@ -295,8 +293,6 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
 	void __rcu **slot = NULL;
 	void *entry;
 
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
-		return ERR_PTR(-EINVAL);
 	id -= idr->idr_base;
 
 	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 101f1c28e1b6..22fecea283d8 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -564,6 +564,8 @@ static inline bool radix_tree_shrink(struct radix_tree_root *root)
 			break;
 		if (!radix_tree_is_internal_node(child) && node->shift)
 			break;
+		if (!node->shift && is_idr(root))
+			break;
 
 		if (radix_tree_is_internal_node(child))
 			entry_to_node(child)->parent = NULL;
@@ -733,7 +735,7 @@ static void radix_tree_free_nodes(struct radix_tree_node *node)
 
 	for (;;) {
 		void *entry = rcu_dereference_raw(child->slots[offset]);
-		if (xa_is_node(entry)) {
+		if (xa_is_node(entry) && child->shift) {
 			child = entry_to_node(entry);
 			offset = 0;
 			continue;
@@ -904,6 +906,8 @@ void *__radix_tree_lookup(const struct radix_tree_root *root,
 		parent = entry_to_node(node);
 		offset = radix_tree_descend(parent, &node, index);
 		slot = parent->slots + offset;
+		if (parent->shift == 0)
+			break;
 	}
 
 	if (nodep)
@@ -977,9 +981,6 @@ static inline void replace_sibling_entries(struct radix_tree_node *node,
 static void replace_slot(void __rcu **slot, void *item,
 		struct radix_tree_node *node, int count, int values)
 {
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(item)))
-		return;
-
 	if (node && (count || values)) {
 		node->count += count;
 		node->nr_values += values;
@@ -1486,7 +1487,7 @@ void __rcu **radix_tree_next_chunk(const struct radix_tree_root *root,
 			goto restart;
 		if (child == RADIX_TREE_RETRY)
 			break;
-	} while (radix_tree_is_internal_node(child));
+	} while (node->shift && radix_tree_is_internal_node(child));
 
 	/* Update the iterator state */
 	iter->index = (index &~ node_maxindex(node)) | (offset << node->shift);
@@ -1789,6 +1790,8 @@ void __rcu **idr_get_free(struct radix_tree_root *root,
 		shift = error;
 		child = rcu_dereference_raw(root->xa_head);
 	}
+	if (start == 0 && shift == 0)
+		shift = RADIX_TREE_MAP_SHIFT;
 
 	while (shift) {
 		shift -= RADIX_TREE_MAP_SHIFT;
diff --git a/lib/xarray.c b/lib/xarray.c
index 8dddad5b237c..f549ee744cc6 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1719,15 +1719,19 @@ void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift)
 	xa_dump_index(index, shift);
 
 	if (xa_is_node(entry)) {
-		unsigned long i;
-		struct xa_node *node = xa_to_node(entry);
-		xa_dump_node(node);
-		for (i = 0; i < XA_CHUNK_SIZE; i++)
-			xa_dump_entry(node->slots[i],
+		if (shift == 0) {
+			pr_cont("%px\n", entry);
+		} else {
+			unsigned long i;
+			struct xa_node *node = xa_to_node(entry);
+			xa_dump_node(node);
+			for (i = 0; i < XA_CHUNK_SIZE; i++)
+				xa_dump_entry(node->slots[i],
 				      index + (i << node->shift), node->shift);
+		}
 	} else if (xa_is_value(entry))
-		pr_cont("value %ld (0x%lx)\n", xa_to_value(entry),
-							xa_to_value(entry));
+		pr_cont("value %ld (0x%lx) [%px]\n", xa_to_value(entry),
+						xa_to_value(entry), entry);
 	else if (!xa_is_internal(entry))
 		pr_cont("%px\n", entry);
 	else if (xa_is_retry(entry))
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 46fc2f1142c3..67d851d31e26 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -227,6 +227,66 @@ void idr_u32_test(int base)
 	idr_u32_test1(&idr, 0xffffffff);
 }
 
+static void idr_align_test(struct idr *idr)
+{
+	char name[] = "Motorola 68000";
+	int i, id;
+	void *entry;
+
+	for (i = 0; i < 9; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 1; i < 10; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 1);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 2; i < 11; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 2);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 3; i < 12; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 3);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 0; i < 8; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc(idr, &name[i + 1], 0, 0, GFP_KERNEL) != 1);
+		idr_for_each_entry(idr, entry, id);
+		idr_remove(idr, 1);
+		idr_for_each_entry(idr, entry, id);
+		idr_remove(idr, 0);
+		BUG_ON(!idr_is_empty(idr));
+	}
+
+	for (i = 0; i < 8; i++) {
+		BUG_ON(idr_alloc(idr, NULL, 0, 0, GFP_KERNEL) != 0);
+		idr_for_each_entry(idr, entry, id);
+		idr_replace(idr, &name[i], 0);
+		idr_for_each_entry(idr, entry, id);
+		BUG_ON(idr_find(idr, 0) != &name[i]);
+		idr_remove(idr, 0);
+	}
+
+	for (i = 0; i < 8; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc(idr, NULL, 0, 0, GFP_KERNEL) != 1);
+		idr_remove(idr, 1);
+		idr_for_each_entry(idr, entry, id);
+		idr_replace(idr, &name[i + 1], 0);
+		idr_for_each_entry(idr, entry, id);
+		idr_remove(idr, 0);
+	}
+}
+
 void idr_checks(void)
 {
 	unsigned long i;
@@ -307,6 +367,7 @@ void idr_checks(void)
 	idr_u32_test(4);
 	idr_u32_test(1);
 	idr_u32_test(0);
+	idr_align_test(&idr);
 }
 
 /*
@@ -396,6 +457,7 @@ void ida_check_conv(void)
 	}
 	assert(ida_is_empty(&ida));
 
+#if 0
 	radix_tree_cpu_dead(1);
 	for (i = 0; i < 1000000; i++) {
 		int err = ida_get_new(&ida, &id);
@@ -410,6 +472,7 @@ void ida_check_conv(void)
 		assert(id == i);
 	}
 	ida_destroy(&ida);
+#endif
 }
 
 /*
