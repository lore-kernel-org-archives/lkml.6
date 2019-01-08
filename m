Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C74F2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VCmoxz1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAHJPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:15:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33975 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfAHJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:51 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so3486687ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
        b=VCmoxz1pe8h/sCGOr3KE6kn1KAUvQMv/IMN3cHZ8CxFJAX8ZoYfa9qdzywShv+V5AQ
         hr+JNNFpfcD28S2hAGOhUjsLvRJuVvrtJOpd5LGTjDA1bKeeCqVaJ0Lb/L4rGRz4QQdw
         Nnf4YQzeACIcW2byxB59y0Tt8VlZCI7yiOKAJv+3S2ouyuInFPMwWUvBAk29+AN6scWd
         Xch8QI5vrJumKZBKZQSaeUoZcibSLEXPDx5JBwxU9IbaBVyE0qh5mA+mHi89wWWHzJTR
         AUPz3k40FqCfQRdMH2XpnNkyKpKzuTYkP2891kux7HXVs/KpeB2rEhqx6SxHuIrK/RUR
         FvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
        b=d550NWod271MuuIQUqt4lkvcB/E/HWsVbFR6HSHr6hduwWckbtK2PeMtQFXkVBQeqp
         KcMP54jImf0VqqY//sMdbisRZq5Hvqh3+6mAgDdaU0qImDjpxJIil6zlr90GcVjMT6HU
         TCefFGtpfONn/iE+Sf2q9jBTvDiHaSs6Q4WpJTxdmlB2jV/LTT//FPUBMdYj4XWmFdAY
         xJpUZkacDRYIn9BD6ZHxEeO/BXq0yFe3QfH/p/Sj350lNNWN+w/cuDYvBUahvIVkGblc
         IQsCU6Cv6N4KWeaEG2mQliZsdrUp67NpGAeZt3hSGW7KfwxPBAUg8QrfUeMQoo8llyCM
         0okQ==
X-Gm-Message-State: AJcUukeo8Spdje4QoTvjw1Zk99iKKKRitYCgzGoacAT5aGX3z0kraiop
        SHO740/LSliw0oVKxmTk7hBenQ==
X-Google-Smtp-Source: ALg8bN6BNPITbKOv3XPbcz4zSiBIE8OsOtEPb3ekrVlDBVJmvPxw0z+AOWIBPhXi1Gs7Z11GOelnQw==
X-Received: by 2002:a50:b3c9:: with SMTP id t9mr1314567edd.270.1546938949770;
        Tue, 08 Jan 2019 01:15:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 01/12] ARM: davinci: da850-evm: remove dead MTD code
Date:   Tue,  8 Jan 2019 10:15:28 +0100
Message-Id: <20190108091539.16674-2-brgl@bgdev.pl>
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

