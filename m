Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E00C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953F2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/33HqbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbeIUT3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43764 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390137AbeIUT3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:39 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so12199787ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyo2v8Q81f5j5TT9ArxjR0qlqnA7vKY1hVWSAJE87jI=;
        b=D/33HqbKd5pZx/nzfIl24UnrbAa8X8/e+b/fwg+pmCIuMmmvEbwz01sdS14gk18Fxm
         94mvUlkVuEPObGVtHy8PdS9+4rBDpY/H5QOuPm16bjYJCREmbaX0RIIWoAhg6IvXWQfj
         zB5R8Bw8Z13dz3FO3+/MjUksjjmmaatnDVRTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyo2v8Q81f5j5TT9ArxjR0qlqnA7vKY1hVWSAJE87jI=;
        b=U+x2FNH8AUFS5KEvSpmLd2zbmoYUTgo6K5IZEkZP9+aaCw1baZB85v+O6u1K+WyLyu
         4zzC8RFz0CM032q8UwAhEW0SlB2auTqfrWww7jjs11AgCOTCrWlg4gKpmLYBvKgpkpnG
         2wNmOER/T7wVppBN6hTiMVsNxkfoLFR8s5FyVHTov851SV73rSiiApwoQDhGfDDD5mHi
         WzOOASNd7zpyNqH0xgF9aksQs0VpD5hdvsVMLNnpEqFLkY+S5zZ9yf5Dngw9CIof9UOB
         yvDj4tlpDO7b+LbKqbIb+kykatvIt719EhmsVf+34CIG685hBqcmoFuoIyt4Hxizon0D
         Bc3g==
X-Gm-Message-State: APzg51BukIVFPA0rd4Y5ELvG6tBX9RCRAJoWMbvXGZPRRfeUv2Mo08QC
        3Qj1jJwIr2x/MN+K1ZVYhVw40g==
X-Google-Smtp-Source: ANB0VdbDRcUaiFvXeio9Y3xcNgxJ9qHrJ8fGgqDOTq+slXnBTxI6OCQfvtwo3Uwt7uqh+aYnMYscGQ==
X-Received: by 2002:a02:c7d1:: with SMTP id s17-v6mr39843839jao.27.1537537243739;
        Fri, 21 Sep 2018 06:40:43 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:43 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/26] nvmem: use kref
Date:   Fri, 21 Sep 2018 06:40:08 -0700
Message-Id: <20180921134026.4596-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use kref for reference counting. Use an approach similar to the one
seen in the common clock subsystem: don't actually destroy the nvmem
device until the last user puts it. This way we can get rid of the
users check from nvmem_unregister().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0ef84441ebe5..920b56e500cc 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/init.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
@@ -31,7 +32,7 @@ struct nvmem_device {
 	int			stride;
 	int			word_size;
 	int			id;
-	int			users;
+	struct kref		refcnt;
 	size_t			size;
 	bool			read_only;
 	int			flags;
@@ -463,6 +464,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
+	kref_init(&nvmem->refcnt);
+
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
@@ -532,6 +535,20 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 }
 EXPORT_SYMBOL_GPL(nvmem_register);
 
+static void nvmem_device_release(struct kref *kref)
+{
+	struct nvmem_device *nvmem;
+
+	nvmem = container_of(kref, struct nvmem_device, refcnt);
+
+	if (nvmem->flags & FLAG_COMPAT)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
+
+	nvmem_device_remove_all_cells(nvmem);
+	device_del(&nvmem->dev);
+	put_device(&nvmem->dev);
+}
+
 /**
  * nvmem_unregister() - Unregister previously registered nvmem device
  *
@@ -541,19 +558,7 @@ EXPORT_SYMBOL_GPL(nvmem_register);
  */
 int nvmem_unregister(struct nvmem_device *nvmem)
 {
-	mutex_lock(&nvmem_mutex);
-	if (nvmem->users) {
-		mutex_unlock(&nvmem_mutex);
-		return -EBUSY;
-	}
-	mutex_unlock(&nvmem_mutex);
-
-	if (nvmem->flags & FLAG_COMPAT)
-		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
-
-	nvmem_device_remove_all_cells(nvmem);
-	device_del(&nvmem->dev);
-	put_device(&nvmem->dev);
+	kref_put(&nvmem->refcnt, nvmem_device_release);
 
 	return 0;
 }
@@ -647,7 +652,6 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 		}
 	}
 
-	nvmem->users++;
 	mutex_unlock(&nvmem_mutex);
 
 	if (!try_module_get(nvmem->owner)) {
@@ -655,22 +659,18 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 			"could not increase module refcount for cell %s\n",
 			nvmem_dev_name(nvmem));
 
-		mutex_lock(&nvmem_mutex);
-		nvmem->users--;
-		mutex_unlock(&nvmem_mutex);
-
 		return ERR_PTR(-EINVAL);
 	}
 
+	kref_get(&nvmem->refcnt);
+
 	return nvmem;
 }
 
 static void __nvmem_device_put(struct nvmem_device *nvmem)
 {
 	module_put(nvmem->owner);
-	mutex_lock(&nvmem_mutex);
-	nvmem->users--;
-	mutex_unlock(&nvmem_mutex);
+	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 
 static struct nvmem_device *nvmem_find(const char *name)
-- 
2.19.0

