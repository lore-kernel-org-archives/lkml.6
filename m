Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F1C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE55251ED
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7oyp5wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE55251ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeFXQJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:09:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50661 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755367AbeFXPgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so6621718wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Omaajg3zht5wN0A/kRIdRl0rgfwuHeYz/DBwFOGT88I=;
        b=p7oyp5wTIm8Ckp4uosuZqssJi1Av0CK32BTqAlE0SQm0JBIWCqpICPzwv2P6+S5yve
         6TUw6DLRDAnAcKXC/1I6TgxSeCLbtELcJ7q0hSEstM8JcpFTVQGFdfv3e7O4LaexeHXn
         +L3XojkyUwMltucTGIW/ykVlx1Hj0CELnS4PPVusMXwOgXhwb1DPLquRkMjX6Cr+wcTR
         N4vHfjwKVrFl5VMK0CvoPpLtWkX8VUTQXdJcnJDSxqu+KmlU/U/bmJxFpghy1kQkN0aX
         EmXkePaQlyhuz7sG+yzRbbzfN47nOF8muGM92aW7Iw1ppetWToYZgtV2lxC13iIzpDrd
         jnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Omaajg3zht5wN0A/kRIdRl0rgfwuHeYz/DBwFOGT88I=;
        b=s4iFRPFNfDbrmhBwHvt0w43MHRBdbDmceUwzJMOl88/Pr6mA9nuDTXBU65ov+mprxF
         /ac+dEoFeVOvhak182C6GwObfD0HDVMWTkeX+V53KPRdLkbdzUwfKN9SqLAmOHCHthK7
         aerLldHOv4s4YcC2iSFiQ+/+djjFAWmxyqOM8LUzbWZZhCrVqPaVl30q9KY3VqOW9DBz
         uF0h+rSHLcKRyWcjZ1dh0KKSmwCMhG/jDQ/xFuWO5rfU0fU//FM2cfSQQXjKjCwitRg4
         3g1GZcH5/5zTA3WIpHoopKCzRDhWdYfGnpdIpsb+jXUFV23Pz6hshAzYTMXOqagosl77
         4mcQ==
X-Gm-Message-State: APt69E1hU5Wgn0Qqgx5S+YzNPs5olE6RdRhKIs54JPfheAjUiAkGFmf4
        zxUb5oghUSF4RVB5QedhrsALoghY
X-Google-Smtp-Source: ADUXVKJboAvweHiWMlUeoE5w5WtTK/vUxHOV1lo0/MUX86BHrNF4ANLLgUgZmjnbt5uiVLbPPpfCxw==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr7237466wmg.69.1529854566587;
        Sun, 24 Jun 2018 08:36:06 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:36:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 6/8] staging: rtl8192u: Remove braces from single statement blocks - Style
Date:   Sun, 24 Jun 2018 16:34:52 +0100
Message-Id: <20180624153454.27356-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
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
index 6793a9aabb2f..227710419123 100644
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

