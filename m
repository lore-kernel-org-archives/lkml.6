Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0937FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2203205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcBDk9Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2203205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeH3Aej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeH3Aei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so6033387wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HtZ4ADlLx3rAZT/2MNcUOoKOeKkQXY8I0r7jjo+0OGA=;
        b=BcBDk9Uy5VHVpcrEPTZUDjbshqdXAgdpa8m+vteJudLfZw1H4kI8hKbqB8ywDkcspI
         OLIeJ4qhmd2FVPY9Zwzob196yeF+d+4IkfpL6Kk5GzLsYSToald8RhepmVs8Vs0Q88YG
         HBM5VEI3ACfNeN5svUQSESpTU/tyvb4sjDuWKEnPisniQFFJbByHe0J+JXme9dmR8XvR
         R8e+Zbj8wHvtX8xnhnPmX92HiCqT41TTtzBx4glluFZuD1Kx3mOm/UryqayIE3SZhul/
         +USh78COqb04YxyjjVhaKECaMgXJn2Y1ffDn9Pfa1OUGEzkq5urObP5tU/yJwRxBz/Br
         6OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HtZ4ADlLx3rAZT/2MNcUOoKOeKkQXY8I0r7jjo+0OGA=;
        b=Qnn2i4jYyPokvqPyBiSDrp7YPltJ4J4Qd+RE1FpzWw8gBnLmV6T3Foci7WMqJ1jJQQ
         HjaJB3jMCKog8AXzTmPHNSy7b81yemMj3q8A9DaVLK5JSgqhNWhveVqaQQ3QSv9vXVz/
         Ew8sZOcWMhTXsLRpTnFiNT7w67F3cReVgzqrQkfJekLQDX/Avy3T1jobJSfthQ4drXiq
         yGwKkt5PJp3Wz8ImjehEVdwemGwgJamBteZCDelhDh5eA6uWuPLO0SDewvoAFRGhRTS6
         grGGw6t4Ely7MZhwbsoBbeRJH8pOgXMY6rLyjrcMxQTnMS3PJyYTv2nEJqbG3Za/PKyw
         Yrww==
X-Gm-Message-State: APzg51DfwxOyBeGp7TnjlyxuFsmqmcwhs6BdSA/+vXo1h0b1ZG4o/Bj1
        JnxvFoc/M/s6qn3LlTC7JDMnDOGpNv0=
X-Google-Smtp-Source: ANB0VdbXcVYWU7V6putlDEl6tAM1ZEv8g84tk3SFOk5WFgR3ChaLsy2vBGU9VaZuax/y8o9gKJKG2A==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr5505146wrv.102.1535574963388;
        Wed, 29 Aug 2018 13:36:03 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/21] staging:rtl8192u: Rename GreenField - Style
Date:   Wed, 29 Aug 2018 21:35:30 +0100
Message-Id: <20180829203547.15650-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bit field member GreenField, this change clears the
checkpatch issue with CamelCase naming. As the member is no longer
used the name has been changed to 'not_used_green_field', and the
redundant line of initialisation code has been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 069f93e77c46..705d811cbe01 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -42,7 +42,7 @@ struct ht_capability_ele {
 	u8	not_used_adv_coding:1;
 	u8	chl_width:1;
 	u8	mimo_power_save:2;
-	u8	GreenField:1;
+	u8	not_used_green_field:1;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
 	u8	TxSTBC:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 7cb18c2f6d93..73745d8406aa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -557,7 +557,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 //	pCapELE->chl_width		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->mimo_power_save        = pHT->SelfMimoPs;
-	pCapELE->GreenField		= 0; // This feature is not supported now!!
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-- 
2.18.0

