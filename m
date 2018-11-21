Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C17C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB04E214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCfG9psv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB04E214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeKVGZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51935 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeKVGZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so6713210wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mj+oklMF3T0/t7qTyQ/E7VylClRGmzedFk0EiNxxjP8=;
        b=PCfG9psv9J3r3fLZcqN4eDfxO2k1we/LHPs32Xcws6Y+J8jHhuBIijP8HgcsWYtodD
         G2C3NQsdS34WNAG6fihwtRO26GQtejjF+TTbV6ilBaNOPSRgmrkMmdNrFbOseHTaZ3j5
         GbMCHiU0gacJmcf/oE90S52v4GcavqIWXRHSa9cWiUGrjsw14OK+TA6grhXqm86tQkka
         zpry3PG/T9FsLAnvokgGNtE9BIb4/BYLFGn8oKfycbfLDhHwewiCvI1cCipF47ksex5x
         XUOQLTwi+uJJ/ruW2jcozyAyukHKnJ6hNhOzI/Wl4T+EN59v7sEiZpBqLVqR47jqL3gz
         VE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mj+oklMF3T0/t7qTyQ/E7VylClRGmzedFk0EiNxxjP8=;
        b=GAWj174i2JFerxbM8hWYjmPYgyUkSiqPHWtfp9RnCHZvWziLxXnJjL+84Ks+pYZLM7
         hXbeHpDxjZxQ7cwf/eTVu8uQqHh5DdvsT5vN0VM3vOuKJzRlDhbfM0fRv0gPuLbyFgvv
         JdaovOgg3d2TQkzeDSSOedyy4sIYvIXOIqJgnqQhu3nc0i6iWc9FfuxV2fghjcQk9SBa
         eQFwAj/v+UdmSpUvjXkeMND7Eje2y1RQ2s+tJxxVVFdMSCdvlXlnftx/fae0TLb8I0bt
         y4euZkew6/lSwxr641IS12HiVonnW77r9XtJDQuPDVtpwAewN0bbAuHFkJ6vzDjEnwIu
         PMVA==
X-Gm-Message-State: AA+aEWa8JSogy0GdIGHyWLr87OV8Tm+1mT9N2NerZ8yIjMyMK11Zrhro
        ZBvh+YQ5+u09s0nM6ZBg9MI=
X-Google-Smtp-Source: AFSGD/UyGddAEjVCCPLfNsrNGBDZexhpzx09BwTX39agGbh2xypkwtA0q9Qep0GhlzVKRqglkKlLMg==
X-Received: by 2002:a1c:83cb:: with SMTP id f194-v6mr7139026wmd.26.1542829804500;
        Wed, 21 Nov 2018 11:50:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/10] staging: rtl8188eu: rename SwLedOn to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:32 +0100
Message-Id: <20181121194937.1852-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function SwLedOn to avoid CamelCase.
SwLedOn -> sw_led_on

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c      | 2 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 2 +-
 drivers/staging/rtl8188eu/include/rtw_led.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index a2e7789aecbd..c3cd3abf9cc7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -94,7 +94,7 @@ static void SwLedBlink1(struct LED_871x *pLed)
 
 	/*  Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == RTW_LED_ON) {
-		SwLedOn(padapter, pLed);
+		sw_led_on(padapter, pLed);
 		RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
 			 ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
 	} else {
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 7e3f04bfd3f0..98f3ebf44944 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -10,7 +10,7 @@
 #include <rtl8188e_hal.h>
 #include <usb_ops_linux.h>
 
-void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
+void sw_led_on(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8 led_cfg;
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_led.h b/drivers/staging/rtl8188eu/include/rtw_led.h
index e50237ab05c4..a3921596a577 100644
--- a/drivers/staging/rtl8188eu/include/rtw_led.h
+++ b/drivers/staging/rtl8188eu/include/rtw_led.h
@@ -94,7 +94,7 @@ void DeInitLed871x(struct LED_871x *pLed);
 
 /* hal... */
 void BlinkHandler(struct LED_871x *pLed);
-void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
+void sw_led_on(struct adapter *padapter, struct LED_871x *pLed);
 void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
 
 #endif /* __RTW_LED_H_ */
-- 
2.19.1

