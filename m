Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65051C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CD52087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="B2LeJ69L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CD52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeIGOsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbeIGOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so14348499wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6kW/MWMreMdqngfmMkd7IkhX/posN3NlXBEDLsqaVk=;
        b=B2LeJ69LnpVEnygPtrvKbCTfC3GKdCl3LpnW/Opnqk9O6dGsko4UrPLNyOeLwJC/tB
         uy7s5P4gJnDKT+yYQ7lIa+wqYl2P48aLuDjmegkx2UNLXWpmuPolU3Fs7TeZh8hFBvyr
         z6bFP0uKAc7MubH3xzLjb+ZZea6jgPuQQiC+cWfd+yiWrUA00PPRZWalQi8yfv5cfxgU
         udparDXdn0LP7S+jrSSefg5gFrc3w0NWdIcMUHXza9/O+TGoMUpZr3bZDemXUiUt6fa5
         d6164NMy9tATVxf8Ikoeg+AnbsLA/tSaQlVEN0QzxYq5Ydn19/NQK2JXUpJtPDFtediv
         bYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O6kW/MWMreMdqngfmMkd7IkhX/posN3NlXBEDLsqaVk=;
        b=o0ArE2x+kavp7CYJq3ReojkNlpqOTd2k3PhBlA8ZXyD6lecBNMZ65HTxYJTR7KJ9sT
         qUAAn+gzskL4bnk9FguYlQjwU+TftcW3FxGVKAVoFJmvHIUzPm59wnMAIwP/nBHmeWGJ
         H/YfSqlFL45EGVtQN5jJ6516EdN/hsryu2+ID0+2/+kmQs823RZs7n1WYAeg0ULKZn4o
         wWkTMjHdx3sEnuC7MBXMyR0lstiPzMobvei6Cvjk0vk12IZIflR5XI69TtTR+Rh9xz2r
         FwPmp2/C718vfzZt1Jz8CAk3bYgInDpK3pRvyCbgyEB9xhDij4lsNDDNOOQFdksuNh0o
         fEPw==
X-Gm-Message-State: APzg51D1Jh6H8M+PXrpwWE/HOEymbdDx5j9JC9vxHBEu5Am9p0RqKKss
        QWQBjokdsmrgCcTizKka7bnVNg==
X-Google-Smtp-Source: ANB0VdabosKZ0ZjzOPCNJjpWuJUjKC2RXOe8YGBWVe8H5ORsjjLitO9xqRtxg2Ml0RuKu28UZcyKHg==
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr5780676wrd.246.1536314915443;
        Fri, 07 Sep 2018 03:08:35 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:34 -0700 (PDT)
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
Subject: [PATCH v2 13/16] nvmem: add support for cell lookups from machine code
Date:   Fri,  7 Sep 2018 12:07:47 +0200
Message-Id: <20180907100750.14564-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a way for machine code users to associate devices with nvmem cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c          | 143 +++++++++++++++++++++++++++-------
 include/linux/nvmem-machine.h |  16 ++++
 2 files changed, 132 insertions(+), 27 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index da7a9d5beb33..9e2f9c993a07 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static DEFINE_MUTEX(nvmem_cell_mutex);
 static LIST_HEAD(nvmem_cell_tables);
 
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+static LIST_HEAD(nvmem_lookup_list);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -285,6 +288,18 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
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
@@ -421,6 +436,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
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
@@ -691,22 +721,16 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
-static struct nvmem_device *__nvmem_device_get(struct device_node *np)
+static struct nvmem_device *
+__nvmem_device_get(struct device_node *np, const char *name)
 {
 	struct nvmem_device *nvmem = NULL;
 
-	if (!np)
-		return ERR_PTR(-EINVAL);
-
 	mutex_lock(&nvmem_mutex);
-
-	nvmem = of_nvmem_find(np);
-	if (!nvmem) {
-		mutex_unlock(&nvmem_mutex);
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
+	nvmem = np ? of_nvmem_find(np) : nvmem_find(name);
 	mutex_unlock(&nvmem_mutex);
+	if (!nvmem)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
@@ -726,18 +750,6 @@ static void __nvmem_device_put(struct nvmem_device *nvmem)
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
@@ -760,7 +772,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	return __nvmem_device_get(nvmem_np);
+	return __nvmem_device_get(nvmem_np, NULL);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
@@ -897,7 +909,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np);
+	nvmem = __nvmem_device_get(nvmem_np, NULL);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
@@ -913,6 +925,44 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
+static struct nvmem_cell *
+nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
+{
+	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_device *nvmem;
+	const char *dev_id;
+
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
+			if (!cell)
+				goto out;
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_lookup_mutex);
+	return cell;
+}
+
 /**
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
@@ -925,10 +975,14 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
  */
 struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 {
-	if (!dev->of_node)
+	if (dev->of_node)
+		return of_nvmem_cell_get(dev->of_node, cell_id);
+
+	/* Only allow empty cell_id for DT systems. */
+	if (!cell_id)
 		return ERR_PTR(-EINVAL);
 
-	return of_nvmem_cell_get(dev->of_node, cell_id);
+	return nvmem_cell_get_from_lookup(dev, cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
@@ -1300,6 +1354,41 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table)
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
diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
index 1e199dfaacab..7859c08934d5 100644
--- a/include/linux/nvmem-machine.h
+++ b/include/linux/nvmem-machine.h
@@ -26,16 +26,32 @@ struct nvmem_cell_table {
 	struct list_head	node;
 };
 
+struct nvmem_cell_lookup {
+	const char		*nvmem_name;
+	const char		*cell_name;
+	const char		*dev_id;
+	const char		*con_id;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
+void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries);
+void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries);
+
 #else /* CONFIG_NVMEM */
 
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
+static inline void
+nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+static inline void
+nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+
 #endif /* CONFIG_NVMEM */
 
 #endif  /* ifndef _LINUX_NVMEM_MACHINE_H */
-- 
2.18.0

