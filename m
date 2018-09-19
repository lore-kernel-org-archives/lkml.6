Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0261BECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E6C206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIUzMlFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbeITCTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:19:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37402 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:19:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so7137539wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnqDFZYKYD346w+GGwXS3wJdkJYgXsgs4Sf5jYBcy3M=;
        b=tIUzMlFMaQ//5p15AI4P48R8tgSS1b8JH1wvkHBUWeV60BzzEoKo91xg2xUrDyzK0k
         N4wvYW4H49uYi9fLr/fHOVKE9JBmMHjtoxdKQvYKcSBATF1NJ6n1RIe+1tuLahSBSrMK
         N/uSjy1oYrO0tPzVOJuC8/356aRYiNKqgCAVfo/WeUD0TKoaJC4LyzbMuy9HGAiiuw+S
         LM2jMK6O/jMbFrUEnw7I81sH6Bm2QDVqB9myiNF9O4hqzp8sFFXGwYllEtNe9o6/J9Zn
         bEP/vZsKuUP6huDGel+x/O0IXpEWThBXwkQy8sTf0n88HLnz3q3qgrrfkLRCztmk3+Ew
         dBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnqDFZYKYD346w+GGwXS3wJdkJYgXsgs4Sf5jYBcy3M=;
        b=l+duX8f6sFlIxyjjM2zhuy20k+KureshwaeF4S3fX1/MA2IpQsaqiOfsrxKak6aG+t
         YZJSSLNtlcTml5yp3H9ESrLeDXUbY8rsZFPtOfvPTHxGZmMFZ2vG+/9Xgk4dUIXCPyuT
         B3rrcfbFf39Rm54QUZxfuV3BcMO/GK+PwVy+sOUnaF3CSVxQYN3UdJ25n9pBqDBE23SN
         VDY0ae+ADq/rSCXJJbPYqP+qn4+lmhV/gmadYItLhDKwnLKbY08End6EtuPVLa6r/mzN
         /muLvE2OKDwx7mVueAEFL/evwlL41L/mrNdoz2hm8xbiqesLdTTlwK+/Vg3JZYBaFOMu
         bSYQ==
X-Gm-Message-State: APzg51Al6/pNLwm7VYOMVsVKVwod2gPCdRa8jZLKEsg9rfrKe2YGDRnM
        Hx/T4/ofZJwoiHmlPSBHYac=
X-Google-Smtp-Source: ANB0VdYKsND3qxkiOEDpYWNy7Y5779CLY+MunJPqAXdIRsI86ia8M+ZjnO6rgV02UfhBccD4el256A==
X-Received: by 2002:adf:ef89:: with SMTP id d9-v6mr30656497wro.195.1537389616633;
        Wed, 19 Sep 2018 13:40:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b10-v6sm18013637wrr.88.2018.09.19.13.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: change return type of Hal_GetChnlGroup88E()
Date:   Wed, 19 Sep 2018 22:39:59 +0200
Message-Id: <20180919204001.2358-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919204001.2358-1-straube.linux@gmail.com>
References: <20180919204001.2358-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of code valid only for 5 GHz the function
Hal_GetChnlGroup88E returns always true.

Change the return type to void and remove the variable bIn24G.

Remove the tests for the return value and the variable bIn24G
from the only user Hal_ReadTxPowerInfo88E().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c | 31 +++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 69693126e102..72266caa2d7c 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -378,10 +378,8 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
+static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 {
-	u8 bIn24G = true;
-
 	if (chnl < 3)			/*  Channel 1-2 */
 		*pGroup = 0;
 	else if (chnl < 6)		/*  Channel 3-5 */
@@ -394,8 +392,6 @@ static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 		*pGroup = 4;
 	else if (chnl == 14)		/*  Channel 14 */
 		*pGroup = 5;
-
-	return bIn24G;
 }
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
@@ -427,7 +423,7 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	struct hal_data_8188e *pHalData = padapter->HalData;
 	struct txpowerinfo24g pwrInfo24G;
 	u8 ch, group;
-	u8 bIn24G, TxCount;
+	u8 TxCount;
 
 	Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
 
@@ -435,19 +431,16 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 		pHalData->bTXPowerDataReadFromEEPORM = true;
 
 	for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
-		bIn24G = Hal_GetChnlGroup88E(ch, &group);
-		if (bIn24G) {
-			pHalData->Index24G_CCK_Base[0][ch] = pwrInfo24G.IndexCCK_Base[0][group];
-			if (ch == 14)
-				pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][4];
-			else
-				pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][group];
-		}
-		if (bIn24G) {
-			DBG_88E("======= Path %d, Channel %d =======\n", 0, ch);
-			DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_CCK_Base[0][ch]);
-			DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_BW40_Base[0][ch]);
-		}
+		Hal_GetChnlGroup88E(ch, &group);
+		pHalData->Index24G_CCK_Base[0][ch] = pwrInfo24G.IndexCCK_Base[0][group];
+		if (ch == 14)
+			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][4];
+		else
+			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][group];
+
+		DBG_88E("======= Path %d, Channel %d =======\n", 0, ch);
+		DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_CCK_Base[0][ch]);
+		DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", 0, ch, pHalData->Index24G_BW40_Base[0][ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 		pHalData->CCK_24G_Diff[0][TxCount] = pwrInfo24G.CCK_Diff[0][TxCount];
-- 
2.19.0

