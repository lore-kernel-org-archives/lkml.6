Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF79C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2YrEoQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeH3AgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:36:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56311 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeH3Aen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so6535444wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=55YwVY90eBG5KFtaoLEWS3jaom0WReVRI//+l3Cts7M=;
        b=U2YrEoQsDaZo8PsDx7w56PTqJEMun36A1KZbtguksfAwzjwYByTjSSuzFVms6x6P4u
         69BvNbrv1qvT/ZNHlqaARoOBmEcR9nobNyVYCr/jaq4ZqUA1JIUhGi/Niiewekxjs5Ad
         nrB4L4jkeNm/2b7I24RA+AhXxW7zmLkO9OG5rd+/cxRg5OD1zM1tOJD+l0hM3OOYQRpG
         MgcuoDYqXNOH8Qn1KA9kfXxLtL+dtkEz40Xz5jsM1pQ5efTCHZOov1lKdM0ZY02P5fEH
         NJKtPqN52DrqwlAXaqbsp6vgU5ne9W/TspuuDDznznIPT9UQBmgxdwRPLSvBlw9As0bx
         3/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55YwVY90eBG5KFtaoLEWS3jaom0WReVRI//+l3Cts7M=;
        b=LgUZT9/WhJL4KQoc33fbaukPBRg8QodoFUnVn5E9HHcpSN1bqZKvPITb5Q8wlTQKZh
         mfgwspZab8xDNsDiWcQXClDlXhLHz5ohNSaaCGIrGVRl3M842kt1CNI6X0bD+7sqbYbR
         EyjEsO1yiwHymA0VR1Eu5RwRHoMh0AEeBmsfgIBuYtGk80YfXggMbVRfB0j2gy6lZk3g
         EOg9Xbnq0gVJuikcQTPClIh67jQM3QLGi/r/bHvyTFuYB/dpTFi8utMdBif3mymY8HhN
         FLkM1cWw+LLZcNLcDxmhDx1ivBar5A0MF3MoJkr2FJr66gcN/2Ea88rE4RKUtPuoUpZz
         KBCw==
X-Gm-Message-State: APzg51B0/NzVM5zWM86yVo6qkrl6mTIN4fVX8puZ4JdBf2cXnbKXVSxt
        a1XS/YOb+Q/A5x4M72/tPzN5hNlxPGs=
X-Google-Smtp-Source: ANB0VdbY5CHlrCpx/fTQ7pDc1nHJfyw6/w9krSZdEe+lbVRkwbWfbvq9VHv7qOZS3Ghq3g3rsEkrzg==
X-Received: by 2002:a1c:ca17:: with SMTP id a23-v6mr4881943wmg.122.1535574967929;
        Wed, 29 Aug 2018 13:36:07 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/21] staging:rtl8192u: Rename TxSTBC - Style
Date:   Wed, 29 Aug 2018 21:35:33 +0100
Message-Id: <20180829203547.15650-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member TxSTBC. As it stands the name causes a
checkpatch issue due to its use of CamelCase naming style. Because
the member is not actually used in the code the name has been changed
to 'not_used_tx_stbc'. The two lines of code, one for initialisation
and one for debug logging have been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 23f8ee39e32d..ab61c9e81c2c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -45,7 +45,7 @@ struct ht_capability_ele {
 	u8	not_used_green_field:1;
 	u8	short_gi20_mhz:1;
 	u8	short_gi40_mhz:1;
-	u8	TxSTBC:1;
+	u8	not_used_tx_stbc:1;
 	u8	RxSTBC:2;
 	u8	DelayBA:1;
 	u8	MaxAMSDUSize:1;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 54c56cec612f..65c377094278 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -145,7 +145,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->chl_width) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->short_gi20_mhz) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->short_gi40_mhz) ? "YES" : "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
@@ -561,7 +560,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->short_gi40_mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
-	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
 	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-- 
2.18.0

