Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9D2088E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0ZP8sK9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeHHRzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:55:52 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39806 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeHHRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:14 -0400
Received: by mail-wr1-f52.google.com with SMTP id h10-v6so2405019wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yskxlK8HP/dt20rNOu7PQtYqAortOf6F4fEk7Jpuvng=;
        b=0ZP8sK9XBdVSH9MobfykpL+Uw9YJ6GOBO4g0FLbw5rMI0ZV/ywOn8AqHzeM19JM6kK
         ECh4d/wDg7PPGqMse2IUl/Ix+OIGI6Df2mPVv9Rq1pu85PS2f073OpzQUEdfUN1pwYBs
         8Bccw/IWu7MjcYyiO3vh2xF/kUXTvH+to2+/GgNlLsoxVIMFsFJ5wbmyyJMlgzSWeEfK
         7Km5q9GB/uVVPS79AKQhNixxtH6p20awJFiB1NLu3/ySEVYqRK77kFIK83cjFQiBLY02
         zG7QbASRPikl5keWpttElubb+pvL7DgBi3W2iTpENH09QiiHmz4UysXZxWQQp31/OyNJ
         /cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yskxlK8HP/dt20rNOu7PQtYqAortOf6F4fEk7Jpuvng=;
        b=lYWY1onOSC/YbvkCKg+V1/E/B7dAkkZ4zyDaoZeiCDp0FRswQCxsVSWHy8d+M/Bx4f
         rtoBF+Psl+W86wJEKEbufLd3N0kl0iVUEJBKR3LokjfuaKUE9+RVQFyaP7Jtb03J8qO8
         xNxbEYcjqVXlEBs749hOuzkEYEiJ/bTFZSBcMIMZ1fiPkxthuz4d17VdeQQ2tJslcmD3
         Ou9Tr2guTkaQBHQERDYMO7bsqwKnc29o1tzvxABztTxU3Aox0b9G/sVaT8beXx1T7q8N
         OyUYDHx4aDEzYuOzu9cZ5q1yTyS0j2jjymVX5N8ED6o/k8B3G8JHKDxNgvqOUnibb+dn
         jDxA==
X-Gm-Message-State: AOUpUlF2bpdIzuwMidbN2WrmuA9nLKVA+DnjwNIhN4WwXE9M5637LV8a
        jkJsVcMiWDpO28rfOifCksjBbg==
X-Google-Smtp-Source: AA+uWPy+A/xZSF1dc+kNomdE4Pa7ILiTGx4uje/TUWZ5xo23lqnVmFjpWsZ1QNaLe29vABpAtFa72w==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr2321857wrm.43.1533742442418;
        Wed, 08 Aug 2018 08:34:02 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:01 -0700 (PDT)
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
Subject: [PATCH 18/28] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date:   Wed,  8 Aug 2018 17:31:40 +0200
Message-Id: <20180808153150.23444-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is now done by the emac driver using a registered nvmem cell.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b5be51c0451e..5c0a0557a361 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -120,7 +120,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 {
 	int ret;
 	const char *partnum = NULL;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -146,13 +145,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 		goto bad_config;
 	}
 
-	pr_info("Found MAC = %pM\n", factory_config.mac);
-	if (is_valid_ether_addr(factory_config.mac))
-		memcpy(soc_info->emac_pdata->mac_addr,
-			factory_config.mac, ETH_ALEN);
-	else
-		pr_warn("Invalid MAC found in factory config block\n");
-
 	partnum = factory_config.partnum;
 	pr_info("Part Number = %s\n", partnum);
 
-- 
2.18.0

