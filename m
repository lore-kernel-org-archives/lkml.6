Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220521A1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsq921Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220521A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeHQVjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35046 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeHQVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so8214455wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=awD+YihZlKrMKnw96Z2QnWpjSYkGcWlBYcds4K8gqJ0=;
        b=Gsq921KdwKwtyHbJmtoyoHNMfDEPHEWSPkCSMlSFP5LynQHfQ9lBMcIx3OgdoI+jHI
         0PuKgOPMWZT9VBF5HtiIZeMA1rzgY2sV3v/fZCfA4xgMqx1SInfCf7NdB58kImdegegy
         p4AQF/OdETyLaNbscsiQJVkmUNdXwloHq1DAu/mnjPF7gxn549Tv7pyoe44LERztSgyY
         xKh8J4cQ0IBJgg3J243D2Wmq+pDkNDEICSDF+a9R54Uinoso++u3aoCG5iGWvkRhS7xH
         l5IEf1jbzD+F8accpm41DeLR7RAJN0nSG+6SIRRI6HjqdyWTvZUXytnc//s28mt+LiK5
         pIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=awD+YihZlKrMKnw96Z2QnWpjSYkGcWlBYcds4K8gqJ0=;
        b=kPETPq5LvJVImEtXsfLzGNK6wYlc1cNvjNV5Hhz/w/jy3ZRTQgfVw34GNt3nbEpiEx
         c4l+MgcBRDYvVN5iF+S4R01XCWNpHTWea1aBI/kNlAPFoNL4Z1G/TJA0pjoNvaqjJgIP
         H3R1cChdcj2klb78zxh3jVsEv6LXxrM/nrzxUg8jOD7in1ZxkRnLO59XlSHaxsj/Apcg
         AHI3glMp8PfRJbsfJKEKwHOBSpS/sf7OwBwXnDoPBge8lddpK8yo2fMoBxA8TwHbkLYU
         RfozoW749R7YL0f2Zd6IXwDVvSpI+ANXAoEWmqoPFw/II0FaUm0dAsQCoX+B+e+Gc6cO
         zaDQ==
X-Gm-Message-State: AOUpUlEh3FO06CPDx59h3zS8kWuFrHw6csku3EQqHtTgFLRGBeprEyn8
        hn/MPbwaCgkDjpt3qmCUrFxPwA5Mz98=
X-Google-Smtp-Source: AA+uWPx62ukc4pnpks0IWZEbOpPMQGy0g7Ij20NLbgzGTwuSFae0Fs9DwXX56mXqRcl0URTuHrfVlA==
X-Received: by 2002:a1c:cb87:: with SMTP id b129-v6mr20841424wmg.64.1534530911096;
        Fri, 17 Aug 2018 11:35:11 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/10] staging:rtl8192u: Remove enum CHNLOP - Style
Date:   Fri, 17 Aug 2018 19:34:46 +0100
Message-Id: <20180817183447.15993-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type CHNLOP is only used as a member variable of the
structure RT_HIGH_THROUGHPUT. Whilst this member variable is initialised
it is never actually used in the code. To simplify the code both the
enumerated type and the member variable have been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 8 --------
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index f63c028b900a..176caa74e4a8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -37,13 +37,6 @@ enum ht_extension_chan_offset {
 	HT_EXTCHNL_OFFSET_LOWER = 3,
 };
 
-typedef enum _CHNLOP {
-	CHNLOP_NONE = 0, // No Action now
-	CHNLOP_SCAN = 1, // Scan in progress
-	CHNLOP_SWBW = 2, // Bandwidth switching in progress
-	CHNLOP_SWCHNL = 3, // Software Channel switching in progress
-} CHNLOP, *PCHNLOP;
-
 typedef	struct _HT_CAPABILITY_ELE {
 	//HT capability info
 	u8	AdvCoding:1;
@@ -192,7 +185,6 @@ typedef struct _RT_HIGH_THROUGHPUT {
 
 	// For Bandwidth Switching
 	u8				bSwBwInProgress;
-	CHNLOP				ChnlOp; // software switching channel in progress. By Bruce, 2008-02-15.
 	u8				SwBwStep;
 	//struct timer_list		SwBwTimer;  //moved to ieee80211_device. as timer_list need include some header file here.
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index b948eae5909d..155805e20143 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -1122,7 +1122,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	memset(&pHTInfo->PeerHTInfoBuf, 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
-	pHTInfo->ChnlOp = CHNLOP_NONE;
 
 	// Set default IEEE spec for Draft N
 	pHTInfo->ePeerHTSpecVer = HT_SPEC_VER_IEEE;
-- 
2.18.0

