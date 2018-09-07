Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CF320876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pcULNN92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CF320876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeIGOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37219 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeIGOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so14024432wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZATZdgnPAoTpW/g3YD69XZQ2uG+BR5UrHmRyj2MT+4=;
        b=pcULNN92xTe/qjAuzPWSQQbdM1Ite5wqjDFVT8DvggEMW1fn5rpUwcZU/6rRh7mov0
         fZdJHqHzazXw2lc4PNtyp09Sxh5O9+skXkL6+MbIbfTXsVtVxlRWkZHjsylt5emgansP
         zNwTjh0hUZqCZYofmDXMwFLCPs74wZ77Tn1eN8tnyg029pLHni2TC7xetFj7c8lBVyqW
         eziiBZaHyP/bbqL9zD58e9/GUwea0KZXxPJI2Yxl9DoD/TAWVdYJTWhH31YuaaDygeR+
         0LHlOQLrhwoN7CDAkzRBHepsMk3Lrs925N8KBejlMIKanDPIaQrARDlXvOnAH4y/OYwD
         3CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KZATZdgnPAoTpW/g3YD69XZQ2uG+BR5UrHmRyj2MT+4=;
        b=IasaIAdi8dP4AwUtkl+OGhmLZexd2TctGgXmkW7/A5si1T9YIhiL7dQv2OOa7Cs635
         8S2rSusBEf6qmOReFHbsCU96RkB+PeXWiPz+UaXYkntk/EP7YnAcEKAqw3a+IVsm4ANB
         VKay0A/20cvHNoTsQYbDwp80biqfLwRZTAsjHiG6ekBTXK52ZBM6qP7Strfc6wC/5oMW
         nkP6YHxawNA9A8CX9KN+pBXU/KKqCjmpRmOSxtEBbAFw42lyRya1f3XWgRIyduoLnRwE
         WANLIWdoBeyH526sfY6+6RBA3hUJ1DvYO/TpEtFirB/c1RkhDOsntddeMo3fySBk/8CS
         yWVQ==
X-Gm-Message-State: APzg51C8CMCYac9Cv4Ng5YQXh7vHKd8rrjMC1L66utdS8Z+qcbpE9olM
        yKQpjNjARKKxwhNq1rgfVQigUw==
X-Google-Smtp-Source: ANB0VdYDxez+BzZjBjYhAMN3BqNHP9OvUbVqViJZLEwThk2xzFJBpV/sXcwLqu0I5j8KzOgKNlQ1bA==
X-Received: by 2002:a1c:b286:: with SMTP id b128-v6mr4301857wmf.121.1536314908917;
        Fri, 07 Sep 2018 03:08:28 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:28 -0700 (PDT)
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
Subject: [PATCH v2 08/16] nvmem: provide nvmem_dev_name()
Date:   Fri,  7 Sep 2018 12:07:42 +0200
Message-Id: <20180907100750.14564-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kernel users don't have any means of checking the names of nvmem
devices. Add a routine that returns the name of the nvmem provider.

This will be useful for nvmem notifier subscribers - otherwise they
can't check what device is being added/removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 89b91f73d08a..364ee16e7d6a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1144,6 +1144,19 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_dev_name() - Get the name of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: name of the nvmem device.
+ */
+const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return dev_name(&nvmem->dev);
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_name);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 7e9fb5a19d91..1313da6731ff 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -43,6 +43,8 @@ int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
 
+const char *nvmem_dev_name(struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -117,6 +119,12 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
+static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

