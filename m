Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7764DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301152075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9aQm7vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301152075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeIDPlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:41:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33444 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeIDPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:41:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so3572157wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZTiYd+aKENvsOkP6N1gekSU/YX4TYwi8wrvvXR6O0E=;
        b=A9aQm7vUkqtT650WP+ANF1KWOHyGaLJN7rOu10jltMhTo9llgDr9d9GRlPJ8/4DMcK
         kJ315vqCM6rT7BAejjvm59typPMsNMai5nK+IwFNqAXBEuxfoOOHJhGPjz7pAc3TRKrK
         UPnI5QNl7+XCkKKWxmtKLqNTZmOHzVxeUJG3OsI0dAQCwuzHl+rRh6u55Z2umS74hdwI
         lA5XzWGJvejP/yGeaVbeR5l+v3cqzA92NeNlHOYzhnwVBcU+5AvOA6xLI8Czo5faNx2m
         5rPdtnPpfWTh9X9RfAtFmY29tFyKES1R9wWj6+LIRHOLeGd3rfXuZE77NzCYsehyVHLn
         bysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PZTiYd+aKENvsOkP6N1gekSU/YX4TYwi8wrvvXR6O0E=;
        b=PMj3Zlz9uYyMO14jKz4WjOhD1MqxCREbas2F497Wvw9+r0ZTLzawInBAKhRXD5N9rI
         5xqYfVwLXEIzZSjuAyzmbMMvErd96ZarFcN2RNd5JurTP6Dui8nJkVAVy+xkJtrDtTm2
         vK8Pi13zxa9zQbdL8OcRC6mo8omFNy06TSr3aFWre4d9cvbAA2rm+zvQmZImmzfmsdbJ
         3/3w9nD8/6OAVdRbSHhmhMiH7lJs7KY2ocq8mraygHXJXO6xY5foTBwpMzNmARdkAHJr
         0eGO5m7uPiCdRy4KxG3Bu8XiMgkYxyTSnQcY8Ni9vz8q+ieSfMNLFCCH35+oeugoyki5
         6MjQ==
X-Gm-Message-State: APzg51CoXbOd8R8s4Bk0/1PZzOGmI/lVnzZLOmqYfOZDahdFUdco+ii2
        LGcaKZeQpElY2WJ94Et43sk=
X-Google-Smtp-Source: ANB0VdZeokxialpkfig6sys1nV0/QOxvRihamLagVJN8a4h5m/1BRMfRaO7HPVibYFOPIATlx9N6lQ==
X-Received: by 2002:adf:8b50:: with SMTP id v16-v6mr22762860wra.282.1536059790439;
        Tue, 04 Sep 2018 04:16:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id x125-v6sm16688436wmg.27.2018.09.04.04.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 04:16:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unnecessary parentheses in rtw_led.c
Date:   Tue,  4 Sep 2018 13:16:16 +0200
Message-Id: <20180904111616.18508-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904111616.18508-1-straube.linux@gmail.com>
References: <20180904111616.18508-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses from conditionals.
Also clears 'Alignment should match open parenthesis'
checkpatch issue.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index 39904ab284fd..548b21196fc9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -18,7 +18,7 @@ static void BlinkTimerCallback(struct timer_list *t)
 	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
 	struct adapter *padapter = pLed->padapter;
 
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 
 	schedule_work(&pLed->BlinkWorkItem);
@@ -454,7 +454,7 @@ void BlinkHandler(struct LED_871x *pLed)
 {
 	struct adapter *padapter = pLed->padapter;
 
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 
 	SwLedBlink1(pLed);
@@ -462,8 +462,8 @@ void BlinkHandler(struct LED_871x *pLed)
 
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	if ((padapter->bSurpriseRemoved) || (padapter->bDriverStopped) ||
-	   (!padapter->hw_init_completed))
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
+	    !padapter->hw_init_completed)
 		return;
 
 	if ((padapter->pwrctrlpriv.rf_pwrstate != rf_on &&
-- 
2.18.0

