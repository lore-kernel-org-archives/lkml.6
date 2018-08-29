Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E1CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B87E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiFS0d0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B87E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeH3Aes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51423 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeH3Aeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so6531657wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWdMSofiEB6XM3Cd4zpAoBRmPICxrXEwy4vbTkoaSHQ=;
        b=HiFS0d0iYWFXgeZQplxYS2BqdsYhdppVLLiTegNzlZ5FQTkSOMA2tlBMkx0MV5vn7a
         xGBcvwG5kBU0RjSZUllpGnuSyhpVElBMfPfAhXt+kb1txHS4fWZKTVyVRFu16+Ynqgtk
         z7sNrTJBCU5lxhSzIOfcT2mknHJys1KNWsR/wM8PYjHyOEGHicZG1xrS6Xs8/at2SxXl
         GtSPA+XC8CTCdYfXiRBcspEbxHNgHgp5BiDzy9t7LJecg6NyetSWfpJHtJDaL1C67eA/
         eXXrZ4ZdtfUBW2vFex6PAeukvxPbFu3o8S4yuzCj/XL0pV0MkAqObC2Gys0K1qaTiEuZ
         Qxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWdMSofiEB6XM3Cd4zpAoBRmPICxrXEwy4vbTkoaSHQ=;
        b=ncgLKIoObEHAsZ3jOPybr620tJ8gFtj1/RJ59y39YosnAr0H4xagw4h7Ue/cYYUptx
         X+UG9WD3XPLLz9DIzfLD33EDLBeNse0ZhXRqy17euCe9HLP2kYSFt8Prm/LWQyM13kl8
         jVwfRAFnleRy+wcTxury3Hvyro73KedsW4jFEDmxzIRGU5IfUzmt+qvIBCh7VJ81Ada+
         3LmARGII+16woPmBO1Enw9Qui3FsiwJlzRUIgRmFYrz8wUOff1JJ7C3Sit5UBg0+PK1B
         Hi7EB7OZe/2GMduguG2gC4Oov+KUALZ0T9kLOHQEv9FEZHMroHtTfAlaL5MpevfPhUoj
         hBPg==
X-Gm-Message-State: APzg51DcmkVooCMY2Lml0KjhTvNBNBCYlMvv6SzM7Rf7WSeAD7DSYVcj
        ohDHWXnSo//sNvgLCwbo2mNoPbA25OE=
X-Google-Smtp-Source: ANB0Vdb/QFtX7YfMUesdYfYo07t6vlHpd6p/fIIKEbyA+A7XWpDf/BF0SXt84CDY+UdLVrUvb0KFAg==
X-Received: by 2002:a1c:ee57:: with SMTP id m84-v6mr5169173wmh.9.1535574971449;
        Wed, 29 Aug 2018 13:36:11 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:10 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/21] staging:rtl8192u: Rename DelayBA - Style
Date:   Wed, 29 Aug 2018 21:35:35 +0100
Message-Id: <20180829203547.15650-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member DelayBA, since its use of CamelCase naming
causes a checkpatch issue. Since the member is not actually used in
code the name has been changed to 'not_used_delay_ba'. The one line
of initialisation code has been removed.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 994ff0f30a07..864bb9db2433 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -47,7 +47,7 @@ struct ht_capability_ele {
 	u8	short_gi40_mhz:1;
 	u8	not_used_tx_stbc:1;
 	u8	not_used_rx_stbc:2;
-	u8	DelayBA:1;
+	u8	not_used_delay_ba:1;
 	u8	MaxAMSDUSize:1;
 	u8	DssCCk:1;
 	u8	PSMP:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c0789ddfd024..bc1d8e9221aa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -560,7 +560,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->short_gi40_mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
-	pCapELE->DelayBA		= 0;	// Do not support now!!
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
-- 
2.18.0

