Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5325D2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlQKLDBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5325D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeI0Bb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38390 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeI0Bb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id x8-v6so2899176eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbN18PXB3MNcGsg1ee0WXwF02Ei9pamz0QZsozx0v+U=;
        b=DlQKLDBGDj5ctDgI255OgBzeqcFUEsfX9J35BbyqljAtzW939lNaXdIHWoG6Sif/ie
         XfoRojLTO02i/XOI5aYBRH8FRmYzlVo/7m5rjCiL2Gd603paDZmGCVMU+gl/sflkIVJJ
         /wjZ3BCZSpYK4E7bagDASyAJ3z0GeNT0XaZtn+ciDUCNCmBi4SgejE1HuNnGYSJ/XsYg
         xYh5uX7ZaZRj2vzzD/AZ32NDejlxBJENuoawk3dp3u6eMTTynOZFL5TERiK+Nj8rLY7T
         EYthAB3McmXlHTsZ0ZgEDYk8Fz1/9tqDJ1Z7EFJhx+lyFzY1jWCFi1m5rVYEzBzdrh90
         vN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbN18PXB3MNcGsg1ee0WXwF02Ei9pamz0QZsozx0v+U=;
        b=SRLWlyfOxUyhtXAuoS2trCMRuu2fqPCeyicDXDD4en+IYSlnLUm9T1Vb9+MH8SfzG5
         aj7aaNVUWrtmA2HTSTe1IwmAbYrCcR8MzQRktKdp+capv5jNYd6li1XHApk6DQNeh//u
         +Mi4lOzwOWAkpm26fBedmdWTJNHXv02FX86uUhwIGl6iKIviCu/91lRD6+IER66kDmar
         GYq7fYnF5m7SnJHWJnmf69nFaxlqfyPv+9YJffhLcDJeM50t6B9N9C85aPpnhWsg4vxJ
         /SJP+AtvKyiX5aA2WwWN3Q8CvaAJVnOr1+/7uF+KIlo6Y7yxP2qfhuj1vJUvSmQcRTx1
         IB+g==
X-Gm-Message-State: ABuFfoj2PQQledZHfAK3RlqrY/aEGNQt5l6bqxvMXa6ZSb2Bk68M7ohK
        WZk0Hd9RLD1dguv1pKf2NbyWvi3+
X-Google-Smtp-Source: ACcGV625yuNaoasOItiBT+mQ15uKQ+XlyIqftFOozrqRzWCCIj61zkyG86LQlTLlB3TTa2p0VqX+0A==
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr11920304edw.198.1537989450381;
        Wed, 26 Sep 2018 12:17:30 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:29 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/13] staging:rtl8192u: Remove TxSTBC and RxSTBC - Style
Date:   Wed, 26 Sep 2018 20:16:57 +0100
Message-Id: <20180926191704.16322-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the member variables TxSTBC and RxSTBC as neither is used in
code.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 83fb8f34ccbd..52cce0dcf9a5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -43,8 +43,6 @@ struct ht_capability_ele {
 	u8	MimoPwrSave:2;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
-	u8	TxSTBC:1;
-	u8	RxSTBC:2;
 	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index d1fbe65ed428..b4220df1f833 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -145,7 +145,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
@@ -504,8 +503,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
-	pCapELE->TxSTBC			= 1;
-	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-- 
2.18.0

