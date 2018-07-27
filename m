Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44EBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3716F20891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz12QzVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3716F20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbeG0DwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:52:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeG0DwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:52:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7-v6so1209222pff.2;
        Thu, 26 Jul 2018 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hw5ZqMfoQIrkB/wTxn21h/0+whhSGPLmeaphm84CJ0M=;
        b=Xz12QzVEr1EqymWFiIijq/uaSBKYhbqZ/0Zbeo9+YJqE9HslYUGQmAvOMquRorD+LY
         JYsvoA1F/40wXCQXrXkhEd36Azz0rGgS2OKFZj4jN94ZjDDkUsBKotkNLhJ6alyEFPOx
         LjxoVDp9R85IoaLcTUY218jGixo8qfB+xWkaqt/xYTgdR5uR9ohEIUMNnCyV5eGejYw3
         zKEpougjj1YMYUm1GNHI/BdsDriDUf+QcyrJw2eYAdeg9OcStqtYLAnQD+o393shpXxJ
         3QxukU64rEtvGV/PBE7q2gswSZmx5RPrsEyWgeFXrbUj6t2fWYs0Pm05VZb2r1MaCyii
         pZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hw5ZqMfoQIrkB/wTxn21h/0+whhSGPLmeaphm84CJ0M=;
        b=R0cGSe+757jDVf+xeh7EOJENy8XGQyPDab/DlA7b2H8SMLCHr0hYdwObwAF2TFEJkX
         QXbinLauLj1OzhqpE0DAx2g0dha+1jd5VkNp6ugyc44ITha9m5p5nUNaxsIxVTXJqaIB
         XhoiMCXK1IPAhYhedGWbpM5DXccR4QP4XhTDlNMbnudMA3E9rSpx7Vw4gV1PNF6A0uAf
         AdJkJLh+7vuyNc1YVfgZc4kgjBJ/Dy96L02cyoFzWimoCr5adjfIrxfAImuR4EwyrjY6
         a2CYgePPpqvba2cQ1ShVkQ8ItsIs9j0Z/0nx+2wMhX5t2VenNUbhEPADigeh2wTNnsLC
         e0kQ==
X-Gm-Message-State: AOUpUlF4gDux5xTwtpJFr3M3fZhdYyc7uUzpbnOWuEv7JOjLXJ+M2qq1
        g3N9UTFBlM9KTotjmvs8nwbEbINk
X-Google-Smtp-Source: AAOMgpfzrw2De8buhnPRZCOAr1vIRbNVjduWip5K7sKgCO9wpvLk9FVk2FDtUsQP8/bmk53DVWSOFw==
X-Received: by 2002:a63:b40e:: with SMTP id s14-v6mr4262672pgf.9.1532658745023;
        Thu, 26 Jul 2018 19:32:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id q28-v6sm4475300pfg.144.2018.07.26.19.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:32:24 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        gregkh@linuxfoundation.org, andi@etezian.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: touchscreen: wdt87xx_i2c: Replace mdelay() with msleep() in wdt87xx_resume()
Date:   Fri, 27 Jul 2018 10:32:16 +0800
Message-Id: <20180727023216.1467-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wdt87xx_resume() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 20f7f3902757..166edeb77776 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -1142,7 +1142,7 @@ static int __maybe_unused wdt87xx_resume(struct device *dev)
 	 * The chip may have been reset while system is resuming,
 	 * give it some time to settle.
 	 */
-	mdelay(100);
+	msleep(100);
 
 	error = wdt87xx_send_command(client, VND_CMD_START, 0);
 	if (error)
-- 
2.17.0

