Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58970C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1927549
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rYUbDYXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC1927549
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966904AbeF1Ohu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:37:50 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37749 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966641AbeF1OdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:21 -0400
Received: by mail-wm0-f45.google.com with SMTP id n17-v6so8803424wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEaxIuyp3QkNsGvwkhtanL8JC1vLeKQqMPNhy3Q8tDs=;
        b=rYUbDYXAESyGZhud6wVUsCMxXA64DgiihWrRg7hfXDFhsFqiXpoMXMqtqNY4Qj+e3a
         DWUuCmFOI5sk7CXPvEzxp6F187Q7AvkcYVhM3RDCdJCSc+tT1/5nVvuxZavYnLUcH/T4
         8JPrqQstfEbhU+vNbK4QswKRizfZK71vLBP57CsJ/K7K18GWpi+5ILXS/dtPfh40+xan
         VHLqESRrTFpwfBzeg4qjMGMBdJyjmHi514TepWL0m2QvCiX0Cx9C3vzqlhI7c3dniVn3
         f4+ILARf9pgs2uN2WkdiePhp7b3YiWWG6MqDWQWoQEfQMC8JvlEwEEhNRFRd/LWVtJ0X
         C0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEaxIuyp3QkNsGvwkhtanL8JC1vLeKQqMPNhy3Q8tDs=;
        b=riEj3sLOnlkoGNSaowNwZTfPkJqgVlRRNyTkItzpykZtQspAy11OSH4rnP6zRkoWAF
         Mbxp/bXSNudYxCO6yEv5ab+m9RZt2rRgVSYTcZQu5SyIhyP4jsDl/G5dUlq2fHh1X5lV
         NCrqA6Z4aADEs/m1HuYALXD2TGQdk8avrmCkwxe70Tt/41T6gKA0+E2uyRr2+ipWjPOh
         GjsEZWxf2vv0xALlNUQFitBTasLiWfuso451cIV8MzEkKX2o3t736UwLeoxRIFyphKzG
         gwhICxiDXPgeb5EflPemP0tLH5isW9/7f9e34TlOkwJo3Hqt9FoQo0aOl4a5/r/AtHvh
         +TFQ==
X-Gm-Message-State: APt69E2vTEjpt94QeCNviYt3OeYaZhfBpwPFTE8erhwbz+nziatqKhBT
        iTUSGXW4gFXVAWs9RBIKpYPD7g==
X-Google-Smtp-Source: AAOMgpfdeGg1oYmghhUf7S3HYjsHBtmzW3yPxdM0r4e85pnurMCqIk0hawdLgpJ1zCmSRw7kNTu4Yg==
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr8181011wme.54.1530196400411;
        Thu, 28 Jun 2018 07:33:20 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:19 -0700 (PDT)
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
Subject: [PATCH v3 09/18] ARM: davinci: da850-evm: remove dead MTD code
Date:   Thu, 28 Jun 2018 16:32:35 +0200
Message-Id: <20180628143244.4561-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e22fb40e34bc..4de075458d83 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -124,32 +124,6 @@ static struct spi_board_info da850evm_spi_info[] = {
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
@@ -1455,8 +1429,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.17.1

