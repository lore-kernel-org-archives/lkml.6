Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75D220647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqpRlOU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75D220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeH3Aeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so6033344wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/jLsZ5ZegUQ+kADjy8EWYT07CcdTb1zkbSGovbTM+s=;
        b=GqpRlOU67dCSZao7Z9GwRNCRhmmYOvFLkeNHYRTKnkbdewH4Polz7lcWINhPPSw5Vh
         S1fr4iAyfZmv3r4UN4mQpGbD2X1CQbJ4j/g0P+LUgvMU5WQfFHNMwaQd8FeLnTNiXern
         fvl1taWZWIfa3pDqfaVNS4T5CZ7lIPZKJvSHCC00ed9QtIXczTjTgjiWC388r/7GjjAB
         Gkzs+z439YkyNqI5lPg557ksYMAZ8BNLuzIkRIeNBrC08ug/xITi8cp0v8F5+sFg1VNW
         ehQDKvKwOyLw75mxPSql1PpL5lAJ93IX2vl2PSGVwNk5xs4Iiqr21yMHLj//pSBTW+Zv
         SZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/jLsZ5ZegUQ+kADjy8EWYT07CcdTb1zkbSGovbTM+s=;
        b=eo/RU2M+Qiv3rwwzdS6VpK/LgAurTTQyBY/YXjkBuA0PFez8NImt6FALdDmGFan3bA
         D9XOtBkjAMhyF1uBJfVDfGFEwSH1vJlZ03YkYuDBaiB3Ue9Crc1WTQpt76qeYXIlm+4n
         gz6EyiQ4WmV4/CMRkRrdvLmY74vzoPkC0i/D6NnJVrXwKRK26ICNbt5tq/7xuICPZyp7
         j+jeiPSBfpBmLK3I6yJIkr2CvOTkFWc3+BTTjpOpwYxcQEQ4R9BmKJ2PIJJZfwKuhyTZ
         JkOLDuOQ27NoT4e5AEYp+48N3hnqwHebcz3fI5KrPdVvB3rmHCRGSGjGqPEY5Va0eTXA
         3NUQ==
X-Gm-Message-State: APzg51B30WoEb9+aYxrZv9WvUTce+x73a119gOpSpRo8F1Q3Xop3Byf8
        G1b+B79yrQHpJS69X7Uc+74LIcb+IFw=
X-Google-Smtp-Source: ANB0VdbOwGD7zQuOqDVFMkg+CcJoDqVm5B4p94xKSfeNd/Sei/BxMi94tGR1KVz+9SUdnccmI7Lg+A==
X-Received: by 2002:a5d:69d1:: with SMTP id s17-v6mr5509447wrw.77.1535574961753;
        Wed, 29 Aug 2018 13:36:01 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/21] staging:rtl8192u: Rename MimoPwrSave - Style
Date:   Wed, 29 Aug 2018 21:35:29 +0100
Message-Id: <20180829203547.15650-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield name MimoPwrSave, to clear the checkpatch issue
with CamelCase naming, to 'mimo_power_save'.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index d79126853cd3..069f93e77c46 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -41,7 +41,7 @@ struct ht_capability_ele {
 	//HT capability info
 	u8	not_used_adv_coding:1;
 	u8	chl_width:1;
-	u8	MimoPwrSave:2;
+	u8	mimo_power_save:2;
 	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index d9c2a2df8d0e..7cb18c2f6d93 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -556,7 +556,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		pCapELE->chl_width = (pHT->bRegBW40MHz ? 1 : 0);
 
 //	pCapELE->chl_width		= (pHT->bRegBW40MHz?1:0);
-	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
+	pCapELE->mimo_power_save        = pHT->SelfMimoPs;
 	pCapELE->GreenField		= 0; // This feature is not supported now!!
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
@@ -1052,7 +1052,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	/*
 	 * Config MIMO Power Save setting
 	 */
-	pHTInfo->PeerMimoPs = pPeerHTCap->MimoPwrSave;
+	pHTInfo->PeerMimoPs = pPeerHTCap->mimo_power_save;
 	if (pHTInfo->PeerMimoPs == MIMO_PS_STATIC)
 		pMcsFilter = MCS_FILTER_1SS;
 	else
-- 
2.18.0

