Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40AFC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DDC2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zs6/61vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DDC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeILMzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33419 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeILMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id r1-v6so9728876wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ckie7x+arONEAftwpr6LcpA8Mb8Zyx+Fo4gw/6J/zcY=;
        b=zs6/61vGHBZTsYmpPbe28hWPy5qln7SosFQigSIWV4cZWoIMA0YgCjoQmf2MUN9xUc
         61QRLLmGGMbbMJToneRfro/rbwpK15/wcCi7DiQ5wfsgL+RpeJrdztCLeeKGldxpun1j
         hJZkzvDRA2SUe3DGDeqI/B/H8fyZ1P9P6AxoZEHkOPwILDBbT8NAiTs3hwIbECH2qI3x
         1UVa2acWNn43Wn2PXr4vKoqYTse8PSv2b25TajmpEGrcGMygdgzm0HAbgGts94EufDz2
         mHR849VSZGUu7GpTFg8vPXRL0Dtmw8QP2073bqmaewCwBnZv864wYfYVL3kuqmOMrZab
         bWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ckie7x+arONEAftwpr6LcpA8Mb8Zyx+Fo4gw/6J/zcY=;
        b=tmVHzvbxwjgRZIdj7uaNCq2osRLmOrTThR/iSXeOU7hKYDbSSLq/9nXjs1Q+YFG904
         huRQRGRkU73vsN9aAunrYwzvs9coUCbIv9hh4KNXIm6F3i0/6tpKtyvO+XIAoG5btBOP
         qWRSY3NnGqDLcpok/XqePw/B0vKi3tO7EzSD/1myWcHvdsVXuV/WeKKiEOh1uAsxC0be
         ACwNAy2MZRfdTXjol60uuMiXRBxEsnHHBdH3S7CUAVf1Xl/AE6o4E/135CAl85DdZ20P
         7xmZ/nQY8IrFVOjQ/zU4fhHEP4Cktxe3/xGp2nrzNWxMks6RfktMx5iM8+99XrmhwpVs
         Pyhg==
X-Gm-Message-State: APzg51CNRVXt2GcIjrr38p5wfOJaIq9JesjU3WYDYX49YCBvbruHkt1h
        kwUZW4t6tbNPm4tufxAbtjxzZw==
X-Google-Smtp-Source: ANB0VdZlpQ2VPazYZtBeW7AdYQ3u4wBswYXV9AigJF76u0oZm+I5V/qj1bM2ItdcEGtUvRz6jZTEQg==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr754279wmd.36.1536738701788;
        Wed, 12 Sep 2018 00:51:41 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:40 -0700 (PDT)
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
Subject: [PATCH v3 01/21] nvmem: provide nvmem_dev_name()
Date:   Wed, 12 Sep 2018 09:51:09 +0200
Message-Id: <20180912075129.25185-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kernel users don't have any means of checking the names of nvmem
devices. Add a routine that returns the name of the nvmem provider.

This will be useful for future nvmem notifier subscribers - otherwise
they can't check what device is being added/removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa1657831b70..d96348ae0f37 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1343,6 +1343,19 @@ int nvmem_device_write(struct nvmem_device *nvmem,
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
index 4e85447f7860..0389fe00b177 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -55,6 +55,8 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+const char *nvmem_dev_name(struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -143,6 +145,12 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
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

