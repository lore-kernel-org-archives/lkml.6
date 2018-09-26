Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14B921537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK2Sogxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14B921537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeI0BcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42884 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeI0Bb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so2877263edr.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jvZ4B3Rc8jP1bZrJCiifd85smN7yybyprzKc5bUSjY8=;
        b=mK2SogxiDPaC66au9f9Psz/UqykXHPEO+OPsD7iyi3DyZlCs0Zo8UgYKrq/C61l5DI
         l+5aNWFHNM/siCOPJaDCYXZSQgtWTb3CayqR3xUF/8kClvG0jZgDJ48I4ag6KGK5YlDU
         nfFVhCVPY6zlEvIaBYvDLActW7L4IXpvqGLY9/+dswayVZVowQSelQBU2WhPrUnkJBT2
         DW94zxcdzdkKI8opEWax4pqLdaKJC3GIFZImndEZ5Y1zRNgKd15irwWLwaFJfKzttF+P
         KburAK7iNonWhgVFzHp5/SgibKCCT2lUJ8RCidEVIyE5HL0IeGezxCsp/1pVLESZm2to
         JY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jvZ4B3Rc8jP1bZrJCiifd85smN7yybyprzKc5bUSjY8=;
        b=FaBSwh5j55QpX2Ca5v/IZnEb5j4GfKnigNN7J8HBPdpNKpaghdvWALjd8+RAv0tyXI
         w4neeA8+8Y5snW9+IrnOMVtpHenlM8dEVIn98i1Q/4g8zNSs/VzxJVUM2VAogiVJAWfc
         jBHVtkP8jT7moEyaWzvBRf/nAtNR7caj0uOIvqrVmk9uIzwZE+qoo7ytyuFWpDzpVCmg
         uPkNPbQg3QQDY0FgStn2LRYxB1CYp5T4LFnV4C0JkfeOLlj/7DHM8ySpetz8mLl4rsy+
         sb/nxEspxXajv3cZgC17LFVTse/lRV/phfjN/92ZhHnuDX264YQt/xALAmcD2o6ajq00
         gn8w==
X-Gm-Message-State: ABuFfogxfwKiRgFLma7lrazKmcCuDQiUZiyjJHZaBgZ+ZBrKxL7N0eIa
        NioRqqdGa9IsyipK0vykt/NP6hSe
X-Google-Smtp-Source: ACcGV63Z9RXdxzGcmm01zcasUKtPNAV2GMET1R1yGVQ7vOlqTHJ2bUYbQJN3k38nYZbx1nn8DaNllg==
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr11853938eda.154.1537989451845;
        Wed, 26 Sep 2018 12:17:31 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:31 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/13] staging:rtl8192u: Remove DelayBA, PSMP and Rsvd1 - Style
Date:   Wed, 26 Sep 2018 20:16:58 +0100
Message-Id: <20180926191704.16322-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused member variables DelayBA, PSMP and Rsvd1.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 3 ---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 52cce0dcf9a5..09596a7a6814 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -43,11 +43,8 @@ struct ht_capability_ele {
 	u8	MimoPwrSave:2;
 	u8	ShortGI20Mhz:1;
 	u8	ShortGI40Mhz:1;
-	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
-	u8	PSMP:1;
-	u8	Rsvd1:1;
 	u8	LSigTxopProtect:1;
 
 	//MAC HT parameters info
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index b4220df1f833..94cedf5f1163 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -503,10 +503,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
-	pCapELE->DelayBA		= 0;	// Do not support now!!
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
 	/*
-- 
2.18.0

