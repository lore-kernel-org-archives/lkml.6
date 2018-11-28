Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F3C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276BE20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3w9PtP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276BE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeK2Ebn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39096 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeK2Ebl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so19189208wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3Bc4FzuE8QpBn/FUOCFcxLPlCCJ5+XJNbK9qBYmXQA=;
        b=e3w9PtP5uFUINEzYttDHeQuVAa7aZwTrTDB7bl5w7fRKv1YAyOyncqwJTznfqNHK6+
         DuTyeYkY3sVl0BkkrCckdSOFiF/MbVGZ4yeWJ60LZFIVhtMWHt0JCGpleOOCtgrpsTi7
         QPWZKFhbIDcjiRYEvdon7No1RltlTWQ04IztDxnZyriUuCauywBM9c23UUNj6VB5IVTU
         BfyrMHylMWU0LfB0hqCT0zUqxf8gBxNO5mdpa3unmDEdF+jMn7LyX0QYNnRgLcKPClMi
         TIKwMU+wNSs+QiWgxy5INPGtylVCnQS850x9E6NnSKiz+l1/psgmsaqClTLs77XptrAp
         5ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3Bc4FzuE8QpBn/FUOCFcxLPlCCJ5+XJNbK9qBYmXQA=;
        b=WX2aCO1irH4DKFScJJFncbYKzTsOqINByRdxfWIcA7g35hDqileqrMVaszx7qGH9NI
         DaKiM3gSSfkJzlynVXFsAx8BCzIU9dYyQPDojhVQxIq+l0q8pBFl/9Ad+W3n+e32z7t/
         oplURI/6O3JdMHsFo9EEEagc83mjuhbChip5zV+T2z3ZnUAcgj1t64tsuWr2oa/J/QP7
         PH/kHCgz3ZW4U/lbyEWWyb79hfedKjWyQOIMV0Ku40hqCxsEW7d8j3wyE5vWDn9bfYFg
         HtyH21pqqFHcKvkWMT2mL/P1vdiZXWTVGXmuVPKSlURRmdkm7t8lfTiXDXaGCVVr4sqU
         cNgw==
X-Gm-Message-State: AA+aEWZSPFByVJqLsE5mKao47fqkfw4UQlF+u6NwGqIUzgMXEDt07v5v
        HNCHLmFgi15VgnTl6uQ7csk=
X-Google-Smtp-Source: AFSGD/VDOl9+Jh7Fh//XmasEN+bmH+2WzYeWQlx/JDjiF28RJbnL3CCiFUml1mc6PVivrfTeZR+1Xg==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr33363701wro.78.1543426157641;
        Wed, 28 Nov 2018 09:29:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: rtl8188eu: remove parentheses in hal8188e_rate_adaptive.c
Date:   Wed, 28 Nov 2018 18:29:02 +0100
Message-Id: <20181128172906.1694-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index 02f423accee8..79e13d076553 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -554,7 +554,7 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	u8 max_rate_idx = 0x13; /* MCS7 */
 
 	if (dm_odm->pWirelessMode)
-		WirelessMode = *(dm_odm->pWirelessMode);
+		WirelessMode = *dm_odm->pWirelessMode;
 
 	if (WirelessMode != 0xFF) {
 		if (WirelessMode & ODM_WM_N24G)
@@ -661,7 +661,7 @@ void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rate
 		     ("macid =%d RateID = 0x%x RateMask = 0x%x SGIEnable =%d\n",
 		     macid, RateID, RateMask, SGIEnable));
 
-	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RateID = RateID;
 	pRaInfo->RateMask = RateMask;
 	pRaInfo->SGIEnable = SGIEnable;
@@ -677,7 +677,7 @@ void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
 	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
 		     (" macid =%d Rssi =%d\n", macid, Rssi));
 
-	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo = &dm_odm->RAInfo[macid];
 	pRaInfo->RssiStaRA = Rssi;
 }
 
@@ -711,7 +711,7 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 		else
 			valid = (1 << MacId) & macid_entry0;
 
-		pRAInfo = &(dm_odm->RAInfo[MacId]);
+		pRAInfo = &dm_odm->RAInfo[MacId];
 		if (valid) {
 			pRAInfo->RTY[0] = (u16)GET_TX_REPORT_TYPE1_RERTY_0(pBuffer);
 			pRAInfo->RTY[1] = (u16)GET_TX_REPORT_TYPE1_RERTY_1(pBuffer);
-- 
2.19.2

