Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33331214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1ia4P9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33331214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbeKVGZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38193 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbeKVGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so6983071wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POZsCbOuQy8fRLO2dhk39cpEUNXgHZfIS2zr0T58/Eg=;
        b=n1ia4P9eAmic5sGcDzhGpTB6h1BJHava2FG69bMwr63ik9hQ5Ht0S0zvszFawr7eYL
         SpWhR6BY29vOesjwHiirry/fXbfKH9fK1SWmC/GeLZ0Pi203rAh4hrxsjhygQk9EZdPR
         Jj7dVhX40jgO0aoZlVBcImJ7wxKh2L3nXdU/5uX9Wp+R9avTtUz3IUNfR/O6Rfjd+t8c
         b5aG9GqQxSlMGnfZlllIMj7yxTl6yfecOmyFC39T5ae6NPCPY0rwdTzWGbuxVrtIqo1c
         OmbKY54IBXW97ZeQuu2a7raPz7tknj90GSIC2ZQ8e+17WmQOq6dC2eDaMyGE1WHkLixF
         pnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POZsCbOuQy8fRLO2dhk39cpEUNXgHZfIS2zr0T58/Eg=;
        b=dhCSNtZmwv7bX7+YQBH+LFR0ymFxM2WLrWeU3Ix6G1HuSfixZ+tb11xfRVi0xkn1Tg
         iQ1AnAnDNJ3dVgRXR07rQBKbxVOpQroP8gO+tRlObEi119rAdrJTAqoWTGI/J956ciU4
         v1LGhEywC1LzRL9vfh6+PfnPnpzHb+VZAwJhjJwQw0ArC/aT2pKRLpWhTDLh7GC1aQSI
         lF2Kw9BshP9pfIbg0X9Esv8+Zsums6bHBh/Z+FrGYWK40ekM96kxNnYJaEswj3XmP2qc
         Yc9OZSKH2s1qoQhksRmeFx6nPYToKIYTs7DcvIoz9c3lb5PnxMV3Kx9gPUUI2lQu5zDS
         YYqg==
X-Gm-Message-State: AA+aEWZ7o0uS0fge2EsBgafX2J1UC4SodysoeyhUoMhIMZl2IHzA3gOF
        NKG0karmAP2DtCO9ufADW2oYqH31pRw=
X-Google-Smtp-Source: AFSGD/Wrm2BfVSwKOSIdEXiXFm4THYtj10bxRMFF4d3eL5B9vQZpWGJYmFs0Mg3ebHzlMvGkNny9zQ==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr7511786wmg.42.1542829806427;
        Wed, 21 Nov 2018 11:50:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/10] staging: rtl8188eu: rename BlinkHandler to avoid CamelCase
Date:   Wed, 21 Nov 2018 20:49:34 +0100
Message-Id: <20181121194937.1852-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function BlinkHandler to avoid CamelCase.
BlinkHandler -> blink_handler

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c    | 4 ++--
 drivers/staging/rtl8188eu/include/rtw_led.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 851c12f032e8..481e2f1930c1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -33,7 +33,7 @@ void BlinkWorkItemCallback(struct work_struct *work)
 	struct LED_871x *pLed = container_of(work, struct LED_871x,
 						BlinkWorkItem);
 
-	BlinkHandler(pLed);
+	blink_handler(pLed);
 }
 
 /*  */
@@ -459,7 +459,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 /*	Description: */
 /*		Handler function of LED Blinking. */
 /*  */
-void BlinkHandler(struct LED_871x *pLed)
+void blink_handler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_led.h b/drivers/staging/rtl8188eu/include/rtw_led.h
index 65cd9ce567b5..80f8dcce05dc 100644
--- a/drivers/staging/rtl8188eu/include/rtw_led.h
+++ b/drivers/staging/rtl8188eu/include/rtw_led.h
@@ -93,7 +93,7 @@ void InitLed871x(struct adapter *padapter, struct LED_871x *pLed);
 void DeInitLed871x(struct LED_871x *pLed);
 
 /* hal... */
-void BlinkHandler(struct LED_871x *pLed);
+void blink_handler(struct LED_871x *pLed);
 void sw_led_on(struct adapter *padapter, struct LED_871x *pLed);
 void sw_led_off(struct adapter *padapter, struct LED_871x *pLed);
 
-- 
2.19.1

