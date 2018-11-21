Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E31FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E4B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpXG0LpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E4B214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbeKVGZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeKVGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so1320602wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeAag+dMlfCBYBebT8ozUcI6nsPa2Lq4fM8o5NA2qN0=;
        b=NpXG0LpFrgjGD0QHrjSLTbKq3bwj9J+g2e3rSLwhZWVB5juvbAdDZNI1W0HvGHiwnA
         FO1lZkrbBO3FKn7knFAj8FJ8KyskCYChiJGd/Q81QXr5vNiHczp8rwvNaiGkj9z4/uGt
         7256Zfb5yb/saDY34YH8F6IfZusHqBnmOybrH/SYZBIQAfJWZqkG+vwOs/54qQh8ViLe
         kImDNZOi5Boh3vNtRcnYA/UhjPll7E6hVh+Pis6044xfJ2IycYGCoYAjPfhCSuAnCDpX
         w3kAYktYkS3FrocrvvFWXtRg4epxt/nv5967IE40kGdeluQdE9dIKPl0I0qf3sGN942F
         sWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeAag+dMlfCBYBebT8ozUcI6nsPa2Lq4fM8o5NA2qN0=;
        b=IYIEO53NNvgEwWbWsqxdhhFYpcbJtAyKznGQW+HWg8ltn6du4spIppn5DhCQSIe2DA
         P/uL+ynelrIHnpg4Zw0xWnIJX7Slav//KbuhSuhAFmjFHYM3mucEfjvdrpPnQsKGkuTS
         I0ENqZ2CwHvOOgx7Tmlx+qoD4FNNLZoo3dBXmioXyYXheN4Yw8dQNSbT4iA01YC2fCCb
         XyfTjV7874pfOH33v8NDXQ/7Rfc+BeRUUatR33bbNeOsPOruu6xUFbJEH+lJ4U/pNUpF
         Yx9Y3YmGgcv+zQbr32XrTxFkcFOy2nJ/jpNh3T1kHP100fPY5XI6BNRRvEQynUlQPdEA
         XiQA==
X-Gm-Message-State: AA+aEWbpo5X+6ITP2FKArIkxFtkz6LM70YodPzjH5CZvZ0v/sFjgkRRK
        oMzKAyHBZsC/vkeKYODdZeW8QOXr0+k=
X-Google-Smtp-Source: AFSGD/WSufGUHE8ctNjQ149r537e7bXdg/DArx3AVoHrUuZH/hqfg6mHU/u0ZJ3LexwQF4d19qKOCw==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr6891719wrp.21.1542829801955;
        Wed, 21 Nov 2018 11:50:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/10] staging: rtl8188eu: cleanup comments in rtl8188eu_led.c
Date:   Wed, 21 Nov 2018 20:49:29 +0100
Message-Id: <20181121194937.1852-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comments in rtl8188eu_led.c. The function names are well
descriptive.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 411649a0b070..535ada474164 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -10,11 +10,6 @@
 #include <rtl8188e_hal.h>
 #include <usb_ops_linux.h>
 
-/*  LED object. */
-
-/*  LED_819xUsb routines. */
-/*	Description: */
-/*		Turn on LED according to LedPin specified. */
 void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
@@ -22,12 +17,10 @@ void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 	LedCfg = usb_read8(padapter, REG_LEDCFG2);
-	usb_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
+	usb_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0) | BIT(5) | BIT(6));
 	pLed->bLedOn = true;
 }
 
-/*	Description: */
-/*		Turn off LED according to LedPin specified. */
 void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
@@ -47,11 +40,6 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = false;
 }
 
-/*  Interface to manipulate LED objects. */
-/*  Default LED behavior. */
-
-/*	Description: */
-/*		Initialize all LED_871x objects. */
 void rtw_hal_sw_led_init(struct adapter *padapter)
 {
 	struct led_priv *pledpriv = &padapter->ledpriv;
@@ -59,8 +47,6 @@ void rtw_hal_sw_led_init(struct adapter *padapter)
 	InitLed871x(padapter, &pledpriv->SwLed0);
 }
 
-/*	Description: */
-/*		DeInitialize all LED_819xUsb objects. */
 void rtw_hal_sw_led_deinit(struct adapter *padapter)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
-- 
2.19.1

