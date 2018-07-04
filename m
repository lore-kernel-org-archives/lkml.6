Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6123E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsLcnQgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B6123E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeGDOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40778 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeGDOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so5943643wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=myC4mBDkGtgp2cxF/gdda9syi/UCaeUmokFei2MbEKA=;
        b=HsLcnQggjTih4CVtgBhtwvT37FFOS3Hv2yRcZfcDAdd1ogEh6JdgK/6oqEvsx34CMe
         WdNocxVEalaTIuSIASu7b5X6KWtsKZODFam2BcONO4PEVB0Pw20xHPCpOJiCTmwQRVvd
         gqjfYIxKgi8YZMCUnq9m1Rm5eanIpDVIlsGKAaMLLfv9zZkw0mWNAe/sUJIJUGpiwfh9
         xtIWDJjjocAK70qXOatytmQn+BYW3W3upOIGpwqav78fVlEQZbXBC26A4AG9CscIr7aO
         DX5Utr40bywgyvbYWMLOdlCAxnGAUA0zDYkXeSi+/2z9+AtbCIAjthNh5xD5dAHUbY6n
         u6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myC4mBDkGtgp2cxF/gdda9syi/UCaeUmokFei2MbEKA=;
        b=Y8vmIOrffco48rl8x6yMnOFG3h8DMZFdv6lDsg9W97D8NdwSO6BFNt5IPmAEudGqNx
         ry4eBL/iBPg9vYWZWEyRsHedndtm5ITSgKb4Wb0iVLWyLfEP6iE8+Uze9lFJj9QrYUoW
         IZo7vw3Se+OR8c4U89ZKHAUKdN0w0/X9h8omF/SQenfvn3fFGiTtWEHO+78sKBzwJA6F
         qdLbu+NBAySUYupfcwAdz8VVs9m5x0jSXqmjf4iPfvS/VeM+zus6bt1MU7ELIuBn9bH1
         omYy2JnQfIMQrUBSvoJ9bKpZg7tgeTtda44YyKMj+drWyJl4HxfT0lPAV0tv3btVwwoQ
         rjBw==
X-Gm-Message-State: APt69E2+46yHv7L2gvhmdlwK+A9NQIV8r0fQsflm6mFq3qCyBjKJs+ey
        BTiK5nnERGHglauHHGVuqxFS7X0V
X-Google-Smtp-Source: AAOMgpc5cgQ/IDV8EY7dDBozf2oG3+koB7AC5nvcudzg4+tO54oKay1avIotR0ZBntMVlxv/My+ZYQ==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr1750927wrv.194.1530714066393;
        Wed, 04 Jul 2018 07:21:06 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 1/9] staging: rtl8192u: Use __func__ instead of hardcoded string - Style
Date:   Wed,  4 Jul 2018 15:20:48 +0100
Message-Id: <20180704142056.2179-1-johnfwhitmore@gmail.com>
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

