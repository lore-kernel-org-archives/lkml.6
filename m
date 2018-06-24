Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A6AC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685E6251B0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLoWII7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685E6251B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeFXQEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:04:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36900 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755902AbeFXPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so11134343wrp.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHKTm/djS/DqO1pyh10Q7PF32ua1SZd4KG2RyOnDzf8=;
        b=JLoWII7TobpSaukiYsUIXJt9vua+U5zxavmzu/87VelG7vf1bWIG0yqkJ5ig9rO5NP
         a80SLi/v3hfFkz039vzNrlwcDawVqW/LvQDZX7J/k5BaBF7AUCDSQx+kylscD8EfJnLa
         ski0wsVqf1KRuQs26SKgfuk3snSA1g6xtWcRAQDhLQ8N9VCTnwvhjmyEKI8mg1HeG88h
         IRQqBfWkhQa2mb4Qe7JbROBJ94hG/9bUVs3TL3Q4M+vmQg41mcFQNlBAI/qLIvxB3QUA
         YZywUEpgSYX4IWXNuKjEeATtODbmOuVaOsFxkq18qlju0MoofnEQwW82xIIiINm42lLD
         qheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHKTm/djS/DqO1pyh10Q7PF32ua1SZd4KG2RyOnDzf8=;
        b=IRg+zZQjt1zKcyr1JG16zyhe0plK4vPj+NOTp7TvwfWb8J7dF3fVZzfAe6PW7bzGlP
         z1GOm1hSm++5N/D0v4/8akzmcVqqfD9/zCUmcGT+RlhZbfaE0aKJK0MbV3pv+h+zBn/I
         L/rNOJhkxPCjyFa07XPIwgLSs54hBvXiU+gC88bzhAe6YAnB+0qivNoQoXf8H6j74tLM
         qF1qg2bv7r5hnhoGQ69snWhL0mN7er9QPwwKBIHGP9pCBXqhlJ1WgtuTE2v04iUUILV3
         9j6uIi7o1Wi4J2ZHElBxdNrcbv4/0RBDoFql57Pxz6BuYLH4W9z1VytsB+HRI7aKP0rt
         KeLQ==
X-Gm-Message-State: APt69E3En1rgh5i85tNAugQJVu/ETxz03ylgbWG4RvXax5RMB/KtvtJE
        HAjQxc4ySXHqieHF8E29H0137wv4
X-Google-Smtp-Source: AAOMgpcKUxwZtAchiYSIZxjCdNmYGgZTJ18mh5RdFDO0uNZ7GPzEdNiOi0qiorNiS8dkiIoP/TfZkg==
X-Received: by 2002:adf:9d93:: with SMTP id p19-v6mr231683wre.12.1529854859790;
        Sun, 24 Jun 2018 08:40:59 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:40:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of hardcoded string - Style
Date:   Sun, 24 Jun 2018 16:40:24 +0100
Message-Id: <20180624154027.27654-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed a number of hard coded function names to use %s and __func__

Mailing list response suggest that there is a better method for debugging
using netdev_dbg(). I can't argue with that, but for the moment this change
will clear the checkpatch.pl Warning.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0bd41ded87c9..6793a9aabb2f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -534,7 +534,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -646,7 +646,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in %s\n", __func__);
 		return;
 	}
 
@@ -710,7 +710,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in HTConstructRT2RTAggElement()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posRT2RTAgg can't be null in %s\n", __func__);
 		return;
 	}
 	memset(posRT2RTAgg, 0, *len);
@@ -758,7 +758,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	if (!pOperateMCS) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in %s\n", __func__);
 		return false;
 	}
 
@@ -819,7 +819,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in %s\n", __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
@@ -901,7 +901,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	static u8				EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 
 	if (!pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== HTOnAssocRsp(): HT_DISABLE\n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "<=== %s: HT_DISABLE\n", __func__);
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-- 
2.17.1

