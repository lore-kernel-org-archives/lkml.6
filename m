Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A89AC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C362156B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuSK6BiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C362156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeHCB4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33523 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHCB4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so1572624edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+IB5SlFt4XoKKDQ8j+B9dy6wOIZRVcZBV5JRJoc7ng=;
        b=nuSK6BiNZVG6ui9ZS+bAykUg/VbMZNpboltXvd3NSJmGODO1+zclJaZQQ6G897pGkH
         ClO5AHKBjTBYvpxoTDep3VY/mjzhc32I21Z3uMp/pblfJSG10talVYLrGeR91oaq+M2G
         k0UYYj1OmP3ANII9C1Sh1vR5lmTmENc2eLMEUE7kRtOE9jflRNQo4EI5gUNf+5/re3e+
         7JEa7rHl1/lu9kfXe9sxFEi5mcmp2goYuM5Ow2plSZ/CV+dWPBy7DwwzXLjBVw0pcJbV
         wcJmrIKibC2CGNPqea6+/zKga6OkKEeksGzlFTTWm5hDZWYJ4ERfvAxfnroWSbLIx8DY
         grCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q+IB5SlFt4XoKKDQ8j+B9dy6wOIZRVcZBV5JRJoc7ng=;
        b=GFMDoM7CPyepnsfC4caMAzfGAztlV2gTnJX8TdQT1Sb02NGY3hcvXywYn8jPzhM6YV
         acbWg/4gVCKarH96yjWHRFPUvPJh/xLjZBi3KKVsBBiKvnqxW8DVtJMlgvT0xGbqDWBW
         BwbonEOXJ7gG8rrSsJISc2z3/M1UNH4BYSvIakVHZt2QOo44vOEpQryucGAYkdlLGXMj
         hFgXUUhFTR/yh8D6cW3SNGaix1gfvTudkOFrODsMgowfrvKFQx/8sNQmOrda+dGS2Pe0
         OFmLr1x9gjdolA4l9knSDzWlaYmHtiMHL4JFxr4m/5zKMR+uX5lZarWAmNi+gXg9pAh7
         z4YQ==
X-Gm-Message-State: AOUpUlGYJXbTT5YzujAP/7dC7GPAcsAHk6Y9owRmLSuTFgzG7+ZVHGWH
        bZ38J3RHInvz3HLTWFv16EZ+7Ca6
X-Google-Smtp-Source: AAOMgpfWix83YCE6S72yR7omAI/Nl+HJfYFKW2Il8czqWvK99TmtNVZtV2ReumNm+q9l1VbJuRRTeQ==
X-Received: by 2002:a50:a105:: with SMTP id 5-v6mr5044320edj.186.1533254579369;
        Thu, 02 Aug 2018 17:02:59 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/18] staging:rtl8192u: Rename DM_DIG_MIN_Netcore - Style
Date:   Fri,  3 Aug 2018 01:02:06 +0100
Message-Id: <20180803000211.10589-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constant DM_DIG_MIN_Netcore causes a checkpatch issue with CamelCase
naming so has been renamed to DM_DIG_MIN_NETCORE.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 2 +-
 drivers/staging/rtl8192u/r8192U_dm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 4c8f674cf54d..3043b84e9237 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1650,7 +1650,7 @@ static void dm_dig_init(struct net_device *dev)
 	dm_digtable.rssi_val = 50;	/* for new dig debug rssi value */
 	dm_digtable.backoff_val = DM_DIG_BACKOFF;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
-		dm_digtable.rx_gain_range_min = DM_DIG_MIN_Netcore;
+		dm_digtable.rx_gain_range_min = DM_DIG_MIN_NETCORE;
 	else
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN;
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 9a0105412350..655b1afd9294 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -35,7 +35,7 @@
 #define		DM_DIG_BACKOFF				12
 #define		DM_DIG_MAX					0x36
 #define		DM_DIG_MIN					0x1c
-#define		DM_DIG_MIN_Netcore			0x12
+#define		DM_DIG_MIN_NETCORE			0x12
 
 #define		RX_PATH_SELECTION_SS_TH_LOW		30
 #define		RX_PATH_SELECTION_DIFF_TH			18
-- 
2.18.0

