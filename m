Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3D3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCFF20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZEaq6o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCFF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeGUUUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeGUUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so14144703wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjBomXy1HcsatFH65plnXBMlY0TUR72nknr9phOvVJI=;
        b=VZEaq6o85Mkev3sra+n2aU7hJ/v0UAObo/Gle+22R25pA4l8FxhWYb+kMUpFDn5Jb2
         Sgwq44pViFddT+YyNng7OCR9lUXI7ra9uae2s+a8/mwdjuddJyL/Fiv0v0YKvGc+VQAX
         nXkxBlybjmToufe54pFUkrZdbtpAd4yltN0vrlxsg6OIlqidfTXq8nKrpvSsbuxV+kFL
         OknEUU6p7F/gtheYLEc+trN+jYcEFI147n7nTGiIykNsNKJiOIYBa+Pn9JpVH3+OMId/
         kRHay5h0thDoUaYv2D5uQoSdsT1/kyqmel100UqmsYbGeiku/62uFCCVET9+V4qosZGh
         dhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjBomXy1HcsatFH65plnXBMlY0TUR72nknr9phOvVJI=;
        b=A1q+ZaATI0Bk0ljDb/JRzbf+Ujw9TdjHbbCaIpvSuxRUP7JXx8+9EXm+qKWvuFZt+/
         dnen317Sqqb2Yd/S21za+9zaQEL4aDGQDJYFbk3Rt0/jL8Pt51HKY/1iHfVYuDmZiln6
         78MOQHddgTvs0YkHs8nKdv1fRhCBcuf1f5zGmNUHPBEYN4SarFJIjtogxdwi03G95R9n
         76bT2239i09nC0cLP0sM3IyWvSzKe+yo2BUSFxTT5RKmI0uv/b0FJHh9SEWWUitS7a+a
         Ij1NAD8VdXFYBSEtyB56qoMjeGJg9Wxp8ZIM3ut01MAqqQb171OPgI4iU3zZTmq3l17O
         X8vw==
X-Gm-Message-State: AOUpUlFvdBFfdkLwvpYeKC4Fo9230b3tZj8a3wOrX5awYnnGC+1PQ/sC
        vIWZ5ghu9eOjo7GqY6zy8HmLrBWz
X-Google-Smtp-Source: AAOMgpfmdguH0swhyK21NTNRkgjERPEDoOPOndOTpkjMVMC+ZWCBuFoB7+YhCHblf74ixw2/D8Q6BQ==
X-Received: by 2002:adf:a401:: with SMTP id d1-v6mr4441082wra.121.1532201193821;
        Sat, 21 Jul 2018 12:26:33 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 09/10] staging:rtl8192u: Rename MaxTxPwrDbmList > max_tx_pwr_dbm_list - Style
Date:   Sat, 21 Jul 2018 20:25:51 +0100
Message-Id: <20180721192552.5378-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable MaxTxPwrDbmList to max_tx_pwr_dbm_list. This
change clears the checkpatch issue with CamelCase naming. The change is
a simple coding style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index b1205345a7e0..21912b2d728d 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -12,7 +12,7 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 	pDot11dInfo->State = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
+	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	RESET_CIE_WATCHDOG(ieee);
 
 	netdev_info(ieee->dev, "Dot11d_Init()\n");
@@ -26,7 +26,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 	/* Clear old channel map */
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
+	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	/* Set new channel map */
 	for (i = 1; i <= 11; i++)
 		(pDot11dInfo->channel_map)[i] = 1;
@@ -57,7 +57,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 	struct chnl_txpower_triple *pTriple;
 
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-	memset(pDot11dInfo->MaxTxPwrDbmList, 0xFF, MAX_CHANNEL_NUMBER+1);
+	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	MaxChnlNum = 0;
 	NumTriples = (CoutryIeLen - 3) / 3; /* skip 3-byte country string. */
 	pTriple = (struct chnl_txpower_triple *)(pCoutryIe + 3);
@@ -79,7 +79,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 
 		for (j = 0; j < pTriple->num_channels; j++) {
 			pDot11dInfo->channel_map[pTriple->first_channel + j] = 1;
-			pDot11dInfo->MaxTxPwrDbmList[pTriple->first_channel + j] = pTriple->max_tx_pwr_dbm;
+			pDot11dInfo->max_tx_pwr_dbm_list[pTriple->first_channel + j] = pTriple->max_tx_pwr_dbm;
 			MaxChnlNum = pTriple->first_channel + j;
 		}
 
@@ -109,7 +109,7 @@ u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel)
 		return MaxTxPwrInDbm;
 	}
 	if (pDot11dInfo->channel_map[Channel])
-		MaxTxPwrInDbm = pDot11dInfo->MaxTxPwrDbmList[Channel];
+		MaxTxPwrInDbm = pDot11dInfo->max_tx_pwr_dbm_list[Channel];
 
 	return MaxTxPwrInDbm;
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index a7fa1a7f01bd..0c7652a2ebb3 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -27,7 +27,7 @@ struct rt_dot11d_info {
 	u8  country_ie_watchdog;
 
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
-	u8  MaxTxPwrDbmList[MAX_CHANNEL_NUMBER+1];
+	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER+1];
 
 	enum dot11d_state State;
 };
-- 
2.18.0

