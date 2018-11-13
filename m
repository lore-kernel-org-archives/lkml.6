Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECB6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CBB22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sxu9i8eO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CBB22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeKNAB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:01:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33891 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbeKNAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so13441243wre.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
        b=Sxu9i8eOfulldiOW2s6lrLD0kGLvUFXrjFvDiI91iV+FcVDZ5z1S8rnXXIv8CdlXM9
         lx7GA9Lhz3RYE6o9IGN/Kx8eGTjTuaYpGeOJsqMuCGp2gRZIewhkzjKa3vUKlzEitboM
         U+nS7lvfka2Ql9lEEC2drCGonOpS8H4cJQEwb+/D5BMDeAfn9+R6j8LTsc2S/Piswvgg
         yldLYLgtyrfeZ4lf2mn0e8i/83PyeWv/54eYj7SOEyEcr5phSmlrKTD6B34cAJarXcl8
         ACip3WuKeY4hnsSFwv/ZviaJ+Wsf0bnnIXrJUsgg7XO2ZomEIWERn0lxZxGRsNynSAfv
         3gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
        b=h/YNSk7FaQCD+36N7eLX+LPDoQ5j8+xM6NOSfnSP3Hout2H26CTy1yG0AseWQEaBGT
         1M2/gM85Kk0m6VEB0RKbHxFvPPsHA1aNVOLdTs66AJBy7TdWxrzgNU8p6KbzbDO5OGRk
         41XTyj9IJW5cHRZSczpHiJpcE18a17NYakm7YHvn/Gjg34UyRX0RiC/2Edvj/V5VOOMM
         iZIp4Jsmx9HOPRUYSZk9z1k7ateFJbvwJOO4o9j52AOGG5PLvwH1DXp8fsAfWVwLifc8
         IaZDJSajOhfZp063D3cdY637V6NCCpwsQ9XZuQbacVyjWf6so0/jqvvMakG44eY4gQWX
         nqQw==
X-Gm-Message-State: AGRZ1gKTwOjzRlXwIgpWWOAhq4O9wx6Tdwbwh+nQ3xWrAOi8L093luil
        xx5oRn2TmXn45ei7uD4Dd02QYQ==
X-Google-Smtp-Source: AJdET5cYRF0z03J3+LXc6zQEY2KOalWWGv3duPIopAzahTAXJAf6RsHxNQP+5fXdh/tbkc05Ilp98g==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr2375313wrh.267.1542117754451;
        Tue, 13 Nov 2018 06:02:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:33 -0800 (PST)
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
Subject: [PATCH v2 22/25] ARM: davinci: remove dead code related to MAC address reading
Date:   Tue, 13 Nov 2018 15:01:30 +0100
Message-Id: <20181113140133.17385-23-brgl@bgdev.pl>
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

There are no more users of davinci_get_mac_addr(). Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  1 -
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e1d0f0d841ff..0c638fe15dcb 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -26,21 +26,6 @@ EXPORT_SYMBOL(davinci_soc_info);
 void __iomem *davinci_intc_base;
 int davinci_intc_type;
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	off_t offset = (off_t)context;
-
-	if (!IS_BUILTIN(CONFIG_NVMEM)) {
-		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
-		return;
-	}
-
-	/* Read MAC addr from EEPROM */
-	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
-		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-}
-
 static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 {
 	int			i;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 05b97144d342..28e6cf1356da 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -46,5 +46,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.19.1

