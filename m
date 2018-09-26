Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE67C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1zFwKZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B98B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI0Bcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38388 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbeI0Bb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id x8-v6so2899134eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xHM1Og1FdC5928qK1RtWyMdCqpx4t+JGKtojb6kc5Bg=;
        b=S1zFwKZj7gFm8maPoWdA6QGyB+uLOZmYjesuc6h1ievfu8Kuk9egWiy+f++MhMf44L
         zdLgJ3IxdXSK9TTTRaEfNlIlwL5CWzouBz6ZO/QjFxYiFMV1Qj3Y4cL/CrqKvRrXWgxo
         4UA/6lSZz5JTYWiHis39ZXZoBgfH/ZHVM76P2KAAZskQnXg94EuVB/Hm/tAx74R4+qTw
         oqF1we3qwS91T1eXpishoLESQ6XKipkvZZBgw2ykqa/E3O646Wl10Db5rUkNnVmU5RZ8
         Q5JUdz5ZbkwmZir+RcbSaxB1NQzCeb3b7G7EekaBe8GnhF4R6T+nKG4C0bkG7CWlk1Ra
         VsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xHM1Og1FdC5928qK1RtWyMdCqpx4t+JGKtojb6kc5Bg=;
        b=BPjwWM+N9BovHNeqmm80UPSWcQkRBCZxkLlJsI/wbHlTlkAcqjWL6By18se0tTxskw
         48v6gTws+GJ5RweGlBpYFLvtsxKHApwQ1aVb6bFaK8SQ+HBDKE1BwkVaDCrK8rPWO/5J
         /rEA7EagAGaMQOYa2NPclqBtklQTaKE5PZSJqFmZo55oe7XpxvXCzwP4SRpRVoMINos+
         6gt+50NVVywzmO5haPIiv/AUG02jxNAuFaUpPPItamN9773L8BVDoFYcwMo8oRzKzY0e
         OyaqngckHtLrDltjer41lHRJXYsehiUi6nz5sOm03cbk4BgrOd++mjvmJ89R78DKf96j
         pXig==
X-Gm-Message-State: ABuFfojcCiORYpOSSUa/eIC3IMusPTqtn/JQCS3nFOW8gVnwl/Kp7JjC
        w0C+BaDEd8NK3CJ8p+vdmBgtdRMN
X-Google-Smtp-Source: ACcGV63oXeyQKCsjrhONP0CPnNzLTUU7dBxrVZmMuvJuoxLFj9yU8KamME4oRhHvbWR/hRytW6Wxxw==
X-Received: by 2002:a50:c40e:: with SMTP id v14-v6mr12214268edf.232.1537989448992;
        Wed, 26 Sep 2018 12:17:28 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:28 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/13] staging:rtl8192u: Remove AdvCoding and GreenField - Style
Date:   Wed, 26 Sep 2018 20:16:56 +0100
Message-Id: <20180926191704.16322-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variables AdvCoding and GreenField are unused in code so
have been removed from the structure and associated initialisation
function.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 64d5359cf7e2..83fb8f34ccbd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -39,10 +39,8 @@ enum ht_extension_chan_offset {
 
 struct ht_capability_ele {
 	//HT capability info
-	u8	AdvCoding:1;
 	u8	ChlWidth:1;
 	u8	MimoPwrSave:2;
-	u8	GreenField:1;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
 	u8	TxSTBC:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c73a8058cf87..d1fbe65ed428 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -493,7 +493,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 
 	//HT capability info
-	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
@@ -501,7 +500,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
-	pCapELE->GreenField		= 0; // This feature is not supported now!!
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-- 
2.18.0

