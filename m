Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D1C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A4F217FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fj32K78h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A4F217FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeHJKeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50633 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeHJKeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so935730wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C6+lAOCD7xYYjqAwsyLpdNynP10DYfCMxlDsoPITD5U=;
        b=Fj32K78hjOSxM5NAqapijcKbRg/4larGEi8ftAd5tBajKY92mFowMxQQk18GW+qzWv
         zxrnIkq/69gbVfOxlq2MwcfBKvoO7EWf0UEi4osZ5146rntyi+b7HTFExQOF4+gd5S4e
         lxawCv1CpztTCSE2PZIiumjeKv0tagGNM+SGuvqHXu4OA+NmbngdtuX3/iBAwu5HHL2p
         r1F5VqEqMpsYoL7+NMYprdJg8b06eC7uR844xP1ZOSuzCMSbZaE+5EFoaIlz4lzqaKAp
         IJp6ksJXeDmy4LJPU/G4sGyKCre9FCbhAbo8EVuA7SnlPYJ6QLZWyzRm/LLLZ8DtnR6Q
         ywKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C6+lAOCD7xYYjqAwsyLpdNynP10DYfCMxlDsoPITD5U=;
        b=T1Ki1MkBTpIYiniVxJ8qpHeooQR+4sLuyldf9iOVpRgmt8JkuPcv87kudDg6IKRFtS
         DhPo9qW6Nv3+edHD/Z3lHBujG/rU3X0rK9bve68zaCIOBVYeaU0XlbWEnmG+4PqkeaDQ
         DwYUlnitJu+Md/aMOsEI7QeMEGz8YaJIXVAlxop19b+lN0vxS5xUqSM/vbUxLS+h1ZGM
         GVODxWLQW3zwc0++C0Ch+1fceczVHGdSsqFpiyYrWMb57oGe7cx6kjmQQVlmRW7YOzA3
         i9lsgkFK9q133/4Tcxvm3r1sifB01wD8midHFyETLk6QhuFtTBjgwqYqWJZIeEJXXWcS
         P0qw==
X-Gm-Message-State: AOUpUlGtKW/OJYFAgUCDLHJiR2SEA/LbKcEYiHKIo4MWjwSG6gQvWyPQ
        gpvrfdJyDkMaC6nXS5MN+zfVqA==
X-Google-Smtp-Source: AA+uWPzy3clBvGJg0JNyQdBbCp/prcqqEHgnMmGGNtBt3AvzUga0oigMCh8jYiBVJd4uCWcmRC7+Ww==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr804377wmo.40.1533888333968;
        Fri, 10 Aug 2018 01:05:33 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/29] nvmem: add support for cell lookups
Date:   Fri, 10 Aug 2018 10:04:58 +0200
Message-Id: <20180810080526.27207-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can currently only register nvmem cells from device tree or by
manually calling nvmem_add_cells(). The latter options however forces
users to make sure that the nvmem provider with which the cells are
associated is registered before the call.

This patch proposes a new solution inspired by other frameworks that
offer resource lookups (GPIO, PWM etc.). It adds functions that allow
machine code to register nvmem lookup which are later lazily used to
add corresponding nvmem cells and remove them if no longer needed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 77 +++++++++++++++++++++++++++++++++-
 include/linux/nvmem-consumer.h |  6 +++
 include/linux/nvmem-provider.h | 10 +++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 514d1dfc5630..329ea5b8f809 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static LIST_HEAD(nvmem_cells);
 static DEFINE_MUTEX(nvmem_cells_mutex);
 
+static LIST_HEAD(nvmem_cell_lookups);
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -247,6 +250,41 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
 	NULL,
 };
 
+/**
+ * nvmem_add_lookup_table() - register a number of nvmem cell lookup entries
+ *
+ * @lookup: array of nvmem cell lookup entries
+ * @nentries: number of lookup entries in the array
+ */
+void nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_lookup_table);
+
+/**
+ * nvmem_del_lookup_table() - unregister a set of previously added nvmem cell
+ *                            lookup entries
+ *
+ * @lookup: array of nvmem cell lookup entries
+ * @nentries: number of lookup entries in the array
+ */
+void nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_del(&lookup[i].list);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_lookup_table);
+
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
@@ -916,6 +954,39 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
+static struct nvmem_cell *nvmem_cell_from_lookup(const char *cell_id)
+{
+	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	mutex_lock(&nvmem_lookup_mutex);
+
+	list_for_each_entry(lookup, &nvmem_cell_lookups, list) {
+		if (strcmp(cell_id, lookup->info.name) == 0) {
+			nvmem = nvmem_find(lookup->nvmem_name);
+			if (!nvmem) {
+				cell = ERR_PTR(-EPROBE_DEFER);
+				goto out;
+			}
+
+			rc = nvmem_add_cells(nvmem, &lookup->info, 1);
+			if (rc) {
+				cell = ERR_PTR(rc);
+				goto out;
+			}
+
+			cell = nvmem_cell_get_from_list(cell_id);
+			break;
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
@@ -940,7 +1011,11 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 	if (!cell_id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	cell = nvmem_cell_get_from_list(cell_id);
+	if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
+		return cell;
+
+	return nvmem_cell_from_lookup(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..f4b5d3186e94 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -29,6 +29,12 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 };
 
+struct nvmem_cell_lookup {
+	struct nvmem_cell_info	info;
+	struct list_head	list;
+	const char		*nvmem_name;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..6a17d722062b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -17,6 +17,7 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+struct nvmem_cell_lookup;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -72,6 +73,9 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+void nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries);
+void nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries);
+
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
@@ -92,6 +96,12 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
 	return -ENOSYS;
 }
 
+static inline void
+nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries) {}
+
+static inline void
+nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries) {}
+
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 {
-- 
2.18.0

