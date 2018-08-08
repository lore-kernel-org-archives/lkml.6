Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9E21A35
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QkqXrrSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED9E21A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeHHRyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33493 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeHHRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:53:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so957084wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gXeisQUg9CT/e0TVeNKIqgvnnNtiYjxB6KBG0kRtOg=;
        b=QkqXrrSRt28avbRFzep8u9o6/pMPtCVFMth9MyQLeywkgPV8oV+NTVwVkzumsndxpi
         +VAvWKHMtM7vT4ZLp4l8fD4uW2WE6UMRN959AV0jA9BfDTAdocYUEmP5NIb+CVd3xCk7
         2wjDVsIsY6gnK5vhsesri/PIO7HQbFuIWSqA2pFEDEgPJG5zVQptJYr8gxWvl6IUZGi8
         3lpfQf6lmDMldihqejMTRbykRmG586A70Ol2XxJzuOwp02fwNCDjn8NXJH5hNMnXvqvJ
         gDWabQGU2oLKuOKuBhWjGw7ihf4UhS1zrOaty2BXAEXbVDOUnB64vNb61+mwLutOjIIP
         n2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gXeisQUg9CT/e0TVeNKIqgvnnNtiYjxB6KBG0kRtOg=;
        b=eae9Rbm1BnDoDYtV71HkRvHNMei+PTX2ZdC6bPU9HFk0QyCAUz7rP+nrZnWs1lBAvY
         Sqo7s6GYkm4F2xie4V93mEjPV5/RRvSo8vhVtz5krHfWioqh3l+SyVjNrHK2HxdfnyFv
         bPYby+GX68VG/S5E46TjKfzlvV9OhSUGXv7upY8BRtgV5TMcFuYRF04YLKYbv2QsqmqB
         OGbOTm+URFX6tYq5C99Av2aNfweJuVLw9mtLunapN6kVlkVDbqatp4x0pLSOx/dZ3Edk
         sq2SYCQ6yJDxRalSwXC119uj+jXCsS9mvg2zQZix2N4+/sIdQqX/5N1QQzRjP6dA7QH2
         E9og==
X-Gm-Message-State: AOUpUlECp1o4HNv5NZAttj4JLO3ndhkSE/oqEK6BQoUDUW8V1VUdZFH3
        8YasTCOHn+B5OFzZ1kao+vbbHA==
X-Google-Smtp-Source: AA+uWPyvPIzatEonKFWgeZF7rzsjDFKGwKfCcqafIbk0zTDsLtnA7s8uZUy6D5jEhIepXbTZODtf5Q==
X-Received: by 2002:a7b:c013:: with SMTP id c19-v6mr1901158wmb.53.1533742428438;
        Wed, 08 Aug 2018 08:33:48 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:47 -0700 (PDT)
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
Subject: [PATCH 11/28] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date:   Wed,  8 Aug 2018 17:31:33 +0200
Message-Id: <20180808153150.23444-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..b5be51c0451e 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -21,6 +21,7 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -160,6 +161,25 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
+	{
+		.info = {
+			.name = "factory-config",
+			.offset = 0x0,
+			.bytes = sizeof(struct factory_config),
+		},
+		.nvmem_name = "1-00500",
+	},
+	{
+		.info = {
+			.name = "mac-address",
+			.offset = 0x64,
+			.bytes = ETH_ALEN,
+		},
+		.nvmem_name = "1-00500",
+	}
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -534,6 +554,8 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_add_lookup_table(mityomapl138_nvmem_cells,
+			       ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.18.0

