Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D9FC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF76220890
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GrZI/lVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF76220890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeIGOsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50702 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbeIGOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so14204706wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J1XTyB4mx+/CzlqafJmwB/GS7AoL7xfVrlZaU0QgY8A=;
        b=GrZI/lVtMW02eiYUBbfrGywbxzO8c4MM1aHazk7T6gSADUS3HfbfE/r3QB8/Lw3Q+T
         3yVl73YfRU5VOashRo9bLWu3c0hOY4VW1D1IZQ+gNCa34H2mqxSo5UXKeXAKSDrk9c7m
         dhNkrnfH/5I4YnTtqCxjtsotaRkc6/9T94tq3UGvKEWAKC81CuYol/4PzcjHkjXdq2ds
         gN+CIlNql+wA2ZcQU+qSMn6INLZv+kF0e/X+wo6F0H3ACDG/rWhy83RzuuM8uqrIhPpi
         ibtKqaV6r8bzjtiFEGZ2u/dexd53Oy6+D8QKSnqSS/TMqPEqmef41P5+uxWPCqxbkzY9
         9pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J1XTyB4mx+/CzlqafJmwB/GS7AoL7xfVrlZaU0QgY8A=;
        b=I431mbuYjwrBiD9TZceCoYewHDmX7FwBHZvCJKzD9zuwb2h0qjY6loXmBgGPftTuno
         H+qwyclIHjVdRTK8pCkwtWSIt8Y9I0oouJrE16VXdXkRT/JN4tKbwxosQlyWw7FoT7Ie
         GG/5kPbuGTiT1BJfsPlEqUYdOFPQ0MKbeEKQsZ46ozVlpGc3hTYTVpofXgoVbDwTrxKh
         2DRCXt9f3Sk5XNU8VT7hbnsQoQcwvnOuDB04qyr1PQXYZaS6UpYHf0j80zoZBxpsFDRm
         tYqAkLR+KlXoSvMoT0cCelTHLtqqts3Jw9pDkr/wfHfmvQXBOCAFSfwz2dLwMecVFR+2
         onOw==
X-Gm-Message-State: APzg51Adb+gXn4Etuutw18d8yUdnh2nIy24f1BGaw6lBtAdA9xKIeIPm
        h3G4do88nMCM/WrT+5caqJlw3A==
X-Google-Smtp-Source: ANB0VdbtkBV1ML2Rf2ViBQMMF/MNN2SlVbE8BidphRJt9UAiGftA9I9Wd6/RYYdOhgAETyZT/CkWmg==
X-Received: by 2002:a1c:c64c:: with SMTP id w73-v6mr4316925wmf.98.1536314911633;
        Fri, 07 Sep 2018 03:08:31 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:30 -0700 (PDT)
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
Subject: [PATCH v2 10/16] nvmem: add a notifier chain
Date:   Fri,  7 Sep 2018 12:07:44 +0200
Message-Id: <20180907100750.14564-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a blocking notifier chain with two events (add and remove) so that
users can get notified about the addition of nvmem devices they're
waiting for.

We'll use this instead of the at24 setup callback in the mityomapl138
board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 36 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h | 19 ++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e456aaa6184a..17307015905a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -58,6 +58,8 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -339,6 +341,32 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
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
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -420,8 +448,15 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	INIT_LIST_HEAD(&nvmem->cells);
 
+	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
+	if (rval)
+		goto err_teardown_compat;
+
 	return nvmem;
 
+err_teardown_compat:
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:
@@ -436,6 +471,7 @@ static void nvmem_device_release(struct kref *kref)
 	struct nvmem_device *nvmem;
 
 	nvmem = container_of(kref, struct nvmem_device, refcnt);
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
 
 	if (nvmem->flags & FLAG_COMPAT)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 1313da6731ff..be583c4eb2d0 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 struct device;
 struct device_node;
@@ -21,6 +22,11 @@ struct device_node;
 struct nvmem_cell;
 struct nvmem_device;
 
+enum {
+	NVMEM_ADD = 1,
+	NVMEM_REMOVE,
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -45,6 +51,9 @@ int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
+int nvmem_register_notifier(struct notifier_block *nb);
+int nvmem_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -125,6 +134,16 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
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

