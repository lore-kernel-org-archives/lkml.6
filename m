Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497ADC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E736820647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnEVMXHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E736820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeH3Aeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeH3Aet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so6010864wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48uacSjtpEzvWNQutauIz3+nJ80q1IZ6cYUsL4tT5j4=;
        b=PnEVMXHw593GatP0ZbBZ5ybjDahRhwE54JCTE70cVJbNMjWkKhXADfEYa8yQlCcQn+
         oRtE2zjEkoPMtCOZU6fh4hFLTp2q2xPELeRWVPoLoTE2yHl+pNkDJSIR9TfgUOa3foaw
         NkSgXCNVcA1qway4+cfsRpH/N+GJF24UfHDq5tJKQfkCxiNY4JIVp93uOq1NPdfQaYMa
         g0B6Fumlx5vmU1uhn/A0lRk/OJHTITSFRRpIuIJJQqpkucFxaVG/3/GgFps0KQkW44bo
         PuaOpwdgdjE7MEZ3X2CUrC+udhdBIL1U/FVjaQV31S1CtGNf1j7qBvJKsQYpRGkDjV+K
         pB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48uacSjtpEzvWNQutauIz3+nJ80q1IZ6cYUsL4tT5j4=;
        b=P2K+mGVqcjkfrMrBjGz5nId8pbFAUuEYZSe2kXuNWSljkGGCKAfTYRJAuFK64r/iNt
         V/EtwMCHDpHHeVb/L37LmfCkL9zRXV1ZNONVbwSgti3fcQVrLC8BHUp/Yq2FnXgrluyw
         sl23KE+UnxWyYiAlYuHSWeBmJF3A4tzUvFbUuBZJe4kXdoNnU4qrODLmKl5pbg+xvOrj
         +f3AL33OnM9T/K6oSMdHLv0bv9L2jTLXoxg65Tmbt6FHGdOBeJ1NZcMZpuMlxl4A7RXB
         Cem9YPmTGc8S34pwDKbpxWc7XqcJV7gts4fR4gAhV7RMddkLKwl4qxtXM506GjWgSpi8
         CbGw==
X-Gm-Message-State: APzg51BSgFlos3ge6NAQUER6uCBqL4dgvHftzcusHL0L/dHFA24akLr3
        L6vy4+jA8v94bQj4r2pNQ3vCE8PLraU=
X-Google-Smtp-Source: ANB0VdZyQ7bUIA0jvExnOaEwpHg5XjQ7aVi4uLYlsm2UShwJ9d9bdA0p3b3ZFI3DUqubbzWlYIfxbg==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr5773459wrq.82.1535574974455;
        Wed, 29 Aug 2018 13:36:14 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/21] staging:rtl8192u: Rename DssCCk - Style
Date:   Wed, 29 Aug 2018 21:35:37 +0100
Message-Id: <20180829203547.15650-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'DssCCk' to 'dss_cck', this clears the
checkpatch issue with CamelCase naming.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index e4693832e1d6..fd04461bcaf8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -49,7 +49,7 @@ struct ht_capability_ele {
 	u8	not_used_rx_stbc:2;
 	u8	not_used_delay_ba:1;
 	u8	max_amsdu_size:1;
-	u8	DssCCk:1;
+	u8	dss_cck:1;
 	u8	PSMP:1;
 	u8	Rsvd1:1;
 	u8	LSigTxopProtect:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 7fb31638f60d..299d486fad0d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -146,7 +146,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->short_gi20_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->short_gi40_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->max_amsdu_size) ? "3839" : "7935");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->dss_cck) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
@@ -561,7 +561,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
 	pCapELE->max_amsdu_size	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
+	pCapELE->dss_cck		= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
@@ -569,7 +569,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	 * MAC HT parameters info
 	 * TODO: Nedd to take care of this part
 	 */
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d max_amsdu_size:%d DssCCk:%d\n", pCapELE->chl_width, pCapELE->max_amsdu_size, pCapELE->DssCCk);
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d max_amsdu_size:%d dss_cck:%d\n", pCapELE->chl_width, pCapELE->max_amsdu_size, pCapELE->dss_cck);
 
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
@@ -956,7 +956,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * TODO:
 	 */
 	pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK &&
-			       (pPeerHTCap->DssCCk == 1);
+			       (pPeerHTCap->dss_cck == 1);
 
 	/*
 	 * Config and configure A-MSDU setting
-- 
2.18.0

