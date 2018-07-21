Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0816520864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKCzSkfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0816520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeGUUU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46482 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbeGUUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so14116831wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wBkcpHEsygOVfK3SPXq4YWBCalRqJWRS9aTefI9eCgQ=;
        b=hKCzSkfNf6mGgMB8VuU8Eu6vwoNvr3Qr9/NnK65bX9v+mkzPry2CeZZxek7z3POfU6
         Shp+jd7nfIPgZIabUtidGmcvsET9ORplWtJv3T76/ecLaEtmvjJ3wId0jWhMsiJm4NOl
         U0zPbLUScC44hBOLPIH6d8MZM+rEHYLRn7ecG5F5mxv2nPhJB4wh86bIiYK9Z+98NpD0
         xzxvCU5ozmLqULvZ26htUs7yHUpvniTDJEbdJBtrZYhAASuwObGjG7AnhOilUyViy2HN
         Al+amwsIIhZI5w4vKCh21ZYihTj5eRK8bGvF1IpKv8LH/uh/jhm5zAB9X/AHcV3er8qE
         Sj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wBkcpHEsygOVfK3SPXq4YWBCalRqJWRS9aTefI9eCgQ=;
        b=jgFTWOFgV6qLV59L50/yASCoyTgoXTq/sKV8GKz6nVG2wvUpGkycbj4BbBxlXBp2mX
         mMMVwN6tCIYJY9jR2IijJydhtD4ByMbw9yL5JEH7u5cMqy+FRSdBav789Kf6XULNvCHd
         4I/aVzUoKRTdlfBe9RLmxxxJVG2Q1ON/VjbJTXASelAve1AevfxpZvJusySJd80rCwiz
         EC4NMZJteHLYwlV7D+T3WaPkJK1rl7DyL2z4jhqx4FvjM5K9gM3ffcvYC4cuk+J/JSos
         EUdXA5UHneIbxwnAjzSGwjGwfTACLHXFIvUSNIK1//Ygjy6EqhF+lzvMjK+LPezJnQUp
         gETg==
X-Gm-Message-State: AOUpUlEqIFZFKJBHKedCetk6geozOadJZp8cPO1/rfwAsnJBmf4gmkkt
        FuZkIVZEUD0qinh9qgkHKegIOJnm
X-Google-Smtp-Source: AAOMgpdUIT7hq/7J8hjt0ZXriCGiDpY45YeNaLTOxtrLaHBge3BqVxRQ9UneH8YdTxsvjpjwgJ6NxQ==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr4631021wrb.204.1532201195817;
        Sat, 21 Jul 2018 12:26:35 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 10/10] staging:rtl8192u: Rename variable State > state - Style
Date:   Sat, 21 Jul 2018 20:25:52 +0100
Message-Id: <20180721192552.5378-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721192552.5378-1-johnfwhitmore@gmail.com>
References: <20180721192552.5378-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable State to state, this clears the checkpatch issue
with CamelCase naming. The change is purely coding style and should
not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/dot11d.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 21912b2d728d..2fb575a2b6ab 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -9,7 +9,7 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 
 	pDot11dInfo->enabled = false;
 
-	pDot11dInfo->State = DOT11D_STATE_NONE;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
 	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
 	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
@@ -34,7 +34,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 	for (i = 12; i <= 14; i++)
 		(pDot11dInfo->channel_map)[i] = 2;
 
-	pDot11dInfo->State = DOT11D_STATE_NONE;
+	pDot11dInfo->state = DOT11D_STATE_NONE;
 	pDot11dInfo->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
@@ -95,7 +95,7 @@ void Dot11d_UpdateCountryIe(struct ieee80211_device *dev, u8 *pTaddr,
 
 	pDot11dInfo->country_ie_len = CoutryIeLen;
 	memcpy(pDot11dInfo->country_ie_buf, pCoutryIe, CoutryIeLen);
-	pDot11dInfo->State = DOT11D_STATE_LEARNED;
+	pDot11dInfo->state = DOT11D_STATE_LEARNED;
 }
 EXPORT_SYMBOL(Dot11d_UpdateCountryIe);
 
@@ -119,9 +119,9 @@ void DOT11D_ScanComplete(struct ieee80211_device *dev)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
-	switch (pDot11dInfo->State) {
+	switch (pDot11dInfo->state) {
 	case DOT11D_STATE_LEARNED:
-		pDot11dInfo->State = DOT11D_STATE_DONE;
+		pDot11dInfo->state = DOT11D_STATE_DONE;
 		break;
 
 	case DOT11D_STATE_DONE:
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 0c7652a2ebb3..5639bb498865 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -29,7 +29,7 @@ struct rt_dot11d_info {
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
 	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER+1];
 
-	enum dot11d_state State;
+	enum dot11d_state state;
 };
 
 #define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
-- 
2.18.0

