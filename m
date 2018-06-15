Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1FE0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FF22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLlgJL5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755942AbeFOG3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:29:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39307 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755816AbeFOG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:28:13 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so6586861lfd.6;
        Thu, 14 Jun 2018 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3EBJUEPr18K51bHPcS+KL0WPH4BH346RIb/VuV0+Oi8=;
        b=XLlgJL5FQmOqmc4Fuud8GjhY7A/3gERsl7Z3VDZqTZjwjsXJR9C7KXZ0VBc7XUOa9F
         5bFVFIlE6L8tFt7Bv8RFZBce2Ya0ue4fSTJgVaVJ81zvBaeSQdStn3USu6v/aDw94qr5
         L1bYOPQG9NgmvqomNMjyQY2XHEQVIRSsazQEbSn/R+QMSFdzw5IXcQ5pGPsQhvraxKD7
         Lm2M0F2Bup+a7wEQLmXl0qo87aHqPgexJ4nK2bO+263VIYRayzK817zBwDpMme/mb7NQ
         QroAIVLTWLX5pPF0/gqkPbq8Z7v0xj4d8t7z5MF00yXXU5SaqyxuwRyzLJt+0wk1rymY
         h5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3EBJUEPr18K51bHPcS+KL0WPH4BH346RIb/VuV0+Oi8=;
        b=Qg8PRsLr0tRXqnax0AKynEFxMTp6elzVrDOkoZOj8y3ZAdVtkYBOpHFOLxQ3T4soeE
         1C7TnObRJCz7cCkVsEgaxfTUjBg1lWzqiPcvlZl5JKkKWiil++MUkrpWMYzrLvNyLwqx
         s9r1IAc/Mmnh+ftuWy7Tx85x0i9o2LZtMbEDddmb4oFFKjfsmTG2frL8leFIdbNfPZGy
         q5pSCItsw87AA3K4L0feWGmHytJdcLJd7QhxJ9xOmJcsUoFb+P8papJrLW3c1vKfx4R1
         ARrt46OqyIRrIwY+X62D1BPQuH1nvO3TiGzGFWv0RGksZa2/oKiulrSJRwM7+hPLHQD5
         ojVw==
X-Gm-Message-State: APt69E0sKGHOo9FtpdXG8lEtfKSb1S6i1Tc+yDNxMY7vIgHuk6ZmZt74
        0QPQeFInDMDzmU4NVjnWE/A=
X-Google-Smtp-Source: ADUXVKIVVbUb7rHM9nXWdHyvid5ZRFE3JVgPIRbzAcKDXwleSucaW6JaTPu2UERCwdofBZCNU5Udbg==
X-Received: by 2002:a19:ae11:: with SMTP id f17-v6mr256506lfc.143.1529044091838;
        Thu, 14 Jun 2018 23:28:11 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id t126-v6sm1355040lff.7.2018.06.14.23.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:28:10 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v4 6/9] xen/gntdev: Make private routines/structures accessible
Date:   Fri, 15 Jun 2018 09:27:50 +0300
Message-Id: <20180615062753.9229-7-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615062753.9229-1-andr2000@gmail.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This is in preparation for adding support of DMA buffer
functionality: make map/unmap related code and structures, used
privately by gntdev, ready for dma-buf extension, which will re-use
these. Rename corresponding structures as those become non-private
to gntdev now.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev-common.h |  88 +++++++++++++++++++++++
 drivers/xen/gntdev.c        | 134 ++++++++++++------------------------
 2 files changed, 131 insertions(+), 91 deletions(-)
 create mode 100644 drivers/xen/gntdev-common.h

diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
new file mode 100644
index 000000000000..2346c198f72e
--- /dev/null
+++ b/drivers/xen/gntdev-common.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Common functionality of grant device.
+ *
+ * Copyright (c) 2006-2007, D G Murray.
+ *           (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
+ *           (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
+ */
+
+#ifndef _GNTDEV_COMMON_H
+#define _GNTDEV_COMMON_H
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/mmu_notifier.h>
+#include <linux/types.h>
+
+struct gntdev_priv {
+	/* Maps with visible offsets in the file descriptor. */
+	struct list_head maps;
+	/*
+	 * Maps that are not visible; will be freed on munmap.
+	 * Only populated if populate_freeable_maps == 1
+	 */
+	struct list_head freeable_maps;
+	/* lock protects maps and freeable_maps. */
+	struct mutex lock;
+	struct mm_struct *mm;
+	struct mmu_notifier mn;
+
+#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
+	/* Device for which DMA memory is allocated. */
+	struct device *dma_dev;
+#endif
+};
+
+struct gntdev_unmap_notify {
+	int flags;
+	/* Address relative to the start of the gntdev_grant_map. */
+	int addr;
+	int event;
+};
+
+struct gntdev_grant_map {
+	struct list_head next;
+	struct vm_area_struct *vma;
+	int index;
+	int count;
+	int flags;
+	refcount_t users;
+	struct gntdev_unmap_notify notify;
+	struct ioctl_gntdev_grant_ref *grants;
+	struct gnttab_map_grant_ref   *map_ops;
+	struct gnttab_unmap_grant_ref *unmap_ops;
+	struct gnttab_map_grant_ref   *kmap_ops;
+	struct gnttab_unmap_grant_ref *kunmap_ops;
+	struct page **pages;
+	unsigned long pages_vm_start;
+
+#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
+	/*
+	 * If dmabuf_vaddr is not NULL then this mapping is backed by DMA
+	 * capable memory.
+	 */
+
+	struct device *dma_dev;
+	/* Flags used to create this DMA buffer: GNTDEV_DMA_FLAG_XXX. */
+	int dma_flags;
+	void *dma_vaddr;
+	dma_addr_t dma_bus_addr;
+	/* Needed to avoid allocation in gnttab_dma_free_pages(). */
+	xen_pfn_t *frames;
+#endif
+};
+
+struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
+					  int dma_flags);
+
+void gntdev_add_map(struct gntdev_priv *priv, struct gntdev_grant_map *add);
+
+void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map);
+
+bool gntdev_account_mapped_pages(int count);
+
+int gntdev_map_grant_pages(struct gntdev_grant_map *map);
+
+#endif
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 0ec670d1d4e7..3385fc4ed386 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -6,6 +6,7 @@
  *
  * Copyright (c) 2006-2007, D G Murray.
  *           (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
+ *           (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -26,10 +27,6 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/mmu_notifier.h>
-#include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -50,6 +47,8 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
+#include "gntdev-common.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Derek G. Murray <Derek.Murray@cl.cam.ac.uk>, "
 	      "Gerd Hoffmann <kraxel@redhat.com>");
@@ -65,73 +64,23 @@ static atomic_t pages_mapped = ATOMIC_INIT(0);
 static int use_ptemod;
 #define populate_freeable_maps use_ptemod
 
-struct gntdev_priv {
-	/* maps with visible offsets in the file descriptor */
-	struct list_head maps;
-	/* maps that are not visible; will be freed on munmap.
-	 * Only populated if populate_freeable_maps == 1 */
-	struct list_head freeable_maps;
-	/* lock protects maps and freeable_maps */
-	struct mutex lock;
-	struct mm_struct *mm;
-	struct mmu_notifier mn;
-
-#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
-	/* Device for which DMA memory is allocated. */
-	struct device *dma_dev;
-#endif
-};
-
-struct unmap_notify {
-	int flags;
-	/* Address relative to the start of the grant_map */
-	int addr;
-	int event;
-};
-
-struct grant_map {
-	struct list_head next;
-	struct vm_area_struct *vma;
-	int index;
-	int count;
-	int flags;
-	refcount_t users;
-	struct unmap_notify notify;
-	struct ioctl_gntdev_grant_ref *grants;
-	struct gnttab_map_grant_ref   *map_ops;
-	struct gnttab_unmap_grant_ref *unmap_ops;
-	struct gnttab_map_grant_ref   *kmap_ops;
-	struct gnttab_unmap_grant_ref *kunmap_ops;
-	struct page **pages;
-	unsigned long pages_vm_start;
-
-#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
-	/*
-	 * If dmabuf_vaddr is not NULL then this mapping is backed by DMA
-	 * capable memory.
-	 */
-
-	struct device *dma_dev;
-	/* Flags used to create this DMA buffer: GNTDEV_DMA_FLAG_XXX. */
-	int dma_flags;
-	void *dma_vaddr;
-	dma_addr_t dma_bus_addr;
-	/* Needed to avoid allocation in gnttab_dma_free_pages(). */
-	xen_pfn_t *frames;
-#endif
-};
-
-static int unmap_grant_pages(struct grant_map *map, int offset, int pages);
+static int unmap_grant_pages(struct gntdev_grant_map *map,
+			     int offset, int pages);
 
 static struct miscdevice gntdev_miscdev;
 
 /* ------------------------------------------------------------------ */
 
+bool gntdev_account_mapped_pages(int count)
+{
+	return atomic_add_return(count, &pages_mapped) > limit;
+}
+
 static void gntdev_print_maps(struct gntdev_priv *priv,
 			      char *text, int text_index)
 {
 #ifdef DEBUG
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 
 	pr_debug("%s: maps list (priv %p)\n", __func__, priv);
 	list_for_each_entry(map, &priv->maps, next)
@@ -141,7 +90,7 @@ static void gntdev_print_maps(struct gntdev_priv *priv,
 #endif
 }
 
-static void gntdev_free_map(struct grant_map *map)
+static void gntdev_free_map(struct gntdev_grant_map *map)
 {
 	if (map == NULL)
 		return;
@@ -176,13 +125,13 @@ static void gntdev_free_map(struct grant_map *map)
 	kfree(map);
 }
 
-static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
+struct gntdev_grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 					  int dma_flags)
 {
-	struct grant_map *add;
+	struct gntdev_grant_map *add;
 	int i;
 
-	add = kzalloc(sizeof(struct grant_map), GFP_KERNEL);
+	add = kzalloc(sizeof(*add), GFP_KERNEL);
 	if (NULL == add)
 		return NULL;
 
@@ -252,9 +201,9 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
 	return NULL;
 }
 
-static void gntdev_add_map(struct gntdev_priv *priv, struct grant_map *add)
+void gntdev_add_map(struct gntdev_priv *priv, struct gntdev_grant_map *add)
 {
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 
 	list_for_each_entry(map, &priv->maps, next) {
 		if (add->index + add->count < map->index) {
@@ -269,10 +218,10 @@ static void gntdev_add_map(struct gntdev_priv *priv, struct grant_map *add)
 	gntdev_print_maps(priv, "[new]", add->index);
 }
 
-static struct grant_map *gntdev_find_map_index(struct gntdev_priv *priv,
-		int index, int count)
+static struct gntdev_grant_map *gntdev_find_map_index(struct gntdev_priv *priv,
+						      int index, int count)
 {
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 
 	list_for_each_entry(map, &priv->maps, next) {
 		if (map->index != index)
@@ -284,7 +233,7 @@ static struct grant_map *gntdev_find_map_index(struct gntdev_priv *priv,
 	return NULL;
 }
 
-static void gntdev_put_map(struct gntdev_priv *priv, struct grant_map *map)
+void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 {
 	if (!map)
 		return;
@@ -315,7 +264,7 @@ static void gntdev_put_map(struct gntdev_priv *priv, struct grant_map *map)
 static int find_grant_ptes(pte_t *pte, pgtable_t token,
 		unsigned long addr, void *data)
 {
-	struct grant_map *map = data;
+	struct gntdev_grant_map *map = data;
 	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
 	int flags = map->flags | GNTMAP_application_map | GNTMAP_contains_pte;
 	u64 pte_maddr;
@@ -348,7 +297,7 @@ static int set_grant_ptes_as_special(pte_t *pte, pgtable_t token,
 }
 #endif
 
-static int map_grant_pages(struct grant_map *map)
+int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 {
 	int i, err = 0;
 
@@ -413,7 +362,8 @@ static int map_grant_pages(struct grant_map *map)
 	return err;
 }
 
-static int __unmap_grant_pages(struct grant_map *map, int offset, int pages)
+static int __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
+			       int pages)
 {
 	int i, err = 0;
 	struct gntab_unmap_queue_data unmap_data;
@@ -448,7 +398,8 @@ static int __unmap_grant_pages(struct grant_map *map, int offset, int pages)
 	return err;
 }
 
-static int unmap_grant_pages(struct grant_map *map, int offset, int pages)
+static int unmap_grant_pages(struct gntdev_grant_map *map, int offset,
+			     int pages)
 {
 	int range, err = 0;
 
@@ -480,7 +431,7 @@ static int unmap_grant_pages(struct grant_map *map, int offset, int pages)
 
 static void gntdev_vma_open(struct vm_area_struct *vma)
 {
-	struct grant_map *map = vma->vm_private_data;
+	struct gntdev_grant_map *map = vma->vm_private_data;
 
 	pr_debug("gntdev_vma_open %p\n", vma);
 	refcount_inc(&map->users);
@@ -488,7 +439,7 @@ static void gntdev_vma_open(struct vm_area_struct *vma)
 
 static void gntdev_vma_close(struct vm_area_struct *vma)
 {
-	struct grant_map *map = vma->vm_private_data;
+	struct gntdev_grant_map *map = vma->vm_private_data;
 	struct file *file = vma->vm_file;
 	struct gntdev_priv *priv = file->private_data;
 
@@ -512,7 +463,7 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
 static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
 						 unsigned long addr)
 {
-	struct grant_map *map = vma->vm_private_data;
+	struct gntdev_grant_map *map = vma->vm_private_data;
 
 	return map->pages[(addr - map->pages_vm_start) >> PAGE_SHIFT];
 }
@@ -525,7 +476,7 @@ static const struct vm_operations_struct gntdev_vmops = {
 
 /* ------------------------------------------------------------------ */
 
-static void unmap_if_in_range(struct grant_map *map,
+static void unmap_if_in_range(struct gntdev_grant_map *map,
 			      unsigned long start, unsigned long end)
 {
 	unsigned long mstart, mend;
@@ -554,7 +505,7 @@ static void mn_invl_range_start(struct mmu_notifier *mn,
 				unsigned long start, unsigned long end)
 {
 	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry(map, &priv->maps, next) {
@@ -570,7 +521,7 @@ static void mn_release(struct mmu_notifier *mn,
 		       struct mm_struct *mm)
 {
 	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int err;
 
 	mutex_lock(&priv->lock);
@@ -651,13 +602,14 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 static int gntdev_release(struct inode *inode, struct file *flip)
 {
 	struct gntdev_priv *priv = flip->private_data;
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 
 	pr_debug("priv %p\n", priv);
 
 	mutex_lock(&priv->lock);
 	while (!list_empty(&priv->maps)) {
-		map = list_entry(priv->maps.next, struct grant_map, next);
+		map = list_entry(priv->maps.next,
+				 struct gntdev_grant_map, next);
 		list_del(&map->next);
 		gntdev_put_map(NULL /* already removed */, map);
 	}
@@ -674,7 +626,7 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 				       struct ioctl_gntdev_map_grant_ref __user *u)
 {
 	struct ioctl_gntdev_map_grant_ref op;
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int err;
 
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
@@ -688,7 +640,7 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 	if (!map)
 		return err;
 
-	if (unlikely(atomic_add_return(op.count, &pages_mapped) > limit)) {
+	if (unlikely(gntdev_account_mapped_pages(op.count))) {
 		pr_debug("can't map: over limit\n");
 		gntdev_put_map(NULL, map);
 		return err;
@@ -715,7 +667,7 @@ static long gntdev_ioctl_unmap_grant_ref(struct gntdev_priv *priv,
 					 struct ioctl_gntdev_unmap_grant_ref __user *u)
 {
 	struct ioctl_gntdev_unmap_grant_ref op;
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int err = -ENOENT;
 
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
@@ -741,7 +693,7 @@ static long gntdev_ioctl_get_offset_for_vaddr(struct gntdev_priv *priv,
 {
 	struct ioctl_gntdev_get_offset_for_vaddr op;
 	struct vm_area_struct *vma;
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int rv = -EINVAL;
 
 	if (copy_from_user(&op, u, sizeof(op)) != 0)
@@ -772,7 +724,7 @@ static long gntdev_ioctl_get_offset_for_vaddr(struct gntdev_priv *priv,
 static long gntdev_ioctl_notify(struct gntdev_priv *priv, void __user *u)
 {
 	struct ioctl_gntdev_unmap_notify op;
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int rc;
 	int out_flags;
 	unsigned int out_event;
@@ -1070,7 +1022,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	struct gntdev_priv *priv = flip->private_data;
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
-	struct grant_map *map;
+	struct gntdev_grant_map *map;
 	int i, err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
@@ -1127,7 +1079,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		}
 	}
 
-	err = map_grant_pages(map);
+	err = gntdev_map_grant_pages(map);
 	if (err)
 		goto out_put_map;
 
-- 
2.17.1

