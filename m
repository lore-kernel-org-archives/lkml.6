Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A9DC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A99216E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr3rUdaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A99216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeHCB43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42725 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1553477edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZc+2OtBGwCF4v6aQDfky2G5d3tdc7ZXOxmnvu+RY/k=;
        b=Cr3rUdaTIJMk3Orb3CiWxUiglSegNjxAzmR4NpjJwxguEtaH8sTm5Tn6HN+0zoA0Nz
         p78vRG1xyZ8BLLMzoniWm9j5aHKDfC2DmnBvLuuwcMQObF3s/p7L+QKjVdWK+O58f6A0
         6WgUoLRHL40puFliG5oRL4rUtAq9krRMNEV+6+zxXpAlMojpxYN0tchlTLgts32P7DN3
         gIvIi5z/KUTAYBbjPTfpIzp+0Wwxd4eI/0iz1y7I+DtzLd0Il+7CUpTb7A0JGSwGgrRf
         OhjGGyBjvVNQafeyA47zYL/Zm+6DyUORjWAopitjETM2vrrFotjv5bjSYtnEJjracXaj
         I7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RZc+2OtBGwCF4v6aQDfky2G5d3tdc7ZXOxmnvu+RY/k=;
        b=Tt3nlki82OtGUrIIUiPGXHPWJMC+Tj8a+v+TrwChlvxy+H6lV0+vHGYRWtbPg1zjnG
         RBY4ZuAC8TO1PJY0jzDjmo+z0a7U2qQLPp+8orbXS0dYpY5uNTcmyoDQR6AGHG40F2Em
         2iZXvKPjJ0aSTQG/5NCru2HQ7JsbA42MesJ54uYtOEBY4WQ90WT4nOIYvUreYFRUHZVi
         IplpoxhqLUSXFUApm5jzHlvM1WNLIJFADnKtlJN1vozZmEQ1GwuDkcRvpo4L+KXThaFz
         00Ojx/pEW5d+zF9U64NV19Wmc/bEIJxSFkUBnXy9uBXVijPeB9iSvqWPawqQH1IEHldp
         uHew==
X-Gm-Message-State: AOUpUlEoP9rIL/NIIXFdUlpT71LxDl7uR6dn0/uRNXoVneMl/IfvwM8M
        kCwuhmTFXV53YVKrpoKgFMf/F5KI
X-Google-Smtp-Source: AAOMgpdMqGycYesQ4YvkKtsG9KLYmHVz5SOEV1GDU+WTXcG9PMhilYYbZW+8xZOPgVbF0fEfFjECpw==
X-Received: by 2002:a50:8103:: with SMTP id 3-v6mr5138810edc.131.1533254575403;
        Thu, 02 Aug 2018 17:02:55 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/18] staging:rtl8192u: Rename member disabledRF - Style
Date:   Fri,  3 Aug 2018 01:02:03 +0100
Message-Id: <20180803000211.10589-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable disabledRF to disabled_rf. This change
resolves the checkpatch issue with CamelCase naming.

The change is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 10 +++++-----
 drivers/staging/rtl8192u/r8192U_dm.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index d847adf57f60..6f17732d038d 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2389,7 +2389,7 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;
 	else
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_1;
-	DM_RxPathSelTable.disabledRF = 0;
+	DM_RxPathSelTable.disabled_rf = 0;
 	for (i = 0; i < 4; i++) {
 		DM_RxPathSelTable.rf_rssi[i] = 50;
 		DM_RxPathSelTable.cck_pwdb_sta[i] = -64;
@@ -2420,8 +2420,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 		cck_Rx_Path_initialized = 1;
 	}
 
-	read_nic_byte(dev, 0xc04, &DM_RxPathSelTable.disabledRF);
-	DM_RxPathSelTable.disabledRF = ~DM_RxPathSelTable.disabledRF & 0xf;
+	read_nic_byte(dev, 0xc04, &DM_RxPathSelTable.disabled_rf);
+	DM_RxPathSelTable.disabled_rf = ~DM_RxPathSelTable.disabled_rf & 0xf;
 
 	if (priv->ieee80211->mode == WIRELESS_MODE_B) {
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;	/* pure B mode, fixed cck version2 */
@@ -2575,9 +2575,9 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 		rtl8192_setBBreg(dev, rCCK0_AFESetting, 0x0f000000, DM_RxPathSelTable.cck_rx_path);
 	}
 
-	if (DM_RxPathSelTable.disabledRF) {
+	if (DM_RxPathSelTable.disabled_rf) {
 		for (i = 0; i < 4; i++) {
-			if ((DM_RxPathSelTable.disabledRF>>i) & 0x1) {	/* disabled rf */
+			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {	/* disabled rf */
 				if (tmp_max_rssi >= DM_RxPathSelTable.rf_enable_rssi_th[i]) {
 					/* enable the BB Rx path */
 					/*DbgPrint("RF-%d is enabled.\n", 0x1<<i);*/
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index a7cce1fdd626..74742cb27a2c 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -132,7 +132,7 @@ struct dynamic_rx_path_sel {
 	enum cck_rx_path_method		cck_method;
 	u8		cck_rx_path;
 
-	u8		disabledRF;
+	u8		disabled_rf;
 	u8		reserved;
 
 	u8		rf_rssi[4];
-- 
2.18.0

