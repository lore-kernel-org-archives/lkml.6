Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70749C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ACB216F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqTorldk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ACB216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeHCB4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37108 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHCB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so1565757eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rbL+9kokxbp5SVhVUh6+h1rHfUXChvmbGK+t31LAHv8=;
        b=JqTorldkk/p99XgoYSrhKV3KtNJoq/0NQcjuay7zcxTFSwLn4qrdKJklMFgYLld3uC
         eI0mM2tI/vLNqVarUXPcqSp++h1seWg/ZT0h3HcRFI3FvvMVu/7MuWmvHUJPrRoiaFhc
         2TelSve7tVospQsOk1ZNfAcZ5pex2paM/+U5o30wwyJbLqaewt7rWE7zxx1DhAiLUlnz
         /DTRUrzV0s6ZWbEaTmhdLCKRs59eWtcsloWryrlYp5cnTEEJoVmL/3KmQEqd5ntqV24Y
         1Nr/8a81pUOBHFlUndAytgjuFgWgqKLV55w4QzgqGq08aH0EtVnx/A4w2nWFac/4RyBn
         QxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rbL+9kokxbp5SVhVUh6+h1rHfUXChvmbGK+t31LAHv8=;
        b=mz2oNX0UdLp99d+9AM5/lYvEs0GdjaLkbnaxUZb33rehauun4Xfl4UGZweyumR+HOQ
         gYFP6mCtzWcrmITWJorhYaC2aMG1NloR7GqF4Hu14FHFH5LDrbiaOWK1aPXXxcTNbZ6c
         yAE65jlnIULIJrHshAeM9UjBh7SozUwvtEZWqd1VALfcCucyrcuBBAHMhgOd2ldgBe9i
         QARnFCt5K7B8ek+rjQ8UyLTA3MSOHUuBWIAH4iFPJK7PL91yP0X8eesHmpwHn7/mM64l
         x9JWVSCm0t0a1L4Lf1iYrtlg9bjyFnNxOab/iSXZmHdTAf39JtpoW2cKKIMGqyV6uMu0
         /BRQ==
X-Gm-Message-State: AOUpUlGtOX8MTLkxrFvTiOoJkv4N33CTshNRUdms53/ZYjUkcA8LxNrB
        zOwDPIj8m4MEiUZOPvjZSDYAVl6z
X-Google-Smtp-Source: AAOMgpdhtfq57OeEI3J5VxdgMwLRFBjSjg5pzDKb0XBgcTGJ/9DQaZUIMB5+/Y9J27ij6zI0PZfexA==
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr5122623edd.195.1533254586273;
        Thu, 02 Aug 2018 17:03:06 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:03:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/18] staging:rtl8192u: Clean up of spacing - Style
Date:   Fri,  3 Aug 2018 01:02:11 +0100
Message-Id: <20180803000211.10589-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple blank line, which cause an issue with checkpath, have been
removed and the spacing of definitions have been aligned to look
cleaner.

These are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 123 +++++++++++++--------------
 1 file changed, 58 insertions(+), 65 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index d93817f2a45b..0de0332906bd 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -21,48 +21,46 @@
 #ifndef	__R8192UDM_H__
 #define __R8192UDM_H__
 
-
 /*--------------------------Define Parameters-------------------------------*/
-#define		DM_DIG_THRESH_HIGH					40
-#define		DM_DIG_THRESH_LOW					35
+#define         DM_DIG_THRESH_HIGH                      40
+#define         DM_DIG_THRESH_LOW                       35
 
-#define		DM_DIG_HIGH_PWR_THRESH_HIGH		75
-#define		DM_DIG_HIGH_PWR_THRESH_LOW		70
+#define         DM_DIG_HIGH_PWR_THRESH_HIGH             75
+#define         DM_DIG_HIGH_PWR_THRESH_LOW              70
 
-#define		BW_AUTO_SWITCH_HIGH_LOW			25
-#define		BW_AUTO_SWITCH_LOW_HIGH			30
+#define         BW_AUTO_SWITCH_HIGH_LOW                 25
+#define         BW_AUTO_SWITCH_LOW_HIGH                 30
 
-#define		DM_DIG_BACKOFF				12
-#define		DM_DIG_MAX					0x36
-#define		DM_DIG_MIN					0x1c
-#define		DM_DIG_MIN_NETCORE			0x12
+#define         DM_DIG_BACKOFF                          12
+#define         DM_DIG_MAX                            0x36
+#define         DM_DIG_MIN                            0x1c
+#define         DM_DIG_MIN_NETCORE                    0x12
 
-#define		RX_PATH_SELECTION_SS_TH_LOW		30
-#define		RX_PATH_SELECTION_DIFF_TH			18
+#define         RX_PATH_SELECTION_SS_TH_LOW             30
+#define         RX_PATH_SELECTION_DIFF_TH               18
 
-#define		RATE_ADAPTIVE_TH_HIGH			50
-#define		RATE_ADAPTIVE_TH_LOW_20M		30
-#define		RATE_ADAPTIVE_TH_LOW_40M		10
-#define		VERY_LOW_RSSI					15
-#define		CTS_TO_SELF_TH_VAL					30
+#define         RATE_ADAPTIVE_TH_HIGH                   50
+#define         RATE_ADAPTIVE_TH_LOW_20M                30
+#define         RATE_ADAPTIVE_TH_LOW_40M                10
+#define         VERY_LOW_RSSI                           15
+#define         CTS_TO_SELF_TH_VAL                      30
 
 /* defined by vivi, for tx power track */
-#define		E_FOR_TX_POWER_TRACK               300
+#define         E_FOR_TX_POWER_TRACK                   300
 /* Dynamic Tx Power Control Threshold */
-#define		TX_POWER_NEAR_FIELD_THRESH_HIGH		68
-#define		TX_POWER_NEAR_FIELD_THRESH_LOW		62
+#define         TX_POWER_NEAR_FIELD_THRESH_HIGH         68
+#define         TX_POWER_NEAR_FIELD_THRESH_LOW          62
 /* added by amy for atheros AP */
 #define         TX_POWER_ATHEROAP_THRESH_HIGH           78
-#define		TX_POWER_ATHEROAP_THRESH_LOW		72
+#define         TX_POWER_ATHEROAP_THRESH_LOW            72
 
 /* defined by vivi, for showing on UI */
-#define			CURRENT_TX_RATE_REG         0x1b8
-#define			INITIAL_TX_RATE_REG		  0x1b9
-#define			TX_RETRY_COUNT_REG         0x1ac
-#define		REG_C38_TH				 20
+#define         CURRENT_TX_RATE_REG                  0x1b8
+#define         INITIAL_TX_RATE_REG                  0x1b9
+#define         TX_RETRY_COUNT_REG                   0x1ac
+#define         REG_C38_TH                              20
 /*--------------------------Define Parameters-------------------------------*/
 
-
 /*------------------------------Define structure----------------------------*/
 
 enum dig_algorithm {
@@ -78,49 +76,49 @@ enum dynamic_init_gain_state {
 
 enum dig_connect {
 	DIG_DISCONNECT = 0,
-	DIG_CONNECT = 1,
+	DIG_CONNECT    = 1,
 };
 
 enum dig_pkt_detection_threshold {
-	DIG_PD_AT_LOW_POWER = 0,
+	DIG_PD_AT_LOW_POWER    = 0,
 	DIG_PD_AT_NORMAL_POWER = 1,
-	DIG_PD_AT_HIGH_POWER = 2,
+	DIG_PD_AT_HIGH_POWER   = 2,
 };
 
 enum dig_cck_cs_ratio_state {
-	DIG_CS_RATIO_LOWER = 0,
+	DIG_CS_RATIO_LOWER  = 0,
 	DIG_CS_RATIO_HIGHER = 1,
 };
 
 /* 2007/10/04 MH Define upper and lower threshold of DIG enable or disable. */
 struct dig {
-	u8		dig_enable_flag;
-	enum dig_algorithm		dig_algorithm;
-	u8		dig_algorithm_switch;
+	u8                                 dig_enable_flag;
+	enum dig_algorithm                 dig_algorithm;
+	u8                                 dig_algorithm_switch;
 
-	long		rssi_low_thresh;
-	long		rssi_high_thresh;
+	long                               rssi_low_thresh;
+	long                               rssi_high_thresh;
 
-	long		rssi_high_power_lowthresh;
-	long		rssi_high_power_highthresh;
+	long                               rssi_high_power_lowthresh;
+	long                               rssi_high_power_highthresh;
 
-	enum dynamic_init_gain_state		dig_state;
-	enum dynamic_init_gain_state		dig_highpwr_state;
-	enum dig_connect		cur_connect_state;
-	enum dig_connect		pre_connect_state;
+	enum dynamic_init_gain_state       dig_state;
+	enum dynamic_init_gain_state       dig_highpwr_state;
+	enum dig_connect                   cur_connect_state;
+	enum dig_connect                   pre_connect_state;
 
-	enum dig_pkt_detection_threshold		curpd_thstate;
-	enum dig_pkt_detection_threshold		prepd_thstate;
-	enum dig_cck_cs_ratio_state		curcs_ratio_state;
-	enum dig_cck_cs_ratio_state		precs_ratio_state;
+	enum dig_pkt_detection_threshold   curpd_thstate;
+	enum dig_pkt_detection_threshold   prepd_thstate;
+	enum dig_cck_cs_ratio_state        curcs_ratio_state;
+	enum dig_cck_cs_ratio_state        precs_ratio_state;
 
-	u32		pre_ig_value;
-	u32		cur_ig_value;
+	u32                                pre_ig_value;
+	u32                                cur_ig_value;
 
-	u8		backoff_val;
-	u8		rx_gain_range_min;
+	u8                                 backoff_val;
+	u8                                 rx_gain_range_min;
 
-	long		rssi_val;
+	long                               rssi_val;
 };
 
 enum cck_rx_path_method {
@@ -129,36 +127,33 @@ enum cck_rx_path_method {
 };
 
 struct dynamic_rx_path_sel {
-	enum cck_rx_path_method		cck_method;
-	u8		cck_rx_path;
+	enum cck_rx_path_method            cck_method;
+	u8                                 cck_rx_path;
 
-	u8		disabled_rf;
+	u8                                 disabled_rf;
 
-	u8		rf_rssi[4];
-	u8		rf_enable_rssi_th[4];
-	long		cck_pwdb_sta[4];
+	u8                                 rf_rssi[4];
+	u8                                 rf_enable_rssi_th[4];
+	long                               cck_pwdb_sta[4];
 };
 
 struct tx_config_cmd {
-	u32	cmd_op;			/* Command packet type. */
-	u32	cmd_length;			/* Command packet length. */
-	u32	cmd_value;
+	u32     cmd_op;        /* Command packet type. */
+	u32     cmd_length;    /* Command packet length. */
+	u32     cmd_value;
 };
 
 /*------------------------------Define structure----------------------------*/
 
-
 /*------------------------Export global variable----------------------------*/
 extern struct dig dm_digtable;
 extern u8 dm_shadow[16][256];
 /*------------------------Export global variable----------------------------*/
 
-
 /*------------------------Export Marco Definition---------------------------*/
 
 /*------------------------Export Marco Definition---------------------------*/
 
-
 /*--------------------------Exported Function prototype---------------------*/
 void init_hal_dm(struct net_device *dev);
 void deinit_hal_dm(struct net_device *dev);
@@ -178,8 +173,6 @@ void dm_shadow_init(struct net_device *dev);
 void dm_initialize_txpower_tracking(struct net_device *dev);
 /*--------------------------Exported Function prototype---------------------*/
 
-
 #endif	/*__R8192UDM_H__ */
 
-
 /* End of r8192U_dm.h */
-- 
2.18.0

