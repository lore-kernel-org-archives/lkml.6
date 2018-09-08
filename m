Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DDC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0575020652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRJYTQcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0575020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeIHQ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:59:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35909 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:59:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so17056748wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvsALzrsw4nqSt3f8pvk9D27HsfunCKCVYXpWnhTqCI=;
        b=sRJYTQcFB7Mtz5TscxKTlaQoHuT3O4eQ8nnMGX6Zkn3ExkqYHMUIgEfbnt7bF8NBH/
         NlA4Dz12wYjAD3y9iKBJZ1ANVc2ONr1AMoLBGp5d6O751NnIpCyVNLnsiZ0Nrf8ilTU1
         7lvlxzMNHToFvgyB/HNCYxreEZ8lNDGFTMDziJCJjprbCcLlmfpmUm+mdbw1kGx7zdmu
         LfTYD+VjHFs54HJtcK8ZLgvl3fYkTlmslvi/JMyJ0UewzMjDbRLx2yE83xTU4LmGZ/Ay
         BwfGnPV2iUQ6tFxvA+MQUZSj9YtSOc1TRtroPDILWLj3SEi0hOXbP8UVUONR+5Gg2frO
         SHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvsALzrsw4nqSt3f8pvk9D27HsfunCKCVYXpWnhTqCI=;
        b=toZ2jYqnwXxGsP+ms2wGzZcc9+wuykRt3khKOBchJLmc/JGDm4FDS9dA89qm0WNw9e
         eduQTc8Zqfw90qPbbpf7kM9HhF8AUtwIPEZaOMRCsNsom3FLsJqFuy9Y80ihsQD+Z3us
         tgcZVcD6NurQdF+QgX16ikwXrAP7fJIL4CuMuAuonVJI5FPBxAwhvrqMo4WCO5HLByeC
         EVOXGVgUTRR/ObCenq07DVKeDMgO7Qt+6zXVFDVumF5V+x6HG6Nlb0PkTkqBd0Vq2kMy
         6a5/M0iw8AuKraHrbmrYmMrrY/TbL+e4Y2RWmkyNPU5cOPP8B5CLAm4PfIl3cz7ohZj7
         HG4A==
X-Gm-Message-State: APzg51Ab8JY7n6shs1ABbF1BC8CXoVKap8cfuuw40Sey1qnF3Lv7ZSGg
        Jc6z5dTBR0TqbnKbbLWS78Y=
X-Google-Smtp-Source: ANB0VdbkJwyivVC6UpIjPPklnVgrsNKD+Q5xP4N9g6rnsaOf1CNMMzv81k7CpNBFJwj2uhVKnUif4A==
X-Received: by 2002:a1c:6386:: with SMTP id x128-v6mr8440739wmb.104.1536408849109;
        Sat, 08 Sep 2018 05:14:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z4-v6sm9096458wrt.89.2018.09.08.05.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 05:14:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: fix lines over 80 characters in rtw_led.c
Date:   Sat,  8 Sep 2018 14:13:53 +0200
Message-Id: <20180908121353.16137-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908121353.16137-1-straube.linux@gmail.com>
References: <20180908121353.16137-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap lines over 80 characters where appropriate to
clear checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index d51494eb11ab..98106e77a9f6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -95,10 +95,12 @@ static void SwLedBlink1(struct LED_871x *pLed)
 	/*  Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == RTW_LED_ON) {
 		SwLedOn(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
+		RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
+			 ("Blinktimes (%d): turn on\n", pLed->BlinkTimes));
 	} else {
 		SwLedOff(padapter, pLed);
-		RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
+		RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
+			 ("Blinktimes (%d): turn off\n", pLed->BlinkTimes));
 	}
 
 	if (padapter->pwrctrlpriv.rf_pwrstate != rf_on) {
@@ -449,7 +451,8 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		break;
 	}
 
-	RT_TRACE(_module_rtl8712_led_c_, _drv_info_, ("Led %d\n", pLed->CurrLedState));
+	RT_TRACE(_module_rtl8712_led_c_, _drv_info_,
+		 ("Led %d\n", pLed->CurrLedState));
 }
 
 /*  */
-- 
2.18.0

