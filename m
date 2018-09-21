Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA80C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC42E21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QXLJacYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC42E21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbeIUNRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40918 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389437AbeIUNRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207-v6so2019448wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qilqxEjxudzJVMWNjYeBFxyC20AgStI3tn0cY3uUaXY=;
        b=QXLJacYotp0D8kOLUA+bKuhvbsyrcLzt06gEKl1jD+g/f1Wku5M/X+HrlSDc5meezh
         io6rBgQZy7ljVZdCzk9MPu+93g20LBgJfF1P8idJFILBp96pmVPZ2f3X9fCUR/jaXoK4
         tp6pJlfsSN7zV6RH3IP1uT2IsSY4qcOaSDpKrxVfDXk/x7MRussjNgVGnCkyarSb44f2
         bXnHszeqAoYQY9XiXym4aRoQn6fRVzXQwYeGjvOnuRWyHRHBz5tJutx40ztUG1gH7z7A
         FKUHLYyP+r+5xaS/ILV5tJE4tPUxzlxAs/bcV6ayelAOGSTQjDTJpqDoPLjTDLI7Z0PE
         q6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qilqxEjxudzJVMWNjYeBFxyC20AgStI3tn0cY3uUaXY=;
        b=OitUpk7YYArZlRi/LR/H4GwJGa2enaU81o++UVI9RhSdsrRvwBpZWWBKqN3HX5ElPA
         FcVJy8VFzjjSoMLI6fabDMrIt86wJW+/FS25ZaPVIbAQ+/F43T3K/+vdyGJ2rpH36/c3
         I7tJirzhqqbEOHjpeh6mKcfO0B5b+OhYW3Fc1HdpOhUsgpdiY+2vk27P3VevsPFVNFzP
         aK+otcV/qvpFiqS9ubdLAMorb82hh19tqWZSTN15Sy1PZV7w94tsSML5mmivgqBPHUcP
         IDHmn14o8HctOQy3q5lso+I2ef0mvbCMYd+E5dxPfdWPHWwuFKOOiDD/3WtDwZkW9Lgl
         AvVg==
X-Gm-Message-State: APzg51AcFXS2BJZZAHFkw2jz7I0QKfU7bwl5VV+bJhXVHO9kOo/Inp2p
        SWDWDGYRNEEAm08gX2ZF3ROINw==
X-Google-Smtp-Source: ANB0VdaTn/DLgZNz0Zxqs7v0Tm2x/PV3TIyKd8uAO0OV0kbEkFA9v26GB6gwPeIGE8RTjSPISkb59w==
X-Received: by 2002:a1c:610b:: with SMTP id v11-v6mr6186846wmb.20.1537514974589;
        Fri, 21 Sep 2018 00:29:34 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:33 -0700 (PDT)
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
Subject: [PATCH v5 06/22] nvmem: use kref
Date:   Fri, 21 Sep 2018 09:29:05 +0200
Message-Id: <20180921072921.19387-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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
2.18.0

