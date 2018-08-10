Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6467BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DD0223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bNyrEded"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DD0223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeHJKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:35:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35142 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbeHJKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:35:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so7487420wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jh45iyxzAhZV5lh7mev1xkgD1t3NViMmTz6DgxZZu/M=;
        b=bNyrEdedPXI5zGAmm/tROj6OOi3+u09cTRTqviKGU5O3cKOoc+EdIWMSArqZ/R2BD2
         jqWPbkJem4BecHC9z6vwqj7wqV1arfFk60D25XPh+NqSnQlyaxVKYn3R3a8KduDXYTMv
         SdPzch1LepaSQLGiQCg3HWwnhPFxsKOSHN5Y+Rg1P37Ew2L/uZiw9FBI8Cq0AkRLHwzr
         csG9U5aJINf3VitBZNpKUL6tQTRKSkBjKsoOn4EHIGuVOfx6M8hBhLr86sC9Oj+hpJs+
         +PtyWT8uo79iN1UTp64Fag+lXGeqopDTzNMPUn3P/R8/9gNPYB9X+dlCWCsbv71Xwags
         sdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jh45iyxzAhZV5lh7mev1xkgD1t3NViMmTz6DgxZZu/M=;
        b=mz4oNI7zts3z8+srV4iwvqwwHr8I5JuSgF01VcFiL5ZXFUIgNhlcI7RDpLbOPGcwVK
         RXfcbswos7gkDXWJdAYf5Cn66XiH19K2kuFPO3eI9x6zAh6igkF/YErZymOIETDm0cuu
         GTTk8k9uzkaRGzWy0h7q/MaD3Tv9nG6jxSS92iEPEPPRd4kClc6kapBNukj1X7i6hcZF
         7TUUQtVHFxlopzyycBfUG40hsxRvn9DFTCBMXie0JctbtN2gCIYQ8ikas4jg19YkjHXD
         FBtofQl7pAnc4/NYThxu6N9GA2UViuCf7wLMlBQIPC53ByySbsZndxr5k8fC2iSv6SIn
         VUAQ==
X-Gm-Message-State: AOUpUlHAS8Gb0DrJo+pPJFo9TCn3aGDOGcWk7z/4bBBWcTBb5MyPF6jR
        phRmJ+wQimpzE/DK+DVCpIgLvQ==
X-Google-Smtp-Source: AA+uWPxuqh/WxcGPymRkgSu0vbbQ4dytEzxPxe01XX8anns4D3ycRy4utWPzmEfNdqIHaqB7Mq+Row==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr3756039wrq.8.1533888384610;
        Fri, 10 Aug 2018 01:06:24 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:24 -0700 (PDT)
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
Subject: [PATCH v2 27/29] ARM: davinci: mityomapl138: use nvmem notifiers
Date:   Fri, 10 Aug 2018 10:05:24 +0200
Message-Id: <20180810080526.27207-28-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
index 35b2b6068a7a..dacc5292f9bd 100644
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
@@ -116,10 +118,15 @@ static void mityomapl138_cpufreq_init(const char *partnum)
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
@@ -151,8 +158,14 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
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
 static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
 	{
 		.info = {
@@ -176,8 +189,6 @@ static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
 	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
-	.setup		= read_factory_config,
-	.context	= NULL,
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -546,6 +557,7 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_register_notifier(&mityomapl138_nvmem_notifier);
 	nvmem_add_lookup_table(mityomapl138_nvmem_cells,
 			       ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
-- 
2.18.0

