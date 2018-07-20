Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB50FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6459420661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGTV5DsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6459420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeGTVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:12:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46768 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbeGTVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:12:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so12306114wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjBomXy1HcsatFH65plnXBMlY0TUR72nknr9phOvVJI=;
        b=GGTV5DsQBnYbLye3eVvID8RkTlVvupfdOQQ01S4nI0GdAUjEwo/+pRJ39ehf7fJhx5
         myWbcLQazcWWD8Oq96RrR8oLh8tKlrohacq8nAtugl+e2kk+Z1zXP5R/s5Z708Kl6YcF
         g74toEW0FN6OvdsCdz8Z8RXFIbRxw/Q6fKESwFv3m1V8WiL6XKSNvTffKEJ7SYtLTTAT
         FrBMLRpOUMHO/f3xM1ZN3weaXa5U+KyQ0SZn50OaX5/ANQOnCWgXjCweF1ZL8hgrMK11
         hXW5FqqTgcJtRVTdzY/0lQQ/DKhaISPZVlb6fjk3jPEZ+Hm0MLqf72xJFCD+FUn1m52/
         hEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjBomXy1HcsatFH65plnXBMlY0TUR72nknr9phOvVJI=;
        b=uO9iMMRwJW4zb33fwFHmpaBRQP1R0Q294yExFXcdqTNOCSW+3WsEX6xw/eHKqrJsO3
         sRAp6afBcmVtq/o4am55lNel2Y/Web4Xd85rAZZXnuFUasHtbVGAgms5z6vx4CraHatU
         hafQEXPjyXXVmeO38J5n+MqzzKUbD9/TxObVxyRbNwcZaiszXjf2zPJK1O6dNmOkhygS
         j7GvtyBttkFd0pX5fTMX9DSvM3kqb9HO2M3oHNN51ZhWSX9a6EHVAjrOaM2ZkGoI2D+V
         IdsExVU1FABzj7sj/RAS4ckVvzuzmzjHvJ/nIvASA8hNqrKLTvTire2amVAvU+gjg32s
         LF2w==
X-Gm-Message-State: AOUpUlF1Y3VCzktCcpKIzlASmq6m5Z+iKMq7kOe/T4TEGj+loO3mZuXK
        Zj4X8vOe+IAXZ99/aaizSyJg8X4bvh0=
X-Google-Smtp-Source: AAOMgpd+koxw+eEznSlC7RhVKWvBIkEKbtc18CR6vE5yTVRMf/hQa08FC3GsxtSos3f6svA0fW9NzA==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr2324835wro.279.1532118137363;
        Fri, 20 Jul 2018 13:22:17 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/14] staging:rtl8192u: Rename MaxTxPwrDbmList > max_tx_pwr_dbm_list - Style
Date:   Fri, 20 Jul 2018 21:21:41 +0100
Message-Id: <20180720202142.26312-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
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

