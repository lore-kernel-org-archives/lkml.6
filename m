Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFC520658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI6IwRr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFC520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeIEXPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:15:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIEXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:15:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so8688677wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JnAsvqSdvzsIxxfGbn65MNHlozSkYN33fnQ5pp9PGMQ=;
        b=iI6IwRr5q9TYEXN5x6zAuo0pNXS9z+768EHvYnprPsiHh+e7t73UT8S3V5DjPebYO1
         yidSLPeEdFHr+KQOoirLAu17i316Fw9Gb58oRbHrqGaP+1CE78im+TGeOgKdiK7uNTsc
         WBr9IDPFJuNyNQ74JKCylW9cKXbr7N2WrYcZ6L3eFktXkkHxm98qkm38+nWRiAo7+AZB
         CbOCZbaU2R8BHcn1oRjHkLkTzCJuIvYHp0rtmINhNJqnARPXGJcxMHFaSn5rEnskv2aK
         /L7I/KqUe40D/hCvLsXR9pNLcqrOAnUlbPZUK+BOxTIyu1AHVKsWoobOFgw25NFG1C3e
         lhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JnAsvqSdvzsIxxfGbn65MNHlozSkYN33fnQ5pp9PGMQ=;
        b=mvqfLlsAqzhuEQYCTYUNK1YRIPk9cGDomqpPjkFdcHsOtpUdnOetztGMNIA4LCiVt9
         fMGQV7MGvMQzYrHru17V6O6iepJrsE/aqg7Gu9ZlTOGCElIM7ndrUvMnF8Iy3G3WWvrh
         iAXuwgveYujHXDkXPFrNApV6GidYwkKEv5ls7biV5xNo1gUHByNFzs0zOw1NaxJmkdQ6
         s4ttnuISELk5yScCcHvVTGdrjsQc0/HdLqG0mNpZOwUsaDlVSOVyIEC03akYIx0Bjrfo
         0YRHal8DzV8tSiaGO4C9yyabmF96bAZUi2zV8OfhJcw6zqHF7TwzwHOr8sjpnyMAaUyZ
         sHtA==
X-Gm-Message-State: APzg51AejcWdotUAYKssYVSEytQQSG+fw1XgnWOvDQW/K0Cg87pLeq92
        Db/s4O0ySZ7YMKS4+ItrDiqYKul5
X-Google-Smtp-Source: ANB0VdacVzNaN/1h6lCqaxlFWCmnR+9zsvUjG6UDQd+Fl7t1XNiSevzOzL7tysBdXvNntIrIjyZ4Og==
X-Received: by 2002:a5d:4d52:: with SMTP id a18-v6mr27568230wru.40.1536173060057;
        Wed, 05 Sep 2018 11:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id 144-v6sm4227857wma.19.2018.09.05.11.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:44:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8188eu: remove empty if statement in rtw_led.c
Date:   Wed,  5 Sep 2018 20:44:07 +0200
Message-Id: <20180905184408.31175-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove emtpy if statement from 'if - else if' by moving
all conditions into a single if. Also clears a line over
80 characters checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: changed patch 1/2 that was wrong.

 drivers/staging/rtl8188eu/core/rtw_led.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index cbef871a7679..a4d10fc5d3bb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -290,9 +290,9 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
-		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
-			;
-		} else if (!pLed->bLedScanBlinkInProgress) {
+		if ((!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
+		     !check_fwstate(pmlmepriv, _FW_LINKED)) &&
+		    !pLed->bLedScanBlinkInProgress) {
 			if (IS_LED_WPS_BLINKING(pLed))
 				return;
 			if (pLed->bLedNoLinkBlinkInProgress) {
-- 
2.18.0

