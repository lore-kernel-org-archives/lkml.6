Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88185C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374FE223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mp2BJsyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374FE223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeHJKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37313 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeHJKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so7467193wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/AcFQWG5GWA8z8qElGqK0mK/sub6hcCVMsKNMHf7yU=;
        b=mp2BJsyMH5Jzh+AlT2TxMl2PXpV1RPDC5IaZTfqZFbmqbesVVLoNcBellbSwNfPWDV
         nvHIjtpIbHbVfVrI7MspXAXuk0D88llSO10SHw2su4SU1w1qsQFWJ+YEeTVWZ4/FX10k
         WWmxfLLYQ3enNOx860j2+05PSR+sGxJR6aLnfzbbOm8K9b39sWO+I3fqcv5I9kvI0h52
         p/P3kBlt6IhyF1a3Zqtmc+wB1Dywc+u/mVEYBfinsqyYSpmWf7nTa6WBc8iwOaqVH5/G
         7NLrG0IJ2wW9UB8+xo1anMudCckAFesZaGr4TcgHVFPHnAHN3fxMiOddOpp8UqoVbDf3
         TSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/AcFQWG5GWA8z8qElGqK0mK/sub6hcCVMsKNMHf7yU=;
        b=ZUHkj0I4dmWWh3QUqLmgotzbbq9aSwWJdA2J04YXEGMBJnuH3Rat/N3RDJGVqsdOHU
         vGnQwXfgYL9xm4gDbXWkgCu7U1D0EYpFidatAGGZF2Z74rS10BdYo99MtABIEgNXM2B2
         r6BLgakGzScL5qtJTaURJz6kK3yb8EGlmRu80MbuoiY1nEPezVlH+7ocTIb/MdlfYDhe
         /kF+IVO5FcvjIwf9d6U0ABdic5E2W/QA03hFaC7JPbiMeNr/zxN5jTeEFg8s4ZZxkKRX
         aT5Z2Jtg0RQqLB2zudizxFSFZLjggHFQNA8tHyljEHTYNYrqKuT3IAPCgpqL0kDG07hI
         nG3g==
X-Gm-Message-State: AOUpUlFhgW/KHsz80nsMQpBF5dz+cpmvoMivSucg7L678lXm5vftQ2EU
        Po45X4l9e6d/UKdN76OMn5vH4w==
X-Google-Smtp-Source: AA+uWPyNG+MiQkHL7lktzUB76ahe9sNj6vF0qIRC9Dge0yNNOKIwv31hpHplckplwuZoZjBt7WDFVA==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr3665248wro.160.1533888337700;
        Fri, 10 Aug 2018 01:05:37 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:05:36 -0700 (PDT)
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
Subject: [PATCH v2 03/29] nvmem: add a notifier chain
Date:   Fri, 10 Aug 2018 10:05:00 +0200
Message-Id: <20180810080526.27207-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
 drivers/nvmem/core.c           | 20 ++++++++++++++++++++
 include/linux/nvmem-consumer.h | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 329ea5b8f809..128c8e51bff2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -65,6 +65,8 @@ static DEFINE_MUTEX(nvmem_cells_mutex);
 static LIST_HEAD(nvmem_cell_lookups);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 
+static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -479,6 +481,18 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_register_notifier);
+
+int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -559,6 +573,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (config->cells)
 		nvmem_add_cells(nvmem, config->cells, config->ncells);
 
+	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
+	if (rval)
+		goto err_device_del;
+
 	return nvmem;
 
 err_device_del:
@@ -586,6 +604,8 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 	}
 	mutex_unlock(&nvmem_mutex);
 
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
+
 	if (nvmem->flags & FLAG_COMPAT)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index f4b5d3186e94..ae4d30347602 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 struct device;
 struct device_node;
@@ -35,6 +36,11 @@ struct nvmem_cell_lookup {
 	const char		*nvmem_name;
 };
 
+enum {
+	NVMEM_ADD = 1,
+	NVMEM_REMOVE,
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -61,6 +67,8 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+int nvmem_register_notifier(struct notifier_block *nb);
+int nvmem_unregister_notifier(struct notifier_block *nb);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -149,6 +157,16 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
+static inline int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

