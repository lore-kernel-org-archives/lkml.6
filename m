Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ADD2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/2DaP/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ADD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeI0BcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34681 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeI0BcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so2918322edr.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8wzbzVNb8z4f7zGI5PF1gBJAjaMNEBp10i4ACaKIQ4=;
        b=Y/2DaP/cr4smYkI4IGZL0RqVI9mW2IYKqxQvlhevbM2xg1KDg2kMPEjAjEgAdlmnZY
         turFxwhbsq9P5P+h1UGI6GXEA5B8UJYkP931J7RhYKKvBjaNVJvjSO9MgkiFuubhQHfS
         w35eMHoOTZU5rWK6NytqxAu6tepHKmqW03Z6rgvbcrxUXkMLHS+qX/AQkqi00WvKQhuj
         M9cqHeg127zwaDLlPadi0ESV0yH0Cd65zNnE44AIg9sRWQsXvf9PL5P0Ph/u4GHrk1Ar
         k1p/V1UsMFM7sVEF2WSO/oEJXNtYhRTMLw6qjGYEXUleraioY4UIyxtVxghzrkCcF1AI
         I6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8wzbzVNb8z4f7zGI5PF1gBJAjaMNEBp10i4ACaKIQ4=;
        b=alYeQLlSg1BZufNGesJkhtJd6XzIk2SJ1EaD0weHAFi8CazacWyBWaNHRCt/f9/mRq
         zP6EQg1gOvnO6Z6CNBv311HfvdnMPYBn6o3b5e0srK3F7JUztEpO4WwStbPdCb/rLzky
         /49+dOheYsCIrxyZaWcz1SzZmPtA1Z/E3AAv5dWyr4orb36L7NcieM8+46W9XhRf1PSQ
         v8nqf2I3dIjy9pXm7YPSBB3TlpLMZDxsEWsXn5a5xXpn8kwlu48SdeWQ+X7XrARRJFJA
         AFPIxksTl5X8UtbKpg1jga66z2ppnuAPRpEJWrtTvv6uagkiq1ZyC5mKE7or+lc9XMSt
         0tlQ==
X-Gm-Message-State: ABuFfogcIycyKtJfYeVDFfVXE7EOnfYqUiNQIfWFVA+JgMK3MFTZO3F1
        hFnNgVioxPeerKRq03EeCXiy6rI6
X-Google-Smtp-Source: ACcGV621skKnxQdFcFymBvHpoxKaVk7KrbuMDutc6n9wVKhFICX6hEEMOQ9tYeMlz/NhJmdH89yP3Q==
X-Received: by 2002:a50:adaa:: with SMTP id a39-v6mr11943158edd.194.1537989453336;
        Wed, 26 Sep 2018 12:17:33 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/13] staging:rtl8192u: Remove LSigTxopProtect - Style
Date:   Wed, 26 Sep 2018 20:16:59 +0100
Message-Id: <20180926191704.16322-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused member bit LSigTxopProtect. This member is not used
in code so has been replaced with a 'padding' bit, to keep byte
boundary alignment.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 09596a7a6814..4154b4e27e59 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -45,7 +45,7 @@ struct ht_capability_ele {
 	u8	ShortGI40Mhz:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
-	u8	LSigTxopProtect:1;
+	u8	padding:1;
 
 	//MAC HT parameters info
 	u8	MaxRxAMPDUFactor:2;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 94cedf5f1163..58c94440aab0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -505,7 +505,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
 	/*
 	 * MAC HT parameters info
-- 
2.18.0

