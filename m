Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8679C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF0A20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az9vUDla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF0A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeIDAVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:21:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbeIDAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:21:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so1666305wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ok/Peh1PK2pzieWZ5HNx9TVIGxCBK2ROcW/7y3aSHcs=;
        b=Az9vUDlaXxQgJlOZbOmX8/P3LOw4O5pP5RWjbXa8os7NIAemdgMEsiVCYWo8g5WG8N
         MGEpjfzNAXZG3uDRAACJ+ngD87GmVyNAdwoDP+9UQ2GEQfvppTqJ7ST70yLEYqh7xjlu
         LyCIoF5j0tcOS3mG586gUdagG/WZ+aJndLhZphirvu41W7MlJQX7wJqRbRMLDGPYG8da
         GlrXivBJxKbJpJIGLL3HW7+ujIr+7H3kTw4Awe2wAaWGy1Gf6cd2kqY55OuSkRHni6Ov
         sQCW9vr7QKBTPhp8/DX57lQhFHx5YcYz0yNlvzsEGk/oxx4+yG3Hap2jb4JdjyeKU06N
         r3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ok/Peh1PK2pzieWZ5HNx9TVIGxCBK2ROcW/7y3aSHcs=;
        b=MnC45EhzV/Lk7nvjm11U6ub6jEdHpwq+uqYjzYIvZTPTmIQ/g73qJPClVrHhcJ//iL
         1SxQ+9WHjljGzfJHXf5BE1MhwVy5E+pMFHNto0eyLhLyPCRQuTdD/4fCP37Z7y83lqVX
         uS6LGhNUIRAO8wXDQ2pi6AKvvSDsWfrqSSnZRbWGNDyFWacfdEhOpJJ1jXQJ3e+rQR5O
         jBwmVj2z9m+Tu0AoPuxw6gjWHg6Y1mCNVo0THdkppPlJe13DZvrCywQNlTjsB6rrjLr9
         PBpjBpFm7GnAB5J3Ux0DTziL4zlPBury7xGf94hT/BVzhcyrL3Zv2fLOP6a7CawEIL8k
         hNMA==
X-Gm-Message-State: APzg51A9pD1Pwj1wNtwsAuF+tZ/PsKcZEIGLslT/vKLEY/js37u+eZQw
        ktdU2+wzsoWS0V+9X62UNwk=
X-Google-Smtp-Source: ANB0Vda5vRYUn78RQCFOgiMlrXsg1oRytIpi/2yA3kJWflXFvm10vsgJ0DDRRtQmar6kuROMfR+lHw==
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr21484372wrc.125.1536004771058;
        Mon, 03 Sep 2018 12:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id r6-v6sm13422648wrt.92.2018.09.03.12.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:59:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: simplify function comment
Date:   Mon,  3 Sep 2018 21:59:18 +0200
Message-Id: <20180903195918.9554-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify function comment to a single line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 9d567838a43a..48738f94cf88 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -768,22 +768,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 	return rate_bitmap;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	odm_RefreshRateAdaptiveMask()
- *
- * Overview:	Update rate table mask according to rssi
- *
- * Input:		NONE
- *
- * Output:		NONE
- *
- * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/27/2009	hpfan	Create Version 0.
- *
- *---------------------------------------------------------------------------*/
+/* Update rate table mask according to rssi */
 void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
 {
 	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
-- 
2.18.0

