Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BC24E76
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdsqCykA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6BC24E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeFXJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:58:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52757 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeFXJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so6168717wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F491Ay2CGNjx5P7lbo2KwuUQREP8MXuhPo46FvxP3SQ=;
        b=NdsqCykAZvDkNRvaBsjWPUDQN/+nmFD7ubxh7JGifpE811xR3oDteTOFi6IxVqPMsu
         M7x7KxEggKCpKLvS+wrW96fpgTf00DpVBjJYjZSVT+oQaDL4vuUTckcUz8p2IWzH/MnL
         hTXeIij9BKXHACvoRjRQbDybLXZFDHCHYMQ3dFtM9WeWTnalSENWMAecrduBjCMklG+Z
         mCcA5+VNhG7DDLPzS0vcWfvaeZN9D0tp3y23xZgvGRZoNX/8vs7qXa5gNHRY43RtKUz2
         7vxAl4zG44i0A0ox6ItYzd4t0lN5mcVTw35EacoI1d+6bnO62Gm/VTE2L/buemxkkLDd
         BqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F491Ay2CGNjx5P7lbo2KwuUQREP8MXuhPo46FvxP3SQ=;
        b=YmN4Jy1gmm7YIcHTHSwkypTx5HVdWCPiHNpli2Z9RUymgg16KzG8HxGmOxApoe6RLn
         CPR1RxSep2OOIjnnX5hYLlunO/qkaHzJfytd3NYDwHhiCgSIB+QnjzGSfp9G137yEn0a
         2tbWd0DeYBWdJ911dxEjpeUi7nCQjqWaK6JRaTKcyKEE/2LXNJm1yLYIb6F4P7tBZE2G
         xVkTmmK4Oi72Iv0HJ9PY3JMKTP51Pi/pAZ67/QwWNlZSQXfAhY+a3wNwa3Z6ZSA3zDPv
         jEpUI4Nu8fy1R9LT5GVF8v/mp5Kg1+X47rxB29kqTUU8oEUR7cPlJYU4AwyZPU0mAWU4
         Gz/Q==
X-Gm-Message-State: APt69E0WSc7IQjZWrIMujuk/PNZKhGxD2+MrMyPzsIk9r+yO9r3dGIsD
        bdu3lcGzN1ylV5d321RXvxKK4Q==
X-Google-Smtp-Source: ADUXVKJqVguqYsbGSWyAhlZnSj19lsyeGi4r2ET0NtAlBZCTgBT0g42N9O2MEsF+7MZK0xBZ/dkM+Q==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr6657974wmg.69.1529834299441;
        Sun, 24 Jun 2018 02:58:19 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 5/8] staging: rtl8192u: Use %s and __func__ instead of hardcoded string - Style
Date:   Sun, 24 Jun 2018 10:57:29 +0100
Message-Id: <20180624095732.12082-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
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
index 604b393d856f..742d2202652f 100644
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

