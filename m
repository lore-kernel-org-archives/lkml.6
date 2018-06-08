Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rGThExh+GluwIQAAmS7hNA
	; Fri, 08 Jun 2018 13:02:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B4A68607E4; Fri,  8 Jun 2018 13:02:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvtm7+jO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3237F606FA;
	Fri,  8 Jun 2018 13:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3237F606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFHNB6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:01:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51322 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeFHNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:01:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so3219846wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a6MbZKt5Rk7aLT+i8yfO+IulC1JEMSIiSs5XQ8pH9dg=;
        b=Wvtm7+jOpAkMFvnziNfQ6+v29D+dygwnE8bna+R7zIrdGxWCqJF+VQg10NsuZAvRB3
         wrxqFn7UWcrFR2gmZr7yKuOEHwZKlitUMpqMp1toto4jWEmyLEgARmGUZ6d5CozRe77T
         fKRnENa0Ymov+SciomcxCzoYeMAjO4/66vjl3h3Sbequ8ZPlXDiV07yUq22Kh6DW/txH
         BUFvJO2nunzNbrzSWOO5KqODUfTQDs5THbYIvMGql3hEhyyAstK/REjEwzttq6fq+Dwp
         ayZKG4NVVqNIuwzGLnsEIyfWfFCH1n3aoyIriEVJ+2vWFvRbs/R6B/xlqVsQiNUhGOgj
         bXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a6MbZKt5Rk7aLT+i8yfO+IulC1JEMSIiSs5XQ8pH9dg=;
        b=c7S+jE1KBPmLN4xb351L3zaNMb4z5s//D/GnAqWyv9dysvmlu9Y7eV5wIiPA8bwWAI
         IeOQUsB+1XIqCJ/9zakRvQUUoj/todr3WOPA7tWxIXr+bE3ktkWQEFXFRIw7rK3BTrMs
         iE4D8FNLV41d3sGsouS4SvnUoO8oZ8Ife5pYo/Izcb0aSNhaTq7gBh+WmwL+N5ZHBXrl
         4tDBkX3ZjxIlyYPITYZfNRRCDAQjoe1Y513NlEqLs8R7ji491Q9sT5C80kP+iCc9FXv4
         UjY51V1sZRgtVskZn+6c9qw4G7ZsDDorq//yFlzprePqszTYFS6njjiyM/a7O2D+41rv
         n3Qg==
X-Gm-Message-State: APt69E1lJ0AO6vg7O/uyFeuzdvBPHlsHJlMLpUbUnCbNNXSfQpk7vmdE
        jOtzuW3eosLSTYiyil5LZYg=
X-Google-Smtp-Source: ADUXVKLK9Ewt3BpdApVcVk4asxoby7XKzwRE7fWG0rA2y9vCJLjTAETWM3mH3obCJ1oPsDO7drr2sw==
X-Received: by 2002:a1c:16ca:: with SMTP id 193-v6mr1459500wmw.37.1528462916007;
        Fri, 08 Jun 2018 06:01:56 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w3-v6sm10986610wrr.88.2018.06.08.06.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 06:01:54 -0700 (PDT)
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: tglx@linutronix.de, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, colin.king@canonical.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v7 8/8] staging: rtl8192e: remove unnecessary parentheses - Coding Style
Date: Fri,  8 Jun 2018 14:01:37 +0100
Message-Id: <20180608130137.4822-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneccessary parentheses, and removed unnecessary (void *) cast

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9cca4a8f1cf5..5a48693e2cf3 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -529,7 +529,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
+		pCapELE = (PHT_CAPABILITY_ELE)&posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -1072,10 +1072,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
 	// Initialize all of the parameters related to 11n
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
+	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));
+	memset(&pHTInfo->SelfHTInfo, 0, sizeof(pHTInfo->SelfHTInfo));
+	memset(&pHTInfo->PeerHTCapBuf, 0, sizeof(pHTInfo->PeerHTCapBuf));
+	memset(&pHTInfo->PeerHTInfoBuf, 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 	pHTInfo->ChnlOp = CHNLOP_NONE;
@@ -1091,7 +1091,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 
 	//MCS rate initialized here
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
-- 
2.17.0
