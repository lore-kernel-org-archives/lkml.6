Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9CB208DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jPZR1hu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9CB208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeHHR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:57:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36168 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeHHRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so2420515wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C1ENfkoTLjW8E17DVw+md+9F6tiK3Z1VCNCm2wV2Sh0=;
        b=jPZR1hu5zBkXG9rS/CQnTD+BZj8gpnkEM9pKhPLQz0sLHXzfppDAMqcLQFOncyiayL
         rcgsB1mru/+1XB8kdyDRoOaZWdkJ9787WgUisZ3SwQu6vxr0DWYU+8s7bZfb3tPHnOfx
         MN7FvU1aDT9UWADNBnCICEQRJeIjS9RXJ/vH0wJGuXyu3aG+C325BwmowNd64S6gSX3c
         2KBqPJN/aZ4+c8BfDyWBd9RflXfeVcQcUEpO1Xk34IIirtmqfodmt/Q8onTCMOw43QZY
         DSmzGCckG9dDMZ4Ao9YVf9JvLyk4SdAkJwe7Ey3AjTpN9PSjaLtO/jqq+QkIdAybK02N
         Vq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C1ENfkoTLjW8E17DVw+md+9F6tiK3Z1VCNCm2wV2Sh0=;
        b=TzHuPvmvlxsP4GN5BagZCM1UMKWcErwqCYDop2t5Sl9fgjjxbNHCkBf2z2xcSzazG8
         9RerQNHwplrrS9qi3u/AyN8IufTCl48sO3YGYZncWVq2WaWImoYH6BQiDBEWnlaS5Cio
         6re9ftCNQsWLDjqkmStyOfDvPviRkqwmdhxy5PYKfYKN9JK9UTI0r91QWL4ZUPqzULEr
         GORheYvAfboU/Y8F/XQG0jKfkzejhULeDXqPallSCujNRonwtwMmCmiahVXqOx/8YVPJ
         K4EgBlCCDRIBgWGx0pKMztDkjuQfPrDjqX1ri+0k/p/sN1UcVbb8Jhb/I675SEvIyI3c
         kNnQ==
X-Gm-Message-State: AOUpUlFQSpsI1/xMK86zekZtVjmwoNO+/ZrC3WeVO0yjjU7SIxfDdxsO
        i/oA98fFEeCUWHP6cFvAUJ6B1w==
X-Google-Smtp-Source: AA+uWPyeKUZkZ5lzpR7fQUL35EZxOiMcdK+l1BV3+kpdv59GQTqxqPRSG5Tzp1r0MeLy0jLVvWQO+A==
X-Received: by 2002:adf:f091:: with SMTP id n17-v6mr2355042wro.49.1533742413825;
        Wed, 08 Aug 2018 08:33:33 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:33 -0700 (PDT)
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
Subject: [PATCH 04/28] nvmem: provide nvmem_device_name()
Date:   Wed,  8 Aug 2018 17:31:26 +0200
Message-Id: <20180808153150.23444-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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
 drivers/nvmem/core.c           | 6 ++++++
 include/linux/nvmem-consumer.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 128c8e51bff2..b040370292a7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1440,6 +1440,12 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+const char *nvmem_device_name(struct nvmem_device *nvmem)
+{
+	return dev_name(&nvmem->dev);
+}
+EXPORT_SYMBOL_GPL(nvmem_device_name);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index ae4d30347602..c4000a218f67 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -69,6 +69,8 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 int nvmem_register_notifier(struct notifier_block *nb);
 int nvmem_unregister_notifier(struct notifier_block *nb);
+
+const char *nvmem_device_name(struct nvmem_device *nvmem);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -167,6 +169,11 @@ static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
 {
 	return -ENOSYS;
 }
+
+static inline const char *nvmem_device_name(struct nvmem_device *nvmem)
+{
+	return ERR_PTR(-ENOSYS);
+}
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0

