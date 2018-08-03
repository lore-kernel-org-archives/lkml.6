Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07AC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D8E216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1ypXQVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D8E216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbeHCB4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40392 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732518AbeHCB4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so1554788edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FaRXOBWs88+ere7piK6woFs9htvWS6hw0e7yhzrbOpM=;
        b=X1ypXQVKp0E77oAZq2IHeElZZxUXVaApkWQttLICi1BM2hIoaUH3AoKF+GK+I8jVT6
         4o/JnfvYecv9P5V58lO13b7PV7htxq5bTSjcm+HXLcpAz/t2V+92ehQOJ/J7lQXHGxIL
         nGcUhKYEcxz0Crh3mjTbjVToiorcQUzuSyaE7Kd/iwzBeicJAUHJ52pVT+OhFos7jB0W
         FmwdZfkYZsdkSI5Xr567aYNVmYLYOQEs8c4owWMj2vxtrlJJh2D2DC2cjzYzW5DQXNx2
         4qCls+wB8U9BgLAhzKVOlvj3Jnry7x3RRPnJxODO+8+gqMuoD0cqgkndoDS0fiNaMdt1
         H7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FaRXOBWs88+ere7piK6woFs9htvWS6hw0e7yhzrbOpM=;
        b=SVUR1v0RY5UDkiNSJkEIslCTeSpIE7e6ViX4gmZSFxUMUzg8T+2JooX9QhMAQ5Bxyh
         0v3I8s/WWkV9QggQbYOc5JsvzznU8/2s6EkIYKIE6z/AFScPryQ1i2Jpbi0svIOJZ1EZ
         /gIv5o7vvIVh+bXS6t5zccnCzeBCoGbup5iWZ5pVMq77+MMM1qs3jZsGmJ/Oqy/V5Bht
         WPAJE5EXdVPVO2TE4UaAOBMirg7cX+JaM4eLhqZIUk5rIYve2UQb26Rji1MxKnclEdeI
         5Ez5LLeAR7kg1boRdVAVs7Q3r1BiepwFx2add69wKhsiVAZutYHP1eV3fyJ4vlaAXOqX
         YvgA==
X-Gm-Message-State: AOUpUlEhQmJoAqlNEMl5MfGCL26Hdx7uxLBdM6LR+6zVJlJ4rNLs6DE3
        sb5z6zV2KC4PfzE8ptemuQhRmcCD
X-Google-Smtp-Source: AAOMgpde6u7SSiuiXDo40OUnFWUDd1R74JO3DW+Z+6MQtDrw5IVuY3RQ4gzd8XrT8rvsEz8WHj4Axg==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr5076375edk.245.1533254584765;
        Thu, 02 Aug 2018 17:03:04 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:03:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/18] staging:rtl8192u: Rename Register Constants - Style
Date:   Fri,  3 Aug 2018 01:02:10 +0100
Message-Id: <20180803000211.10589-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The four register constants, 'Current_Tx_Rate_Reg',
'Initial_Tx_Rate_Reg', 'Tx_Retry_Count_Reg' and 'RegC38_TH' all cause
checkpatch issue with CamelCase naming. The three have been renamed to
'CURRENT_TX_RATE_REG', 'INITIAL_TX_RATE_REG', 'TX_RETRY_COUNT_REG' and
'REG_C38_TH' respectively.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 16 ++++++++--------
 drivers/staging/rtl8192u/r8192U_dm.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 0e4f55c6493f..5fb5f583f703 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2875,13 +2875,13 @@ void dm_check_fsync(struct net_device *dev)
 
 		if (priv->framesyncMonitor) {
 			if (priv->ieee80211->state == IEEE80211_LINKED) {
-				if (priv->undecorated_smoothed_pwdb <= RegC38_TH) {
+				if (priv->undecorated_smoothed_pwdb <= REG_C38_TH) {
 					if (reg_c38_State != RegC38_NonFsync_Other_AP) {
 						write_nic_byte(dev, rOFDM0_RxDetector3, 0x90);
 
 						reg_c38_State = RegC38_NonFsync_Other_AP;
 					}
-				} else if (priv->undecorated_smoothed_pwdb >= (RegC38_TH+5)) {
+				} else if (priv->undecorated_smoothed_pwdb >= (REG_C38_TH + 5)) {
 					if (reg_c38_State) {
 						write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 						reg_c38_State = RegC38_Default;
@@ -3046,15 +3046,15 @@ static void dm_check_txrateandretrycount(struct net_device *dev)
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct ieee80211_device *ieee = priv->ieee80211;
 	/* for 11n tx rate */
-	/*priv->stats.CurrentShowTxate = read_nic_byte(dev, Current_Tx_Rate_Reg);*/
-	read_nic_byte(dev, Current_Tx_Rate_Reg, &ieee->softmac_stats.CurrentShowTxate);
+	/*priv->stats.CurrentShowTxate = read_nic_byte(dev, CURRENT_TX_RATE_REG);*/
+	read_nic_byte(dev, CURRENT_TX_RATE_REG, &ieee->softmac_stats.CurrentShowTxate);
 	/*printk("=============>tx_rate_reg:%x\n", ieee->softmac_stats.CurrentShowTxate);*/
 	/* for initial tx rate */
-	/*priv->stats.last_packet_rate = read_nic_byte(dev, Initial_Tx_Rate_Reg);*/
-	read_nic_byte(dev, Initial_Tx_Rate_Reg, &ieee->softmac_stats.last_packet_rate);
+	/*priv->stats.last_packet_rate = read_nic_byte(dev, INITIAL_TX_RATE_REG);*/
+	read_nic_byte(dev, INITIAL_TX_RATE_REG, &ieee->softmac_stats.last_packet_rate);
 	/* for tx tx retry count */
-	/*priv->stats.txretrycount = read_nic_dword(dev, Tx_Retry_Count_Reg);*/
-	read_nic_dword(dev, Tx_Retry_Count_Reg, &ieee->softmac_stats.txretrycount);
+	/*priv->stats.txretrycount = read_nic_dword(dev, TX_RETRY_COUNT_REG);*/
+	read_nic_dword(dev, TX_RETRY_COUNT_REG, &ieee->softmac_stats.txretrycount);
 }
 
 static void dm_send_rssi_tofw(struct net_device *dev)
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 30241d91e44a..d93817f2a45b 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -56,10 +56,10 @@
 #define		TX_POWER_ATHEROAP_THRESH_LOW		72
 
 /* defined by vivi, for showing on UI */
-#define			Current_Tx_Rate_Reg         0x1b8
-#define			Initial_Tx_Rate_Reg		  0x1b9
-#define			Tx_Retry_Count_Reg         0x1ac
-#define		RegC38_TH				 20
+#define			CURRENT_TX_RATE_REG         0x1b8
+#define			INITIAL_TX_RATE_REG		  0x1b9
+#define			TX_RETRY_COUNT_REG         0x1ac
+#define		REG_C38_TH				 20
 /*--------------------------Define Parameters-------------------------------*/
 
 
-- 
2.18.0

