Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtPxQzj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDAE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeH3Aew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35582 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6833308wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbZLoBFRfKfLGFTb81oCtsjmulYrRK+pZNnpbQ5S7Kg=;
        b=NtPxQzj6t3cZoxw2UmBhSKLB8B/iekDoXfcK8R9IEu1rBdtIptNqMfQhwOcJfqlJ3H
         x8404W7xFKFnY2gnPYdqMPmJPFStwW7Bivn5TjcUVzWHyYAXUHcO2iMOc05WblgRT1DT
         f91f2zKRVM7TSTeMLflecA1G678vie2noaLDaWURRwactqN7c99lw6kIJkKqdvGvsWgP
         mbE5dWmm38g+BKbf7IcGUdadNPAf6YU+yJB1WLsgu+qM9kP9u4J70bW+yulAuVF+sk6O
         nVAGK3Hh504XvTiNq0vNA9mCVdrzZZJ3EUTcGjwLpExy2NYnVgo05dI2Cc55ZQr1cTj4
         hjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbZLoBFRfKfLGFTb81oCtsjmulYrRK+pZNnpbQ5S7Kg=;
        b=BRjEc1KRyYnpwjizA1CmqgmINO8HzjzkhND8DbDuHXPQLhWvbSJEsi7MeZ0H1+KJJR
         UI5VffOPHu1dnblJDsPbUx52S45aDE8iEmsvmVThMCAN0rK2gnnJNDNh1Xe1EhUKb3uZ
         vrFw2bSX2Mzx37kbOFvK3Ib55KltD2fQ8T7tL6+58P5fwAvFp5tr4MHJQ6Wl5L8sWEgJ
         3+nCDAMt72k+sk0QtFlXS7xRtgP4UpvJAfubMuSoeu9raN2z4D5fZk+harWTHn8QXodK
         Pbi8YcJhzLhAkadM8T2wUdLBriEjyOBX+N1r/hqQwlQMm8DxwmMpAUTMR4IJg7nnmzMd
         H/Bg==
X-Gm-Message-State: APzg51C2rxpUzw5vSbmWCa7FeD24uLphzLwy7ozx/vSwFoqwxvoB9/jL
        zCsFqnNcu7eBIZc1N4PlTp7/gsczsDA=
X-Google-Smtp-Source: ANB0VdZ9hO9tYQ91Xr5Pp/bnC/LAv9mHmZ6GLdj/0FtfiOlGcVEIAL1Lqjro0ZvxgS7puOEHr36+1w==
X-Received: by 2002:a1c:98a:: with SMTP id 132-v6mr5199106wmj.86.1535574976232;
        Wed, 29 Aug 2018 13:36:16 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/21] staging:rtl8192u: Rename PSMP - Style
Date:   Wed, 29 Aug 2018 21:35:38 +0100
Message-Id: <20180829203547.15650-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member variable 'PSMP', since its uppercase name
conflicts the coding standard on naming. Because the variable is not
actually used in code it has been renamed to 'not_used_psmp'. The one
line of initialisation code has been removed.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index fd04461bcaf8..7f11257e2675 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -50,7 +50,7 @@ struct ht_capability_ele {
 	u8	not_used_delay_ba:1;
 	u8	max_amsdu_size:1;
 	u8	dss_cck:1;
-	u8	PSMP:1;
+	u8	not_used_psmp:1;
 	u8	Rsvd1:1;
 	u8	LSigTxopProtect:1;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 299d486fad0d..2ea9fa3b6e0a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -562,7 +562,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//pCapELE->chl_width, pCapELE->short_gi20_mhz, pCapELE->short_gi40_mhz);
 	pCapELE->max_amsdu_size	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
 	pCapELE->dss_cck		= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
-	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
 	/*
-- 
2.18.0

