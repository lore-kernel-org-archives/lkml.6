Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD337C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6602087B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OX/FY9L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6602087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeIEO1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34336 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeIEO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so13530003wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fMftZWrQBIalsIbPmpTJQIjNIX58zZmJ2I3AfPo/uy8=;
        b=OX/FY9L7q4y5aFzrt9Y8LRlw6xAbQqeoVameJhBUtC31erQvFyDq3NlJOqnVB+wAVe
         WORCHJ7nqIAJ81IqqTQnkUz3xvhXkyKEW7UM9Lny8XArpCQnb9CodjAarU0hWxxq4FLa
         +EDDp5gS9AJpcp526MfR5K4Lkpv79MtEEB3+0BrM9MixHeWNp5iQGaePPQgtMnRS0ata
         7vmeoOlaQtWPcIJw1GlyJEVbF72EShPoUb6ipojpWEae3POH8QE2ov3xVb21F7+i4k46
         W6pWVSfTlBRawax2hIBVcIXxxKa/Cxzo82ZTY+ADjIajBIATc6La8OhPnmna0X1TFhDC
         aqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fMftZWrQBIalsIbPmpTJQIjNIX58zZmJ2I3AfPo/uy8=;
        b=SucF7sBHRcLAtr34G4jOp6Fujy+gvAYMatBDjimnI8ZRlfEbXlQlCgWkpyueFKxmXR
         g5qlYXb70noaWx74Mty090oLS0A5pivoy5m2pQYR2rywcdLy4PJjg6xAXvy1AMNyFM57
         7+m9dzGhTcVQ87AKyn+UN+TL+cHbVD7VnlpE0dYVIsSIYFaRt1d0kGSrqmolG2MCYG+x
         YZei7Ipb3i+XDwEhR1PU9zWdZCpWlE2+ZfjEzgJmlnHjZyskXBbVCCNRMOqepmWKZ/H5
         Sca5dF36JmNQOE0pOKCTtFTi9O55z4PK4U4xY3KmZGJ6YwoAw6uPOTnR+3P/iHklsTRn
         gR9Q==
X-Gm-Message-State: APzg51A0AA+w8GMNiy/n9fyB6M0qjA0C7kgu33U3Lg7sdDGRWZo1fj39
        swQu3ILDFuBi3ZrVtX81sSnkiQ==
X-Google-Smtp-Source: ANB0VdansAl2rjNg46PcnkRbhtChF/wJ1E4wXg7jxbvK1WbqZSMtqGtVUqafwi6tBiLbA/wS+bFKmQ==
X-Received: by 2002:a1c:6386:: with SMTP id x128-v6mr11055581wmb.104.1536141495459;
        Wed, 05 Sep 2018 02:58:15 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:14 -0700 (PDT)
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
Subject: [PATCH 09/13] nvmem: add support for cell info
Date:   Wed,  5 Sep 2018 11:57:34 +0200
Message-Id: <20180905095738.26406-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
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
 MAINTAINERS                   |  1 +
 drivers/nvmem/core.c          | 97 ++++++++++++++++++++++++++++++++++-
 include/linux/nvmem-machine.h | 41 +++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/nvmem-machine.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..a520924bf0a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,7 @@ F:	drivers/nvmem/
 F:	Documentation/devicetree/bindings/nvmem/
 F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
+F:	include/linux/nvmem-machine.h
 F:	include/linux/nvmem-provider.h
 
 NXP SGTL5000 DRIVER
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 17307015905a..854baa0559a1 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/nvmem-machine.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -58,6 +59,9 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static DEFINE_MUTEX(nvmem_cell_mutex);
+static LIST_HEAD(nvmem_cell_tables);
+
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -341,6 +345,66 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+static struct nvmem_cell *
+nvmem_cell_from_cell_info(struct nvmem_device *nvmem,
+			  struct nvmem_cell_info *info)
+{
+	struct nvmem_cell *cell;
+
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return ERR_PTR(-ENOMEM);
+
+	cell->nvmem = nvmem;
+	cell->offset = info->offset;
+	cell->bytes = info->bytes;
+	cell->name = info->name;
+	cell->bit_offset = info->bit_offset;
+	cell->nbits = info->nbits;
+
+	if (cell->nbits)
+		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
+					   BITS_PER_BYTE);
+
+	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
+		dev_err(&nvmem->dev,
+			"cell %s unaligned to nvmem stride %d\n",
+			cell->name, nvmem->stride);
+		kfree(cell);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return cell;
+}
+
+static int nvmem_add_cells_from_list(struct nvmem_device *nvmem)
+{
+	struct nvmem_cell_table *table;
+	struct nvmem_cell_info *info;
+	struct nvmem_cell *cell;
+	int rval = 0, i;
+
+	mutex_lock(&nvmem_cell_mutex);
+	list_for_each_entry(table, &nvmem_cell_tables, node) {
+		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
+			for (i = 0; i < table->ncells; i++) {
+				info = &table->cells[i];
+				cell = nvmem_cell_from_cell_info(nvmem, info);
+				if (IS_ERR(cell)) {
+					rval = PTR_ERR(cell);
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
  * nvmem_register_notifier() - Register a notifier block for nvmem events.
  *
@@ -447,13 +511,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	INIT_LIST_HEAD(&nvmem->cells);
+	rval = nvmem_add_cells_from_list(nvmem);
+	if (rval)
+		goto err_teardown_compat;
 
 	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 	if (rval)
-		goto err_teardown_compat;
+		goto err_remove_cells;
 
 	return nvmem;
 
+err_remove_cells:
+	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
@@ -1179,6 +1248,32 @@ int nvmem_device_write(struct nvmem_device *nvmem,
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
diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
new file mode 100644
index 000000000000..1e199dfaacab
--- /dev/null
+++ b/include/linux/nvmem-machine.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * nvmem framework machine code bindings
+ *
+ * Copyright (C) 2018 Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ */
+
+#ifndef _LINUX_NVMEM_MACHINE_H
+#define _LINUX_NVMEM_MACHINE_H
+
+#include <linux/nvmem-provider.h>
+#include <linux/list.h>
+
+struct nvmem_cell_info {
+	const char		*name;
+	unsigned int		offset;
+	unsigned int		bytes;
+	unsigned int		bit_offset;
+	unsigned int		nbits;
+};
+
+struct nvmem_cell_table {
+	const char		*nvmem_name;
+	struct nvmem_cell_info	*cells;
+	size_t			ncells;
+	struct list_head	node;
+};
+
+#if IS_ENABLED(CONFIG_NVMEM)
+
+void nvmem_add_cell_table(struct nvmem_cell_table *table);
+void nvmem_del_cell_table(struct nvmem_cell_table *table);
+
+#else /* CONFIG_NVMEM */
+
+static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
+static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
+
+#endif /* CONFIG_NVMEM */
+
+#endif  /* ifndef _LINUX_NVMEM_MACHINE_H */
-- 
2.18.0

