Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928BE2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YYWZtmW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928BE2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbeIUNRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38509 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389511AbeIUNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so8063798wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aecfarjoeDMcu1kl6u1BGN19//Di9TtONvHVMnCvVhw=;
        b=YYWZtmW2Hk1saQg8NQO+fU2JnvJcZCBkQuJ/WDK7QxAleMMmDgWi3DGPqb6BOrhEoX
         LhfdP3ece/qPXgXQlQiEFNq69zYiFNiXDs9mrkWt/Jg+ejoiyUTB+0KlgU5GqZYOsMvR
         u+FskGSqYyDcQS6z47Zru9VYz6xm3uQwGzcRunJ+n0s8psY7DOFqGOjPVbhUIi60SL4h
         uJNRvRIiqyicZ9Gx44x8kxclfWhc1GPZ2dMOR5RrgQdm57gycK0W8vmR8/aHaDonTpoM
         1CSRIk7Xz/XQgBFzL9o5bqghCE200xkCmTRwpDKkXX0rXKDrXjt+wG0B6OEmC7rYIamg
         kQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aecfarjoeDMcu1kl6u1BGN19//Di9TtONvHVMnCvVhw=;
        b=KhXhdI7cRNHiGl3IfjfSsdijhINmWtGb+3jAA/usvqaouQ3xOpOphxBZXWhi6j16Sc
         KC2xkYafu5m18/NxEsRZEBcjiMnp0ecc/C6lgQ24Zm/lWebGOaboRLs8UJJdfv6TJb/v
         CzCH0B32l+Zfch0Q9ey4+RuEI19EiCzE0xpHvb2G73ltRRe1WNZiWnC7ubI4qwvTvIT+
         gTixD2MS7Wzx0D2zSFlffoEiMtTkL/TJjI24u6bcxNqW8eMEevjOwUHusd13KFul2FSL
         zC5Mxr4dvhm3AvDpktsK5fFs8dO+weyQ+ehY9vd4KdHikDDu26NkGotvGRRetwc2ifqq
         faGg==
X-Gm-Message-State: APzg51DKon9xiNkzRfrzbY/DHo9h7z36zr7+BjB7Mf1/cYqVLynP/qFn
        6n8aQIwwrHLbdfrHiMOdLfchxQ==
X-Google-Smtp-Source: ANB0VdbMaeAx4c6C9b/PzBPPdB+ZwRVw+6OkPxQO90FmXUbnMoj67MK430vh+VBxtIdTjFQ/944LfQ==
X-Received: by 2002:adf:8024:: with SMTP id 33-v6mr36029974wrk.16.1537514984101;
        Fri, 21 Sep 2018 00:29:44 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:43 -0700 (PDT)
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
Subject: [PATCH v5 13/22] nvmem: add support for cell info
Date:   Fri, 21 Sep 2018 09:29:12 +0200
Message-Id: <20180921072921.19387-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add new structs and routines allowing users to define nvmem cells from
machine code. This global list of entries is parsed when a provider
is registered and cells are associated with the relevant nvmem_device
struct.

A possible improvement for the future is to allow users to register
cell tables after the nvmem provider has been registered by updating
the cell list at each call to nvmem_(add|del)_cell_table().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 72 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 33 +++++++++++-----
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ee794613024c..8e0108806e65 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -59,6 +59,9 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static DEFINE_MUTEX(nvmem_cell_mutex);
+static LIST_HEAD(nvmem_cell_tables);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -416,6 +419,43 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
+{
+	const struct nvmem_cell_info *info;
+	struct nvmem_cell_table *table;
+	struct nvmem_cell *cell;
+	int rval = 0, i;
+
+	mutex_lock(&nvmem_cell_mutex);
+	list_for_each_entry(table, &nvmem_cell_tables, node) {
+		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
+			for (i = 0; i < table->ncells; i++) {
+				info = &table->cells[i];
+
+				cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+				if (!cell) {
+					rval = -ENOMEM;
+					goto out;
+				}
+
+				rval = nvmem_cell_info_to_nvmem_cell(nvmem,
+								     info,
+								     cell);
+				if (rval) {
+					kfree(cell);
+					goto out;
+				}
+
+				nvmem_cell_add(cell);
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_cell_mutex);
+	return rval;
+}
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -502,8 +542,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_teardown_compat;
 	}
 
+	rval = nvmem_add_cells_from_table(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	return nvmem;
 
+err_remove_cells:
+	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
@@ -1306,6 +1352,32 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_add_cell_table() - register a table of cell info entries
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_add_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_add_tail(&table->node, &nvmem_cell_tables);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_cell_table);
+
+/**
+ * nvmem_del_cell_table() - remove a previously registered cell info table
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_del_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_del(&table->node);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0f357d0c1e75..5c9f205cac8f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -67,6 +67,25 @@ struct nvmem_config {
 	struct device		*base_dev;
 };
 
+/**
+ * struct nvmem_cell_table - NVMEM cell definitions for given provider
+ *
+ * @nvmem_name:		Provider name.
+ * @cells:		Array of cell definitions.
+ * @ncells:		Number of cell definitions in the array.
+ * @node:		List node.
+ *
+ * This structure together with related helper functions is provided for users
+ * that don't can't access the nvmem provided structure but wish to register
+ * cell definitions for it e.g. board files registering an EEPROM device.
+ */
+struct nvmem_cell_table {
+	const char		*nvmem_name;
+	const struct nvmem_cell_info	*cells;
+	size_t			ncells;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -77,9 +96,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells);
+void nvmem_add_cell_table(struct nvmem_cell_table *table);
+void nvmem_del_cell_table(struct nvmem_cell_table *table);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -102,12 +121,8 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 
 }
 
-static inline int nvmem_add_cells(struct nvmem_device *nvmem,
-				  const struct nvmem_cell_info *info,
-				  int ncells)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
+static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.18.0

