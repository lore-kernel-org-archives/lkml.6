Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B37C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BE82080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PJL8eMa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BE82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbeKNABK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:01:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKNAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so11578044wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
        b=PJL8eMa9+jAOQEZNJcbJMuSBrsGHEjmzI10SPdojyC87xlN5V9crDDWQ+lH3v/VzOM
         1BgbUtHLRcXfw/YhVhc1RMPR1tHbbr2h2C490+AKByKBjNr5cdg0KaSMeQ2FXZ3djCDX
         WT6Ys3rYvkQbowoqMbQhCP6WyvgYuMh3LVETsVbCH14uid6zYbfsgiJgv/1Gdx3TjQco
         dEjOKY9M6u1ZSaJ7RFTHKm9BhVsHRDywikCx2ORM+ukOBDPEiUcYp9J8RjeXrLgxxrv6
         WHI8fixQ+evqM5Ip9WfK8/u4WR2v+o8N/UryB/bOM8UPhppphIXf4VLR9ztQb3dMp4Q+
         VXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syCNYOhWI2Fa3CkPeYThsu7drj9CGAM/9EZeMe/84fg=;
        b=XE8ERi9GYL8B+T8hRMpOk+b+DCtS/Ff/N1jvocIPNB8qB9RwxYxKrVm2+bKzOk4MDH
         iuLO6h9Oux3YHhQzcOG/yXqEf49iMIkQbVFPmFRSmzG5ZCMECMMA1nq7pD5w+IAgvV+k
         79iiC2fTXQVfZtmV1soG4m80yaP5VZaHgGpG8YVE5kWEXYXo2hTwD6Va9+hI9ZY8VGgM
         uJ10IcvjLUU6/7+dl1xBZuOdwMANJ+/M4GVtePeAAWukc+VGeKdhC9ydEq3d1FzYU9n9
         uzpwpavrdIXY64Uyc1mOJ3MpzQUfD9EkphJqflA83lJxT5Vik8AXmq7tR0JYVojnUodN
         mtQA==
X-Gm-Message-State: AGRZ1gJTCf8lUOZFHFw8RjdLSnplquUqnpwWuBQM6I1RIBmbc9nryNd7
        AfZdWM+OuIDtzcLHmT4nnUUvPw==
X-Google-Smtp-Source: AJdET5ePKezX6JsMVmB21bIh2rzVp1xhzc1G5EZ2Oj5DB2QjqGjdRdYo3Cs8BUYnOEw6tUiFG4ab/A==
X-Received: by 2002:a1c:5f85:: with SMTP id t127-v6mr3313396wmb.44.1542117756310;
        Tue, 13 Nov 2018 06:02:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 23/25] ARM: davinci: mityomapl138: use nvmem notifiers
Date:   Tue, 13 Nov 2018 15:01:31 +0100
Message-Id: <20181113140133.17385-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
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

