Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B71C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5085927512
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LJyZ7zXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5085927512
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966733AbeF1Od2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:28 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39731 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966647AbeF1OdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:19 -0400
Received: by mail-wr0-f180.google.com with SMTP id b8-v6so5757584wro.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uc9DsLvuo9YkRZ27l37cWzXamU3JMdrZofUpXwWBSEI=;
        b=LJyZ7zXxD1xKXGnte/b4sm4paxZOnN5pjajrfN6S3fZ4wZt86SnEMO5WW1svS90e4+
         mBUOjpuACCCMSSp/s7u6Tizij3KnaNtoL3Yh+na5xxG5TIptZTzjwA1KUqVVDPwJhyFS
         L4mHkbxl9Mf9oMeBAKbrmKiQV2Z9EbEfzd+M7OD4sQGB+YJw4EMqNLZR/oeLQDS7+wyG
         lkZOhtizAzWRR4EPLBY3Ic2THZAe/Fdhc3ka5k7YJ68qiB4S3ervhKk4R6ipkO+2PiDB
         O1tNhPYfJAsL29MOkJqNytN3F7fXXHphzhxEQ3fpgk1bBG+y49/ZC5Iqg4yorXu/DD82
         FvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uc9DsLvuo9YkRZ27l37cWzXamU3JMdrZofUpXwWBSEI=;
        b=SP7BiJZ0FBkttlwVhfpBfeBoaZKeLHTKGBkAfcbkuiABKmMCXjdP2YKRB+94bK3qRb
         9now4p6zQGCeQeN8u48jHzcv0lFTDW1m+VSovaEY78wGpwsQsGfxbz3FUYfYR3MGeCWr
         9uSvcohxNt3SVLBfy6QKY4BbaFJczsElWdeGYqrDH3tLteDF6+wWJFlpKYqHzqPVQPfW
         3jBcmOhUMdknNh+i+snRJZBzid6q8AJBE232iqMHgXjMREhtk2YgLn08z6gwu3APFW/f
         34nXDAVsm3qMNFsUzziCGuxiZdKxRlxDohFyiKoyGo7LT13Uuup2aalBSPHsEF11qRvt
         PC3g==
X-Gm-Message-State: APt69E3jwyJU0fkg/Lzw8I2VELY+X/CLgZMbmUoS10epQA9Wswqn8u/1
        02rh4P9CP+2fvMRKyHkJbIUFMVMzNho=
X-Google-Smtp-Source: AAOMgpfAm8rPir5y+o7a+baHhcYZ/y6WkATIz9utkr+rGs7F0ybz340tPZOwtm/JfUI0sQq2kPRI4w==
X-Received: by 2002:adf:9ed0:: with SMTP id b16-v6mr6035015wrf.170.1530196397931;
        Thu, 28 Jun 2018 07:33:17 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 07/18] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date:   Thu, 28 Jun 2018 16:32:33 +0200
Message-Id: <20180628143244.4561-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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
2.17.1

