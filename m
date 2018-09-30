Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10FC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B1E2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0z30b3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B1E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeJAC2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:28:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45033 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbeJAC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so4239604wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZ5pvrkX/GuhDtt7b+6bgd4qKJzDccvgl9mpa13GPdw=;
        b=j0z30b3ZiwRtHkBjN/u6T7lfnF+ye9d36I2PdYiULMzcdzo33XKJNub2/mJDDeQ/gu
         qR2uBT6q2AVD2VsLHH320ipugX+ccIfmp1AE4OxmRiqYXFyUFNLYdsuntJGbUx81bpp9
         ontxSqqdZOcUXXxnMJ3c5PXtPN+w49s6zMvF4eK18hSDkt/E3dvIx9rgJekAdq5vR8a3
         67aVTriix2SjfkTp+DqD/FLfJ2sprMPTkM1MfoJeljFg+gXdeCsuB6zYVXWYnxK0+yxr
         110t3ZWOWxWnPG1OIsK3UldgnvYmY7vC7hC/G4j+l5qFVKrKOsfGfAk1/FOHjGptz+ZS
         7kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZ5pvrkX/GuhDtt7b+6bgd4qKJzDccvgl9mpa13GPdw=;
        b=HwP2GMti+yNCAHfPKQ+kzbN0tMlNlBUGCb9UtUiUZ5vTGlQ1tSjkjaGaF8mKh+2E83
         speldgA6l0jDi2fM7TTAi52hBwYpXYm98TVvHScoGlJSIJ0t18XauqEzKvW0ICmNKiax
         N2NP8YYn2yvL9QkZj/e7jNzmCCdQPsW40+fLTnuOmc1vkyxKrNUQx/NfCvF+Jbn3B8Q3
         idYOy6Hc5rxA1nkL+HrAW1pHaAxFV7xiq6tQglaceMbvrj3C77v8EfDG0XhHpe4bw0We
         eQs26FjkmEjZOKa2XBD3SVxrtkqIfVOatjqlgDK1FxsZY1Rp0RyagwuFYR4ZwkgCOQx5
         mJvQ==
X-Gm-Message-State: ABuFfoic27JC509Ytp5THOvwJFSaiSlAhJrt6I/urkNe4TDmp5/BWjzA
        0qSLAW+VLvqvAJRBuz+A4YA=
X-Google-Smtp-Source: ACcGV62mo8rO79+/Sc8TAUSxnlNGFzrKqtpGWkK6/aIuGH5d/439hHYdp4RZI1/oW+ELiOacF7FCCw==
X-Received: by 2002:a5d:6608:: with SMTP id n8-v6mr5127462wru.281.1538337211660;
        Sun, 30 Sep 2018 12:53:31 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/19] staging: rtl8188eu: rename variable in odm_SignalScaleMapping()
Date:   Sun, 30 Sep 2018 21:53:03 +0200
Message-Id: <20180930195310.1531-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable in odm_SignalScaleMapping() to avoid CamelCase.
RetSig -> retsig

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 25a6531ddf02..498785d32a0b 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -28,26 +28,26 @@ static u8 odm_query_rxpwrpercentage(s8 antpower)
 /*  IF other SW team do not support the feature, remove this section.?? */
 static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 currsig)
 {
-	s32 RetSig = 0;
+	s32 retsig = 0;
 
 	if (currsig >= 51 && currsig <= 100)
-		RetSig = 100;
+		retsig = 100;
 	else if (currsig >= 41 && currsig <= 50)
-		RetSig = 80 + ((currsig - 40) * 2);
+		retsig = 80 + ((currsig - 40) * 2);
 	else if (currsig >= 31 && currsig <= 40)
-		RetSig = 66 + (currsig - 30);
+		retsig = 66 + (currsig - 30);
 	else if (currsig >= 21 && currsig <= 30)
-		RetSig = 54 + (currsig - 20);
+		retsig = 54 + (currsig - 20);
 	else if (currsig >= 10 && currsig <= 20)
-		RetSig = 42 + (((currsig - 10) * 2) / 3);
+		retsig = 42 + (((currsig - 10) * 2) / 3);
 	else if (currsig >= 5 && currsig <= 9)
-		RetSig = 22 + (((currsig - 5) * 3) / 2);
+		retsig = 22 + (((currsig - 5) * 3) / 2);
 	else if (currsig >= 1 && currsig <= 4)
-		RetSig = 6 + (((currsig - 1) * 3) / 2);
+		retsig = 6 + (((currsig - 1) * 3) / 2);
 	else
-		RetSig = currsig;
+		retsig = currsig;
 
-	return RetSig;
+	return retsig;
 }
 
 static u8 odm_evm_db_to_percentage(s8 value)
-- 
2.19.0

