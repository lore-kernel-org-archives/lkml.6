Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29D1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACED620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4aBUvF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACED620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030797AbeFST5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54715 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030597AbeFST5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so2263470wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AwB+MbS77Gi2Om2Yc2yEFaTsQNEUkfbGwmbW/D2rlNU=;
        b=B4aBUvF4P85cNGWNAuw4D9mLxKkNTEHtdGEh4218/VeOczZ5lENzSysJwYAN9NVlte
         iFYgeQ+GqxJbXOQ3jHjhxthKaIb3Kv2jmxVBR87vWtSG3GqyqiuJzi0RJJs0Fl6Ijn08
         oG8mFcvQ/Cw7nTnVllJokhf+w16V/ojuNtujnnhBYggxbHJM83uBxyXaHnAps3zgH9my
         IgwPKfZBb8faeCVElNDvjh5vAj4MmGdt4C6jzSZzZ1+6v+fVS6JaexqPkin0Fad0dlk7
         mU5slDMRr6uMOEXdWqveMJK++jbMJOGi0qWW3vYEDFSDEaD3hU5mlzfDTMdg0RnlSTjj
         pEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AwB+MbS77Gi2Om2Yc2yEFaTsQNEUkfbGwmbW/D2rlNU=;
        b=bqim8QQaBmYgSt/V05QaHKHBFH20qYCj9Ohi0IJuhVsz4lbQV3WvnrLTKC8DesanZ9
         hLDu4xrT/wA5FJoph3AkT5sP5xq0eESESqC6rZFpqm09rexSPHw428h6qyCjE7mWSBgp
         Qo19INdByb79jetLlE7xXirHmF5xkZesLhuGMVVits6AQi8zXs8MbQMY6Swgr5mbpRe+
         Uze+fZpMXF/vhpVHFMbgR41F1Pf4IRNxz/hE6DxEIp93LsM+O83KGJmb2PMXNtV1cEtd
         5HaFjt8xyB3um19iz6F1SEeJvOl2cQPEIKcGrD4UH7OB8RILHk5h9Ct5JWBcoFQeo1bB
         SBqw==
X-Gm-Message-State: APt69E1lOvAQbsKJ39oF73AtAwHeaSOCUADCbrSR3ivr7KqlJJV3c1ox
        iFcxDKN5mkkzm3i5y+ACmS8=
X-Google-Smtp-Source: ADUXVKJ5tzDgZhNRNXDxipjRfLGVJSduay6/oPADmJyqqkBtG69U8HVmoFCOlw+oyOS1cY1BctEZ3Q==
X-Received: by 2002:a1c:1808:: with SMTP id 8-v6mr14231074wmy.113.1529438222923;
        Tue, 19 Jun 2018 12:57:02 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 5/9] staging: rtl8192u: Use %s and __func__ instead of hardcoded string - Style
Date:   Tue, 19 Jun 2018 20:56:01 +0100
Message-Id: <20180619195605.31321-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed a number of hard coded function names to use %s and __func__

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index e5ca4f3bfc7e..732d03e8474e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -539,7 +539,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -652,7 +652,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
 
@@ -716,7 +716,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -766,7 +766,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 	u8					i;
 
 	if (!pOperateMCS) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
 
@@ -829,7 +829,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -914,7 +914,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== %s: HT_DISABLE\n", __func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.17.1

