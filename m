Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB92C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C812174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRSMYo8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C812174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeHGX3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35415 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeHGX3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so84549wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O38dp8wzu2hQ9ZnxqPGd1I0RrQZGin2pNCiczhGzGEA=;
        b=vRSMYo8wH4KN3OEsHKycfi3hbQh1+5F2ySH8IyKRaIxpQSpnOjj5EqwRmGBtNF9kkW
         vpcfQMXdTjxP12OzDQJxUJ7nol5VriZgSDm2xiBiXpYykcIlrRamDkrDFfKqufRaIfLJ
         e8ozCDD6IDPT9CqMZnOCV6NGOba9csCd3Z0rV8uewpvC/fXx14sm7UB4AybsNLkbZ1G7
         qzBZkUwGPaPhi2f9H3J7po2+KoLT8iWF4WHTlWQWqaxpDR8hVXlbKfcYFGhoG4JdtBAP
         g30s392t2TwfBrpooaBhkSx2zWtfZ4dRhJqrVuERqCa5sKxb4IfUAihhcSH2B1yyEwSM
         GxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O38dp8wzu2hQ9ZnxqPGd1I0RrQZGin2pNCiczhGzGEA=;
        b=hbGEHyq1JUBR9V0iUu/kBrZvFEJ4B0tr5h05UvIG1Ux+5u+YSk3v0W1tyzXi03/dNg
         54rfHyVkiDzxS2gCwXzNcFNmyG5s7ArsSOJcNVK+M+byLUMnZtHUidNAmDJCHT1a7XO0
         CT8U/lBL7+HiIjP/OCq4FXJrs/nKMoZu6mhABubuDfGKVNLvGu7nk8wiE+0qrIXtuBlU
         awT313H+w2w4QeHE/ufTQUoUvDiQDoWsbN7sYF1zNUTJtHjD/j5yIQ+whVAzD7u3aUZh
         8CR26xPNw/W7EdFmeGeGHRJy1VNZV1bKWwgwg7Tdr2VK9MJydNa4QKnqW43+C/DZxajK
         zUGA==
X-Gm-Message-State: AOUpUlHFlBoxcf6B9DkG8N5nneks/VDf6w3c4smRvkgwU5yfgmOsTASR
        O+xvDbaThk+onl99WTXY3Q0Ldlwn
X-Google-Smtp-Source: AA+uWPxBP62+YuNaS9BjPEDyrEN3XlkrII449nxl2pnIriqE58mNPkiuenuC5s3tN3WeBj6cWSrzgA==
X-Received: by 2002:adf:b642:: with SMTP id i2-v6mr64100wre.54.1533676403440;
        Tue, 07 Aug 2018 14:13:23 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:22 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/17] staging:rtl8192u: Rename DOT11D_ScanComplete - Style
Date:   Tue,  7 Aug 2018 22:12:53 +0100
Message-Id: <20180807211255.29343-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function DOT11D_ScanComplete causes a checkpatch issue due to its
use of CamelCase naming. The function has been renamed to
dot11d_scan_complete.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c            | 4 ++--
 drivers/staging/rtl8192u/ieee80211/dot11d.h            | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 3a11c0ad3f2b..48911c68b7a4 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -115,7 +115,7 @@ u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel)
 }
 EXPORT_SYMBOL(dot11d_get_max_tx_pwr_in_dbm);
 
-void DOT11D_ScanComplete(struct ieee80211_device *dev)
+void dot11d_scan_complete(struct ieee80211_device *dev)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
@@ -134,7 +134,7 @@ void DOT11D_ScanComplete(struct ieee80211_device *dev)
 		break;
 	}
 }
-EXPORT_SYMBOL(DOT11D_ScanComplete);
+EXPORT_SYMBOL(dot11d_scan_complete);
 
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel)
 {
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 847f5d51a6ec..d52ddad1cd42 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -56,7 +56,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u16 coutry_ie_len,
 			      u8 *coutry_ie);
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
-void DOT11D_ScanComplete(struct ieee80211_device *dev);
+void dot11d_scan_complete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 39ed743a1a56..a20c79401dab 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -464,7 +464,7 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 	} else {
 		ieee->sync_scan_hurryup = 0;
 		if (IS_DOT11D_ENABLE(ieee))
-			DOT11D_ScanComplete(ieee);
+			dot11d_scan_complete(ieee);
 		mutex_unlock(&ieee->scan_mutex);
 	}
 }
@@ -504,7 +504,7 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	return;
 out:
 	if (IS_DOT11D_ENABLE(ieee))
-		DOT11D_ScanComplete(ieee);
+		dot11d_scan_complete(ieee);
 	ieee->actscanning = false;
 	watchdog = 0;
 	ieee->scanning = 0;
-- 
2.18.0

