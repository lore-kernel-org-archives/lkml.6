Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D413F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF97420881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbdTyfHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF97420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeG3K7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:59:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeG3K7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:59:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so6937075pgv.0;
        Mon, 30 Jul 2018 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pvBmAOvXm54SsGN8KhTiaSDPeHZFYKBxD2lIOwMg75g=;
        b=UbdTyfHCiahVwQ/v1xD33EQYe2jfAM31fRy8D3KXQKvdM+J76LZyGX6X+74RZJUNcN
         qYXwuhqQRXRB40vr0gVITZQkY/wUfojvphVFXbS+xTS4xpALvjssvQF7gxajW6hLtaJz
         QFKlhRmpsUvhL0kGWEhCszyQsVfQ7HwPPGWyEilId5rEKAtyEmKctvUUTIlbhkI+ZPxx
         fUMNV0BQi3gw+RdSPLdeAZ2W+EiXbXiXb9GxcshffDzzVui6oUWXJ+ik7piG5ACPq8Zh
         4UTTAy5KxDNd2KitGSC8j+YCRK94s4vkhQCbjZFsAx3cXHXOUm2VjfaWJ0T21NPSUd+c
         D6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pvBmAOvXm54SsGN8KhTiaSDPeHZFYKBxD2lIOwMg75g=;
        b=t7q0aR/RFB+h5dkv3kEALXckymg72bQowTrACXblkLoFvHN2jDZdsE9gvH0Tox7Aez
         XV54+E/vZ9Wdm34diVK5Bbwg4uCo2/VbW8rXbj5VERg2rOwL1ocUqrqWkb9nCzNzbjZo
         X2soA4vGaIOj6K8LedhGOa7TvcX+yYjjbZlJnIWrLbWaqAM9iTI3NTTs5JiQ9izANf08
         aHEl/Szxx8WpmfFzdZwm2OPXGc508lH+rzvieCJNvvjtRAHufkD51vicrBtTjRKPLwzH
         z8zLJUfbcLJfRtaCgNV57Y6JmpuXwEDR72cw7wpnzMkEW+jKH9a/WovLBcLeMNZvzzmR
         zihw==
X-Gm-Message-State: AOUpUlH1qqAbnKdSNOZHwifcdchCJ10blSlJ+kbEpdGNOcW62fofWZos
        qqAqkaygbrf8IK/EGCrGdeY=
X-Google-Smtp-Source: AAOMgpc7cqNuyltE1ZlFmti0Axf0dRFUymsdrE4UpGZaHStfQI1BKV7LHIddsUY/wB/5GPhHR9dcOQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11-v6mr17134499pfg.255.1532942704907;
        Mon, 30 Jul 2018 02:25:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id f67-v6sm18975558pfe.75.2018.07.30.02.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:25:04 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] media: usb: em28xx: Replace mdelay() with msleep() in em28xx_pre_card_setup()
Date:   Mon, 30 Jul 2018 17:24:59 +0800
Message-Id: <20180730092459.7848-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

em28xx_pre_card_setup() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 6e0e67d23876..24ac257fd421 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -2825,13 +2825,13 @@ static void em28xx_pre_card_setup(struct em28xx *dev)
 		em28xx_write_reg(dev, EM2880_R04_GPO, 0x01);
 		usleep_range(10000, 11000);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfd);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfc);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xdc);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfc);
-		mdelay(70);
+		msleep(70);
 		break;
 	case EM2870_BOARD_TERRATEC_XS_MT2060:
 		/*
@@ -2839,11 +2839,11 @@ static void em28xx_pre_card_setup(struct em28xx *dev)
 		 * demod work
 		 */
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfe);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xde);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfe);
-		mdelay(70);
+		msleep(70);
 		break;
 	case EM2870_BOARD_PINNACLE_PCTV_DVB:
 		/*
@@ -2851,11 +2851,11 @@ static void em28xx_pre_card_setup(struct em28xx *dev)
 		 * DVB-T demod work
 		 */
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfe);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xde);
-		mdelay(70);
+		msleep(70);
 		em28xx_write_reg(dev, EM2820_R08_GPIO_CTRL, 0xfe);
-		mdelay(70);
+		msleep(70);
 		break;
 	case EM2820_BOARD_GADMEI_UTV310:
 	case EM2820_BOARD_MSI_VOX_USB_2:
-- 
2.17.0

