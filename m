Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27142C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5220205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhKwcoM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5220205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeH3Ae5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33377 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeH3Ae4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so192257wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMpUaOqub5hk7roeaiifRFOwWFGNsgqah+M4XssWR00=;
        b=VhKwcoM1pQAx5abBQcyqVVV2I8kIwyFj3P4VfZ2YGk9hBCPtrCyr2DzFeYGDVI5uFX
         5KrcQ/7dioYgBuNYEvCXco+BST1oNAaYtRPp9kvl+DGmTdi84ON8fHhgqk3snyugD9Ou
         JNT6LzILr4aCwRfHBvfShjx/l0bcPmhCsNcsspVaRAK94CiSIt+aXPG6WJuehDgJoZpK
         6vtjJEIOIjnFcm6RhFJZAC1lNjUP87U3W19alLhVSGY6yqraFYU9xMYiZfnZ3S10cfE9
         tvZ22OrWNSH48qj8ArlPVQOFgV+nA3d6AcjMHoRox4ZhJBuBJnZDwWj5mUlliG/kDmzl
         bXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMpUaOqub5hk7roeaiifRFOwWFGNsgqah+M4XssWR00=;
        b=OxrMjD9lww8PXSEnRCcRYCMXXHmQVow0kQBc4OVXXWFY3A3roLXLFQfjRYf0F8e/ui
         C1DzqV6b1xD50wiUgnPAWKIWB0Ig33VidM2sH4KorSYea3S9oBsMh+emYa5wc26oE0ag
         JAEmIeNBVDNu2QP12Kl7gqQSEjhSqn9SAtykPUJuQ3o5J9IDLlujZ5j1H0iYuTh5n/Pt
         Z7F1hpxvBNVCKQZkCR32zcqgpr2JUsK1H7q4rjOPkRjhOl2x7yHIjsNLUaTsmw5RefvV
         XdikErLSu3L+dRh1sNOCjOuHfsnHCklYtqtywUlDQnQeluCUvL0zW6iiefXNEZNFdmrc
         qkDA==
X-Gm-Message-State: APzg51CkhP5+Zlb7DB3X8HEorCHvL7GUb7C9mDOzSR9GB46d64ZnhWs/
        XDPm+5yPm+09QSu8PV7y4I0xoVV8z5w=
X-Google-Smtp-Source: ANB0VdZht4c2ZKwIgxSfIh7ay/cJZ+2MgdEGJm7cX9B4Bh8Atb7QBQ4VqwJpyA5zGeAd2KpYq1QNXw==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192-v6mr5583852wmd.140.1535574981887;
        Wed, 29 Aug 2018 13:36:21 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:21 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/21] staging:rtl8192u: Rename MaxRxAMPDUFactor - Style
Date:   Wed, 29 Aug 2018 21:35:41 +0100
Message-Id: <20180829203547.15650-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'MaxRxAMPDUFactor' to
'max_rx_ampdu_factor', this clears the checkpatch issue with CamelCase
naming.

The change is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h  |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 040660a46bca..12db4ac9703b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -55,7 +55,7 @@ struct ht_capability_ele {
 	u8	not_used_l_sig_txop_protect:1;
 
 	//MAC HT parameters info
-	u8	MaxRxAMPDUFactor:2;
+	u8	max_rx_ampdu_factor:2;
 	u8	MPDUDensity:3;
 	u8	Rsvd2:3;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index ec96e14a2bed..4fc919ebd10b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -147,7 +147,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->short_gi40_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->max_amsdu_size) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->dss_cck) ? "YES" : "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->max_rx_ampdu_factor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
@@ -571,9 +571,9 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
-		pCapELE->MaxRxAMPDUFactor = 2; // 2 is for 32 K and 3 is 64K
+		pCapELE->max_rx_ampdu_factor = 2; // 2 is for 32 K and 3 is 64K
 	} else {
-		pCapELE->MaxRxAMPDUFactor = 3; // 2 is for 32 K and 3 is 64K
+		pCapELE->max_rx_ampdu_factor = 3; // 2 is for 32 K and 3 is 64K
 		pCapELE->MPDUDensity	= 0; // no density
 	}
 
@@ -978,8 +978,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 */
 	if (!pHTInfo->bRegRT2RTAggregation) {
 		// Decide AMPDU Factor according to protocol handshake
-		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
-			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
+		if (pHTInfo->AMPDU_Factor > pPeerHTCap->max_rx_ampdu_factor)
+			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->max_rx_ampdu_factor;
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 	} else {
@@ -990,12 +990,12 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
 				// Realtek may set 32k in security mode and 64k for others
-				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
+				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->max_rx_ampdu_factor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
 		} else {
-			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
-				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
+			if (pPeerHTCap->max_rx_ampdu_factor < HT_AGG_SIZE_32K)
+				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->max_rx_ampdu_factor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
 		}
-- 
2.18.0

