Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B645C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3746420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV3HsuqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3746420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeH3AfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeH3AfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:35:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so6034159wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6TACjDabhPBkHdvUt0NjmnDtd7aOkN50U8OVQx9Tybk=;
        b=GV3HsuqER8EhzUL3C0Mx1Z90UJ8Ni/MjQEJpnvZ8NawLewxc37OMGbg0AJ7hWkKlAx
         1R8lDychbJpnlAZc/CStSM7wBzgiFnHBzzYtfBnDsZXD2mw3O5eWZHtH91TXY3nIp8SP
         qAC2j2lk09ZaNkYMYQEvov60eIlGbJT3ATflMM745mc4EIEQ1Yl9ChZg8LjvTI+mzVVH
         7j9NsXWBU2oh3j8niDxJqxkj8L9mc3RT/Uqpy0hQmQ29ZmGYUN/zNz9uuM0iuPlHLyaJ
         xbTf+n4IC2u/ps0q4DtiLYV30GHUeD1Gv+lqpy86+bYlWTK4vIsTfUjmecjySMf3NDuy
         8/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6TACjDabhPBkHdvUt0NjmnDtd7aOkN50U8OVQx9Tybk=;
        b=CkPNXDtIH+MeyXkjsbw/kTZcQ/A8cRkbocel6av61x5O1YiYIHHwRGtV21Ne0wtdsr
         JOBYGyAqwVDvE379d4lJ+mK3yKOdkynxBPqAchTcWIKUhGJuM3U4WLwDakowfXnK2d6u
         Aii5eg/coTA2QkAjoIvvJg1sUCFYL8aOSnyoCeF+Z3Njmhv7wjDnVziDMVMFpM6/Tsy0
         OKC7vv3rQ1u4EzSUWYzA/x1qpXdIeXsVWkSQwJkbsDskE7gbIbYKrZBvnQsnRbWzoo4q
         sjZAFkYwHGQzjpc6w1WzeTC2N29P5R7z47PZGjJ612NUTGIlD06X6RHOM30licIohNFB
         m1Pw==
X-Gm-Message-State: APzg51AyHkUw8GWwmiK2M8aJpu2AxvTkxF+gGlIxoIIYixC7kk/Ts6G2
        9olskSup1wmRVtmJY0sCh3x41xMeEM0=
X-Google-Smtp-Source: ANB0VdbrTrK0jlRLnZvOrDJ6ZIihyYixvJQLeHf3ZFFbyWB3ys/U5VHaaNwCmSnZIdFyD0LBJvklRQ==
X-Received: by 2002:adf:ec05:: with SMTP id x5-v6mr5237679wrn.266.1535574987767;
        Wed, 29 Aug 2018 13:36:27 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:27 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/21] staging:rtl8192u: Rename MCS - Style
Date:   Wed, 29 Aug 2018 21:35:44 +0100
Message-Id: <20180829203547.15650-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member 'MCS' to 'cap_mcs', since the uppercase name
conflicts with the coding standard. The 'cap' has been prepended
to make the variable easier to find in the code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 20 +++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index a6fe975902bb..a96cc5c01b10 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -159,7 +159,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 						((ht_cap->short_gi40_mhz)?1:0):
 						((ht_cap->short_gi20_mhz)?1:0);
 
-		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS, MCS_FILTER_ALL);
+		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->cap_mcs, MCS_FILTER_ALL);
 		rate = MCS_DATA_RATE[is40M][isShortGI][max_mcs&0x7f];
 		if (rate > max_rate)
 			max_rate = rate;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 2b73279b45d8..edd0c00307bf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -60,7 +60,7 @@ struct ht_capability_ele {
 	u8	not_used_rsvd2:3;
 
 	//Supported MCS set
-	u8	MCS[16];
+	u8	cap_mcs[16];
 
 	//Extended HT Capability Info
 	u16	ExtHTCapInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 19c4903b572f..625d117e5a8f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -149,8 +149,8 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->dss_cck) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->max_rx_ampdu_factor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->mpdu_density);
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
-				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->cap_mcs[0],\
+				pCapELE->cap_mcs[1], pCapELE->cap_mcs[2], pCapELE->cap_mcs[3], pCapELE->cap_mcs[4]);
 }
 
 /*
@@ -578,15 +578,15 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 
 	//Supported MCS set
-	memcpy(pCapELE->MCS, ieee->Regdot11HTOperationalRateSet, 16);
+	memcpy(pCapELE->cap_mcs, ieee->Regdot11HTOperationalRateSet, 16);
 	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS15)
-		pCapELE->MCS[1] &= 0x7f;
+		pCapELE->cap_mcs[1] &= 0x7f;
 
 	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS14)
-		pCapELE->MCS[1] &= 0xbf;
+		pCapELE->cap_mcs[1] &= 0xbf;
 
 	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_ALL_2SS)
-		pCapELE->MCS[1] &= 0x00;
+		pCapELE->cap_mcs[1] &= 0x00;
 
 	/*
 	 * 2008.06.12
@@ -596,7 +596,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		int i;
 
 		for (i = 1; i < 16; i++)
-			pCapELE->MCS[i] = 0;
+			pCapELE->cap_mcs[i] = 0;
 	}
 
 	//Extended HT Capability Info
@@ -1037,10 +1037,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * Handle Ralink AP bad MCS rate set condition. Joseph.
 	 * This fix the bug of Ralink AP. This may be removed in the future.
 	 */
-	if (pPeerHTCap->MCS[0] == 0)
-		pPeerHTCap->MCS[0] = 0xff;
+	if (pPeerHTCap->cap_mcs[0] == 0)
+		pPeerHTCap->cap_mcs[0] = 0xff;
 
-	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11HTOperationalRateSet);
+	HTFilterMCSRate(ieee, pPeerHTCap->cap_mcs, ieee->dot11HTOperationalRateSet);
 
 	/*
 	 * Config MIMO Power Save setting
-- 
2.18.0

