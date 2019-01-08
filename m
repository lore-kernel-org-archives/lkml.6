Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA722089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mscUU3ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfAHJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33574 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfAHJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so3498575eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
        b=mscUU3ZWKPFNJHUEfNCsIH9Q6oMXrfnX4GjoBcDTTRTCfpTqqskB8ocUk3JJS6f7nH
         F1QPu6fR0Qc/E10AyfaUCOcJ9Jn3owXgOnusdSM3Wa953EWG+ixmUezdY1iXoo3X/SAM
         Y+tqYuuJrzNetOMRfLn62Ki31x5ODVN8O+Tassm3sW7pgpIBNeMPIRgJr7s2e6UkIGCz
         05PF/B9vBpQp++4E3934cLafg0iezy9iHXPYypudW6fD29Et8K6rxh18Ni12NwuXSOfU
         shPXkmpCuR1BbJCz+O4a6UyJ8su0KQPQ2ye74GXElSqM92Aifsb53Ao4lkBtES/sQZ0c
         uOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
        b=A98dGcmNGlI3q+u3p/TM4SoPcVe9WP3MjTDNKf5dMG2U/tJC+KPe53/cmbbp0QottM
         TyISxqj118rHLq0zd2aPhVHwXYWPcDXSBbOei8OlK+CF5Ca995UqicPi5uZjALJv+pbm
         +0cvDyCy3M0WjAhcTjzhHnmwsSf1IU/GO3eFu/8UiqHlij2yU0d53MOgTfkQes096ErV
         qa+Bto7vlHi+65ouiiNPtK1a2ZuEcFbk7ZpFsATQZYyhi/3DZY75kH+M9sooPLFhnE1u
         a83rZfFhiiLQrl8f5NLto5cmRBwY+6rWuhBt87eme+dH8XKYpV/rpSZp8Y0IP3I6p+4c
         Wj5w==
X-Gm-Message-State: AJcUukfaJhz3znhNO2r8gHNEhBqTxM3pREOkm7TFfeq8tfw+jkaFhqb1
        CHOOR+7tuQA5fJGEqmFWoR1G5A==
X-Google-Smtp-Source: ALg8bN4dDw5IvyscDJ7IN+fJkMMKyW2fwpGh6nsmSR42EOQznEqT9Y6G2fSaVLrGxUkS9e2x57NcyA==
X-Received: by 2002:a17:906:5202:: with SMTP id g2-v6mr1163630ejm.139.1546938962046;
        Tue, 08 Jan 2019 01:16:02 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:16:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 10/12] ARM: davinci: mityomapl138: use nvmem notifiers
Date:   Tue,  8 Jan 2019 10:15:37 +0100
Message-Id: <20190108091539.16674-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Stop using the at24_platform_data setup callback in favor of nvmem
notifiers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 3286dc2457a5..ac1a1699d185 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,8 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/notifier.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
@@ -117,10 +119,15 @@ static void mityomapl138_cpufreq_init(const char *partnum)
 static void mityomapl138_cpufreq_init(const char *partnum) { }
 #endif
 
-static void read_factory_config(struct nvmem_device *nvmem, void *context)
+static int read_factory_config(struct notifier_block *nb,
+			       unsigned long event, void *data)
 {
 	int ret;
 	const char *partnum = NULL;
+	struct nvmem_device *nvmem = data;
+
+	if (strcmp(nvmem_dev_name(nvmem), "1-00500") != 0)
+		return NOTIFY_DONE;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -152,8 +159,14 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 bad_config:
 	/* default maximum speed is valid for all platforms */
 	mityomapl138_cpufreq_init(partnum);
+
+	return NOTIFY_STOP;
 }
 
+static struct notifier_block mityomapl138_nvmem_notifier = {
+	.notifier_call = read_factory_config,
+};
+
 /*
  * We don't define a cell for factory config as it will be accessed from the
  * board file using the nvmem notifier chain.
@@ -183,8 +196,6 @@ static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
 	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
-	.setup		= read_factory_config,
-	.context	= NULL,
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -561,6 +572,7 @@ static void __init mityomapl138_init(void)
 
 	davinci_serial_init(da8xx_serial_device);
 
+	nvmem_register_notifier(&mityomapl138_nvmem_notifier);
 	nvmem_add_cell_table(&mityomapl138_nvmem_cell_table);
 	nvmem_add_cell_lookups(&mityomapl138_nvmem_cell_lookup, 1);
 
-- 
2.19.1

