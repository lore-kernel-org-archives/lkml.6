Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A315E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iVPEx3YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A315E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeINTzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37423 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeINTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so10859675wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3JwPT9aoVeFiw7lwEM5tGc15cd9dEB7wdw3Rm9T4Ac=;
        b=iVPEx3YTxvbx2eRoKfJXvUhCsfC1Q5koeN87QHyS+Hx2YfhBM/EmbMWFyAqLwZev1k
         BLIMPnfndIqG+dlKsj0fXUdwe0hoMnPksa1E7i1OMWvNKUG9T7cHY0MIcWT5pD7/QXg6
         adCUxMA2XSxvJB5QTQ9d6IvgDfT9qemUmsl4D5DRI4gI2fu+EmVpMSo2Ex0nFKuS5HDc
         Uxir5PhMw7UWBXXkKzmtV9cq1CpdKwimBOcvScDCU4C1pi1xxb829TU5MUH20IpAZ60c
         p9+N+gV7SfcoNrhq7gK7SnMJdfvcDtYESPDvGzLWG+F4qW2bXJZK/43PPfYT1TxKAlxC
         XFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3JwPT9aoVeFiw7lwEM5tGc15cd9dEB7wdw3Rm9T4Ac=;
        b=TL9hG6LlqN7py/1CkZisQ73RePyXbJbF00hIPIKYVyN6oj8LPy7Y2vEiy4yliujh21
         u3LGQYQWLfI6f6JGiQ35m2ei7JvmS0juSsKFeimVfBiwo+nEZK3+rbJ4bu1SQbI9fCAf
         wmF7yOvhla83kHx8VzyfjR/kC/OFUEL5Jt8LUOzkRJCpG4tF+4/eB6lQDIfo9qYAvJFv
         Cnqz4J8NVE+ANNeYw+DFriSJDzpIX2Q4519pAqJgvApMGTlCVrfHevRk7b9boB/t9VSO
         Yeop9rBNvHKlDby5vTco4CdJVKWV/ARRqsJ7aRFwJ90uZD9KSO+FwJqgcMSgYjMXtiWr
         e6yA==
X-Gm-Message-State: APzg51BMfGs8H3iWbO3bRjZmieDxBJaGnWcasytVjbGGSliE4bnyfCqB
        J6jOI+KOQYK5K+IlwbxM/nCDeQ==
X-Google-Smtp-Source: ANB0VdaBgQ1b0c71m+FKGhizDR8S2sBgA3jAyATT01Q4eT07YuaGKpVh1P6s+5fs+eBLxUhX6GGYNw==
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr10308354wrr.171.1536936050423;
        Fri, 14 Sep 2018 07:40:50 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:49 -0700 (PDT)
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
Subject: [PATCH v4 20/22] nvmem: use EOPNOTSUPP instead of ENOSYS
Date:   Fri, 14 Sep 2018 16:40:09 +0200
Message-Id: <20180914144011.27614-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits warnings when using ENOSYS. Some of the frameworks
started using EOPNOTSUPP as return values for API functions when given
subsystem is disabled in Kconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/nvmem-consumer.h | 30 +++++++++++++++---------------
 include/linux/nvmem-provider.h |  5 ++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index e17617fa034f..312bfa5efd80 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -93,13 +93,13 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
 						const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
 						     const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void devm_nvmem_cell_put(struct device *dev,
@@ -113,31 +113,31 @@ static inline void nvmem_cell_put(struct nvmem_cell *cell)
 
 static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline int nvmem_cell_write(struct nvmem_cell *cell,
 				    const char *buf, size_t len)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_cell_read_u32(struct device *dev,
 				      const char *cell_id, u32 *val)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_device *devm_nvmem_device_get(struct device *dev,
 							 const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void nvmem_device_put(struct nvmem_device *nvmem)
@@ -153,28 +153,28 @@ static inline ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *info,
 					 void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_cell_write(struct nvmem_device *nvmem,
 					  struct nvmem_cell_info *info,
 					  void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_read(struct nvmem_device *nvmem,
 				    unsigned int offset, size_t bytes,
 				    void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_device_write(struct nvmem_device *nvmem,
 				     unsigned int offset, size_t bytes,
 				     void *buf)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
@@ -189,12 +189,12 @@ nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 
 static inline int nvmem_register_notifier(struct notifier_block *nb)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 static inline int nvmem_unregister_notifier(struct notifier_block *nb)
 {
-	return -ENOSYS;
+	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_NVMEM */
@@ -208,13 +208,13 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 						   const char *id)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 						       const char *name)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_NVMEM && CONFIG_OF */
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 8ae012f6545a..1e3283c2af77 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -100,7 +100,7 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
@@ -114,8 +114,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return -ENOSYS;
-
+	return -EOPNOTSUPP;
 }
 
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
-- 
2.18.0

