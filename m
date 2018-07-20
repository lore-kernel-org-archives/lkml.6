Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DAD20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j92/JjW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DAD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeGTVMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40099 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbeGTVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so10923769wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rw5BlBwv7RdJou1zekHb0S3Mv4NAuya8Ii6BR+ksxI8=;
        b=j92/JjW5um+Wz4KgQF1br2JnZcZlCroDdRfBgFP0UjaB4xN/E9DH0Xs//Ev07KB2Wl
         3VkYQjLbtdfM6Ah0KQIWuOeo7cQRNMCj/G7JoEbOo12FWS3sW9Vjc84oFjMsLYB0boo1
         Yi+qVB3+wKOXE93DYbyqtCcK89Ew/VSRFEx6cdJw4kPzp2GkJNLYr4WJ5knJPAqjyr9O
         5x6I0vZ7n4DxSXysvce/dAfDb6V/HMshPGwpkOb1S8QZbJVH34OVTree5HquXIH5GMIG
         TcLciJ6Jktl1xwfqWIAv3akNo6NXANwo8QsNeL3hwruIdhWhEK4eoat6Jcd86Qk2XU7L
         p57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rw5BlBwv7RdJou1zekHb0S3Mv4NAuya8Ii6BR+ksxI8=;
        b=XM4QPHVVK3WZeWF/dfDy2rgcBpAqnY76mucpLCF26QYJzhTzWs3UOXkfNzwfzyT9DM
         4l6F0i8A/JfOBzK9u7Tiq8rRR9LCIkiDPMMD77fVIYewF8aYJMtfmG8RzWOVqBEuiPdh
         c3e9LuS6/dXHnifJ3F5xkpylhP/4u6drqx/8DT0Bl6/FnsgU3AretXqNS588wyAGkPFP
         PXbBTC9KnuMddAtouRcf3SPdtYhHgkuc70sUUtnu8ytRn1cwq7Bnt6f6JgN8FyajyFHO
         xcjkGeBuUrB8HQeDGkqe+hi6TJM3tGah73juW1RaC9ZK7Mykrw/Crphx/NVjV0TO/5rQ
         90zQ==
X-Gm-Message-State: AOUpUlFgSZZJp7DbwWFQe3XxPNqU7nSiz/7XiEikRp+CckYb6BonzSUj
        7HGU24PUs/NJrHllck76ZQMdgHhKteA=
X-Google-Smtp-Source: AAOMgpd4IntH7J8V3hxkWnzxEaJtuUruJuMtDEjQf1vd3ryqMhRI53uS/uJZI5cBmPMjKN5S97Bo4g==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr2279750wmh.103.1532118127990;
        Fri, 20 Jul 2018 13:22:07 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/14] staging:rtl8192u: Remove typedef and rename struct RT_DOT11D_INFO - Style
Date:   Fri, 20 Jul 2018 21:21:35 +0100
Message-Id: <20180720202142.26312-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
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
index 21874e78d8a1..590f2f2b3134 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2684,7 +2684,7 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	for(i = 0; i < 5; i++) {
 	  ieee->seq_ctrl[i] = 0;
 	}
-	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
+	ieee->pDot11dInfo = kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL);
 	if (!ieee->pDot11dInfo)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
-- 
2.18.0

