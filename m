Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D8C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A1420893
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Dd7gl4Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A1420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeILMzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50549 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbeILMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1261250wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=Dd7gl4SiLS2CTwbYqt8gDFxF41lxBpmvFFXyYZ3P2C/mGY9+tVdlm3eqOobDQK9OJ4
         DpE4xBE3Ho0ccDT7IN4cCTwSieU/HJw6mTK7QFJ+60up39tV7S0b9tGzB+8zCgOVkEJ+
         6l1RTUokGr2sbJ3seQKkmmytvIA0CQc+SNyRkIXmodsd/u2s1qs14Xzim/BOolIHwsaY
         APrcYC5zVsgf38egRn041cZG5zBMfCjOjOhwiKMaOlM+xdHs/IztV9GmzjNzqD5z/VyK
         ywgR4ckPEO0ET3zASULpqtFLZtV3shVG0pvUyofAYWLVkqsTWBP7RsngAZxDR8rCraUf
         7GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=ND86NtVePRPk7R7SWz2MIRVBAnQTKlro6pwsk/KIUe+jhW94l2QSDdw+7yx4nT/QEo
         cOwHjyBnf+XaejJYB4LScAFewxKXMccWrqXa1YLOwHLcT8VrSr6a2nwhaUFZRcAQJ3fC
         UKbUFNttc8qzYLCIZRZP2fG4Es8jzr+Dp+cf+suRg2HBS7ydOBDIKCHtvopSKfyXrTtO
         xsxknhJU5BRKhbpXNoUVsq7rj9FpWIBMvoK5UVFBmms4QLUQXtR508G50usNk8tz0122
         R7oKWPAA4yEcM923Ox3qTuvaX8HeVSmoDLPOtBZCGKsshwyZ+cS6E8LjLfJsb0wl5gak
         zspA==
X-Gm-Message-State: APzg51DWSBBLkEARDwhFe8PwCF2TGCfIzG9Od1qqBaQGDi/+ZUY3u0WH
        3sWAdKPzcqLErAwYpSV8K7sIyw==
X-Google-Smtp-Source: ANB0Vda8oRA8IzsbDf0mP70ZuFj+ZhEMQ0NduvjVP9Z2klDOrntiWoEoEu62nPm5/7OviM7JUI2Oww==
X-Received: by 2002:a1c:ca17:: with SMTP id a23-v6mr721806wmg.122.1536738715613;
        Wed, 12 Sep 2018 00:51:55 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 07/21] nvmem: lpc18xx_eeprom: use devm_nvmem_register()
Date:   Wed, 12 Sep 2018 09:51:15 +0200
Message-Id: <20180912075129.25185-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed version of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/lpc18xx_eeprom.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a9534a6e8636..b42dbaddb419 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -236,7 +236,7 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	lpc18xx_nvmem_config.dev = dev;
 	lpc18xx_nvmem_config.priv = eeprom;
 
-	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
+	eeprom->nvmem = devm_nvmem_register(dev, &lpc18xx_nvmem_config);
 	if (IS_ERR(eeprom->nvmem)) {
 		ret = PTR_ERR(eeprom->nvmem);
 		goto err_clk;
@@ -257,10 +257,6 @@ static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = nvmem_unregister(eeprom->nvmem);
-	if (ret < 0)
-		return ret;
-
 	clk_disable_unprepare(eeprom->clk);
 
 	return 0;
-- 
2.18.0

