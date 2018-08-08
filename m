Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE52621A79
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT7Wq8oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE52621A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeHHXWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42094 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbeHHXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so1878235edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jetCnrPb9S11c3Yjs3Au+g87ylHqFE2uLFBYGlEHJJ0=;
        b=cT7Wq8ozoiXCRaCxomPmoBcUJ9/lNQSgAVe6iv0CTibH3qTids5yoVa5lFzfTJFR0M
         BNjDn3iGZIjutw36C7bf+RYII4DsRaJXLEePrBWYNsoCO5z9TzkmNGmJMTciPq+Pgwao
         6VXdYqDYBncwAjNXvb69B9In5BzI/84T21P1AzBwtq90XaPhLia1TKr7AeoB2Alc1hLt
         chUjlMZOkiLOl8iHKFc5Lyj5tmtsjH5EfQ8wLu5N9TgSATsf9RrfbLADn1oBsT6wlNeg
         lLIpPptVzQxzeOl/pU4R+tdIdBVQlms7WIANItGrOXYnO7FNdPkxz4zphCzrIYW9fGyg
         jYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jetCnrPb9S11c3Yjs3Au+g87ylHqFE2uLFBYGlEHJJ0=;
        b=h7Zue9UMOslm4n9u8xu7lkYciDlEKqU7eWT+F2l9cZyMRS2cMhF7ym2/jcCmC+1l6U
         Hm1Tb233EmyGzn3zs4L6viGNeEehPkYzhnppjhVBQpM5VnXy7BRHyhXYo61cXp8ZZrcs
         64/+RLRuAXALH+PT7iniTeOXNwFMwZUmbNDHT+eRHHXPiKEtpTekJbW6prR6uL5u0OxB
         Yhi9HlTBWHW+XYpiWKO0qykqAVaAItlATzWiQ4xryIZEN4tHeQ0V5zblW8gGqS829loB
         tqGPHmOdvuRURTHuj1kfN4vu3ciyLvX7TGod8MTwbhp4Dng28sSNuMtplpto5vFROHXT
         B1mg==
X-Gm-Message-State: AOUpUlGq03LYOVNkLPZKXBS2AXxGEb0fc/lx2wlnQjW/jZoSOyAVCOib
        txinNBYF5We9VWc5xg2C7+ymYIKiYlI=
X-Google-Smtp-Source: AA+uWPw6ccnbvyCHC2ciI2wVMkgNhyPV0De5mdGPonRCPq+hmqEYh+Ki2eq3OS2IoOVxiACO8NSxYg==
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr4853818edl.265.1533762073999;
        Wed, 08 Aug 2018 14:01:13 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 13/15] staging:rtl8192u: Rename DOT11D_ScanComplete - Style
Date:   Wed,  8 Aug 2018 22:00:34 +0100
Message-Id: <20180808210036.22580-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
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
index d4333ea106fd..00e59e949f82 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -50,7 +50,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
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

