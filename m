Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B2AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DD7214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCDSyXfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DD7214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbeKVGZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45714 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbeKVGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so6931789wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCToRm7qo5KpurFNjkYkvECpUMcTnOnYuffET0O2+o0=;
        b=DCDSyXfnX0OC1ltHsD90EFYiPbNKWRIhuOwF5VW903wcQ/2zj3zZWPzE/gS1HKtPNZ
         gyw5c3shYfSmL/din/UuTdtPtLIaaPc3Y0k0CeVIV8Iyh9VzGrUyR0mHLaYOSjIPQTb9
         MhGZhS6wPZ2rj+YIOvxAxpcqKhBaL0yf/qVf1Bk6rgdclujft80AuamPeXOsQutrEYIe
         vrMgKfA9lAPtpiyI6nIG11Aq9h+AVr5Z2eCACqPwKumxFN7AIUhxZmFxDt07NIY4eDIx
         7XMD+OsTDuwz5m3W8Xc5uvIZDcyvqxEmIiCvq+GIEm/oJPWUuDdGwSIwANqEGgkaFyFG
         41uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCToRm7qo5KpurFNjkYkvECpUMcTnOnYuffET0O2+o0=;
        b=XuIMETWhmlltt6FA2buZsGx3xAvuJ2J83SfMW6R9SrdV4HKE1g6cEX4O31fnUhhN6s
         V0OYTcClqpN1u2f16/LwUNA7xtcVYZxf9DMBqLKHGwoXZ/QizA+jJo6+N5E7ioneO6Nd
         KAvC/CBpPQGUKTgGkcMmhUDcLLuL6VZZeJF6PNmCeqe/C/3NpzcQge1R9LVCmVYMwjkL
         QOn+qLjP8c85jjjwuaJqMT7/fevXvvpVpeGL2hsM/j9u1/7nARU7UsCsufGCRvGQsv39
         LUMRU5E1nUKQCbDZvF7QPZOTUspU3T1tjO0DWW/9rOVsZivu4Wbj559GDgiuC1YyboJO
         4WSw==
X-Gm-Message-State: AA+aEWavCNDEpAU4FL/Y8a56D69fQ7FFl8mKu3F3kK2COvSO1BLmuEsv
        egFxE6Iaq4NyQlL8+L6eAPhWp0tFVLY=
X-Google-Smtp-Source: AFSGD/XOI15CIw9t7ewMTGjocu0f8gl5CXRIFFMsvST+spkCjUZtAs0XZj0badamfCcX4uKvp6Xceg==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr4488648wrs.228.1542829807301;
        Wed, 21 Nov 2018 11:50:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/10] staging: rtl8188eu: cleanup a function comment
Date:   Wed, 21 Nov 2018 20:49:35 +0100
Message-Id: <20181121194937.1852-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121194937.1852-1-straube.linux@gmail.com>
References: <20181121194937.1852-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for blink_handler() adds no extra information
in addition to the function name, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 481e2f1930c1..99ebaf5e4548 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -455,10 +455,6 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		 ("Led %d\n", pLed->CurrLedState));
 }
 
-/*  */
-/*	Description: */
-/*		Handler function of LED Blinking. */
-/*  */
 void blink_handler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
-- 
2.19.1

