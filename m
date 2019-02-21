Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694B320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG2NnpXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfBULwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:52:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfBULvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:51:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so29787828wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HK8QbCIFy5aDnSVrVdT4WnOO19dxv5nTcs4f7aY3fDI=;
        b=bG2NnpXX0hO+BDBi1iV3RNyBl7w3e6uHme1uZqRj7g5+zb2utfAK7IYpHN2diMZTW7
         9GLyNmSFR/2Wo6aZYXK0pFeixBlyc51yFLcnVh33uhiQY6xEs9xmwseY4at9TzHkAFck
         RaHWRi0F/jhbedx+IPQP32wON5AvmRBYgyMDyoipe9GMzu3XKh7VxIta4GH6hgb52yh+
         Y0++H4e1zGfF6jhUkCjCo0CAzx4qK5kK4H00lZamnZbqTK4Gh0Ic/JWa5C1lQrzCPIbz
         LlwshSYvoSMDvy1CB7ZCdQapuM7tWf6rfYr/rwL9jjfmd7MfeXgT1Egf9rrEc+AIlY9Y
         tptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HK8QbCIFy5aDnSVrVdT4WnOO19dxv5nTcs4f7aY3fDI=;
        b=cRAcSOHIm/l57SnQGhglaSXMAHk3tDUFgyCJpYgtBXsFpWkdX8TARkvZBO9XdTGrGC
         eMwOjyMFsYvbY4H+7CshvRLN4Zl3lT0J9r6WVggiAfTKYW2z4hkBq7JRqZNruVn7ilfz
         +dbBfRWdXn7c89y/R8zVU9niZrQoaOnkPhf4r3JP665jhcx0apW13bvIuKoUjbjT//J6
         mpC1NUr6YQ3iyhkW0zRn9R9arcEzbbCTkys4jCEqguxpWfSEOQw0GjhLGfQzLbSdE9Qu
         6o+wbhqDGdp7DvLpiEuIIbiq73cpooRPoOl98r3PzBJTk8vJTiIJFuaZADpJhe4rmCvE
         /6DQ==
X-Gm-Message-State: AHQUAuZeDmPbLMtWsW8yKqaxU3/hzyAYLv3bdvOSyUa22PukyDK2PT5k
        Jzzm+GFlUTe2P9yaBIrK4Z0=
X-Google-Smtp-Source: AHgI3IaRDYRD6FGXpaLTc5yIDUslsIutZBUadaIXpwRpRwRz2vCkx4Dd1vOdoRgnPDmpmNPuNQpfmQ==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr31384034wrp.227.1550749899266;
        Thu, 21 Feb 2019 03:51:39 -0800 (PST)
Received: from localhost.localdomain (ip5f5abba0.dynamic.kabel-deutschland.de. [95.90.187.160])
        by smtp.gmail.com with ESMTPSA id j5sm15092849wrw.59.2019.02.21.03.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:51:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: remove unused function declarations
Date:   Thu, 21 Feb 2019 12:50:55 +0100
Message-Id: <20190221115057.31207-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115057.31207-1-straube.linux@gmail.com>
References: <20190221115057.31207-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no definitions of odm_DIGbyRSSI_LPS(), ODM_PhyStatusQuery()
and ODM_MacStatusQuery() in the driver code. So remove the unused
declarations from the headers odm.h and odm_hwconfig.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/odm.h          | 1 -
 drivers/staging/rtl8188eu/include/odm_hwconfig.h | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/odm.h b/drivers/staging/rtl8188eu/include/odm.h
index 947481de9cb1..8245cea2feef 100644
--- a/drivers/staging/rtl8188eu/include/odm.h
+++ b/drivers/staging/rtl8188eu/include/odm.h
@@ -1045,7 +1045,6 @@ extern	u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8];
 
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal);
 void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
-void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm);
 void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres);
 bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI,
 		      bool bForceUpdate, u8 *pRATRState);
diff --git a/drivers/staging/rtl8188eu/include/odm_hwconfig.h b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
index 8cef32dc6350..2cd8a47a3673 100644
--- a/drivers/staging/rtl8188eu/include/odm_hwconfig.h
+++ b/drivers/staging/rtl8188eu/include/odm_hwconfig.h
@@ -93,18 +93,9 @@ struct phy_status_rpt {
 #endif
 };
 
-void odm_Init_RSSIForDM(struct odm_dm_struct *pDM_Odm);
-
 void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
 			struct odm_phy_status_info *pPhyInfo,
 			u8 *pPhyStatus,
 			struct odm_per_pkt_info *pPktinfo);
 
-void ODM_MacStatusQuery(struct odm_dm_struct *pDM_Odm,
-			u8 *pMacStatus,
-			u8	MacID,
-			bool	bPacketMatchBSSID,
-			bool	bPacketToSelf,
-			bool	bPacketBeacon);
-
 #endif
-- 
2.20.1

