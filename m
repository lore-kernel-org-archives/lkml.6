Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C765C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0403420661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQOaS8xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0403420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeH3Aez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40908 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbeH3Aez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so6758470wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKnpytX7EkMP9GS5n7vzmmh4NwAvnZgHiYsL1RjVEHc=;
        b=KQOaS8xDc/NSZF7JC/B8G2vm7vZXnuEDWAclGabZOnz6erZYaKEKQO4WrK8Dm750Jr
         R0NAjNgPLaanm97Lfvv1deRrz6cSRU6D4MC82Z0Z50zVtBvYinIkX6+JfASff8DRkK8w
         9/rjglILon3XMvjpWy1Ph/bB6QiMrJsYpRbzB8VzRRe4xzxZhLL/J1ndYPTKZDK4ydXU
         ZtU7svXvPwWojI/GOnAGVs8CGdbANfmKZpiS8InYYtqQjOIJMh/NPWqGz1ffNnYUjpVR
         J4xJk8gcM4bsnvYdT55/yq7vVuMmPS1jVgmQqFgC+5dGRFi7RqArfJlUFSkEwI7ay7kf
         RCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HKnpytX7EkMP9GS5n7vzmmh4NwAvnZgHiYsL1RjVEHc=;
        b=nkxgmktImQdxER4ZAqrpsDY6MG+Tdb5teWAZ2wkjJMN3Dy8OMMIiI2Jo6RDGhDE67b
         Luc+NfkzyHZHN6586x1FliVAWVtbvKS3P45EqRBFPGmDcJ+8NOtD/8TJd8U24h5PRCPR
         LiFKeU5cUkqcHx5KpZn7F7J0H1LhVpNAVyOuNZqwEF5SI/ky8HVvBI++5aB/MJRnMRat
         4+WYD5f28pBNuClEwGuQY7tyoxNuNw/BOLrp7Ps1HC5z8Efc2pvmolGSguwZaWuNOro/
         EPPr0kSUjQCfEPuXwc2wZIwkIJ3/B8a2nHEpLgVxTsWiYX1sbFXED2Sl6YJLS8v7Z4zO
         BpHQ==
X-Gm-Message-State: APzg51ApNQk6VKFIhfY3qW8U1D47unrkSlqLKBUsnC5WI/iZBtZuWX5/
        aH55lxVDxcKwUiHU99gnDfZ80s3TmnA=
X-Google-Smtp-Source: ANB0VdamdQ6WaHZ7mGi5Relgv03jgWlgzD4lcZ9zc99ifuJhakQj7RCdcCnPftTrxhqLMlG4OK1ZOw==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr4875574wmd.105.1535574979915;
        Wed, 29 Aug 2018 13:36:19 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:19 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/21] staging:rtl8192u: Rename LSigTxopProtect - Style
Date:   Wed, 29 Aug 2018 21:35:40 +0100
Message-Id: <20180829203547.15650-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'LSigTxopProtect', since it currently
causes a checkpatch issue due to its use of CamelCase naming.
Since the member is not actually used in code it has been renamed
to 'not_used_l_sig_txop_protect', and the singe initialisation line
of code has been removed.

This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 132a6da3bf51..040660a46bca 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -52,7 +52,7 @@ struct ht_capability_ele {
 	u8	dss_cck:1;
 	u8	not_used_psmp:1;
 	u8	not_used_rsvd1:1;
-	u8	LSigTxopProtect:1;
+	u8	not_used_l_sig_txop_protect:1;
 
 	//MAC HT parameters info
 	u8	MaxRxAMPDUFactor:2;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 2ea9fa3b6e0a..ec96e14a2bed 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -562,7 +562,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
 	pCapELE->max_amsdu_size	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->dss_cck		= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
 	/*
 	 * MAC HT parameters info
-- 
2.18.0

