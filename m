Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A70C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31A020645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/A8Lx+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31A020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeK2Ebo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeK2Ebn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so4492989wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syII6Je4YYG6Fqp2wHfOY5DV0b+O7+sPug04wRvJhWg=;
        b=L/A8Lx+oi9ttpGAofJs0sc6yq7MmM6NytHBuU6ImPreXPjV3KNrhGFaUGKbxTXJmkz
         E9T11a3MvbLhn6GrxWqircFNZ46Jta8FhEnRWpwPSt3n4AMesb2L2m6SQSO9kM4V2pYk
         j/PhMFwolC8EPk4FhqSMVXIN4ug1JohMvW6U2yUqjhu8XBjjnzWC2hhH62gzoXULlbYW
         TGDPgZ1khkrCiGPXoacBhGxekG+BjnqdGNmqzM24AnvulN5aFfBw3NwWkZKoFh111uc6
         AOT+ictoUyl8bPEAY6Q2z4LGd6M+FZT5gkKpWQldi1c+nTNn9pF4ond0kBDUYmQ5T6Hy
         Jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syII6Je4YYG6Fqp2wHfOY5DV0b+O7+sPug04wRvJhWg=;
        b=P1vWS+a9/9Q72K/VrpnbYnZIn3Fmi9ObZs+jaJ3TFrZOn4H54Ax2PUSzwPmlPVxIYu
         1n5sdr7KSVjC5wGHj/b+ProzL5q1eeJiBhlhvFk2jCS+XiWFqNy95TZll/ks99MqHfoP
         aDXumYb91KDIAyryhTfEjchfpKHThcCiiZgRvpcZZyMYGTaI20vtBgfz8DOnf1SZJ/OG
         W1+K/1saT4HOFDN4ppYVggCsn5Nhzav0VXfD3rizCdnO8CbqUTvc6sVzMyxowQy8t1SP
         vCRiMDYIwTj343dmhJv1RuhmjPZ/SNZd7XDBaegUd/qDag+ag9AOicEVCys7Vl/Brzht
         9C8A==
X-Gm-Message-State: AA+aEWZR4Z7uNh8C1vf4EScHBhhHfXn2dWpyM5McPslWTYL1llzE3qS1
        +dSV7dlZoyzICEzqub5MLFM=
X-Google-Smtp-Source: AFSGD/XWCH92QefmXMuS+nGfxfx6evmaZVyVXyrHh44YZu1bVram9H3Yr8Vbuj/GT9Wi/eJubSJm+Q==
X-Received: by 2002:a1c:2854:: with SMTP id o81mr3311585wmo.131.1543426159520;
        Wed, 28 Nov 2018 09:29:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: cleanup lines ending with '('
Date:   Wed, 28 Nov 2018 18:29:04 +0100
Message-Id: <20181128172906.1694-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup lines ending with '(' in hal8188e_rate_adaptive.c.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index ccd7bb24302b..c6f6594feaa2 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -92,11 +92,8 @@ static u16 DynamicTxRPTTiming[6] = {
 
 /*  End Rate adaptive parameters */
 
-static void odm_SetTxRPTTiming_8188E(
-		struct odm_dm_struct *dm_odm,
-		struct odm_ra_info *pRaInfo,
-		u8 extend
-	)
+static void odm_SetTxRPTTiming_8188E(struct odm_dm_struct *dm_odm,
+				     struct odm_ra_info *pRaInfo, u8 extend)
 {
 	u8 idx = 0;
 
@@ -184,10 +181,8 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
 	return 0;
 }
 
-static int odm_RateUp_8188E(
-		struct odm_dm_struct *dm_odm,
-		struct odm_ra_info *pRaInfo
-	)
+static int odm_RateUp_8188E(struct odm_dm_struct *dm_odm,
+			    struct odm_ra_info *pRaInfo)
 {
 	u8 RateID, HighestRate;
 	u8 i;
@@ -532,11 +527,8 @@ static void odm_PTDecision_8188E(struct odm_ra_info *pRaInfo)
 	pRaInfo->PTStage = temp_stage;
 }
 
-static void
-odm_RATxRPTTimerSetting(
-		struct odm_dm_struct *dm_odm,
-		u16 minRptTime
-)
+static void odm_RATxRPTTimerSetting(struct odm_dm_struct *dm_odm,
+				    u16 minRptTime)
 {
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
 		     (" =====>%s()\n", __func__));
-- 
2.19.2

