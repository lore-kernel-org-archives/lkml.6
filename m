Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA5C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697C021655
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icd8y3U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697C021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeHCB4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40381 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so1554618edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GAef5pWO8RXdK3FHy3IQOS36IAzEbGM4QxYQPd4xF8=;
        b=Icd8y3U7RggMicwSMUttwozG7pN3uJJA9kGFPQQeGYKCiGbmXTDkkKgyl9BVVSDVmK
         At9k6iE5Ee/GYrh+gpIe9oL47TaDZfV/fiO2vS+W8mw+XCAL2Quxuf3432ZY2Dd9HABw
         Mv1hsD70abou3UU8UbjJSUWSHkSdckvL9K+xJvbl12m7kTDcibTZaZRAJfjm10KRtaDd
         Sk23j42OMsya5cYOLLcIp2j8/sRRdY9660MlF31qOJpad2p/f2/LsyGa+9z7SEprrzc0
         gTHkzQHwRHNRF2+4Yo5Jh/puJdcFcO8iK/aH085wCsWzWEG+bI/o2UBaoKtxLV3gbxQq
         /5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GAef5pWO8RXdK3FHy3IQOS36IAzEbGM4QxYQPd4xF8=;
        b=ZZv/p8GwIGK62VhOifVewF+GTUxuVTD5hYco4ux/5ehMfxrei8KgihByZcMnjbr3V/
         kvpEzyts8oKCrel40kfgsx4Cot3byjg5T+jpVB7OwxAu9MOpLErbdX8YK2rqg5T4vodr
         4KguJvaPL84yDk0jX15QKXFH2ySJGXSCfyz/Xuy9lLTgp4xnYZVVYHatNKSrBkCZaO8O
         pTmgZClmKlvMDa/8wc7BKFG9PiW61S+s0CZ86nvzapRnk+2a/ENYKD7pLDOYpwegLPPn
         v4WTM2Wh3DNUUmOsvsfqVqC3Knu+wB+xZYeqTMueZpEUgzsc0mvegV79YfcmKQ7z4r0u
         +2DA==
X-Gm-Message-State: AOUpUlGL6zbCOFAGQVUlLYPO6mH8KPBI1BWj6wsr6uqUbP1AW9KZs9v1
        tWvTkIQT4x7Jzf4eHw90FPUqW3e9
X-Google-Smtp-Source: AAOMgpdKdnQZzJH1xwX/Z/+exa+zmsA7JOF4Vf2X4YQHRcf4LhwiCadGIlT/1dRsQ4jwJ1b230rctg==
X-Received: by 2002:a50:90e7:: with SMTP id d36-v6mr5041168eda.279.1533254570011;
        Thu, 02 Aug 2018 17:02:50 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/18] staging:rtl8192u: Remove member variable Enable - Style
Date:   Fri,  3 Aug 2018 01:01:59 +0100
Message-Id: <20180803000211.10589-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure dynamic_rx_path_sel defines a member variable 'Enable'
which is initialised and later tested. The variable is however never
changed to the test is redundant and the member variable is then never
used.

The member variable, initialisation and test have all been removed.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 3 ---
 drivers/staging/rtl8192u/r8192U_dm.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 54390587ba07..611bf3e34bf3 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2376,8 +2376,6 @@ void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 		else
 			priv->brfpath_rxenable[i] = false;
 	}
-	if (!DM_RxPathSelTable.Enable)
-		return;
 
 	dm_rxpath_sel_byrssi(dev);
 }	/* DM_RFPathCheckWorkItemCallBack */
@@ -2387,7 +2385,6 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 	u8 i;
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	DM_RxPathSelTable.Enable = 1;	/* default enabled */
 	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 06ebd820de52..53daec820ca7 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -129,7 +129,6 @@ enum cck_rx_path_method {
 };
 
 struct dynamic_rx_path_sel {
-	u8		Enable;
 	enum cck_rx_path_method		cck_method;
 	u8		cck_Rx_path;
 
-- 
2.18.0

