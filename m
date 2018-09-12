Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E765FECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D972087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qvItpAFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D972087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeILMza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36548 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeILMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so927755wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ONRPGmkEebVAn+Em0u14ctkjE+SPNF1nDYJohXjda1s=;
        b=qvItpAFIA/3X/EtDfp67HU5NjxuE3cAbpL8MLCh3D1XFACpaWiO1829tMp2pNzJmTi
         gynBFUzsPa6tNEMNyCxq8m/lG1vgNXTeZNlDCQvC+Ek2J300vFgaG5BQW9WDKIVUwZzY
         OmZyU8G3Q2R8MxPf+zWfqSLd/2UFdLcaYqzIoikfs930btSMvHEk4PElRhchvNYiIdpt
         4xW0ag4N2aygeqzyPOJQdD2HbgPY9YKDIpyjMhLKE4tJ7+eG3633UYXXHI11zct0t6a2
         uXIaJhlQoCuBIPS/XdEX5bmpEJ4PyBuyFIcjo4ZKJBc1eYfyloIw/CxSmGTJJ3AkwR50
         gwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ONRPGmkEebVAn+Em0u14ctkjE+SPNF1nDYJohXjda1s=;
        b=ON57tSQ5wjskFABHc7GpM8bPsEGsf/CVfFbnwuKrYeoRCNGyVTWej5nXgBvEGPRZmy
         b7uBJGq58n+nTXyZxtJv5n//aO4m5PoGhr2FEkoRUZ+wskFeZiaCqG1Ao9W8KpLwsxBS
         2m59wvZp0QyPBrxJv7t+tAjcVLRk7Plwu8rLrYicQ+J5p1rhJYzK0osIqxMq73/aKAjW
         Drm5itfqDmsl6kfdAW0e8UbbqkhRb1uaXomVrVeYxgVzpj3PdBH9nGVk2YinX8MQ/ytV
         Caw6iR4ds2vWTVLLw8DjAEpZrXFLPddQNCFhAkrhncht4z2zXnAZqrheTuiCVC9t+oHR
         10xg==
X-Gm-Message-State: APzg51CV1Kxl3VOeNdJZ2fcpYrcsJm4wJ9kuCAxLK0y0TQO5PVEEpVmN
        bqpgl8bkFUBBbonHYbWgq3hY6Q==
X-Google-Smtp-Source: ANB0VdYlUVak9AjqeNrN4vunVrijFUrZrwOoN65g0hO7EDu48V0vPrOaPGErYEz13zRmx41BEBoL/A==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr499767wrn.43.1536738729835;
        Wed, 12 Sep 2018 00:52:09 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 16/21] nvmem: add a notifier chain
Date:   Wed, 12 Sep 2018 09:51:24 +0200
Message-Id: <20180912075129.25185-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a blocking notifier chain with four events (add and remove for
both devices and cells) so that users can get notified about the
addition of nvmem resources they're waiting for.

We'll use this instead of the at24 setup callback in the mityomapl138
board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 36 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 21 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9cc86d131e1e..af6f7163cb67 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -65,6 +65,8 @@ static LIST_HEAD(nvmem_cell_tables);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 static LIST_HEAD(nvmem_lookup_list);
 
+static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -300,6 +302,7 @@ static struct nvmem_device *nvmem_find(const char *name)
 
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
@@ -319,6 +322,7 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
 	mutex_unlock(&nvmem_mutex);
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
 
 static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
@@ -434,6 +438,32 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+/**
+ * nvmem_register_notifier() - Register a notifier block for nvmem events.
+ *
+ * @nb: notifier block to be called on nvmem events.
+ *
+ * Return: 0 on success, negative error number on failure.
+ */
+int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_register_notifier);
+
+/**
+ * nvmem_unregister_notifier() - Unregister a notifier block for nvmem events.
+ *
+ * @nb: notifier block to be unregistered.
+ *
+ * Return: 0 on success, negative error number on failure.
+ */
+int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
+
 static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 {
 	const struct nvmem_cell_info *info;
@@ -647,6 +677,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	return nvmem;
 
 err_remove_cells:
@@ -675,6 +709,8 @@ static void nvmem_device_release(struct kref *kref)
 	nvmem_device_remove_all_cells(nvmem);
 	device_del(&nvmem->dev);
 	put_device(&nvmem->dev);
+
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
 }
 
 /**
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 27eee3945405..0326b52e906b 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 struct device;
 struct device_node;
@@ -47,6 +48,13 @@ struct nvmem_cell_lookup {
 	struct list_head	node;
 };
 
+enum {
+	NVMEM_ADD = 1,
+	NVMEM_REMOVE,
+	NVMEM_CELL_ADD,
+	NVMEM_CELL_REMOVE,
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -80,6 +88,9 @@ void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
 
+int nvmem_register_notifier(struct notifier_block *nb);
+int nvmem_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -179,6 +190,16 @@ nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 static inline void
 nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 
+static inline int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

