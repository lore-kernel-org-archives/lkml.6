Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C3C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FA12156B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdiK+Xsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FA12156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeHCB4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33525 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so1572647edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOEjfyetwUz70XSoCLlxdLbqRuODUZDuv6sb4a3M4JM=;
        b=gdiK+Xsdq5a/1hjMzgKhqQHndtuJYTUyULkzXQhBLeMCUnmZMKfX+rGRCZO9Xa8cZ5
         q1QzlV5i8Mue+DAZ0rdybYayvL7czCao2Bxb3xhxBPoPVN9uxWm5jNeKrfSJVLUWr+19
         UwjaWvM0akuzPQDfpu0K/9tfBp5fRXO9dtoNFep9GR7q/g0bdW/jumt/kXdPvWuNDB9g
         FAlNDQTpG5EUJX0UQyBhPg4VIrM6CdeEMZVXoxmtb7nfmiPYrTe9PY2PyH4ZMeI7MQwt
         Vk8y0NDwF8NRKZv3pgfamHB3hXcIZcT8ljvNklk180s4rKk/e2MZj14nKCv7u7aRVfSn
         qhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOEjfyetwUz70XSoCLlxdLbqRuODUZDuv6sb4a3M4JM=;
        b=l1Jmq2WxCMrWjRotXVSHVAfEigEB1SFGnl1/cJP9tOSrPXPvia1bVJKM7GFQq0Lv0f
         KjA8HreDIlfa/igGqxaKRylbMwpsJ0OvbgawXrPDww2ZPmZZo9fLmPuJN6biEMZe0Fus
         tfOBZNIEd0VtNjS0wcQoNXLZ8W+0ySLpcdhCgB/vaKh7tCPH20lvzn+Mi1G/3bE2lE38
         vficzrY3uoeA0LBqjBC9TOISnm8eNztXcYn3PLk/kptx//oJjrd0Ib/6+DX/GIem7XZ/
         wIkiF2MyJEVFC0bsDDWWmghEvuBRCW7Ff+8JiHOQyrkUQt+/G+ladRNsFpdRz+ptq2GB
         8P5A==
X-Gm-Message-State: AOUpUlHcmOgd4Tp+rQjsq0TWYtOiEfMpRsbGTpVfQBhyK9bP1vFdxyl2
        ezRzhr+bs7btEvlli5gedZ7vYDG7
X-Google-Smtp-Source: AAOMgpfCUICieJsDTwQwEX1Y4gcavDtfYYgdKVoynJS4edJhBEkTfGFQQ35epq8SF/6xlqVgQ7jQgw==
X-Received: by 2002:a50:b37a:: with SMTP id r55-v6mr5132755edd.145.1533254580688;
        Thu, 02 Aug 2018 17:03:00 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:03:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/18] staging:rtl8192u: Rename RateAdaptiveTH_High - Style
Date:   Fri,  3 Aug 2018 01:02:07 +0100
Message-Id: <20180803000211.10589-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constant RateAdaptiveTH_High causes a checkpatch issue with respect
to CamelCase naming. As a result the constant has been renamed to
RATE_ADAPTIVE_TH_HIGH.

This is purely a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 drivers/staging/rtl8192u/r8192U_dm.c   | 4 ++--
 drivers/staging/rtl8192u/r8192U_dm.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 28592a8d6dd0..d4a063afca55 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3079,9 +3079,9 @@ static bool HalRxCheckStuck819xUsb(struct net_device *dev)
 	 * or maybe it will continuous silent reset every 2 seconds.
 	 */
 	rx_chk_cnt++;
-	if (priv->undecorated_smoothed_pwdb >= (RateAdaptiveTH_High + 5)) {
+	if (priv->undecorated_smoothed_pwdb >= (RATE_ADAPTIVE_TH_HIGH + 5)) {
 		rx_chk_cnt = 0;	/* high rssi, check rx stuck right now. */
-	} else if (priv->undecorated_smoothed_pwdb < (RateAdaptiveTH_High + 5) &&
+	} else if (priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5) &&
 		   ((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M) ||
 		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_20M))) {
 		if (rx_chk_cnt < 2)
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 3043b84e9237..b9b751fb96c3 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -243,11 +243,11 @@ void init_rate_adaptive(struct net_device *dev)
 	prate_adaptive	pra = (prate_adaptive)&priv->rate_adaptive;
 
 	pra->ratr_state = DM_RATR_STA_MAX;
-	pra->high2low_rssi_thresh_for_ra = RateAdaptiveTH_High;
+	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
 	pra->low2high_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M+5;
 	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
 
-	pra->high_rssi_thresh_for_ra = RateAdaptiveTH_High+5;
+	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
 	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
 	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 655b1afd9294..07e80e064f76 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -40,7 +40,7 @@
 #define		RX_PATH_SELECTION_SS_TH_LOW		30
 #define		RX_PATH_SELECTION_DIFF_TH			18
 
-#define		RateAdaptiveTH_High			50
+#define		RATE_ADAPTIVE_TH_HIGH			50
 #define		RateAdaptiveTH_Low_20M		30
 #define		RateAdaptiveTH_Low_40M		10
 #define		VeryLowRSSI					15
-- 
2.18.0

