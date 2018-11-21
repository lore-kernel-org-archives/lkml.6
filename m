Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2357C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4443214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXVIi+iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4443214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbeKVGZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:25:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53685 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:25:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so3485625wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBWWeHiL1hiZOkiIMmwGmqroxFUi+Pag7aWWzF3j+sI=;
        b=YXVIi+iWSHydBL+3iyw4haaoE+cu9nGXoha4VpyDwyyVQsOhMz6rGE8BtyxFcY15Mm
         b/n7UFetP/27qWlP34FliS8bm6v2mx2cybcFP72KUpy/JzGNSEd5B2uzOunsb6xv/dsH
         ooyYM3TKVvbvNsr324flXMxhVxznHDsctPwwPruM/ratTsgJnwu2Wwh+YTBlJ3Aod8zG
         h0IAlEQSmtbgLqLlWY5YAvBPRTxRpOjRimAL/AVXFL1sYlyAkva5uuVPOq+PCLbkFfZh
         qgNdMQ3R12WA3aOLfgeJZXQCj3yxL8MWqIWigG9Ng4rby1wOIA7RGeD++XvFGBSoir2o
         yZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JBWWeHiL1hiZOkiIMmwGmqroxFUi+Pag7aWWzF3j+sI=;
        b=I+IrOVGS9kOFLTt8odC6ZdbvMMJRyVj8h3ITZFGIVOI/nNGR0iLTuGlhO9v/CvPP9/
         U75mgvKxbOdMu1Y7fTafa+dgHUzwoYOJvcCyWNGP39M84ZQWwS9HkiKkCD/SdAYfvgAP
         p2o57QSbwbXnCq6hltRIbj830TRBg3RY9Vv0h+NLErZWaKx+HQAEsl5rNh3rPDA6gDtk
         B+ZjQzTjAvaH4mtNjPWfzlhZ0eenUJ52NsvJ4a9cVtuUqSAxxS+Bv5rH4OFubA80GgMl
         lMqjB/FCEK+bfn6OzJYUmxjREZRSrpvOdYakcje1jkcsO9CcVtJT20NegxOtGkrubj+S
         wq0g==
X-Gm-Message-State: AGRZ1gImhw6BeTSNX7v/6tjjd6MZbv1sMegBsAcjNsQPnlcjAeJbBCqp
        n9rh6UJD5lJfRywWY7FaqeD7aRo9AkA=
X-Google-Smtp-Source: AJdET5fdE8+Y2flQeDBYLNIlPop/220Ci0N/SjEasOn3Pv02BDgOaGUsOtzP7rGM6SedFINwYai3TA==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr7185335wmd.141.1542829801136;
        Wed, 21 Nov 2018 11:50:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id j20sm30599wme.20.2018.11.21.11.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:50:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/10] staging: rtl8188eu: remove unnecessary parentheses in rtl8188eu_led.c
Date:   Wed, 21 Nov 2018 20:49:28 +0100
Message-Id: <20181121194937.1852-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
index 412b76271a3d..411649a0b070 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
@@ -54,16 +54,16 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 /*		Initialize all LED_871x objects. */
 void rtw_hal_sw_led_init(struct adapter *padapter)
 {
-	struct led_priv *pledpriv = &(padapter->ledpriv);
+	struct led_priv *pledpriv = &padapter->ledpriv;
 
-	InitLed871x(padapter, &(pledpriv->SwLed0));
+	InitLed871x(padapter, &pledpriv->SwLed0);
 }
 
 /*	Description: */
 /*		DeInitialize all LED_819xUsb objects. */
 void rtw_hal_sw_led_deinit(struct adapter *padapter)
 {
-	struct led_priv	*ledpriv = &(padapter->ledpriv);
+	struct led_priv *ledpriv = &padapter->ledpriv;
 
-	DeInitLed871x(&(ledpriv->SwLed0));
+	DeInitLed871x(&ledpriv->SwLed0);
 }
-- 
2.19.1

