Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA713C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87E62073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j2QRwdlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBEJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:49:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40519 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:49:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so2844073wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvO3sb+k8cXgUb28uG7hJkzIJr/t2f9+FI2ONr5oCNk=;
        b=j2QRwdlKIRs+ecR9klrAJZMs5TAgLv2AoiSGqWS7IIBRL5neWgy44AqWafGe+pZH6u
         ZoVDpjVAqp/Jh+xMuO26rRGKHcR3e1NzxwKoRVDag/5OQCvpBCDOFZ2q1VVjQJPBp+QZ
         z6VDW1iTiyVCy+l3IEuUU1G8sGKFMaE5Na4C17IUM1KsOne9wzucRI7wIWzQCOc00FMX
         2P+AY46+ZxZlBbTgd2nd5JQKqTmZ9UGBkTYFUkIQlgYxYn1tqj7aombXp/ohHT1pxkxC
         +KbbDb0iOFXL0HTb6EZcrzeXFPCF9nWpL7qjPXE/SN1wRPNvdufEifn3WSULs0qKRBmW
         1k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvO3sb+k8cXgUb28uG7hJkzIJr/t2f9+FI2ONr5oCNk=;
        b=k6gYt0EWP9yNIs2e5sZ2QGltxA28WFd5meZWxkqLNATtc7E08CyO1ECd4GGfLqMRqN
         KHcv/ykH8X4yxoxqVXU3+zpgnMyn079PTd2sIP5bL0QMKrmKPSFb9U0CrNTOLnWX1x8u
         rYgHbJ2nLzfQYcqSMZinYI8E7dwuYFxt3L8WYiwgtYEJxZ4n4/1+awEH6AxZmwxa2XU+
         pLEBeH/+4BvuGBbgKQF9vXB6POa3BK2W1Ja7y1aBIAyv8hrt70lUUBoCipenLd1JxH69
         VBC7ZOvN3hfhavvPEuixaQvx5lAksVnvQnF3JuJV1x/wcPopciLTwMzA+hVxOT4xxVfI
         0MXA==
X-Gm-Message-State: AHQUAub2wfzq+al/pVDHZHf1sUK9SLkx7+F5u1tsgrTusjNBY4zffKX/
        z+d3hBv/hc4IkPjl8cCZRnzlMA==
X-Google-Smtp-Source: AHgI3IaOcilG/mUyo6QvSlWX3pgCT8zXEEnJ/QUeuocCQXoW6onx4/teB2PLEnOYqW+Rxky0vA5NrA==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr2835668wmj.145.1549360186816;
        Tue, 05 Feb 2019 01:49:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k4sm8466197wrp.8.2019.02.05.01.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:49:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: davinci: da850-evm: use GPIO hogs instead of the legacy API
Date:   Tue,  5 Feb 2019 10:49:37 +0100
Message-Id: <20190205094937.18645-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to drop the hard-coded GPIO base values from the davinci GPIO
driver's platform data, we first need to get rid of all calls to the
legacy GPIO functions. Convert the mdio configuration to hogging the
relevant GPIO line in the da850-evm board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 44bca048dfd0..69eba55d4c0f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1064,6 +1064,17 @@ static const short da850_evm_rmii_pins[] = {
 	-1
 };
 
+static struct gpiod_hog da850_evm_emac_gpio_hogs[] = {
+	{
+		.chip_label	= "davinci_gpio",
+		.chip_hwnum	= DA850_MII_MDIO_CLKEN_PIN,
+		.line_name	= "mdio_clk_en",
+		.lflags		= 0,
+		/* dflags set in da850_evm_config_emac() */
+	},
+	{ }
+};
+
 static int __init da850_evm_config_emac(void)
 {
 	void __iomem *cfg_chip3_base;
@@ -1102,14 +1113,9 @@ static int __init da850_evm_config_emac(void)
 	if (ret)
 		pr_warn("%s:GPIO(2,6) mux setup failed\n", __func__);
 
-	ret = gpio_request(DA850_MII_MDIO_CLKEN_PIN, "mdio_clk_en");
-	if (ret) {
-		pr_warn("Cannot open GPIO %d\n", DA850_MII_MDIO_CLKEN_PIN);
-		return ret;
-	}
-
-	/* Enable/Disable MII MDIO clock */
-	gpio_direction_output(DA850_MII_MDIO_CLKEN_PIN, rmii_en);
+	da850_evm_emac_gpio_hogs[0].dflags = rmii_en ? GPIOD_OUT_HIGH
+						     : GPIOD_OUT_LOW;
+	gpiod_add_hogs(da850_evm_emac_gpio_hogs);
 
 	soc_info->emac_pdata->phy_id = DA850_EVM_PHY_ID;
 
-- 
2.20.1

