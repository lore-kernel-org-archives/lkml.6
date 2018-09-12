Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8F7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fa24vuCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8096420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeILMz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeILMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so914692wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lLKK18pFJM5d1X9iNpVJoHXKMT+hCg6oOMMo9UfD6ow=;
        b=Fa24vuCMOjNUTBR5ac4mq0/BGhHz97k7rhZaazZN+EGE+6W711frTRSiK3i6jvriOV
         R9OXchT2tDU5SY4FO9wV1gELthijetAGtA6XQo/vyXeEFRLsQjEdZ5cp38TMm3Vubv4a
         IWYUIO5cmhJ5w8lcDa7d/2geBHU1C+b/gTEUQZGZf2RS4B8t2yTfhhkNzK089Fxx1Vky
         v87Wv6TuOkO6dIH953pmX1sWhBL90Mc+Utk2JajCflwBC8s32qitVRo0GSP0T1ZBn6sT
         36zV+Xpi2XZE4QczYqhjKRCFhwuXQfMeaWI7rJaGV4nVf9MoDHnamysUiL8Hdc36W51z
         b/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lLKK18pFJM5d1X9iNpVJoHXKMT+hCg6oOMMo9UfD6ow=;
        b=KtRqOiYesI3j//ZNeVROZcGj1b/X2PhJ0MOMPIOnFOUHui657uPezhez02sOkPqmWf
         JDQm1ZVuqD9p5EZFnVN/QBEpGQuur0yLLSioArc/irLRyhUwMjn/B5P1UkpGgHf5bcc7
         4kxkBLTP4ltHfZEfCHca+ZrXJwNS9+WgODvK5AnjLWl6BTAlrjsIpwBbJntWxK+JkD9q
         5fLzugODNHt+KsWHoNqZ+LPOWvYiSZv5N/XeDTTJOH/FWHH6IlgtOfJqNc9u50udpp/O
         US+Pi3dhrOD/x5uS52lzH+Jws8EyALE2QAOuLwWGOxzql8PfqDlDUz/FjnPY3unr8lWm
         zLXw==
X-Gm-Message-State: APzg51D++FeNDn8ltOueM0qktf2Q6puJKnDl2xZL/XCWSmgVd8q94qfH
        nwGEIhrEPuZ+8M8lxp3kERaoZw==
X-Google-Smtp-Source: ANB0VdbV9mzFm0a1AO34Ak4ksncDimz1vfGd/D9UF5yj+XB7z2efDJz3h8UGLf3mQDdP4qXRQSqGug==
X-Received: by 2002:adf:e5c4:: with SMTP id a4-v6mr533615wrn.190.1536738726091;
        Wed, 12 Sep 2018 00:52:06 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:05 -0700 (PDT)
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
Subject: [PATCH v3 14/21] nvmem: add support for cell lookups from machine code
Date:   Wed, 12 Sep 2018 09:51:22 +0200
Message-Id: <20180912075129.25185-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a way for machine code users to associate devices with nvmem cells.

This restores the support for non-DT systems but following a different
approach. Cells must now be associated with devices using provided
routines and data structures before they can be retrieved using
nvmem_cell_get().

It's still possible to define cells statically in nvmem_config but
cells created this way still need to be associated with consumers using
lookup entries.

Note that nvmem_find() must be moves higher in the source file as we
want to call it from __nvmem_device_get() for devices that don't have
a device node.

The signature of __nvmem_device_get() is also changed as it's no longer
used to retrieve cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 129 ++++++++++++++++++++++++++-------
 include/linux/nvmem-consumer.h |  28 +++++++
 2 files changed, 131 insertions(+), 26 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 13568e7ad178..9cc86d131e1e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static DEFINE_MUTEX(nvmem_cell_mutex);
 static LIST_HEAD(nvmem_cell_tables);
 
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+static LIST_HEAD(nvmem_lookup_list);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -283,6 +286,18 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
+static struct nvmem_device *nvmem_find(const char *name)
+{
+	struct device *d;
+
+	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
+
+	if (!d)
+		return NULL;
+
+	return to_nvmem_device(d);
+}
+
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	mutex_lock(&nvmem_mutex);
@@ -472,6 +487,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 	return cell;
 }
 
+static struct nvmem_cell *
+nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
+{
+	struct nvmem_cell *cell = NULL;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(cell, &nvmem->cells, node) {
+		if (strcmp(cell_id, cell->name) == 0)
+			break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return cell;
+}
+
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
 	struct device_node *parent, *child;
@@ -719,16 +749,12 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
-					       struct nvmem_cell **cellp,
-					       const char *cell_id)
+					       const char *nvmem_name)
 {
 	struct nvmem_device *nvmem = NULL;
 
-	if (!np)
-		return ERR_PTR(-ENOENT);
-
 	mutex_lock(&nvmem_mutex);
-	nvmem = of_nvmem_find(np);
+	nvmem = np ? of_nvmem_find(np) : nvmem_find(nvmem_name);
 	mutex_unlock(&nvmem_mutex);
 	if (!nvmem)
 		return ERR_PTR(-EPROBE_DEFER);
@@ -752,18 +778,6 @@ static void __nvmem_device_put(struct nvmem_device *nvmem)
 	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 
-static struct nvmem_device *nvmem_find(const char *name)
-{
-	struct device *d;
-
-	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
-
-	if (!d)
-		return NULL;
-
-	return to_nvmem_device(d);
-}
-
 #if IS_ENABLED(CONFIG_OF)
 /**
  * of_nvmem_device_get() - Get nvmem device from a given id
@@ -786,7 +800,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	return __nvmem_device_get(nvmem_np, NULL, NULL);
+	return __nvmem_device_get(nvmem_np, NULL);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
@@ -890,15 +904,43 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
+static struct nvmem_cell *
+nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 {
-	struct nvmem_cell *cell = NULL;
+	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
+	struct nvmem_cell_lookup *lookup;
 	struct nvmem_device *nvmem;
+	const char *dev_id;
 
-	nvmem = __nvmem_device_get(NULL, &cell, cell_id);
-	if (IS_ERR(nvmem))
-		return ERR_CAST(nvmem);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	dev_id = dev_name(dev);
+
+	mutex_lock(&nvmem_lookup_mutex);
+
+	list_for_each_entry(lookup, &nvmem_lookup_list, node) {
+		if ((strcmp(lookup->dev_id, dev_id) == 0) &&
+		    (strcmp(lookup->con_id, con_id) == 0)) {
+			/* This is the right entry. */
+			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
+			if (!nvmem) {
+				/* Provider may not be registered yet. */
+				cell = ERR_PTR(-EPROBE_DEFER);
+				goto out;
+			}
+
+			cell = nvmem_find_cell_by_name(nvmem,
+						       lookup->cell_name);
+			if (!cell) {
+				__nvmem_device_put(nvmem);
+				goto out;
+			}
+		}
+	}
 
+out:
+	mutex_unlock(&nvmem_lookup_mutex);
 	return cell;
 }
 
@@ -935,7 +977,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
+	nvmem = __nvmem_device_get(nvmem_np, NULL);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
@@ -975,7 +1017,7 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 	if (!cell_id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	return nvmem_cell_get_from_lookup(dev, cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
@@ -1405,6 +1447,41 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table)
 }
 EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
 
+/**
+ * nvmem_add_cell_lookups() - register a list of cell lookup entries
+ *
+ * @entries: array of cell lookup entries
+ * @nentries: number of cell lookup entries in the array
+ */
+void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_add_tail(&entries[i].node, &nvmem_lookup_list);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_cell_lookups);
+
+/**
+ * nvmem_del_cell_lookups() - remove a list of previously added cell lookup
+ *                            entries
+ *
+ * @entries: array of cell lookup entries
+ * @nentries: number of cell lookup entries in the array
+ */
+void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_del(&entries[i].node);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 0389fe00b177..27eee3945405 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -29,6 +29,24 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 };
 
+/**
+ * struct nvmem_cell_lookup - cell lookup entry
+ *
+ * @nvmem_name:	Name of the provider.
+ * @cell_name:	Name of the nvmem cell as defined in the name field of
+ *		struct nvmem_cell_info.
+ * @dev_id:	Name of the consumer device that will be associated with
+ *		this cell.
+ * @con_id:	Connector id for this cell lookup.
+ */
+struct nvmem_cell_lookup {
+	const char		*nvmem_name;
+	const char		*cell_name;
+	const char		*dev_id;
+	const char		*con_id;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -57,6 +75,11 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
+void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
+			    size_t nentries);
+void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries,
+			    size_t nentries);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -151,6 +174,11 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
+static inline void
+nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+static inline void
+nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

