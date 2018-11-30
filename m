Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCEC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E140B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5/kaYUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E140B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeK3Suk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:50:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46243 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Suk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:50:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so3370781lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZhJX52OzyR2f0VWl5hWW6T0rUX2InV/MPW8RUQDCoY=;
        b=W5/kaYUYfR0g9/Ri/PYG5ZGq9UF016zi76A9KyvkI2wLZEMAm7pBpPRzjPvZZ/LgXP
         InSW7CVLBdW1HttuuSvtNrvIhbRoTHPdX8JUzKEHu9cvafW+Kso4DfEauniZPzr/UDDH
         4u71FA8usJ9a0I4hqxHfLYIHlczUi7XfIkDge1AnDfBogX5/5mHpFwyKtAF1Jn7r7ZBO
         IcvLe1bKGpcYZtcWU32uw2Dgnpg5ul1tfk6Ty1XzrWdcDpDdn3oa2cvjPtA+sR3kPWRi
         oPuE+TZPS0sho17Em7yK8cgn4q8lRiybUp+/2Fo6NwLisHASAPYX1S2PxWRaRdK2TTkK
         W6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZhJX52OzyR2f0VWl5hWW6T0rUX2InV/MPW8RUQDCoY=;
        b=rNfkHB5LpYugL+QkiKy/HL/37IIlH3PaU2+oYg+5C2layfzdsf1KfUsquOdLFN/OgV
         XiZxvAfs6sZt6j4CE4+8Go2XLS0CBBMbWGfgPKZO4nUd+q9AV2llvryV90ubmyMzC7Jo
         WefnCvhXojBGAR4hQeLC6q+hZ0MARVrMbgNrVEI3VuQcmvEv8/4Ajy2iFiNPmHxoVVHf
         b8etCUJ4QdNxAkYsNtu89Uf8RG44yS4+Jv9kkhve2DcQv0VRPc/s3fqpcEKKpbNicPQu
         8vdn+6UpHP7mR7e6HB6iyloyOfrO+T9xTyXmR/a0z6Ai1HfXJTfSQvftYLLbxSlnzW8O
         pUig==
X-Gm-Message-State: AA+aEWaY5+x/OzBAAZSoSxP/IXcfHq2FJw2J7ekUx+z6ZJsRA04xrBsy
        353tR8sU2sXWvfhiWa9y06M=
X-Google-Smtp-Source: AFSGD/Wl9vZQ0umf4QZvlGA8so4skFwHxZfjn0w5LkIlqoJPMkZgQ4OU0LR/9/0uFehBCqebcvsKDw==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr3095796lfr.34.1543563732335;
        Thu, 29 Nov 2018 23:42:12 -0800 (PST)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s3-v6sm656317lje.73.2018.11.29.23.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 23:42:11 -0800 (PST)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [Xen-devel][PATCH v2 1/3] xen: Introduce shared buffer helpers for page directory...
Date:   Fri, 30 Nov 2018 09:42:03 +0200
Message-Id: <20181130074205.20496-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

based frontends. Currently the frontends which implement
similar code for sharing big buffers between frontend and
backend are para-virtualized DRM and sound drivers.
Both define the same way to share grant references of a
data buffer with the corresponding backend with little
differences.

Move shared code into a helper module, so there is a single
implementation of the same functionality for all.

This patch introduces code which is used by sound and display
frontend drivers without functional changes with the intention
to remove shared code from the corresponding drivers.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/Kconfig                 |   3 +
 drivers/xen/Makefile                |   1 +
 drivers/xen/xen-front-pgdir-shbuf.c | 553 ++++++++++++++++++++++++++++
 include/xen/xen-front-pgdir-shbuf.h |  89 +++++
 4 files changed, 646 insertions(+)
 create mode 100644 drivers/xen/xen-front-pgdir-shbuf.c
 create mode 100644 include/xen/xen-front-pgdir-shbuf.h

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 815b9e9bb975..838b66a9a0e7 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -340,4 +340,7 @@ config XEN_SYMS
 config XEN_HAVE_VPMU
        bool
 
+config XEN_FRONT_PGDIR_SHBUF
+	tristate
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 3e542f60f29f..c48927a58e10 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -44,3 +44,4 @@ xen-gntdev-y				:= gntdev.o
 xen-gntdev-$(CONFIG_XEN_GNTDEV_DMABUF)	+= gntdev-dmabuf.o
 xen-gntalloc-y				:= gntalloc.o
 xen-privcmd-y				:= privcmd.o privcmd-buf.o
+obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)	+= xen-front-pgdir-shbuf.o
diff --git a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
new file mode 100644
index 000000000000..48a658dc7ccf
--- /dev/null
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+/*
+ * Xen frontend/backend page directory based shared buffer
+ * helper module.
+ *
+ * Copyright (C) 2018 EPAM Systems Inc.
+ *
+ * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+
+#include <asm/xen/hypervisor.h>
+#include <xen/balloon.h>
+#include <xen/xen.h>
+#include <xen/xenbus.h>
+#include <xen/interface/io/ring.h>
+
+#include <xen/xen-front-pgdir-shbuf.h>
+
+#ifndef GRANT_INVALID_REF
+/*
+ * FIXME: usage of grant reference 0 as invalid grant reference:
+ * grant reference 0 is valid, but never exposed to a PV driver,
+ * because of the fact it is already in use/reserved by the PV console.
+ */
+#define GRANT_INVALID_REF	0
+#endif
+
+/**
+ * This structure represents the structure of a shared page
+ * that contains grant references to the pages of the shared
+ * buffer. This structure is common to many Xen para-virtualized
+ * protocols at include/xen/interface/io/
+ */
+struct xen_page_directory {
+	grant_ref_t gref_dir_next_page;
+	grant_ref_t gref[1]; /* Variable length */
+};
+
+/**
+ * Shared buffer ops which are differently implemented
+ * depending on the allocation mode, e.g. if the buffer
+ * is allocated by the corresponding backend or frontend.
+ * Some of the operations.
+ */
+struct xen_front_pgdir_shbuf_ops {
+	/*
+	 * Calculate number of grefs required to handle this buffer,
+	 * e.g. if grefs are required for page directory only or the buffer
+	 * pages as well.
+	 */
+	void (*calc_num_grefs)(struct xen_front_pgdir_shbuf *buf);
+
+	/* Fill page directory according to para-virtual display protocol. */
+	void (*fill_page_dir)(struct xen_front_pgdir_shbuf *buf);
+
+	/* Claim grant references for the pages of the buffer. */
+	int (*grant_refs_for_buffer)(struct xen_front_pgdir_shbuf *buf,
+				     grant_ref_t *priv_gref_head, int gref_idx);
+
+	/* Map grant references of the buffer. */
+	int (*map)(struct xen_front_pgdir_shbuf *buf);
+
+	/* Unmap grant references of the buffer. */
+	int (*unmap)(struct xen_front_pgdir_shbuf *buf);
+};
+
+/**
+ * Get granted reference to the very first page of the
+ * page directory. Usually this is passed to the backend,
+ * so it can find/fill the grant references to the buffer's
+ * pages.
+ *
+ * \param buf shared buffer which page directory is of interest.
+ * \return granted reference to the very first page of the
+ * page directory.
+ */
+grant_ref_t
+xen_front_pgdir_shbuf_get_dir_start(struct xen_front_pgdir_shbuf *buf)
+{
+	if (!buf->grefs)
+		return GRANT_INVALID_REF;
+
+	return buf->grefs[0];
+}
+EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_get_dir_start);
+
+/**
+ * Map granted references of the shared buffer.
+ *
+ * Depending on the shared buffer mode of allocation
+ * (be_alloc flag) this can either do nothing (for buffers
+ * shared by the frontend itself) or map the provided granted
+ * references onto the backing storage (buf->pages).
+ *
+ * \param buf shared buffer which grants to be maped.
+ * \return zero on success or a negative number on failure.
+ */
+int xen_front_pgdir_shbuf_map(struct xen_front_pgdir_shbuf *buf)
+{
+	if (buf->ops && buf->ops->map)
+		return buf->ops->map(buf);
+
+	/* No need to map own grant references. */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_map);
+
+/**
+ * Unmap granted references of the shared buffer.
+ *
+ * Depending on the shared buffer mode of allocation
+ * (be_alloc flag) this can either do nothing (for buffers
+ * shared by the frontend itself) or unmap the provided granted
+ * references.
+ *
+ * \param buf shared buffer which grants to be unmaped.
+ * \return zero on success or a negative number on failure.
+ */
+int xen_front_pgdir_shbuf_unmap(struct xen_front_pgdir_shbuf *buf)
+{
+	if (buf->ops && buf->ops->unmap)
+		return buf->ops->unmap(buf);
+
+	/* No need to unmap own grant references. */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_unmap);
+
+/**
+ * Free all the resources of the shared buffer.
+ *
+ * \param buf shared buffer which resources to be freed.
+ */
+void xen_front_pgdir_shbuf_free(struct xen_front_pgdir_shbuf *buf)
+{
+	if (buf->grefs) {
+		int i;
+
+		for (i = 0; i < buf->num_grefs; i++)
+			if (buf->grefs[i] != GRANT_INVALID_REF)
+				gnttab_end_foreign_access(buf->grefs[i],
+							  0, 0UL);
+	}
+	kfree(buf->grefs);
+	kfree(buf->directory);
+}
+EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_free);
+
+/*
+ * Number of grefs a page can hold with respect to the
+ * struct xen_page_directory header.
+ */
+#define XEN_NUM_GREFS_PER_PAGE ((PAGE_SIZE - \
+				 offsetof(struct xen_page_directory, \
+					  gref)) / sizeof(grant_ref_t))
+
+/**
+ * Get the number of pages the page directory consumes itself.
+ *
+ * \param buf shared buffer.
+ */
+static int get_num_pages_dir(struct xen_front_pgdir_shbuf *buf)
+{
+	return DIV_ROUND_UP(buf->num_pages, XEN_NUM_GREFS_PER_PAGE);
+}
+
+/**
+ * Calculate the number of grant references needed to share the buffer
+ * and its pages when backend allocates the buffer.
+ *
+ * \param buf shared buffer.
+ */
+static void backend_calc_num_grefs(struct xen_front_pgdir_shbuf *buf)
+{
+	/* Only for pages the page directory consumes itself. */
+	buf->num_grefs = get_num_pages_dir(buf);
+}
+
+/**
+ * Calculate the number of grant references needed to share the buffer
+ * and its pages when frontend allocates the buffer.
+ *
+ * \param buf shared buffer.
+ */
+static void guest_calc_num_grefs(struct xen_front_pgdir_shbuf *buf)
+{
+	/*
+	 * Number of pages the page directory consumes itself
+	 * plus grefs for the buffer pages.
+	 */
+	buf->num_grefs = get_num_pages_dir(buf) + buf->num_pages;
+}
+
+#define xen_page_to_vaddr(page) \
+	((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
+
+/**
+ * Unmap the buffer previously mapped with grant references
+ * provided by the backend.
+ *
+ * \param buf shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+static int backend_unmap(struct xen_front_pgdir_shbuf *buf)
+{
+	struct gnttab_unmap_grant_ref *unmap_ops;
+	int i, ret;
+
+	if (!buf->pages || !buf->backend_map_handles || !buf->grefs)
+		return 0;
+
+	unmap_ops = kcalloc(buf->num_pages, sizeof(*unmap_ops),
+			    GFP_KERNEL);
+	if (!unmap_ops)
+		return -ENOMEM;
+
+	for (i = 0; i < buf->num_pages; i++) {
+		phys_addr_t addr;
+
+		addr = xen_page_to_vaddr(buf->pages[i]);
+		gnttab_set_unmap_op(&unmap_ops[i], addr, GNTMAP_host_map,
+				    buf->backend_map_handles[i]);
+	}
+
+	ret = gnttab_unmap_refs(unmap_ops, NULL, buf->pages,
+				buf->num_pages);
+
+	for (i = 0; i < buf->num_pages; i++) {
+		if (unlikely(unmap_ops[i].status != GNTST_okay))
+			dev_err(&buf->xb_dev->dev,
+				"Failed to unmap page %d: %d\n",
+				i, unmap_ops[i].status);
+	}
+
+	if (ret)
+		dev_err(&buf->xb_dev->dev,
+			"Failed to unmap grant references, ret %d", ret);
+
+	kfree(unmap_ops);
+	kfree(buf->backend_map_handles);
+	buf->backend_map_handles = NULL;
+	return ret;
+}
+
+/**
+ * Map the buffer with grant references provided by the backend.
+ *
+ * \param buf shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+static int backend_map(struct xen_front_pgdir_shbuf *buf)
+{
+	struct gnttab_map_grant_ref *map_ops = NULL;
+	unsigned char *ptr;
+	int ret, cur_gref, cur_dir_page, cur_page, grefs_left;
+
+	map_ops = kcalloc(buf->num_pages, sizeof(*map_ops), GFP_KERNEL);
+	if (!map_ops)
+		return -ENOMEM;
+
+	buf->backend_map_handles = kcalloc(buf->num_pages,
+					   sizeof(*buf->backend_map_handles),
+					   GFP_KERNEL);
+	if (!buf->backend_map_handles) {
+		kfree(map_ops);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Read page directory to get grefs from the backend: for external
+	 * buffer we only allocate buf->grefs for the page directory,
+	 * so buf->num_grefs has number of pages in the page directory itself.
+	 */
+	ptr = buf->directory;
+	grefs_left = buf->num_pages;
+	cur_page = 0;
+	for (cur_dir_page = 0; cur_dir_page < buf->num_grefs; cur_dir_page++) {
+		struct xen_page_directory *page_dir =
+			(struct xen_page_directory *)ptr;
+		int to_copy = XEN_NUM_GREFS_PER_PAGE;
+
+		if (to_copy > grefs_left)
+			to_copy = grefs_left;
+
+		for (cur_gref = 0; cur_gref < to_copy; cur_gref++) {
+			phys_addr_t addr;
+
+			addr = xen_page_to_vaddr(buf->pages[cur_page]);
+			gnttab_set_map_op(&map_ops[cur_page], addr,
+					  GNTMAP_host_map,
+					  page_dir->gref[cur_gref],
+					  buf->xb_dev->otherend_id);
+			cur_page++;
+		}
+
+		grefs_left -= to_copy;
+		ptr += PAGE_SIZE;
+	}
+	ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
+
+	/* Save handles even if error, so we can unmap. */
+	for (cur_page = 0; cur_page < buf->num_pages; cur_page++) {
+		buf->backend_map_handles[cur_page] = map_ops[cur_page].handle;
+		if (unlikely(map_ops[cur_page].status != GNTST_okay))
+			dev_err(&buf->xb_dev->dev,
+				"Failed to map page %d: %d\n",
+				cur_page, map_ops[cur_page].status);
+	}
+
+	if (ret) {
+		dev_err(&buf->xb_dev->dev,
+			"Failed to map grant references, ret %d", ret);
+		backend_unmap(buf);
+	}
+
+	kfree(map_ops);
+	return ret;
+}
+
+/**
+ * Fill page directory with grant references to the pages of the
+ * page directory itself.
+ *
+ * The grant references to the buffer pages are provided by the
+ * backend in this case.
+ *
+ * \param buf shared buffer.
+ */
+static void backend_fill_page_dir(struct xen_front_pgdir_shbuf *buf)
+{
+	struct xen_page_directory *page_dir;
+	unsigned char *ptr;
+	int i, num_pages_dir;
+
+	ptr = buf->directory;
+	num_pages_dir = get_num_pages_dir(buf);
+
+	/* Fill only grefs for the page directory itself. */
+	for (i = 0; i < num_pages_dir - 1; i++) {
+		page_dir = (struct xen_page_directory *)ptr;
+
+		page_dir->gref_dir_next_page = buf->grefs[i + 1];
+		ptr += PAGE_SIZE;
+	}
+	/* Last page must say there is no more pages. */
+	page_dir = (struct xen_page_directory *)ptr;
+	page_dir->gref_dir_next_page = GRANT_INVALID_REF;
+}
+
+/**
+ * Fill page directory with grant references to the pages of the
+ * page directory and the buffer we share with the backend.
+ *
+ * \param buf shared buffer.
+ */
+static void guest_fill_page_dir(struct xen_front_pgdir_shbuf *buf)
+{
+	unsigned char *ptr;
+	int cur_gref, grefs_left, to_copy, i, num_pages_dir;
+
+	ptr = buf->directory;
+	num_pages_dir = get_num_pages_dir(buf);
+
+	/*
+	 * While copying, skip grefs at start, they are for pages
+	 * granted for the page directory itself.
+	 */
+	cur_gref = num_pages_dir;
+	grefs_left = buf->num_pages;
+	for (i = 0; i < num_pages_dir; i++) {
+		struct xen_page_directory *page_dir =
+			(struct xen_page_directory *)ptr;
+
+		if (grefs_left <= XEN_NUM_GREFS_PER_PAGE) {
+			to_copy = grefs_left;
+			page_dir->gref_dir_next_page = GRANT_INVALID_REF;
+		} else {
+			to_copy = XEN_NUM_GREFS_PER_PAGE;
+			page_dir->gref_dir_next_page = buf->grefs[i + 1];
+		}
+		memcpy(&page_dir->gref, &buf->grefs[cur_gref],
+		       to_copy * sizeof(grant_ref_t));
+		ptr += PAGE_SIZE;
+		grefs_left -= to_copy;
+		cur_gref += to_copy;
+	}
+}
+
+/**
+ * Grant references to the frontend's buffer pages.
+ *
+ * These will be shared with the backend, so it can
+ * access the buffer's data.
+ *
+ * \param buf shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+static int guest_grant_refs_for_buffer(struct xen_front_pgdir_shbuf *buf,
+				       grant_ref_t *priv_gref_head,
+				       int gref_idx)
+{
+	int i, cur_ref, otherend_id;
+
+	otherend_id = buf->xb_dev->otherend_id;
+	for (i = 0; i < buf->num_pages; i++) {
+		cur_ref = gnttab_claim_grant_reference(priv_gref_head);
+		if (cur_ref < 0)
+			return cur_ref;
+
+		gnttab_grant_foreign_access_ref(cur_ref, otherend_id,
+						xen_page_to_gfn(buf->pages[i]),
+						0);
+		buf->grefs[gref_idx++] = cur_ref;
+	}
+	return 0;
+}
+
+/**
+ * Grant all the references needed to share the buffer.
+ *
+ * Grant references to the page directory pages and, if
+ * needed, also to the pages of the shared buffer data.
+ *
+ * \param buf shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+static int grant_references(struct xen_front_pgdir_shbuf *buf)
+{
+	grant_ref_t priv_gref_head;
+	int ret, i, j, cur_ref;
+	int otherend_id, num_pages_dir;
+
+	ret = gnttab_alloc_grant_references(buf->num_grefs, &priv_gref_head);
+	if (ret < 0) {
+		dev_err(&buf->xb_dev->dev,
+			"Cannot allocate grant references\n");
+		return ret;
+	}
+
+	otherend_id = buf->xb_dev->otherend_id;
+	j = 0;
+	num_pages_dir = get_num_pages_dir(buf);
+	for (i = 0; i < num_pages_dir; i++) {
+		unsigned long frame;
+
+		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
+		if (cur_ref < 0)
+			return cur_ref;
+
+		frame = xen_page_to_gfn(virt_to_page(buf->directory +
+						     PAGE_SIZE * i));
+		gnttab_grant_foreign_access_ref(cur_ref, otherend_id, frame, 0);
+		buf->grefs[j++] = cur_ref;
+	}
+
+	if (buf->ops->grant_refs_for_buffer) {
+		ret = buf->ops->grant_refs_for_buffer(buf, &priv_gref_head, j);
+		if (ret)
+			return ret;
+	}
+
+	gnttab_free_grant_references(priv_gref_head);
+	return 0;
+}
+
+/**
+ * Allocate all required structures to mange shared buffer.
+ *
+ * \param buf shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+static int alloc_storage(struct xen_front_pgdir_shbuf *buf)
+{
+	buf->grefs = kcalloc(buf->num_grefs, sizeof(*buf->grefs), GFP_KERNEL);
+	if (!buf->grefs)
+		return -ENOMEM;
+
+	buf->directory = kcalloc(get_num_pages_dir(buf), PAGE_SIZE, GFP_KERNEL);
+	if (!buf->directory)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * For backend allocated buffers we don't need grant_refs_for_buffer
+ * as those grant references are allocated at backend side.
+ */
+static const struct xen_front_pgdir_shbuf_ops backend_ops = {
+	.calc_num_grefs = backend_calc_num_grefs,
+	.fill_page_dir = backend_fill_page_dir,
+	.map = backend_map,
+	.unmap = backend_unmap
+};
+
+/*
+ * For locally granted references we do not need to map/unmap
+ * the references.
+ */
+static const struct xen_front_pgdir_shbuf_ops local_ops = {
+	.calc_num_grefs = guest_calc_num_grefs,
+	.fill_page_dir = guest_fill_page_dir,
+	.grant_refs_for_buffer = guest_grant_refs_for_buffer,
+};
+
+/**
+ * Allocate a new instance of a shared buffer.
+ *
+ * \param cfg configuration to be used while allocating a new shared buffer.
+ * \return zero on success or a negative number on failure.
+ */
+int xen_front_pgdir_shbuf_alloc(struct xen_front_pgdir_shbuf_cfg *cfg)
+{
+	struct xen_front_pgdir_shbuf *buf = cfg->pgdir;
+	int ret;
+
+	if (cfg->be_alloc)
+		buf->ops = &backend_ops;
+	else
+		buf->ops = &local_ops;
+	buf->xb_dev = cfg->xb_dev;
+	buf->num_pages = cfg->num_pages;
+	buf->pages = cfg->pages;
+
+	buf->ops->calc_num_grefs(buf);
+
+	ret = alloc_storage(buf);
+	if (ret)
+		goto fail;
+
+	ret = grant_references(buf);
+	if (ret)
+		goto fail;
+
+	buf->ops->fill_page_dir(buf);
+
+	return 0;
+
+fail:
+	xen_front_pgdir_shbuf_free(buf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_alloc);
+
+MODULE_DESCRIPTION("Xen frontend/backend page directory based "
+		   "shared buffer handling");
+MODULE_AUTHOR("Oleksandr Andrushchenko");
+MODULE_LICENSE("GPL");
diff --git a/include/xen/xen-front-pgdir-shbuf.h b/include/xen/xen-front-pgdir-shbuf.h
new file mode 100644
index 000000000000..150ef7ec51ec
--- /dev/null
+++ b/include/xen/xen-front-pgdir-shbuf.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+/*
+ * Xen frontend/backend page directory based shared buffer
+ * helper module.
+ *
+ * Copyright (C) 2018 EPAM Systems Inc.
+ *
+ * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+ */
+
+#ifndef __XEN_FRONT_PGDIR_SHBUF_H_
+#define __XEN_FRONT_PGDIR_SHBUF_H_
+
+#include <linux/kernel.h>
+
+#include <xen/grant_table.h>
+
+struct xen_front_pgdir_shbuf_ops;
+
+struct xen_front_pgdir_shbuf {
+	/*
+	 * Number of references granted for the backend use:
+	 *
+	 *  - for frontend allocated/imported buffers this holds the number
+	 *    of grant references for the page directory and the pages
+	 *    of the buffer
+	 *
+	 *  - for the buffer provided by the backend this only holds the number
+	 *    of grant references for the page directory itself as grant
+	 *    references for the buffer will be provided by the backend.
+	 */
+	int num_grefs;
+	grant_ref_t *grefs;
+	/* Page directory backing storage. */
+	u8 *directory;
+
+	/*
+	 * Number of pages for the shared buffer itself (excluding the page
+	 * directory).
+	 */
+	int num_pages;
+	/*
+	 * Backing storage of the shared buffer: these are the pages being
+	 * shared.
+	 */
+	struct page **pages;
+
+	struct xenbus_device *xb_dev;
+
+	/* These are the ops used internally depending on be_alloc mode. */
+	const struct xen_front_pgdir_shbuf_ops *ops;
+
+	/* Xen map handles for the buffer allocated by the backend. */
+	grant_handle_t *backend_map_handles;
+};
+
+struct xen_front_pgdir_shbuf_cfg {
+	struct xenbus_device *xb_dev;
+
+	/* Number of pages of the buffer backing storage. */
+	int num_pages;
+	/* Pages of the buffer to be shared. */
+	struct page **pages;
+
+	/*
+	 * This is allocated outside because there are use-cases when
+	 * the buffer structure is allocated as a part of a bigger one.
+	 */
+	struct xen_front_pgdir_shbuf *pgdir;
+	/*
+	 * Mode of grant reference sharing: if set then backend will share
+	 * grant references to the buffer with the frontend.
+	 */
+	int be_alloc;
+};
+
+int xen_front_pgdir_shbuf_alloc(struct xen_front_pgdir_shbuf_cfg *cfg);
+
+grant_ref_t
+xen_front_pgdir_shbuf_get_dir_start(struct xen_front_pgdir_shbuf *buf);
+
+int xen_front_pgdir_shbuf_map(struct xen_front_pgdir_shbuf *buf);
+
+int xen_front_pgdir_shbuf_unmap(struct xen_front_pgdir_shbuf *buf);
+
+void xen_front_pgdir_shbuf_free(struct xen_front_pgdir_shbuf *buf);
+
+#endif /* __XEN_FRONT_PGDIR_SHBUF_H_ */
-- 
2.19.1

