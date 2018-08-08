Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E418C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA92208DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wQ5VJBcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA92208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeHHRyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43688 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeHHRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so2390797wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7UsCvqnFt3W2bHK6DWe4k8iaOUKf7rLaco+g4nZ2Ys=;
        b=wQ5VJBcvYrRS7XzApI6Ewk7Yh2aHYbgtfXrwvfm6MshVgyVhbPGV1/DwqQOiM80HmY
         Zix+HKApykFghM20kd+OAmvTLf7cCkmrnFOq/QvXfVsiPCGP/qtkgheug2QgJb5NMfLu
         KQz8yku0bHglBxhO2GL5ytkdZoz/X6nH2WmpLuO/SQVEEbDrsNH+Tf/UGbL3yrYGTZFZ
         e/8ixazqAbSEsisLFAzsYrTV8znqB4ARnUZ+g42md/LHwFdm4s4nN0uwKl/6swegoftM
         DvwSihE17QCX/CohxEJIE1jSmL/8jLFZx1G82ngk/+ynEDVjic/VKQisVIP6NAFAquIS
         vxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7UsCvqnFt3W2bHK6DWe4k8iaOUKf7rLaco+g4nZ2Ys=;
        b=HnVekOcyoxiFnCifOERPLCsUsBDfKGvLCCZHap6Azpc8EceKNEaDnKfbHgJKwjhYCW
         rtt71MfUuteZv53ihopRzoevsE2rm3l+2DpFuzXbrFlD06KaFz18hCHnWmI+43wWCaAi
         7giBygV+XT/13wgpvVR4K6za2FdZoJNScWQkaby0tH/RPLz2QBKBi6DQN7Zh3chNZ/86
         4TetnQ0bDxe8dD7mWQZy5AdRHGoMvAvY7Mo788c8aVwX4gL4lH9xc16xGThXXVCJYvBu
         LMBQcOYgyzN97D9TqGynkewZfcN5Sw29aCXcmiZEd62jBRQUQTDxqxzVTJl7dULW/p+L
         E+PA==
X-Gm-Message-State: AOUpUlEVAA0RSOAIu18Bga0db6sSZgW7SECQC+wRORGrqn/zTMxIBPP1
        OHSF9x1zWTcwa5tCpCRlxNGhbQ==
X-Google-Smtp-Source: AA+uWPwUxWzFD2iZAkFk/ZYc9NPSGQyMkmEjBY6HOUC2+Y9/EnglksJzTqPZaHJDUfZJ0skIHB7UKA==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5-v6mr2365511wrt.210.1533742458304;
        Wed, 08 Aug 2018 08:34:18 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:17 -0700 (PDT)
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
Subject: [PATCH 25/28] ARM: davinci: remove dead code related to MAC address reading
Date:   Wed,  8 Aug 2018 17:31:47 +0200
Message-Id: <20180808153150.23444-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it. Also
remove the mac_addr field from the emac platform data struct.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index bcb6a7ba84e9..0c6cc354a4aa 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -28,21 +28,6 @@ EXPORT_SYMBOL(davinci_soc_info);
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
index 05b97144d342..19888b27706d 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -19,7 +19,6 @@ struct mdio_platform_data {
 };
 
 struct emac_platform_data {
-	char mac_addr[ETH_ALEN];
 	u32 ctrl_reg_offset;
 	u32 ctrl_mod_reg_offset;
 	u32 ctrl_ram_offset;
@@ -46,5 +45,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.18.0

