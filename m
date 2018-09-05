Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E76FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F520876
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aAb9ZMjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4F520876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIEO1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeIEO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so6998758wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QNr1Tad048IXHrlgjJJINGlU6RT88CBalusVA7tzIww=;
        b=aAb9ZMjPXwNsXi4wamX4XdPDOIusj3ue91kpAs/Yvl7vMFMc/DpREsi9h+SJMrsd3V
         YfmvOo3WTIjwBFYBFCcfJ6U+8NgWBm2cvk3e+YsUlwzmqUk9JgpjhUpXOo2oXh5ouWZj
         TDyjJg0+TDLknPFxGWSMQwYc5wASRqXn3CetBI7W3pFwjqMeMc5D6pSXlcvpNj0+yJjY
         2b8dGZP4c7XON/87F1DrpPtUCrCVR0p0uXbCgoPd7Lcutj3Q5dFJ+zq4QKsEAOhlXOyW
         WBVsYi6YHpMvxWFeoogoqjQwi7vJAxrHZyWpbEur/l7PqXc4HySpetwdA6VPUyDG/Va3
         dhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QNr1Tad048IXHrlgjJJINGlU6RT88CBalusVA7tzIww=;
        b=rR0vQs+Xz/b3cEm2Kwg+DI8vUHysONmzbTc52Bp7SiXrX+MnhbMEhgQAWamMgK6Shm
         12oAPpKI0T8JEWTkh/MOBJ9t/yy2OWXkNVgPf8ppHWytQgVQLbd1k2mw6cl5DzeiPrhp
         v7ilWKohKCJhI/nIhWhuZAHrc/5oNjIYdaa2onvdBufHjUkfWX1MOCYZoKK6rNO/LfJp
         x8j0HvgIuUQem3DyRtAKBNlX2nGpgVvLoJyW5jUhd/mmUlvyZgRQfR76CFTN98hU2RNY
         KLccy9HmYaocV8XZqC9UwH+3pYL6j/v5umuRO/pMOdnzd5IKm0r1bEwoMyYu0tdzltSe
         YFgA==
X-Gm-Message-State: APzg51Af0mnJ0gVN5KEya4P4hioWw0fX6ymLHv8mbLhu53RA+zPL2lfo
        f4PAhWPPcTO3Rx9xyp64W2RGkQ==
X-Google-Smtp-Source: ANB0VdYj8KZSD2JMbnZgyg4vsJTpQ8e3knSB6hKrbQztH4l3cGOfNBjPxf2gEoEq/200g5aUOnmY2A==
X-Received: by 2002:a5d:404a:: with SMTP id w10-v6mr25212549wrp.147.1536141487773;
        Wed, 05 Sep 2018 02:58:07 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:07 -0700 (PDT)
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
Subject: [PATCH 03/13] nvmem: use kref
Date:   Wed,  5 Sep 2018 11:57:28 +0200
Message-Id: <20180905095738.26406-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
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
 drivers/nvmem/core.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 86af62e2df47..2335b72d4b3e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -32,7 +32,7 @@ struct nvmem_device {
 	int			stride;
 	int			word_size;
 	int			id;
-	int			users;
+	struct kref		refcnt;
 	size_t			size;
 	bool			read_only;
 	int			flags;
@@ -368,6 +368,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
+	kref_init(&nvmem->refcnt);
+
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
@@ -430,6 +432,20 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
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
@@ -439,19 +455,7 @@ EXPORT_SYMBOL_GPL(nvmem_register);
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
@@ -517,7 +521,6 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
-
 static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 {
 	struct nvmem_device *nvmem = NULL;
@@ -533,30 +536,24 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	nvmem->users++;
 	mutex_unlock(&nvmem_mutex);
 
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
 			nvmem->name);
-
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

