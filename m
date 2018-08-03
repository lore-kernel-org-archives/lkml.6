Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B81C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BB0215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBichRS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BB0215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeHCB4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45695 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCB4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so1549360edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCO2pqnd8mbF9fas8rxRLqOqOWSlAtWzbEGohZIiWAk=;
        b=tBichRS1z/v0j6frtn+3MxnQ03pHuMm62RPIySphMHefgUWP+U1ZPIVgZcQ0h5O5gS
         BlhiYtvQspUNFoMwIHV6/htPTcG41zCFPUw1hoAugqKC0UkI/ELh65DrIVQcV+WxlQ3N
         H3fqAaCa5erX2viDiLVnSgH0PybfS4P2cBVemoQ0hwQ72oNeIKJ2fmTDP4wcr8ouNT/E
         BjOShPn3Y92989vQjgP83Z67ZADRrUVRVUQbZNNotohvsI+92QhuBlyoqDm6OY8LePAP
         AwN35q5vl/zQeaBlTOb2ZC7spRGhuj48wnHRrT1U31lwaDhRYQpmnfGxnWzJBUcCZget
         Ibqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCO2pqnd8mbF9fas8rxRLqOqOWSlAtWzbEGohZIiWAk=;
        b=V1TXF6LAT0KQbnN4UymbkfnCTFcXRCQBV2JBvvwUrH5ktP4ZVYFJcZO1w2/tRoihlt
         1XzUvuv38o9d8lKXcF/Jm4W6pDso37ZNG1bwZPBpVqpTEMD56N3WwAPMdsYb1bxdX6KQ
         0Vvv3SXx2HAuBpObC79dSUkBt4VqLIFTmyP0v0b6DX9rmcLUpspb/WET7VENDTHEvV+L
         nWBgittRpQFTjB36vD/+QZI7z4102A9HZf95R3afG+p92Pg3rw1yPDOPhw9dnWSnd+Bg
         F683PID9cc48itDI6CXDen6VNzt35lRsySdc8KovlhK4CRPpVk39Hx6imIA+Azcgt6Yu
         b+tQ==
X-Gm-Message-State: AOUpUlHaEvI1CaTCy+sDZDGwrvejYkH0QB0qFUswk7UmzaFo4lpUiSw2
        Iw676ufzvwxN/H5iAZQk1PSl94oM
X-Google-Smtp-Source: AAOMgpf6PKmRYYO09KJY0mLLvKIzJAJ1Cd2YRn7HQyyunUr2pg65NM8BOutSWQAgzJgato2sjVRksg==
X-Received: by 2002:aa7:c2c1:: with SMTP id m1-v6mr5124543edp.249.1533254563337;
        Thu, 02 Aug 2018 17:02:43 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:42 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/18] staging:rtl8192u: Remove debug member from structures - Style
Date:   Fri,  3 Aug 2018 01:01:54 +0100
Message-Id: <20180803000211.10589-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two structures, (struct dig and struct dynamic_rx_path_sel) contain
a u8 member variable representing debug setting. In the file r8192U_dm.c
these member variables, for both structures, are initialised to an
enumerated constant 'DM_DBG_OFF'. The member variables are never
assigned another value, other then off. Later in code the member
variables are tested to for equality to 'DM_DBG_OFF' and if that is the
case an assignment statement is executed.

Since the value of the variables is always off the test is redundant and
the conditional branch can just be executed without the test. Since the
member variables are then actually used both have been removed, along
with the enumerated type which defines debug status, on/off.

These are coding style changes to remove unused or redundant code, there
should be no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 8 ++------
 drivers/staging/rtl8192u/r8192U_dm.h | 8 --------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 0ba1b1e2bc6e..3336798310ac 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1635,7 +1635,6 @@ static void dm_dig_init(struct net_device *dev)
 	/* 2007/10/05 MH Disable DIG scheme now. Not tested. */
 	dm_digtable.dig_enable_flag	= true;
 	dm_digtable.dig_algorithm = DIG_ALGO_BY_RSSI;
-	dm_digtable.dbg_mode = DM_DBG_OFF;	/* off=by real rssi value, on=by DM_DigTable.Rssi_val for new dig */
 	dm_digtable.dig_algorithm_switch = 0;
 
 	/* 2007/10/04 MH Define init gain threshold. */
@@ -1720,8 +1719,7 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	/*DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
 		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/
 
-	if (dm_digtable.dbg_mode == DM_DBG_OFF)
-		dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
+	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
 	/*DbgPrint("DM_DigTable.Rssi_val = %d\n", DM_DigTable.Rssi_val);*/
 	dm_initial_gain(dev);
 	dm_pd_th(dev);
@@ -2398,7 +2396,6 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
-	DM_RxPathSelTable.DbgMode = DM_DBG_OFF;
 	DM_RxPathSelTable.disabledRF = 0;
 	for (i = 0; i < 4; i++) {
 		DM_RxPathSelTable.rf_rssi[i] = 50;
@@ -2440,8 +2437,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 
 	/* decide max/sec/min rssi index */
 	for (i = 0; i < RF90_PATH_MAX; i++) {
-		if (!DM_RxPathSelTable.DbgMode)
-			DM_RxPathSelTable.rf_rssi[i] = priv->stats.rx_rssi_percentage[i];
+		DM_RxPathSelTable.rf_rssi[i] = priv->stats.rx_rssi_percentage[i];
 
 		if (priv->brfpath_rxenable[i]) {
 			rf_num++;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 2ba6a4208870..bc736f2f5a5c 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -96,7 +96,6 @@ enum dig_cck_cs_ratio_state {
 struct dig {
 	u8		dig_enable_flag;
 	enum dig_algorithm		dig_algorithm;
-	u8		dbg_mode;
 	u8		dig_algorithm_switch;
 
 	long		rssi_low_thresh;
@@ -133,7 +132,6 @@ enum cck_rx_path_method {
 
 struct dynamic_rx_path_sel {
 	u8		Enable;
-	u8		DbgMode;
 	enum cck_rx_path_method		cck_method;
 	u8		cck_Rx_path;
 
@@ -147,12 +145,6 @@ struct dynamic_rx_path_sel {
 	long		cck_pwdb_sta[4];
 };
 
-typedef enum tag_DM_DbgMode_Definition {
-	DM_DBG_OFF = 0,
-	DM_DBG_ON = 1,
-	DM_DBG_MAX
-} DM_DBG_E;
-
 typedef struct tag_Tx_Config_Cmd_Format {
 	u32	Op;			/* Command packet type. */
 	u32	Length;			/* Command packet length. */
-- 
2.18.0

