Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27054ECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B139D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U/nS09/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B139D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeILMzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeILMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so932956wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SlueuK3D0KeRnvcAEcelp7MxOUpOfwsUS5G08uyAGgM=;
        b=U/nS09/f1K13kRtxhqixd6Dz914B8d7hXMIHKUtMnIeNNjr+Z0W77trvKYXmkSteM6
         4lxtSfrBtmxE7a2O+bWIi21v/27UIBSjUtReKA9Idy0maq9R6W7Xbcw1D2zgWlCfWlQb
         GDDAd7ORnGpshvQ5vV953c4uuODaYMfQ/BBQEt4N1c1o/TjyGZCx8Jy5GXb095OyZjws
         0lkvv3uFz1+Wxl3QslvFyYs6nGb6sVUg00cM4HlCYQESQmuHWUzPLxIri8/ITNDkz51I
         fPF6Zq38Rxh0XFUanm/n+5D8lT2mDaZcfqcDiGJBbZ+RB9UDr55MpbUrckA0oZflav+w
         mcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SlueuK3D0KeRnvcAEcelp7MxOUpOfwsUS5G08uyAGgM=;
        b=VvU9aFE11G0swjCf6Qti1cN8aCVex0HVoDxj0n9UfYeR0pzaOUjEoEkxS+J5pvqPtK
         Zlngdrh3u7VMTeGYD35Zml9mWhlAJ0Wywqmezgyn84iQdwHGVYMvBmAin/IduimY6UCN
         vEbaILDXwb8Ds38xmKWpLri/Tqmlj2I+K7oedb8wZsU5GlIPZ8FzhXN4uLcBixZdORst
         va+ux7sZo7QLc/sZxbneX4qyVeb5JbFVxluTMBfEdSsZV0wh8wwweiL7X2WUD75xT6Me
         38/X9FpkMLTUQ6+I0wRr3PT34nbS1hGAwX7ZUQqo/PNjLrIi38VP8fbivXHdPpdNUpX1
         ziFg==
X-Gm-Message-State: APzg51BXXWPd1s6dpBRX62bN8oW/SSXKlp8nOxBbcd/Ynt4a7fAQCzD7
        gxmKpMR+16NCv9pCTiAjQRN+bA==
X-Google-Smtp-Source: ANB0VdZx7bfMc2Yp6gvxO2lSWstnoWPtk5yyLobK8LITg+ehGl1Olf8+LNV5PkQ0RjlkGdvkRhxAdg==
X-Received: by 2002:adf:ed88:: with SMTP id c8-v6mr518705wro.264.1536738734945;
        Wed, 12 Sep 2018 00:52:14 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:14 -0700 (PDT)
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
Subject: [PATCH v3 19/21] nvmem: use EOPNOTSUPP instead of ENOSYS
Date:   Wed, 12 Sep 2018 09:51:27 +0200
Message-Id: <20180912075129.25185-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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
 include/linux/nvmem-provider.h |  4 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

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
index d37785afd14d..01ad6895ea12 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -100,7 +100,7 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
@@ -114,7 +114,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-EOPNOTSUPP);
 
 }
 
-- 
2.18.0

