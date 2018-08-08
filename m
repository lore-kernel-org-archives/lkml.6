Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B6C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEADF21480
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tGOhqhgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEADF21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHHRxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:53:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeHHRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so2382633wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrklqQoVna1AmqNCU3D6TLUmDxCRyEqqCAbn0AY+9ek=;
        b=tGOhqhgB+VQgpU+wvkZEyKTCEfpDSRa9otYxlA03cNtCasel7cpD3/KdUhww2wm4Pm
         fjecI5ekdjsXq/qtOgD40K5558+7j9MiGovw1hv3MRtLpIZAn7heVXGUqXD+JfqmsnwQ
         TXJRpYoLiDY6qtKE7TgSXcyICr489v0zRi6FJ1fUuu3+eticUHpF2b2AOogwbp9BmN/N
         NGIEklrO1b7ixyrtRAQoTrGihAn1LjnzY3rew+cvC68zGxI58LDEa5CmJ7R3xwj8Risv
         7GOXKvnUmzX7bbj5hXhy5QCUv3xKFAEv+/DkgzpyWsFci4GBN+q6Y+8dWoVmQTjRJM3W
         q00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrklqQoVna1AmqNCU3D6TLUmDxCRyEqqCAbn0AY+9ek=;
        b=bWwESqLFBbRWy4267tm2sX0Sjbp0j/8NqGHJqSYPDBhueTWTmmDEN5k/vIy5GMrvhe
         qjIlE2bwdogXCyRWNMI+YaThh/8KIQrjzpBY64nQUSSurqQmb10K9cT4300gqZ2E/VRh
         dZxx1ygtT8zEdTRD4+Gh8CVa5Zr+CaomxsLHR4Y9OV/yW/A1fK9DL3gCMvTRZyzcIUEc
         Ox9oKgDRzvjQC3PksJR9wC+4K3cthxcRubaJQy8nDiYNBDNuRSKhx0Eep7hEiD9fOw0I
         /G0jJTwMlIoxgbqGRSa53YdH6XrphS2L51duRi0ndxb4hrS+pmwVfCwg7213HM7aPYII
         7YGQ==
X-Gm-Message-State: AOUpUlGQNfgxH9f8G1vlW6RhU+3grceO/mVXgxvDE4dFHH0pVg8BzK4G
        jUpczVY7Nf3ZgQU+DRa5BJ9WZw==
X-Google-Smtp-Source: AA+uWPwEASbCLgwuQsHEGaZm9m+7/XT8CXQ1Qp5WvwSSMK3JkUQrEpoFZ6K2BNuLsbgiE22k2QymAQ==
X-Received: by 2002:adf:9a55:: with SMTP id z79-v6mr2083051wrb.153.1533742418005;
        Wed, 08 Aug 2018 08:33:38 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/28] mtd: Add support for reading MTD devices via the nvmem API
Date:   Wed,  8 Aug 2018 17:31:28 +0200
Message-Id: <20180808153150.23444-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

Allow drivers that use the nvmem API to read data stored on MTD devices.
For this the mtd devices are registered as read-only NVMEM providers.
On OF systems only devices that have the 'nvmem-provider' property
are registered, on non-OF system all MTD devices are registered.

Signed-off-by: Alban Bedel <albeu@free.fr>
[Bartosz:
  - use the managed variant of nvmem_register(),
  - set the nvmem name]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/Kconfig     |  1 +
 drivers/mtd/mtdcore.c   | 50 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 46ab7feec6b6..f5549482d0df 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,5 +1,6 @@
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
+	imply NVMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 42395df06be9..a57302eaceb5 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -488,6 +488,49 @@ int mtd_pairing_groups(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(mtd_pairing_groups);
 
+static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct mtd_info *mtd = priv;
+	size_t retlen;
+	int err;
+
+	err = mtd_read(mtd, offset, bytes, &retlen, val);
+	if (err && err != -EUCLEAN)
+		return err;
+
+	return retlen == bytes ? 0 : -EIO;
+}
+
+static int mtd_nvmem_add(struct mtd_info *mtd)
+{
+	struct nvmem_config config = { };
+
+	config.dev = &mtd->dev;
+	config.owner = THIS_MODULE;
+	config.name = mtd->name;
+	config.reg_read = mtd_nvmem_reg_read;
+	config.size = mtd->size;
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.priv = mtd;
+
+	mtd->nvmem = devm_nvmem_register(&mtd->dev, &config);
+	if (IS_ERR(mtd->nvmem)) {
+		/* Just ignore if there is no NVMEM support in the kernel */
+		if (PTR_ERR(mtd->nvmem) == -ENOSYS) {
+			mtd->nvmem = NULL;
+		} else {
+			dev_err(&mtd->dev, "Failed to register NVMEM device\n");
+			return PTR_ERR(mtd->nvmem);
+		}
+	}
+
+	return 0;
+}
+
 static struct dentry *dfs_dir_mtd;
 
 /**
@@ -570,6 +613,11 @@ int add_mtd_device(struct mtd_info *mtd)
 	if (error)
 		goto fail_added;
 
+	/* Add the nvmem provider */
+	error = mtd_nvmem_add(mtd);
+	if (error)
+		goto fail_nvmem_add;
+
 	if (!IS_ERR_OR_NULL(dfs_dir_mtd)) {
 		mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(&mtd->dev), dfs_dir_mtd);
 		if (IS_ERR_OR_NULL(mtd->dbg.dfs_dir)) {
@@ -595,6 +643,8 @@ int add_mtd_device(struct mtd_info *mtd)
 	__module_get(THIS_MODULE);
 	return 0;
 
+fail_nvmem_add:
+	device_unregister(&mtd->dev);
 fail_added:
 	of_node_put(mtd_get_of_node(mtd));
 	idr_remove(&mtd_idr, i);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index a86c4fa93115..8121c6582285 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/nvmem-provider.h>
 
 #include <mtd/mtd-abi.h>
 
@@ -339,6 +340,7 @@ struct mtd_info {
 	struct device dev;
 	int usecount;
 	struct mtd_debug_info dbg;
+	struct nvmem_device *nvmem;
 };
 
 int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
-- 
2.18.0

