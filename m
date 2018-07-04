Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAEDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EF9208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYoNrNp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EF9208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeGDL77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:59:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37767 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeGDL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:59:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so5483310wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=myC4mBDkGtgp2cxF/gdda9syi/UCaeUmokFei2MbEKA=;
        b=fYoNrNp9TCzXpkdSBo0v6GBiJOArk5qsV5bCIDh0yfK7xTqlxUnRLZzJ1KgK1L5di6
         Ih+K/jLxZJiAuD3eUqtUqjM7RUISavF1cPoP6UD73BRh2qG0iggTwPtcwGu/6+t7RKEd
         SpU3+px3jn4zXhumpObL6T3pKEajZLaI3yb/zFJH1GoFzXpveza6kGqJHbvZQLchCpDf
         6p+UlPHT5ZQFBS4crtpMq6NOurIDOT4w6mNxUxBujsuUHDURGOkkLdUIlxjraElnf2nE
         /RF3Pw1UKA41XoSgeS9kXr8nKAfDV3f3fxsDLXIJox7Z6QKm0/JceGBMBMTwZJefq/cq
         CQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myC4mBDkGtgp2cxF/gdda9syi/UCaeUmokFei2MbEKA=;
        b=RRvZDm1qSG0lWmJP54y5lcHSuE2/ITgaRwJf043VpYaXjsZvbEfjYkBpHHooirbqZg
         egtsb6gZQ9mRgQv61hWo7iufkymwkWHLcqLD+vv1MgJhEkVM+N5uEP947FiUDqbru+t4
         M4/b5lPNXZFNWjTRJ0moQ6KdBsiHz0mVZHIfJYQ+mPQUJfpEPgbm18eB2t5/5MfBPqkd
         9XXyeXmzCLS28VYz8Daw3SsWTLVCRivcPXRtaf7mY0oEQ6zJU6bUswssG0sq+UxZK7YM
         S3xXrSse6rCZkAIftvEYRu2yMLCKLrNr9v/b/R1YrL5sn5lL8unJqqPyhQL0O3+J87uk
         FDbg==
X-Gm-Message-State: APt69E0y0wbDEDsw/kGC2SgJ9GMvY8YaH4KF0sIuMORIQIiRTqsnAnEI
        99TltgpGfecC8V4kpNyVfG8fzivC
X-Google-Smtp-Source: AAOMgpcdR6tOpuSZ9twVl4zyPiXjSifQ6ofmJxGvV2Q1Gbxr1k8EYVvfCN2cNtk+/PKD4oK1JOoCBg==
X-Received: by 2002:a1c:b8d2:: with SMTP id i201-v6mr1316714wmf.158.1530705593809;
        Wed, 04 Jul 2018 04:59:53 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6893985wmw.9.2018.07.04.04.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:59:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/5] staging: rtl8192u: Use __func__ instead of hardcoded string - Style
Date:   Wed,  4 Jul 2018 12:59:21 +0100
Message-Id: <20180704115925.28024-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed logging statements to use %s and __func__ instead of hard coding the
function name in a string.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 98d74d87bf11..a549d9678214 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -534,7 +534,9 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"posHTCap or pHTInfo can't be null in %s\n",
+				__func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -645,7 +647,9 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"posHTInfo or pHTInfoEle can't be null in %s\n",
+				__func__);
 		return;
 	}
 
@@ -709,7 +713,9 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"posRT2RTAgg can't be null in %s\n",
+				__func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -758,7 +764,9 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	u8					i;
 
 	if (!pOperateMCS) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"pOperateMCS can't be null in %s\n",
+				__func__);
 		return false;
 	}
 
@@ -820,7 +828,9 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"pMCSRateSet or pMCSFilter can't be null in %s\n",
+				__func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -900,7 +910,9 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,
+				"<=== %s: HT_DISABLE\n",
+				__func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.17.1

