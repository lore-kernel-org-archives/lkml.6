Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D809C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E24214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBV7LfGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E24214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbeKVG0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:26:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so6985684wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrasjDkn9V+V8m5ngLumGw6r9Rg42eL72GD8jIm7ozk=;
        b=mBV7LfGeqlYleGiQlRKqFsBbqQ/oDQUTN/oW7Pre8s/qu9L7POWZFAjCwzl+mqn7UO
         Ju7tYl3BwENRJoMQpS/7LQEuFtPC+MBWQ7QmP+QEWqeT1owaf8x1jfNK5lZum4/V5/OO
         UvlBrBMJGdCrtx4mB8MVnm9PlhwpaU95c3DVm9fWDh7nBbusrD5SiPpzrakIn+eVfvSo
         afNfWP0b1DPt42vo7+rY5luxqPowsg5Dc5w/s65EuMigqO+gYpFIZK+t0Y5pRN5HAACI
         +NCqaIvgGimH2U69OAoo7C5y065P6fh9n7tOAAcAvfQlFH+UkKAyj7kz5s4bxccm3QOx
         W4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrasjDkn9V+V8m5ngLumGw6r9Rg42eL72GD8jIm7ozk=;
        b=HspQVxpNtIILYl2MJkO2v6ah3Z3kNfy6YAwuR6OH3qJoxzOWcQYZ3vv4ixzCLYuFQz
         qMMtuPN/uQxnWc/3S/2TaJ6iDKJ292svoNKy8MFQrEhqnB+liWztgyofSX/UbsaB+oiu
         MbamomYTxVGSJNloifZPRqsbNpxbGoOYMWqaHnbjvs+nFPZP+o2jEFDhxdMnmhXJprfu
         qGsrungQ/sC98wIqE9wpZ6Exz+a4LB0rDzpRq6L5TuMp8VVuQFLN4oRK6u++QhYJ7xWv
         p7UfRGDL42ydjo3ofk4rawMa1A9W7+lJ5/5nY4BwkD+RuAeaadHnS4nPJ7sRCmDJWpET
         8Sfg==
X-Gm-Message-State: AGRZ1gIJawgpgagd2dFPgy6RykS506yvKh/HkHquZpAgdMzHIRlV2ks0
        aiVUkV+ag/fP5YSKgPP/whfKrCdu71c=
X-Google-Smtp-Source: AFSGD/Wco15o0cr6WrF1UDpGrLwQkHspbDIjLauofevhw5xQ+6MjyedScopBozujxCjNISPLdnfhcw==
X-Received: by 2002:a1c:3c1:: with SMTP id 184-v6mr6922714wmd.90.1542829805377;
        Wed, 21 Nov 2018 11:50:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/10] staging: rtl8188eu: rename SwLedOff to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:33 +0100
Message-Id: <20181121194937.1852-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function SwLedOff to avoid CamelCase.
SwLedOff -> sw_led_off

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c      | 6 +++---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 2 +-
 drivers/staging/rtl8188eu/include/rtw_led.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index c3cd3abf9cc7..851c12f032e8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -98,13 +98,13 @@ static void SwLedBlink1(struct LED_871x *pLed)
 		RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
 			 ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
 	} else {
-		SwLedOff(padapter, pLed);
+		sw_led_off(padapter, pLed);
 		RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
 			 ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
 	}
 
 	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
-		SwLedOff(padapter, pLed);
+		sw_led_off(padapter, pLed);
 		ResetLedStatus(pLed);
 		return;
 	}
@@ -445,7 +445,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 			del_timer_sync(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
-		SwLedOff(padapter, pLed);
+		sw_led_off(padapter, pLed);
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 98f3ebf44944..1d8832550dfd 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -21,7 +21,7 @@ void sw_led_on(struct adapter *padapter, struct LED_871x *pLed)
 	pLed->bLedOn = true;
 }
 
-void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
+void sw_led_off(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8 led_cfg;
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_led.h b/drivers/staging/rtl8188eu/include/rtw_led.h
index a3921596a577..65cd9ce567b5 100644
--- a/drivers/staging/rtl8188eu/include/rtw_led.h
+++ b/drivers/staging/rtl8188eu/include/rtw_led.h
@@ -95,6 +95,6 @@ void DeInitLed871x(struct LED_871x *pLed);
 /* hal... */
 void BlinkHandler(struct LED_871x *pLed);
 void sw_led_on(struct adapter *padapter, struct LED_871x *pLed);
-void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
+void sw_led_off(struct adapter *padapter, struct LED_871x *pLed);
 
 #endif /* __RTW_LED_H_ */
-- 
2.19.1

