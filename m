Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB23EC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24E22086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns7HCyyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeJMAAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:00:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46363 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeJMAAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:00:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so13987861wru.13;
        Fri, 12 Oct 2018 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mat2nPClyH8OZFkoDv8q+tL0+LVOi6YVRjAlX7dy2ug=;
        b=Ns7HCyyikkEuSK7L1GUt/jf4gkOJsg1yjjKmZYgWP8c2UAXtQiaoPiN9OqF/cnxEqD
         /5jXAs7JMVfPy5k1j2cJWx8esMMQO8Mu3Y+wfKPUrDxGYVRD5spA4Oxs1zOcWw+T8aMA
         7sh5M2I6VNBayxsNzme4V7Wp/prXDNwh35mf3YinVV1eJ+MENYmELX1LaLjep9Z/zFKi
         JI14GgaLn10E1ky/5ZzT7a6wuBIauSeIwxQ/nHxe4XeUHvHp+ODN20WmD5IB31XweIxX
         IYlu47wY+aPdRKgYgL3DHL8k6UDdTix4OeI79PI3PqESjiqkyiCljWH7PUrNAUgin6Vd
         K/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mat2nPClyH8OZFkoDv8q+tL0+LVOi6YVRjAlX7dy2ug=;
        b=K625ZqSu3/yLS7/xpFrV9cSSCrPbKYBpDdUjDgJIA2WruYN0lGs1P3VAaW1XVoZ2U7
         S4vL8kiHQp898geHFaDY6GwLdx6vGhK3FXTLkXeTMmTifRcINECK3gnJM0dnci8CteHa
         fJVDa3Q+dZrNxd1LVR2rEeOLHJPdONUGn303BFIogFwbUO73vqYYOBz4dFJUpNmT3oqc
         nyGrgfQlHCeXme70iFQYxhYflyVCJ2i7xlP89kX5GTBZn5O27th1hk/JC1anzMwQm+dF
         8Abs/07ILw/Z8/MaJpysesd7f4CLKUtggRZSdnXlGSqtloyxcu81QnFOo8pL0jQ0ya4A
         XZkQ==
X-Gm-Message-State: ABuFfojvWbYvtVSQlOZQz+j6iIWjOWL6n8RZYmeys0mvrz6eBawyGR4u
        NjF2TWmQJLMfJ/2qDQes1EY=
X-Google-Smtp-Source: ACcGV63SWRCq7z7Oyas0cDpn/T0b+k2uYffJ6Wo9mMqhtAozmawsowhpjgzpsgygbfq9Cj8a+o67fw==
X-Received: by 2002:a5d:694c:: with SMTP id r12-v6mr5581651wrw.170.1539361610284;
        Fri, 12 Oct 2018 09:26:50 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1736842wmd.9.2018.10.12.09.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 09:26:49 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 lora-next 2/5] net: lora: sx1301: replace burst spi functions with regmap_noinc
Date:   Fri, 12 Oct 2018 17:26:03 +0100
Message-Id: <1539361567-3602-3-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now use to regmap_noinc API to allow reading and writing to
the internal FIFO register which controls processor memory.
We also remove the now defunct spi element from the structure as this
completes the move to regmap.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx1301.c | 22 ++--------------------
 drivers/net/lora/sx1301.h |  2 --
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index fd29258..9c85fe7 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -74,23 +74,6 @@ static struct regmap_config sx1301_regmap_config = {
 	.max_register = SX1301_MAX_REGISTER,
 };
 
-static int sx1301_read_burst(struct sx1301_priv *priv, u8 reg, u8 *val, size_t len)
-{
-	u8 addr = reg & 0x7f;
-	return spi_write_then_read(priv->spi, &addr, 1, val, len);
-}
-
-static int sx1301_write_burst(struct sx1301_priv *priv, u8 reg, const u8 *val, size_t len)
-{
-	u8 addr = reg | BIT(7);
-	struct spi_transfer xfr[2] = {
-		{ .tx_buf = &addr, .len = 1 },
-		{ .tx_buf = val, .len = len },
-	};
-
-	return spi_sync_transfer(priv->spi, xfr, 2);
-}
-
 static int sx1301_soft_reset(struct sx1301_priv *priv)
 {
 	return regmap_write(priv->regmap, SX1301_PAGE, REG_PAGE_RESET_SOFT_RESET);
@@ -180,7 +163,7 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct
 		return ret;
 	}
 
-	ret = sx1301_write_burst(priv, SX1301_MPD, fw->data, fw->size);
+	ret = regmap_noinc_write(priv->regmap, SX1301_MPD, fw->data, fw->size);
 	if (ret) {
 		dev_err(priv->dev, "MCU prom data write failed\n");
 		return ret;
@@ -196,7 +179,7 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct
 	if (!buf)
 		return -ENOMEM;
 
-	ret = sx1301_read_burst(priv, SX1301_MPD, buf, fw->size);
+	ret = regmap_noinc_read(priv->regmap, SX1301_MPD, buf, fw->size);
 	if (ret) {
 		dev_err(priv->dev, "MCU prom data read failed\n");
 		kfree(buf);
@@ -566,7 +549,6 @@ static int sx1301_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, netdev);
 	priv->dev = &spi->dev;
-	priv->spi = spi;
 
 	priv->regmap = devm_regmap_init_spi(spi, &sx1301_regmap_config);
 	if (IS_ERR(priv->regmap)) {
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index e939c02..e6400f8 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -12,7 +12,6 @@
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
 #include <linux/lora/dev.h>
-#include <linux/spi/spi.h>
 
 #define SX1301_CHIP_VERSION 103
 
@@ -64,7 +63,6 @@
 struct sx1301_priv {
 	struct lora_dev_priv lora;
 	struct device		*dev;
-	struct spi_device	*spi;
 	struct gpio_desc *rst_gpio;
 	struct regmap		*regmap;
 };
-- 
2.7.4

