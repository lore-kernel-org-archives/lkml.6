Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD5520870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CXv4lqCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD5520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIEO1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIEO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so6998589wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKv5jlrCAyaYTLT/BZL/veEIJ+piaHWDiSNiFe36RjY=;
        b=CXv4lqCW6SJO5b/lBKqRMdAZMQmup9tC8YUXo8aR010fLf3nw72naoB+hHFiqVD5lM
         aGtvIhVRbO5myt/7Th3flCDnbhs2Plsap+hyo4ItMYoCCRUSb2wV2nBmYOR+a6D1hOGC
         7puMTt2NHsR5SbONqxmqvPOTEvHc6/zEMf1PXGomCl5MLb+xI2Hv5IVivOLptTKw3CX6
         u9iUItXeB0ZB1QxbuvlCxY9kaZ5NH7IkXyaG6wqmRnk9kHs6V1xMAQl9u9qthUHuE9rh
         ovYMC7qDQc+BFLP2Zc7eRg6b1VC/1olxkEVHu2kTXevSanr4d5Zp9vaJUtvkhMvAJHLp
         WlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UKv5jlrCAyaYTLT/BZL/veEIJ+piaHWDiSNiFe36RjY=;
        b=om9MoibFsBBEMnScIspp3RG+SvaxFGH9WZ73mskb7aV2kgqOduM0elai8jyNKvE7jF
         i4lr8jZQ7sWPfFlR1wl8RcsBDY4RM1W9dB+7JqQUHB2D2IcvN4MPuJuzGHAfxhXWojMu
         3m/f6yuVzmEg7TPkKtdEN7BL13nL8ucewPDWlwWk2BENPqhHx4QnzFfhHur4SBookdYk
         jCcESwDISpeGO5O5tR/cP+7PaWzsuShy5OfjlSX4RvIAphVAsNjoVJpvlgjVw5IN0dYI
         AqWcpY9TRs/ZdVbdPq57PxhfVHTTtJH2+ZfToXpzMKSyaL33CAtltCeNQZzm7kiwZNxM
         UZTg==
X-Gm-Message-State: APzg51CV44bEgvhMFo3HIwRslu6zRoMbeBxvoUf0izSa/KCkPtg9mnEu
        M1oBoaL0z/k+tHRLFPICAxw9fg==
X-Google-Smtp-Source: ANB0VdZHiHR95nOgohrJATT8SCBhjPE74HEEzFjrPo+cY1CtBPdaIf/eJi+x2nukOwZP9rlTGVLwOw==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr7700649wrd.253.1536141485148;
        Wed, 05 Sep 2018 02:58:05 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/13] nvmem: remove unused APIs
Date:   Wed,  5 Sep 2018 11:57:26 +0200
Message-Id: <20180905095738.26406-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove all APIs dealing with nvmem_cell_info. There are no users and
this part of the subsystem will be reworked.

This patch temprarily disables support for non-DT users.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 212 ++-------------------------------
 include/linux/nvmem-consumer.h |  26 ----
 include/linux/nvmem-provider.h |  13 --
 3 files changed, 12 insertions(+), 239 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..bb475c2688f9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -282,23 +282,6 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
-static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
-{
-	struct nvmem_cell *p;
-
-	mutex_lock(&nvmem_cells_mutex);
-
-	list_for_each_entry(p, &nvmem_cells, node)
-		if (!strcmp(p->name, cell_id)) {
-			mutex_unlock(&nvmem_cells_mutex);
-			return p;
-		}
-
-	mutex_unlock(&nvmem_cells_mutex);
-
-	return NULL;
-}
-
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	mutex_lock(&nvmem_cells_mutex);
@@ -326,82 +309,6 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	mutex_unlock(&nvmem_cells_mutex);
 }
 
-static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
-				   const struct nvmem_cell_info *info,
-				   struct nvmem_cell *cell)
-{
-	cell->nvmem = nvmem;
-	cell->offset = info->offset;
-	cell->bytes = info->bytes;
-	cell->name = info->name;
-
-	cell->bit_offset = info->bit_offset;
-	cell->nbits = info->nbits;
-
-	if (cell->nbits)
-		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
-					   BITS_PER_BYTE);
-
-	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-		dev_err(&nvmem->dev,
-			"cell %s unaligned to nvmem stride %d\n",
-			cell->name, nvmem->stride);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * nvmem_add_cells() - Add cell information to an nvmem device
- *
- * @nvmem: nvmem device to add cells to.
- * @info: nvmem cell info to add to the device
- * @ncells: number of cells in info
- *
- * Return: 0 or negative error code on failure.
- */
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells)
-{
-	struct nvmem_cell **cells;
-	int i, rval;
-
-	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
-	if (!cells)
-		return -ENOMEM;
-
-	for (i = 0; i < ncells; i++) {
-		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
-		if (!cells[i]) {
-			rval = -ENOMEM;
-			goto err;
-		}
-
-		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
-		if (rval) {
-			kfree(cells[i]);
-			goto err;
-		}
-
-		nvmem_cell_add(cells[i]);
-	}
-
-	/* remove tmp array */
-	kfree(cells);
-
-	return 0;
-err:
-	while (i--)
-		nvmem_cell_drop(cells[i]);
-
-	kfree(cells);
-
-	return rval;
-}
-EXPORT_SYMBOL_GPL(nvmem_add_cells);
-
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
  * drivers sys directory, to be backwards compatible with the older
@@ -516,9 +423,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_device_del;
 	}
 
-	if (config->cells)
-		nvmem_add_cells(nvmem, config->cells, config->ncells);
-
 	return nvmem;
 
 err_device_del:
@@ -618,32 +522,19 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
 
-static struct nvmem_device *__nvmem_device_get(struct device_node *np,
-					       struct nvmem_cell **cellp,
-					       const char *cell_id)
+static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 {
 	struct nvmem_device *nvmem = NULL;
 
-	mutex_lock(&nvmem_mutex);
-
-	if (np) {
-		nvmem = of_nvmem_find(np);
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-	} else {
-		struct nvmem_cell *cell = nvmem_find_cell(cell_id);
+	if (!np)
+		return ERR_PTR(-EINVAL);
 
-		if (cell) {
-			nvmem = cell->nvmem;
-			*cellp = cell;
-		}
+	mutex_lock(&nvmem_mutex);
 
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-ENOENT);
-		}
+	nvmem = of_nvmem_find(np);
+	if (!nvmem) {
+		mutex_unlock(&nvmem_mutex);
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	nvmem->users++;
@@ -706,7 +597,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	return __nvmem_device_get(nvmem_np, NULL, NULL);
+	return __nvmem_device_get(nvmem_np);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
@@ -810,18 +701,6 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
-{
-	struct nvmem_cell *cell = NULL;
-	struct nvmem_device *nvmem;
-
-	nvmem = __nvmem_device_get(NULL, &cell, cell_id);
-	if (IS_ERR(nvmem))
-		return ERR_CAST(nvmem);
-
-	return cell;
-}
-
 #if IS_ENABLED(CONFIG_OF)
 /**
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
@@ -857,7 +736,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
+	nvmem = __nvmem_device_get(nvmem_np);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
@@ -926,19 +805,10 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
  */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 {
-	struct nvmem_cell *cell;
-
-	if (dev->of_node) { /* try dt first */
-		cell = of_nvmem_cell_get(dev->of_node, cell_id);
-		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
-			return cell;
-	}
-
-	/* NULL cell_id only allowed for device tree; invalid otherwise */
-	if (!cell_id)
+	if (!dev->of_node)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	return of_nvmem_cell_get(dev->of_node, cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
@@ -1227,64 +1097,6 @@ int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
 
-/**
- * nvmem_device_cell_read() - Read a given nvmem device and cell
- *
- * @nvmem: nvmem device to read from.
- * @info: nvmem cell info to be read.
- * @buf: buffer pointer which will be populated on successful read.
- *
- * Return: length of successful bytes read on success and negative
- * error code on error.
- */
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell cell;
-	int rc;
-	ssize_t len;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
-	if (rc)
-		return rc;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
-
-/**
- * nvmem_device_cell_write() - Write cell to a given nvmem device
- *
- * @nvmem: nvmem device to be written to.
- * @info: nvmem cell info to be written.
- * @buf: buffer to be written to cell.
- *
- * Return: length of bytes written or negative error code on failure.
- * */
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell cell;
-	int rc;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	return nvmem_cell_write(&cell, buf, cell.bytes);
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
-
 /**
  * nvmem_device_read() - Read from a given nvmem device
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..7e9fb5a19d91 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -21,14 +21,6 @@ struct device_node;
 struct nvmem_cell;
 struct nvmem_device;
 
-struct nvmem_cell_info {
-	const char		*name;
-	unsigned int		offset;
-	unsigned int		bytes;
-	unsigned int		bit_offset;
-	unsigned int		nbits;
-};
-
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -50,10 +42,6 @@ int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
 int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf);
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf);
 
 #else
 
@@ -116,20 +104,6 @@ static inline void devm_nvmem_device_put(struct device *dev,
 {
 }
 
-static inline ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-					 struct nvmem_cell_info *info,
-					 void *buf)
-{
-	return -ENOSYS;
-}
-
-static inline int nvmem_device_cell_write(struct nvmem_device *nvmem,
-					  struct nvmem_cell_info *info,
-					  void *buf)
-{
-	return -ENOSYS;
-}
-
 static inline int nvmem_device_read(struct nvmem_device *nvmem,
 				    unsigned int offset, size_t bytes,
 				    void *buf)
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..cc8556e3c825 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 
 struct nvmem_device;
-struct nvmem_cell_info;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -52,8 +51,6 @@ struct nvmem_config {
 	const char		*name;
 	int			id;
 	struct module		*owner;
-	const struct nvmem_cell_info	*cells;
-	int			ncells;
 	bool			read_only;
 	bool			root_only;
 	nvmem_reg_read_t	reg_read;
@@ -77,9 +74,6 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells);
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -105,12 +99,5 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 
 }
 
-static inline int nvmem_add_cells(struct nvmem_device *nvmem,
-				  const struct nvmem_cell_info *info,
-				  int ncells)
-{
-	return -ENOSYS;
-}
-
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.18.0

