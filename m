Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55710C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B64C21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdpUkeSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64C21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeI0Bc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39256 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeI0BcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so2890904edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUHn+5zQ4B8uUzmSrqpqoMMPhA3gdqh5YoJapseYOYk=;
        b=kdpUkeSkwQX60LaaRNKsWrfHBUxbQUeKUFw30+hG3bCtT7LDpwlsD97vIINZJqOSKw
         z+I8JYFB5KsYqXBfU6i2MQDhl5c0Q/lZoVJKiM2lRy8LMcmqoQ7wzPPD9SNtVFv6MRMw
         lEQ9dKC/w2RTc8DoZZ3Lc8cKC6pGC5UaCNLOvDkdpSFdrdEEHcrzQ2cBLHAK4l9dEdsW
         LMHGneJEvmWT4qypUT7rYVWehuk3CC0jY1Ke1cu5i20fK9FbnHrmDIsl0vlToqIa2uSp
         1vj3P8t0h90wxFitHfdB6xmQTguhyKoOWYx1GrKw/U1EDbXxAr7cjWcHjrqbZ6re+NoP
         Q4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUHn+5zQ4B8uUzmSrqpqoMMPhA3gdqh5YoJapseYOYk=;
        b=cDfeeee2iGcDvE2jCpelzaGMzSqhI2WqbkO+5VqO08/wQyRIpvaVwabWyNNW7XdqWa
         uMaLwPMZ0c49qdPiiRtMgJ+KymVe6nuTaC8cs9fmaeL95fwEXnfYrnE2B5rrJBbvVcyW
         FSGyT370SCtbl8+pHynHA9rl/K/34GMaXgc4WMLWdCiQog4JDLOAZCZyUq48xyCv0YOB
         zgkIdh0+Jzu4XOZq1o4Eyi901qkZC67MNeXI5uppAZ18qLu9bquXxT72dOBlBrSwxUTz
         yHd2yHRIBI9rvcYwsfVOzbMQMSm9PmmNamnDQXckNe/foQyCg/VA4NTLcdPrEfG0xnX1
         onuQ==
X-Gm-Message-State: ABuFfojLzwcw3zr+2Aek6Sw1bEHvM10BuJVZvI4H/HULS0i9Utz2OFpm
        ZIlQYKv9fTza0u7ziz+J+KqZ3DOA
X-Google-Smtp-Source: ACcGV63XmHAAu7DSPY6hogVvcHO+fiunYOJiYXtPLKfBz/0QlMgebtAS3Itvgc5SyYYip1CUsmSM1A==
X-Received: by 2002:a50:b1c4:: with SMTP id n4-v6mr11199199edd.128.1537989456601;
        Wed, 26 Sep 2018 12:17:36 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:35 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/13] staging:rtl8192u: Remove ExtHTCapInfo - Style
Date:   Wed, 26 Sep 2018 20:17:01 +0100
Message-Id: <20180926191704.16322-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable ExtHTCapInfo is not used in code so has been
removed.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 3 ---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 0c5ded7ad98c..f36fbf56c585 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -54,9 +54,6 @@ struct ht_capability_ele {
 	//Supported MCS set
 	u8	MCS[16];
 
-	//Extended HT Capability Info
-	u16	ExtHTCapInfo;
-
 	//TXBF Capabilities
 	u8	TxBFCap[4];
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 58c94440aab0..e20488ecbd96 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -542,9 +542,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->MCS[i] = 0;
 	}
 
-	//Extended HT Capability Info
-	memset(&pCapELE->ExtHTCapInfo, 0, 2);
-
 	//TXBF Capabilities
 	memset(pCapELE->TxBFCap, 0, 4);
 
-- 
2.18.0

