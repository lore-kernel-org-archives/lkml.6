Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93496C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543520868
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I63cr+tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5543520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbeKNAAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50872 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeKNAAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so12121123wmw.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
        b=I63cr+tbCx/td55Gvhzg57rRGVH/mP7GtwF3VQsJ+v0oIhaEfYxqxReO3Cv/96MVZC
         E3WqUkG/YivISQ+MKMYdujDmHFek7v09UbndzW1jCRO7lSbtmbMHgNqLTOtCp+ILUpCJ
         wiFeYVmMa8w+D5Jtk8MPRItODnXt6oNU10b6A9NNlxfexfGDTl95uOQv6+ikrFnTEmBd
         I6ZBmA9XehvRbIRABqf7mFEzURQ7fRoDStQnGkPa4PgT95zy0s78ItpZkILPGXwBugkd
         PYarMYhnWnfPCKu/1C8ADlyP0pWtGHy3pLxW8zskbMJAOcA3E93F6aUJGU7dMhG5F7td
         gchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
        b=RqiA/sPxcV+aQ2VFpO2vXjfxr0GO2wIwZhRZqRHqGJYBaN6aCOk2ZwCdQ5433PC9fj
         wUlkwsAENx0i2S/SluESImT+URWq9OIdQ4wc03MpgsVEd3MUC44ffDHSDpIu/M1h4M+H
         rmAjvJM9Cf4jNArXniwBtwCBwCUe6ygEEiwgh9KBvkoW6pksuMXqAE7QZQekDxSQ6uvv
         cbcl42XVoRPIwWt9Pl+7+VP8BwB9l4gIIlJKEWcIv3+AMWcxjFH67TvXzo/BIPvq/0+m
         hm80WO+LL8F6cX2JsNLm8C89VUWz8ytrFOtRXT7imhm2GyIiyj+3dL8CiMLdgwQhUMMm
         6v9Q==
X-Gm-Message-State: AGRZ1gIIOMpnBa4xVDgpvkSZw5/DVY7uD474oNEfRlnsCXvB7ck5esLU
        ai96S32gBc5K3HV2Qtx48S7QjA==
X-Google-Smtp-Source: AJdET5eBWqbpkPuDG25XfcRJdhNFcl9LxodbjbwiolEO+3PzHNwJNw6+CIjZNsn9xz6HcjOhubC8pA==
X-Received: by 2002:a1c:38c5:: with SMTP id f188-v6mr3269398wma.19.1542117739313;
        Tue, 13 Nov 2018 06:02:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:18 -0800 (PST)
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
Subject: [PATCH v2 14/25] ARM: davinci: da850-evm: remove dead MTD code
Date:   Tue, 13 Nov 2018 15:01:22 +0100
Message-Id: <20181113140133.17385-15-brgl@bgdev.pl>
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

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6a29baf0a289..128dd7d8dff6 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -150,32 +150,6 @@ static struct spi_board_info da850evm_spi_info[] = {
 	},
 };
 
-#ifdef CONFIG_MTD
-static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	size_t retlen;
-
-	if (!strcmp(mtd->name, "MAC-Address")) {
-		mtd_read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
-		if (retlen == ETH_ALEN)
-			pr_info("Read MAC addr from SPI Flash: %pM\n",
-				mac_addr);
-	}
-}
-
-static struct mtd_notifier da850evm_spi_notifier = {
-	.add	= da850_evm_m25p80_notify_add,
-};
-
-static void da850_evm_setup_mac_addr(void)
-{
-	register_mtd_user(&da850evm_spi_notifier);
-}
-#else
-static void da850_evm_setup_mac_addr(void) { }
-#endif
-
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1494,8 +1468,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.19.1

