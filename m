Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D91C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC4E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YipjvyLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIDPlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:41:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53502 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeIDPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:41:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so3988400wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tbN7wH2EKKOWD1nd831HhK0ptYqfYp1AmYx/G0O0hps=;
        b=YipjvyLo+LLWiaOcmeYA1KajpHdAH1e86FogCvghIbCiPGj9d/zxmq7LeVEIFBalPo
         6e+fXTF33iYsErHMOJoQbbJrpdbmbJv5dpL88klY+eZI324yQ1nAYRQQ88TCdoN+JXtB
         mtwyxw2POmW095gvGwbkDa45GgQRhvaqbCwzfTegduh2BfPUgr/WADp65+78dJn5hUlX
         QMTnlDTnQcmYvT4t6SN6PipsH8phfPdcGsMjY/GmQHVrwz2xvQ8Arj12miid9CnlaZDx
         uugBAZ9IL4ZVAVVoV3AOyruu2Lh1H4hmPXxxOh5J0UUpxu86fjwZDTrYJNZO8wBGzA9O
         at5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tbN7wH2EKKOWD1nd831HhK0ptYqfYp1AmYx/G0O0hps=;
        b=ISYfVit/cxNsUsUlsOOAu7bxz8Z6TiO6y4SMu2ME3TIa2Z365CeRBCKKi3FBAeNqcN
         mK07WPXwKXL5O5g45jekMaQYxle8VgVON6yaEwH9nzw6i+jCR6o38ltx0iAHqKdYzFck
         XxlzpQuyMyO3ugMpm1Zp+8Ewtcg57EbjtgbBBSpfCmbmixTP1KbSAGecZnNRudTQmVAZ
         D9bleF9bDZxJcLxzCTnssqjhnmOw6HZ4+imT/ctw8hBxaCWPS6SkN/3lZlP1Fkrnlc18
         /p0HSsc5tTpU71OGUrqIo+0Q5okVFlbc5GpZoVqbdHzCUBmwxEf4V+SJnLo8g8zLnO8E
         p91g==
X-Gm-Message-State: APzg51BFZGNwj4CC4lKTsPgV8SDb7q/nmIgHaDGyxsc0fyw41uftcH5D
        v0bj/TAkQvnBXUhVYEY5NvA=
X-Google-Smtp-Source: ANB0VdYBffq7/rxGJcBOQE21r3pwVD0AO6baqmwmWkvC6t6Qb5kt/V8jHTEi1sjSWZ8E72o6tVMkDw==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr2386513wmz.79.1536059788623;
        Tue, 04 Sep 2018 04:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id x125-v6sm16688436wmg.27.2018.09.04.04.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 04:16:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: remove empty if statement in rtw_led.c
Date:   Tue,  4 Sep 2018 13:16:15 +0200
Message-Id: <20180904111616.18508-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty if statement from 'if - else if' and replace the
else if with if. Remove the now unused variable pmlmepriv.
Also clears line over 80 characters and CamelCase checkpatch
issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index cbef871a7679..39904ab284fd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -239,7 +239,6 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 {
 	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
@@ -290,9 +289,7 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
-		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
-			;
-		} else if (!pLed->bLedScanBlinkInProgress) {
+		if (!pLed->bLedScanBlinkInProgress) {
 			if (IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-- 
2.18.0

