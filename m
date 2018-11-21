Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B66214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeG3qaiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B66214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbeKVG0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:26:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732989AbeKVGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so6968844wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTqGI/zVcHRk6bjLU+5ley79BR6mM3U3/ygvVB1xjdU=;
        b=AeG3qaiDvaHjq6CyfQZk0wAwrNu3duKUUneU1P/JSkJZGmDeGNLMUJIs399oOwGs+a
         VXphgPjX83E3Ts3dcnA4H3JyjrPps3wUJ2gNTaHNnan9NFb41utjutjIj9Flg36dIxv1
         rK3dXA4nzkarbA+CkUIozaXAF0g266Vrty00JAICJJsjmV7F2ux4Ic6Dv01BC45SImKp
         nYWZ0/uZcJqwdw/8RmUl9DDTX+engT2lKuI+N2VyTC/9RY6Dk6y0ttkCnGwHW7f6e6hV
         lsEisCowcjqP0qU4jkyP1eoGPxiZ049RQcaRVwyqkru9tctTN39bQOgLoLFxnFcUaIY+
         6p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTqGI/zVcHRk6bjLU+5ley79BR6mM3U3/ygvVB1xjdU=;
        b=pq5dUJqB6X/F7lU/9xiaX+PnFTwErpXz/847WJ6rb/OCzwFlwmQg2ZY5QIyzUjPa7h
         R/06tAjOT44EioNtYFMVZfUsn9SEydSSnyah3tBPYk8SFZqLsYh5tLbolW8Og57rj6ku
         8tZLcgI8Glx2ZR6bnConhn6R5HPRh5NOakusr+8QFDEtKb4FPzW/K8Loq/mz0vtSChM9
         PTyyzPMlJQCX8WlcLPnQwJgV7yOgqYQZhBNm68HO9KWZDpisockxoEptrMVujSdg9DCc
         5l+e9kH8dNwF1dt6YJxGJVtEEVBIXyZDxxYmpCXGQN/I7c9LnrEDqW6qf82Ji+br4gtw
         xXWA==
X-Gm-Message-State: AA+aEWbMmyTvudb3txc1oppcEbbeYMJ5jo9nUszeOfWXdBZosShVi+zd
        pDp75LlGwTWqQkcV5Mcoc20=
X-Google-Smtp-Source: AFSGD/UGTarsL0QFwmWaMozL5IqTJ5Weo9PCuKKm0ESG7fDKZY+NfHlt0KDfKvA5afdYswCrKg4nWA==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr6769656wrr.313.1542829803667;
        Wed, 21 Nov 2018 11:50:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:03 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/10] staging: rtl8188eu: rename LedCfg to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:31 +0100
Message-Id: <20181121194937.1852-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable LedCfg to avoid CamleCase.
LedCfg -> led_cfg

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index d4495839af34..7e3f04bfd3f0 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -12,30 +12,30 @@
 
 void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 {
-	u8	LedCfg;
+	u8 led_cfg;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
-	LedCfg = usb_read8(padapter, REG_LEDCFG2);
-	usb_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6));
+	led_cfg = usb_read8(padapter, REG_LEDCFG2);
+	usb_write8(padapter, REG_LEDCFG2, (led_cfg & 0xf0) | BIT(5) | BIT(6));
 	pLed->bLedOn = true;
 }
 
 void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
-	u8	LedCfg;
+	u8 led_cfg;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		goto exit;
 
-	LedCfg = usb_read8(padapter, REG_LEDCFG2);/* 0x4E */
+	led_cfg = usb_read8(padapter, REG_LEDCFG2);/* 0x4E */
 
 	/*  Open-drain arrangement for controlling the LED) */
-	LedCfg &= 0x90; /*  Set to software control. */
-	usb_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
-	LedCfg = usb_read8(padapter, REG_MAC_PINMUX_CFG);
-	LedCfg &= 0xFE;
-	usb_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
+	led_cfg &= 0x90; /*  Set to software control. */
+	usb_write8(padapter, REG_LEDCFG2, (led_cfg | BIT(3)));
+	led_cfg = usb_read8(padapter, REG_MAC_PINMUX_CFG);
+	led_cfg &= 0xFE;
+	usb_write8(padapter, REG_MAC_PINMUX_CFG, led_cfg);
 exit:
 	pLed->bLedOn = false;
 }
-- 
2.19.1

