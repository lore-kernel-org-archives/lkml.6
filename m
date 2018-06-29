Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35105C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1E227CCD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R3jn183N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1E227CCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeF2Jre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:47:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34872 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753471AbeF2Jkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so1377162wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/FNWrso0KYb0FtvjK1i/NE6vmY1e5xQyWwcE+KEWFI=;
        b=R3jn183NteYS4ykkM1zHN3kG2kow5YhYIUZxfE0cRBG8cQARzRyQRvYA7VYEUNOkgU
         sR9pqrmagPqwAcj9sHhg0JBYj/tn08KmcuoVZFbhE53YZvSU+dYjd/5IbJQbw5XrDqJK
         iRE8eJsjKBHwVsic1V5ZHKUhfcEg5SVrIfTdYztK9wryjsPbxVz1RaMhtMPkwzssBcys
         DP5Hbr2Eo4mvN9AgS1lLI1zzrmLAVxt1IbUqZzKjgeTTZCxgHQIx0CiwSghhR54rnEOG
         +QvyVgGzbhY4nBvzDG7Nj17iwnAREj77bcsjHbcQlr108vcgOcGxpa4EmM7Nh2zWcQB8
         K0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/FNWrso0KYb0FtvjK1i/NE6vmY1e5xQyWwcE+KEWFI=;
        b=MzMPE+txjfWJYGWgDHtfDRmEfDmrc78CG4p0oaW7bvwAR9eqNhJLVeZYM2GWbpMTib
         JBBFTKBnhEqOsxv3tIC6AK7yrLYCsBfZJGZYNl8blCej/ZMKZLS0kTUZSeuZmewjp59F
         0EEiEbXJ3yNXdOalfIRsd1p5BveXAjTMrwo+KiwCT/uNu2PTowBeoq8MF3hmGM8vCSO1
         A33AQegpWA6gLzoZp/F/FJ8yWo7tNg/dR/em+zkl2RXEhUOKlTv5zZoQta4EkEXh4eiR
         IeDIOqPR0mZwzJUepuhW6AJeUH0Q9il9JXXbzbmUldYmAk8N7h+IFOp7WuFqb/hMGTeU
         93xg==
X-Gm-Message-State: APt69E3XTzWz8CoIcbP0scVMl/h1jH+Do1lyjcR1o3mWxSveU7MXnZZn
        Pri0nFdx+4uv5c70UqVnQ7xX4w==
X-Google-Smtp-Source: AAOMgpeWekvZVrWRVwPLeQ0h+yF5iTQuAuezdeCepqs2wz8KYQgWnOmJNINpsqUtP1kIH0f1Pnk2uw==
X-Received: by 2002:a1c:d884:: with SMTP id p126-v6mr1148161wmg.110.1530265244681;
        Fri, 29 Jun 2018 02:40:44 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 01/18] nvmem: add support for cell lookups
Date:   Fri, 29 Jun 2018 11:40:22 +0200
Message-Id: <20180629094039.7543-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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
---
 drivers/nvmem/core.c           | 77 +++++++++++++++++++++++++++++++++-
 include/linux/nvmem-consumer.h |  6 +++
 include/linux/nvmem-provider.h | 10 +++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b0cdc21d01..2495550cbbc4 100644
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
@@ -936,7 +1007,11 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 			return cell;
 	}
 
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
2.17.1

