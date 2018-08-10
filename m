Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210BBC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D25223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1IezMsPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D25223F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeHJKey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:34:54 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55942 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeHJKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:34:52 -0400
Received: by mail-wm0-f44.google.com with SMTP id f21-v6so918287wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2kUHt8xOX/X/PnpUK/Av4k3yjo3y+RVMVX0DZ8RBXo=;
        b=1IezMsPvfeCSNwxz/W7g8guUWIj1MlKn1Y/XH0QHuzFMya6wnUXorRPiYypsD6lbLg
         gFHq/HzljmuSs7G/4V66s0jCYV/eX55xvrzDQFbLzXBfTSQ6bx5akAyYMzK2+rSdgnLE
         2syRCvvfjtYgr5FSpZG1euQg55osIUDpajdFLgLu/9GA+6uHpzcADzpxeeAaECNPVjMd
         8qLN2ZTufzsNa6IsRDTCd3tFKm2w6zazU6l2lxEVxVHmht4uK4hu/cK6H2bbp8X1/lxg
         RxxwhI+KPGkpj8IqzGLlOI4lpgpM8XpHXOHFKFGkjO6nTIAPM7UqMhWaNBOudfwVLM2K
         SuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2kUHt8xOX/X/PnpUK/Av4k3yjo3y+RVMVX0DZ8RBXo=;
        b=h0Vt5OCgkDewFOCk3Zu4DaPYKdeTiA4GIU09ZY8/5Nr2RCXzGkmx3Ca5nFEe/L3zjW
         tpX+wF5hecByL3NSyoh/o3W7PSAARVHNnYp66fKYZQhJmoimS9b8MScX3CliskvaZIyt
         WClt6LmzbKEGdp7iuiiNKBGd/hwhZ5YyuelDoTvBQj+GQMD+v8vS6JhCdAHnR+J0WExl
         HVX/jainlYHanAqXRMU2q3NODotVXAMOj09mOe6SrPlLbIMGzJXEIFDxeqNE4X6FpKxw
         P8F8szrBdaRbD5P4nyOV2qmyIDudT/JAO4mhrj+FbCIF58C4Lay3TYkO/nkaGXx7CWsD
         fIUw==
X-Gm-Message-State: AOUpUlHJ5i9Oq6yyk4f15E2CamCamHsbroQE0aXxRLtZcv+bDasoliLn
        p+XCHLuF1aZyCUHQRaUHxormyg==
X-Google-Smtp-Source: AA+uWPxWBZF891XRgjDhENshzdI9BBPFzNgjARcveCg1grLiyw8JKPh+e10lACy6aZz5pXAQkYfpjw==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr746588wme.55.1533888366699;
        Fri, 10 Aug 2018 01:06:06 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:06 -0700 (PDT)
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
Subject: [PATCH v2 18/29] ARM: davinci: da850-evm: remove dead MTD code
Date:   Fri, 10 Aug 2018 10:05:15 +0200
Message-Id: <20180810080526.27207-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
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
index 521a26b5c20d..1df796b67b82 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -137,32 +137,6 @@ static struct spi_board_info da850evm_spi_info[] = {
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
@@ -1470,8 +1444,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.18.0

