Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC90C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A621531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CBDVl5qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5A621531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbeIUNTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:19:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40909 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389294AbeIUNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207-v6so2019076wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6JdxSWkz3pHnb2fNllglZS2DOqO298ZYcJuckKV8dz4=;
        b=CBDVl5qOB9JQYOEHqBjET5xhNurapJvIkATKWAAMwmg9gt9a+5eQDMqcyrKfeHO7fq
         Jfc+cjC8ORm7vSZ8DsSTsFuci+2eZCT3x+4iEy9FDLOAsNYLfLLHQzK1IJgtLxM/9mfu
         /eTZKTnEANm7C4nKN4X09xMfH8N4/V/o0OcLeqCGX05/vvo4PhW1jGBUapUqhRIY42wA
         ZQFyfX/Fsy7J6oNkfBXivtHg6BoSP2n8hHuUvD+i8nYJskpk3Ud6/JScS3DlMx8DzRci
         P+K421WjXPi76mOXc5D8iVCcfBUOqm57yKKoeBzj5si/S4/urnCxIOiS6voFh9nHjgKD
         Bnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6JdxSWkz3pHnb2fNllglZS2DOqO298ZYcJuckKV8dz4=;
        b=f07c5C5cev65g6j3yqI+SiJMNIuUj3pTke6iyRi0l0ylrMYRppzuKlz1hZKkXSCSgn
         xH2hsPludyc93bAD29qMmDItqGW3SVORx6rWn28UiETFDb8921FaRxCAIlR+Qp2l223+
         PYZQzqk6vhdKXWAE2piCHRuK+NMalnzSg2uQKxl20sVbRICeq3QVLNbx+DkH6yZQe4+2
         qf38zj7kAilVEffiOLvv3IK3n9u1fEI4zjOtOnrUYmxU3khOaKs/X3QBETRBibOTqhft
         INDBijYO281bY2miUl/LV+ulJpavEU5xUD0K0W638S+PFCx5hDbQsoj8F/pnPngzDXml
         fAZw==
X-Gm-Message-State: APzg51DZJe4iHI1GsVpuEmd3OzZ3CBQXHGGNhg7PxFsDOhN1HW9H0RQL
        53x/0ddMTFa73snPOaUZy6QXLA==
X-Google-Smtp-Source: ANB0VdZfKA924IcvzbN2d1seyZe/z6U1lhE9+XVw3x5/HGA4kOtqS5bSGQ4IP0wEA1pTUHoVfdD+SA==
X-Received: by 2002:a1c:2351:: with SMTP id j78-v6mr5813004wmj.68.1537514967931;
        Fri, 21 Sep 2018 00:29:27 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:27 -0700 (PDT)
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
Subject: [PATCH v5 01/22] nvmem: provide nvmem_dev_name()
Date:   Fri, 21 Sep 2018 09:29:00 +0200
Message-Id: <20180921072921.19387-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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
index 6f064002f439..11afa3b6d551 100644
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

