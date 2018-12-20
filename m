Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D31C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B532176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="k4FnwGC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbeLTHlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:41:39 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:39720 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbeLTHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:41:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 15F12BFB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2oTB40_G971A for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 01:41:37 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id D5798C11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:41:37 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id q23so859427ior.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ODt2/HIvXPhmOVsMhflUX8ASB3mSn0Ldo6VoVN1i1Ts=;
        b=k4FnwGC2OCITxvc/LP/yzG/ilamRECMpclMVQkjDzgcKca2CWlFKKRaPlxm6UvAUFE
         FKyD9qfDiO/S5dd/I8XvNa3IYb6mEld/bnHskSerpxNQXxmVBwF1SNrVRo0dleAOg4rs
         rdSboc8wrwYZ3vonon6WpRKgo9Nc8C93S1EmJSm6dgBTm2EOT6l5tfirhRQIyW8/+1IX
         Y3/GSjd42arkqjTAV6i61nHI86nCZDiOniY0S733xuDayTH/37M4cQpgopvYWSVltOSs
         WnhyjjAy9SaCD281uTF3B2a9vPQL9Ck++aGMX9+8iwL2vOeufEJlDQ5gcEyWhrSfypGX
         g5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODt2/HIvXPhmOVsMhflUX8ASB3mSn0Ldo6VoVN1i1Ts=;
        b=jFy8MHAKv4z5eHGyA8RYXix41X8Bu5ht5446qLF5gpk0aO/7175XqZ7MRz6lw3/vlt
         9s1ogvD+jWLs60SAboGmsXvqYNB8+7KLJTYfSNEMt6UiO6YovAUTI6fkog8yx+qTbEnj
         vqbpjBJOc9lPbkjIo+8WljjV2x4FmH9TLPgFIrfTodtDLHfPE57XIhsDUJIck2yzbFxh
         2ccH3tybaynvcM6YIbEOMQ/KQZNqyb9RKmGeLKbFFVL6+Cv39OtebOmhKe9jCA0UjDAS
         q7VQNKSA1nv8W5wbo5eb+0s8WZS+kmOjMQWCSgHVvDcGjXBqr/61UO/A3XTDGr9Q3UjB
         S56g==
X-Gm-Message-State: AA+aEWYKuppoEOvWCiAQOPCJ8LC89dftJOx7Kd9v1iuqRFTP9f3ZkNcF
        RtykHrDPiA0dQWpS2irK/KCClGVhG77XxRHknB6MqW+iFJFvk4aTzbvvB2qwAO50fKOW8ckgbLi
        g4bu7AyzuF0uLccchI2RxvlB1in8Y
X-Received: by 2002:a24:65c8:: with SMTP id u191mr9586209itb.7.1545291697386;
        Wed, 19 Dec 2018 23:41:37 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XxWuJw3F+AM9EPyPYdLpAlVkbxmELduXondrGLbCgE1VnfdgUEGCXc+X6M37sxE9K6kxEvXQ==
X-Received: by 2002:a24:65c8:: with SMTP id u191mr9586196itb.7.1545291697075;
        Wed, 19 Dec 2018 23:41:37 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-24.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.24])
        by smtp.gmail.com with ESMTPSA id x99sm4620260ita.23.2018.12.19.23.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:41:36 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: anx7808: fix a missing check of return value
Date:   Thu, 20 Dec 2018 01:41:16 -0600
Message-Id: <20181220074116.40546-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both anx78xx_set_bits() and anx78xx_clear_bits() in the poweron process
may fail. The fix inserts checks for their return values. If the poweron
process fails, it calls anx78xx_poweroff().

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 26 ++++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index f8433c93f463..a57104c71739 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -610,20 +610,20 @@ static int anx78xx_enable_interrupts(struct anx78xx *anx78xx)
 	return 0;
 }
 
-static void anx78xx_poweron(struct anx78xx *anx78xx)
+static int anx78xx_poweron(struct anx78xx *anx78xx)
 {
 	struct anx78xx_platform_data *pdata = &anx78xx->pdata;
-	int err;
+	int err = 0;
 
 	if (WARN_ON(anx78xx->powered))
-		return;
+		return err;
 
 	if (pdata->dvdd10) {
 		err = regulator_enable(pdata->dvdd10);
 		if (err) {
 			DRM_ERROR("Failed to enable DVDD10 regulator: %d\n",
 				  err);
-			return;
+			return err;
 		}
 
 		usleep_range(1000, 2000);
@@ -638,12 +638,18 @@ static void anx78xx_poweron(struct anx78xx *anx78xx)
 	gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 
 	/* Power on registers module */
-	anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
+	err = anx78xx_set_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
 			 SP_HDCP_PD | SP_AUDIO_PD | SP_VIDEO_PD | SP_LINK_PD);
-	anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
+	err |= anx78xx_clear_bits(anx78xx->map[I2C_IDX_TX_P2], SP_POWERDOWN_CTRL_REG,
 			   SP_REGISTER_PD | SP_TOTAL_PD);
+	if (err) { 
+		anx78xx_poweroff(anx78xx);
+		return err;
+	}
 
 	anx78xx->powered = true;
+
+	return err;
 }
 
 static void anx78xx_poweroff(struct anx78xx *anx78xx)
@@ -1144,7 +1150,9 @@ static irqreturn_t anx78xx_hpd_threaded_handler(int irq, void *data)
 	mutex_lock(&anx78xx->lock);
 
 	/* Cable is pulled, power on the chip */
-	anx78xx_poweron(anx78xx);
+	err = anx78xx_poweron(anx78xx);
+	if (err)
+		DRM_ERROR("Failed to power on the chip: %d\n", err);
 
 	err = anx78xx_enable_interrupts(anx78xx);
 	if (err)
@@ -1379,7 +1387,9 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Look for supported chip ID */
-	anx78xx_poweron(anx78xx);
+	err = anx78xx_poweron(anx78xx);
+	if (err)
+		goto err_poweroff;
 
 	err = regmap_read(anx78xx->map[I2C_IDX_TX_P2], SP_DEVICE_IDL_REG,
 			  &idl);
-- 
2.17.2 (Apple Git-113)

