Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5351ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8674421531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cyCJgE39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8674421531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389639AbeIUNRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389623AbeIUNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so573187wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3JwPT9aoVeFiw7lwEM5tGc15cd9dEB7wdw3Rm9T4Ac=;
        b=cyCJgE39z3uNe10IH6WoV5lHS3nTLCMJiNRYcYaFvOSo6L7dHiCMtdAJzA50jU5oiY
         m3mLtied89U5vLdY9RiYbg6TAtfiD1rW5ZKEHjDAU3V17AAAWUD7S1OP1VAKnIFmJ3VY
         wSECvQn5Gz3u30TSljY/BWKPDpnWIlGRaRUkLPR3h/yR2bzMH/QhHoFfilSPVTOF2YDN
         AofSkWnKhY5nEzrTNa63pJ0gy6yzxKUwioXKbVei09SDyOQMSZ6DDQqSlFTGeGYBgo3S
         +ZST2FAZMoTc4gCyz9Uxi0PRG9Xng6gG4htP+D2sMNX2YzhVfE036682xz3KVO5ACh/t
         QjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3JwPT9aoVeFiw7lwEM5tGc15cd9dEB7wdw3Rm9T4Ac=;
        b=tHyP/jr/xKtUl60M0bwr8Uyg6nE0yfrof7MrmBRP3De/jg9pHevqPwIzp3jot6C59B
         2EV4O17/z4Fda9WoQU0Kq+j7DtuliQZkhc40JcAs29vU7SfgA/wL4Hh3y1at/c0ayb4O
         6Fk11eMPyyzOuhFAKKlkuFKP1P5VJ8hDkWlqnR7hSe/HdXb/bpC6xmNLsMXd13Lqgj0u
         OgVixqKMJSKRVRiYfG2DJAMHM6kWX+da5VdTNKhYLhQ+nFdZMgG1+1PbPro4sRohlntH
         vff8Ly0eJHiNFUQ7KYJN6u3kdTmTo5bBKdgO/chenQVRz2XHnkSwAW/vyqIH/Tcnz921
         fWcA==
X-Gm-Message-State: APzg51CNTm+xbXSuXooXR65zC9fAg9vIF77ETqbScuOlHPi2ingrIX3V
        Kei3oaT43J/oLdFuI0Z3hPrmOQ==
X-Google-Smtp-Source: ANB0VdZk0lLT+z2B9JRqsDhPBHsRFqWQa8sDVG5d5y0Tj0yzyXw3eQukRVQEcQaZESwRi18Xd7Ut0A==
X-Received: by 2002:adf:b2d7:: with SMTP id g81-v6mr10068281wrd.48.1537514993658;
        Fri, 21 Sep 2018 00:29:53 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:53 -0700 (PDT)
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
Subject: [PATCH v5 20/22] nvmem: use EOPNOTSUPP instead of ENOSYS
Date:   Fri, 21 Sep 2018 09:29:19 +0200
Message-Id: <20180921072921.19387-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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

