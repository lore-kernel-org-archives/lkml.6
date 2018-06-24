Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D9C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E1251F1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX+VZRT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76E1251F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755527AbeFXQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:10:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34663 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeFXPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so10291685wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+FLW887LuPN9auS+2Pf4e8IP23Kc8sU92edwQuq9WA=;
        b=eX+VZRT/YK5SSXGD99Hct1TT7q6Hskcze/kzK48eXkB57MwmP1FEhPNt03HmMeIU7b
         YRulrLrRKbLTSUPuZwf2olmKbDfhZhlOf2Iq/iSJlnja3sD5mEg20iBE6PobUbElZ8zD
         /1drjYdXNLqgjzzQQblVXln4ugo3yQCjhU6c6AQXS1tjrn2blT1Z7Fm2B6/cbG7aIv+d
         gTL8ms+AjEs4NbBlIo9t2yNyqhix00hKKybn9ZI0XK0G7U0ISG7ds12/yzB+VW6wGN8U
         NIS0V9m86dQFXHsSEHF35FUu9OHWilWuV9pc1WGI90wiztWsRt1mwU4i+GQo61QTWr1E
         d/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+FLW887LuPN9auS+2Pf4e8IP23Kc8sU92edwQuq9WA=;
        b=gRB3CKojj5miVqbgfQM7PhyfbAC1IRT72amumM7PhnbysXWAxZFfKYipx3IMA8gl/1
         gnbRz2fGmt3ob9WtkEU171rNVKd8G6tvxdoIC1ikw6zGYKpZd+SdVl2Nxzqb4aLGl3E/
         Dw7YlUd4ReZidSstrYAzwrmV7VSuaAfV/+c66S7u2GAUPilmi16gEmPDFCcp9W1rlYqL
         pEpYzZUp7luxOalD2ew3dJil/eepAGcW8CGu4Nh0Eqa98JyXyjP9jBwGlgFDtlS86REx
         q+FkQZlfDufG040AcOR1RRelA8DIf3UQEewqbz5Q++dajvsPH6e7yqufEuZFD4isayn6
         kYLQ==
X-Gm-Message-State: APt69E1g4y1Lep5/PRcxihVsqXxMl8MHQopWbI6mT1xn9VqwtRKbb/q8
        RNSz1Ysa8mr1Mx3ZDoSBdWck4pi4
X-Google-Smtp-Source: ADUXVKLpJyOVqYYsY8XPg6S0vmP36lw2DlkxBYRgycUxiEuEY60FpiTfszO4ixll9oFsyJb4+8NhWg==
X-Received: by 2002:a1c:852:: with SMTP id 79-v6mr6809493wmi.115.1529854561649;
        Sun, 24 Jun 2018 08:36:01 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:36:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize memory, instead of loop.
Date:   Sun, 24 Jun 2018 16:34:49 +0100
Message-Id: <20180624153454.27356-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced memory initialising loop with memset, as suggested by Andy Shevchenko

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 4bfadb49c363..ccb7bdf5ad5d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -742,8 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
  */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
-	u8					i;
-
 	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
@@ -756,8 +754,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for (i = 0; i <= 15; i++)
-			pOperateMCS[i] = 0;
+		memset(pOperateMCS, 0, 16);
 		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
-- 
2.17.1

