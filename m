Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CFC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E85024E7E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqqUb+6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E85024E7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeFXJ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:59:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35556 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeFXJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id z137-v6so1146081wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qqpxA3A0cNqrCwP/X12gKZWSoRfxeL9sF14PFgFoqOA=;
        b=BqqUb+6P0sGtPyivqpXx2FDwCShUvf9xKk17e/9loSWqf0pgDdjpMGc8hTElWzuXO1
         a617+I6pMjm5kwNarG+ZEiXfXQH/9sdNy+BL/fQ56ZxOYOHi++jYIUn0vb7PGIQd45b2
         g3KBPFd+Vm7vdJA/8pZnW+g6cSVgrqFNsXg74GovhfmZpgmZGccbbJQ9OhCuleTCbsCm
         3NxQ/PzlS8O9TaCoAPK4LaZgGHXt4ZxJaeej40rLywitQOtPiDnjg5IkuOYTlFpDWbcd
         3ZGTswERWMhFDR3oajcADCeQRetleSNyYhpVFI+X1dBilT3tuwHz/2Hjz835nkWzSBFc
         BYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qqpxA3A0cNqrCwP/X12gKZWSoRfxeL9sF14PFgFoqOA=;
        b=XX3dLdMeCKmNd899VCQS2qy/FGcGnlNFObxVhRluE4Jos/qAvaUOA3/xIqjaSEFqcC
         e4O+Z8rszYq+TXRvgyP26W43d4IFbsF7an8194DNWiz4Y2u2QpvA0VBZXek5kxUCShaK
         AkcpGZgMC5ad/LMD/GkuoBpgzQQA/BMLj1bZJ+GqDaGFLdEoMO9mUVPHviSYP2x+gWUF
         6sz1+t+WADXDOnBkfByGbrFgH3pOkR+Z4ZNRjgNh3/r8FQ5k3m+uMTEoXx8vf0GnRe3h
         8cW5l+U72U9NCTSI6CQZo6zKaIqPYQnYveXGZnSSY/9FFIjr7V1IOBozDKbEQ3/QLh/a
         ghPQ==
X-Gm-Message-State: APt69E1XiJ5r5QSi1ANB6MVRWz3pJBJ2NVw0qVjCOG/mUIso66LsUa4O
        gupRT0kShgG0CQ08abmoF5r0lA==
X-Google-Smtp-Source: ADUXVKJomsH3kGLigpZz0Tj2JwMEdN23xAKO7hu61BIYe/SOoB2Gn7vMUiuy4etlzRns4OQ7lTdR6g==
X-Received: by 2002:a1c:5582:: with SMTP id j124-v6mr6554077wmb.153.1529834301075;
        Sun, 24 Jun 2018 02:58:21 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 6/8] staging: rtl8192u: Remove braces from single statement blocks - Style
Date:   Sun, 24 Jun 2018 10:57:30 +0100
Message-Id: <20180624095732.12082-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the unrequired braces from single statement blocks - Coding Style.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 742d2202652f..03ec7e6373c6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -549,11 +549,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
-	} else {
+	else
 		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
-	}
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -721,9 +720,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x01;
 	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
 
-	if (ieee->bSupportRemoteWakeUp) {
+	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
-	}
 
 	*len = 6 + 2;
 	return;
@@ -861,12 +859,10 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++) {
+	for (i = 0; i <= 15; i++)
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
-	}
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
-
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-- 
2.17.1

