Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E605FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EE920882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Koy/9eEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EE920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeINTz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeINTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id y139-v6so2174688wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sH6sHViOL69spwJvTSXNgwwBEle/YysBPMHNYaVwPC4=;
        b=Koy/9eEzBccfFG9qSCX+EOZhuxMPA7hy2QzVpOung//tiU7iCFZE18fJYvadLjX0kA
         /qoGTEDfuoqQXsoDCRQoHYQBFZY52GGkoNEFHD6GQq1Yb6cXXlexKon4T1Qn2O094bql
         pkEGDJFEyXZYW640qfwuWpmTcRY1rfT4n7pFTIPq1Ulxnn+0P5DAmzqillC91rWLZP/T
         MPyMz6ujatZmEyFm9s6NSCk0V8NZ+U8de7XDUffgaD07C4K8My4oONF6vg/QBqeBol7k
         50YL2nI0k3SzjhZElLFjuWJEz2CeYTjtBDqNq7T6K5G2mG7l7OnMov9kFjr8MgD33Tc3
         jx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sH6sHViOL69spwJvTSXNgwwBEle/YysBPMHNYaVwPC4=;
        b=hwoNz+l0aqskBVeGru9RhWAzJvmAjqK5INtYTo2gVTYOr106RzmgQESegr+eNWU+XK
         hcjZot2sM7OhEc3BkSddgY+gfj+e7DqORQtQchhmZ7KCqBEQJZTnt91d60OsK1vmQJ9j
         QYG1gsJ7Rkt6FfjwNMjXJP6ECQf5tEnkH9nceRDaH38BFjJUWQS9I9v6NYMPEc5FQgSN
         CfdvtmukG3xii9G7wd5mfRzhh9/Jm2TlhAkYphNBoP0s0HLCt+EKzVSDgynijxytQYeU
         4rSHCNrU7AcKj1E50ji1fLk8kEjVyZOsuqSytJmWNsVG4Goiks9eMrMLsQk9wmxwc/iW
         u6yA==
X-Gm-Message-State: APzg51D0RgDVix1iKqcdEVnjxapr8amf0JWZqcmkNkMQDAYfCsi2Fw0H
        e2/vlCILXgd9B7lPIqxo+rOjqQ==
X-Google-Smtp-Source: ANB0VdaTRxeowG48swESmynF2i+4+p8//1nxusFMaHH5bMDpBv61xoPI4fKsn4qSlT1FiOSi5idSDw==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr2523529wmf.141.1536936038037;
        Fri, 14 Sep 2018 07:40:38 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:37 -0700 (PDT)
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
Subject: [PATCH v4 11/22] nvmem: change the signature of nvmem_unregister()
Date:   Fri, 14 Sep 2018 16:40:00 +0200
Message-Id: <20180914144011.27614-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We switched the nvmem framework to using kref instead of manually
checking the current number of users in nvmem_unregister() so this
function can no longer fail. We also converted all remaining users
that still checked the return value of nvmem_unregister() to using
devm_nvmem_register(). Make the routine return void.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 8 ++------
 include/linux/nvmem-provider.h | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 552ffedce38e..c950d54bb69d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -553,20 +553,16 @@ static void nvmem_device_release(struct kref *kref)
  * nvmem_unregister() - Unregister previously registered nvmem device
  *
  * @nvmem: Pointer to previously registered nvmem device.
- *
- * Return: Will be an negative on error or a zero on success.
  */
-int nvmem_unregister(struct nvmem_device *nvmem)
+void nvmem_unregister(struct nvmem_device *nvmem)
 {
 	kref_put(&nvmem->refcnt, nvmem_device_release);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
 static void devm_nvmem_release(struct device *dev, void *res)
 {
-	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+	nvmem_unregister(*(struct nvmem_device **)res);
 }
 
 /**
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..0f357d0c1e75 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -70,7 +70,7 @@ struct nvmem_config {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
-int nvmem_unregister(struct nvmem_device *nvmem);
+void nvmem_unregister(struct nvmem_device *nvmem);
 
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
@@ -87,10 +87,7 @@ static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int nvmem_unregister(struct nvmem_device *nvmem)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
 
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
@@ -101,7 +98,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return nvmem_unregister(nvmem);
+	return -ENOSYS;
 
 }
 
-- 
2.18.0

