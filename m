Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D8214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCvnrx7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4D8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeKVGZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39584 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbeKVGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so6965610wrx.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QTCenHkwjy5c+kwiKVnfnaBzsZrFdS4I2lLs6y388M=;
        b=PCvnrx7WKUF0Ej2d+NHevPlTdWCK0cnE7vq2oWrB+qUfhJkVeV4/Fcd9ekdyR55eyn
         ss9+PIguzqMq4AIdx7UAiVkfQ3pjylEWwH/XO6VfdH+X8y/Z7g7npppJ5ZDoxY+croqs
         f4JZ87UlfahOLd7PQVaTNzVz/jSbFzrYut81DhVjNGTOJl739VfGGQDMZ+U+8FlmiIGj
         XCsRjN5g0sx2dX8iirFsNmBs8elSoGhmfwkotYOsug1Pk2aZM7olo5nkgq9nXZ2ofb5a
         1nlyhBC6Mv6vGjcOv8EQaIgWwElET5P70DM2Klws9odo5/IRgKHU4ScnblUmUnc0m1tY
         KdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QTCenHkwjy5c+kwiKVnfnaBzsZrFdS4I2lLs6y388M=;
        b=jaaRGrBfWwNAqn23N8cPBowlmhH3mywMfM269kOIHZ08TuiKYLhxAD+6GQpWdmT8Tk
         EaL5nfKtJlC1sQbb5T0XPDvTzCrq/DTPlTG4CdkciS+XpdCo4E9igOS9FI78a6UQPH7q
         IfljZI1O+IufSPaYTyiuVltlUC5H/XFNOaMFwP8mf6xIwrN4kFuSGe21jTr76VekCWZS
         16yrxvwmIgv2pxC9vnKVd3IlVWSbmH5O9FSEqEsqEfbEOI30/advZ9z8pv+J6uNjDbgw
         gx2/qrF2JY6ZTOAZNxNiXNOnTY68kJKLej5lYFWNAjLQ5TanFTfkNuIscVcq6r6Npm2t
         fgpQ==
X-Gm-Message-State: AA+aEWbp5OaqyrLqqWo0zxdRcO8AAKHO1IxuPk6bMtZjwto8gnUwm75m
        tvZQ2HgFSVXaun8FbyMxVpo=
X-Google-Smtp-Source: AFSGD/VCwB/w8h3E6T2DTXZvhFgzXatGQvJ4XuS/2pzFvFapMJJoV/c5FuaVNxF+wmQcAMAAmCvAiQ==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr7101434wrq.294.1542829809336;
        Wed, 21 Nov 2018 11:50:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/10] staging: rtl8188eu: rename SwLed0 to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:37 +0100
Message-Id: <20181121194937.1852-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct field SwLed0 to avoid CamelCase.
SwLed0 -> sw_led

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c      | 2 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 4 ++--
 drivers/staging/rtl8188eu/include/rtw_led.h   | 4 +---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index ab68eb808c49..d1406cc99768 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -240,7 +240,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
-	struct LED_871x *pLed = &ledpriv->SwLed0;
+	struct LED_871x *pLed = &ledpriv->sw_led;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	switch (LedAction) {
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 1d8832550dfd..35806b27fdee 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -44,12 +44,12 @@ void rtw_hal_sw_led_init(struct adapter *padapter)
 {
 	struct led_priv *pledpriv = &padapter->ledpriv;
 
-	InitLed871x(padapter, &pledpriv->SwLed0);
+	InitLed871x(padapter, &pledpriv->sw_led);
 }
 
 void rtw_hal_sw_led_deinit(struct adapter *padapter)
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
 
-	DeInitLed871x(&ledpriv->SwLed0);
+	DeInitLed871x(&ledpriv->sw_led);
 }
diff --git a/drivers/staging/rtl8188eu/include/rtw_led.h b/drivers/staging/rtl8188eu/include/rtw_led.h
index e09ba8d2141b..ee62ed76a465 100644
--- a/drivers/staging/rtl8188eu/include/rtw_led.h
+++ b/drivers/staging/rtl8188eu/include/rtw_led.h
@@ -79,9 +79,7 @@ struct LED_871x {
 void led_control_8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction);
 
 struct led_priv {
-	/* add for led control */
-	struct LED_871x			SwLed0;
-	/* add for led control */
+	struct LED_871x sw_led;
 };
 
 void BlinkWorkItemCallback(struct work_struct *work);
-- 
2.19.1

