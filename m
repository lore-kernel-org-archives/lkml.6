Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14434ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61B20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1BShzpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC61B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeGUUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36096 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so14175413wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R9GML930NUAqqd2KZU9Zrg35TPib87vl6dcWQbEiMAs=;
        b=t1BShzpi9gYCMTagQZRRGlJPjM0PSZY8XoTlw3JeEnZY1NXwUpEn97Qvf4wNLs98Ty
         ELvab1nAqFz3KSpvHFQW/Ps86nhqwB5zhux49oonJav5i1ebYEkMlqoNgGyhQ5brf4va
         TQ4JPw0/OA03qcVBBDdi2B3qNCZwqdPGPLCsNPhPw8kPY5QBeLKffRPmAFppB3CiaInR
         SPsHuhGKVfoN12pT1Bfd8LxqrGOObpWZ/kB6HlWIkhuu33DgxtLa2rbjDDvDHCwLOM5U
         bFcJuJyB3LgZmQ0YK3nVrN4r7M9KPEeRsc2IEV/BkqQMosD4xpO+aFyGaIEb+t3GWXN+
         skqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R9GML930NUAqqd2KZU9Zrg35TPib87vl6dcWQbEiMAs=;
        b=dxWVjJ0usDfH5wenx+QbKjmIGfVagJQMbeywFHSNlYSgPNueYqjemHTEdigxl7Sg+e
         QTvtsc0pZj5TiTcEgWWrlJIjXnjMarxtW3/8KqOqP+f8zZ1EJyI7L/lSwvjfGkP/DQPS
         MWVDJxatiKGGVbqLfDB93KZw5J6CD6Z/gurCRXhdXCiQeFiAPSZ9yXTE9s7lR9cg4khS
         mqO0WejCL1+e1y1/LcW/PomB+G73qd5bjamvcgl4juUFLRclKz0hkpDnOeuL9Ny0O+Ov
         7P2SLqpcWSuUd+M31M/u0lKesjfc6MGcj7BxNR9Wp9mqLPvlkLoiuFGmB9DmHEnMYKJB
         fnzA==
X-Gm-Message-State: AOUpUlEed0Aj91JqIBa69X6QvHKDsgUTUFRHit0Y8V4mrZe2u262Crhf
        1J2tEWrKcGDsJnVVv8AKtJcu5uAl
X-Google-Smtp-Source: AAOMgpdl2w3IXjAduTlI4p0/+eLW2g3JKfFhLvfdcu9v4YrZ/u9mvrUFYtF5jPWOSUPye2Qi1nRgJg==
X-Received: by 2002:adf:be0f:: with SMTP id n15-v6mr4719452wrh.267.1532201182004;
        Sat, 21 Jul 2018 12:26:22 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/10] staging:rtl8192u: Remove typedef and rename struct RT_DOT11D_INFO - Style
Date:   Sat, 21 Jul 2018 20:25:45 +0100
Message-Id: <20180721192552.5378-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the typedef from structure RT_DOT11D_INFO. This change clears the
checkpatch issue with declaring new types.

Rename the structure from RT_DOT11D_INFO to rt_dot11d_info.

Coding style changes which should not impact runtime execution of code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c        | 14 +++++++-------
 drivers/staging/rtl8192u/ieee80211/dot11d.h        | 11 ++++++-----
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 44b5e506b140..cd63e158c7c8 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -5,7 +5,7 @@
 
 void Dot11d_Init(struct ieee80211_device *ieee)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(ieee);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 
 	pDot11dInfo->bEnabled = false;
 
@@ -23,7 +23,7 @@ EXPORT_SYMBOL(Dot11d_Init);
 void Dot11d_Reset(struct ieee80211_device *ieee)
 {
 	u32 i;
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(ieee);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 	/* Clear old channel map */
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
 	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(Dot11d_Reset);
 void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 			    u16 CoutryIeLen, u8 *pCoutryIe)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 i, j, NumTriples, MaxChnlNum;
 	struct chnl_txpower_triple *pTriple;
 
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(Dot11d_UpdateCountryIe);
 
 u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 MaxTxPwrInDbm = 255;
 
 	if (Channel > MAX_CHANNEL_NUMBER) {
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(DOT11D_GetMaxTxPwrInDbm);
 
 void DOT11D_ScanComplete(struct ieee80211_device *dev)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
 	switch (pDot11dInfo->State) {
 	case DOT11D_STATE_LEARNED:
@@ -138,7 +138,7 @@ EXPORT_SYMBOL(DOT11D_ScanComplete);
 
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
 	if (channel > MAX_CHANNEL_NUMBER) {
 		netdev_err(dev->dev, "IsLegalChannel(): Invalid Channel\n");
@@ -152,7 +152,7 @@ EXPORT_SYMBOL(IsLegalChannel);
 
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 {
-	PRT_DOT11D_INFO pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 default_chn = 0;
 	u32 i = 0;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 9402c05cb24f..8f7426333da5 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -16,8 +16,8 @@ enum dot11d_state {
 	DOT11D_STATE_DONE,
 };
 
-typedef struct _RT_DOT11D_INFO {
-	/* DECLARE_RT_OBJECT(RT_DOT11D_INFO); */
+struct rt_dot11d_info {
+	/* DECLARE_RT_OBJECT(rt_dot11d_info); */
 
 	bool bEnabled; /* dot11MultiDomainCapabilityEnabled */
 
@@ -30,15 +30,16 @@ typedef struct _RT_DOT11D_INFO {
 	u8  MaxTxPwrDbmList[MAX_CHANNEL_NUMBER+1];
 
 	enum dot11d_state State;
-} RT_DOT11D_INFO, *PRT_DOT11D_INFO;
-#define eqMacAddr(a, b)		(((a)[0] == (b)[0] && \
+};
+
+#define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
 	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
 	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
 #define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
 	(des)[1] = (src)[1], (des)[2] = (src)[2], \
 	(des)[3] = (src)[3], (des)[4] = (src)[4], \
 	(des)[5] = (src)[5])
-#define GET_DOT11D_INFO(__pIeeeDev) ((PRT_DOT11D_INFO)((__pIeeeDev)->pDot11dInfo))
+#define GET_DOT11D_INFO(__pIeeeDev) ((struct rt_dot11d_info *)((__pIeeeDev)->pDot11dInfo))
 
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->bEnabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->CountryIeLen > 0)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index fe61451f6c14..ca3a35b8ac07 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2542,7 +2542,7 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
 
-	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
+	ieee->pDot11dInfo = kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL);
 	if (!ieee->pDot11dInfo)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
-- 
2.18.0

