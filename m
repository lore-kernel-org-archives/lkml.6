Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463E8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGV1CYC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A0B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeG2Wk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG2Wk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so10590046wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwOjsv1jcKicJbwXnDhyjhWcHJJ5jtX6FVf7yisnVa4=;
        b=JGV1CYC0FFumG+5pV7KCRgmKh8O5xohfHZ2OpZqJ6/B0lrcjsHSt9mK7W4bmW5xtqL
         sfsNxnAubo4GEuTeqcCeny92z+dk7eUV4/gXGCu40nAw76JVhqP0lUmWjWmushGOacDY
         05knYsi8AqCoD6FGRCbKcZkeEecxPDwwYVg2KemuR8M85lzenWRPGDMzWTtjfj0NSM1Q
         Q13KXaL0HkIGqEE347lTD1nIPIhnDq/YrGoavcHnEDHwBs5idaWnd/62vIgjFU+IOsqd
         tt3s42m74LAOpPUjNfBOG6+6k3jgqD6n0UfVdxtMQNDjr89nEP6bv5SyMhs4pRuLGvLc
         rQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwOjsv1jcKicJbwXnDhyjhWcHJJ5jtX6FVf7yisnVa4=;
        b=tyzl2NGiG3mKu7egp+CaN2LDst0CfkHOvTDFLTXJe20R1LtPC7NRwbh3ICS8Hd41SU
         5WXF+o1bzwWQW48Bs54PwuqUmZ5GdbfWC8zvRvYzzsAut1JEEBVZgtlferbIx6ptibXi
         2/yEg1L57b+cffMxmWfQ6Yo4cWgdt/rElWHglO6nw/NmXF2kXUWo0ZwjxMhCe5dRtkoZ
         tqxzVG/+0HNbiV0CT2iUEh+A1aa4V6hjHwJY8tZZj21VNcOr2bkB+XAjV1ZNcWC0UPDV
         BQu0JhaX9n/slKpYLaTAUGs7d8QvEQILK+7SlCwQGCkI9LjOXyiiNYlj/zdIgb4Zy2kb
         jZPw==
X-Gm-Message-State: AOUpUlHAjz334aLRhcCAS2XEg3gPRne4odQQSyduLpOgRIttpavmpTUw
        V1xhPXPrUSApX4rB8eJ46qwPsuBzLOg=
X-Google-Smtp-Source: AAOMgpezEsbhKTwuLUtm0TKBgjXD5q9kTHz4LPFji6PGtr5buSnqYCbRNisDHiZUql3SwFHu0HSOog==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr3025904wrw.278.1532898514389;
        Sun, 29 Jul 2018 14:08:34 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 09/15] staging:rtl8192u: Remove enum dm_dig_op_e - Style
Date:   Sun, 29 Jul 2018 22:07:41 +0100
Message-Id: <20180729210747.10803-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the enumerated type dm_dig_op_e. The type is only used as a
parameter to the function dm_change_dynamic_initgain_thresh(), but
that function is never referenced in the code at all.

I would consider this to be a coding style change as the function is
never referenced and as a result the enumeration is never used. In
any case there should be no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 91 ----------------------------
 drivers/staging/rtl8192u/r8192U_dm.h | 20 ------
 2 files changed, 111 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index c4e4e3ba394b..16dbe55d0e15 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1613,97 +1613,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
 }   /* dm_BBInitialGainBakcup */
 
 #endif
-/*-----------------------------------------------------------------------------
- * Function:	dm_change_dynamic_initgain_thresh()
- *
- * Overview:
- *
- * Input:		NONE
- *
- * Output:		NONE
- *
- * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/29/2008	amy		Create Version 0 porting from windows code.
- *
- *---------------------------------------------------------------------------*/
-
-void dm_change_dynamic_initgain_thresh(struct net_device *dev, u32 dm_type,
-				       u32 dm_value)
-{
-	switch (dm_type) {
-	case DIG_TYPE_THRESH_HIGH:
-		dm_digtable.rssi_high_thresh = dm_value;
-		break;
-
-	case  DIG_TYPE_THRESH_LOW:
-		dm_digtable.rssi_low_thresh = dm_value;
-		break;
-
-	case  DIG_TYPE_THRESH_HIGHPWR_HIGH:
-		dm_digtable.rssi_high_power_highthresh = dm_value;
-		break;
-
-	case DIG_TYPE_THRESH_HIGHPWR_LOW:
-		dm_digtable.rssi_high_power_lowthresh = dm_value;
-		break;
-
-	case DIG_TYPE_ENABLE:
-		dm_digtable.dig_state		= DM_STA_DIG_MAX;
-		dm_digtable.dig_enable_flag	= true;
-		break;
-
-	case DIG_TYPE_DISABLE:
-		dm_digtable.dig_state		= DM_STA_DIG_MAX;
-		dm_digtable.dig_enable_flag	= false;
-		break;
-
-	case DIG_TYPE_DBG_MODE:
-		if (dm_value >= DM_DBG_MAX)
-			dm_value = DM_DBG_OFF;
-		dm_digtable.dbg_mode		= (u8)dm_value;
-		break;
-
-	case DIG_TYPE_RSSI:
-		if (dm_value > 100)
-			dm_value = 30;
-		dm_digtable.rssi_val			= (long)dm_value;
-		break;
-
-	case DIG_TYPE_ALGORITHM:
-		if (dm_value >= DIG_ALGO_MAX)
-			dm_value = DIG_ALGO_BY_FALSE_ALARM;
-		if (dm_digtable.dig_algorithm != (u8)dm_value)
-			dm_digtable.dig_algorithm_switch = 1;
-		dm_digtable.dig_algorithm	= (u8)dm_value;
-		break;
-
-	case DIG_TYPE_BACKOFF:
-		if (dm_value > 30)
-			dm_value = 30;
-		dm_digtable.backoff_val		= (u8)dm_value;
-		break;
-
-	case DIG_TYPE_RX_GAIN_MIN:
-		if (dm_value == 0)
-			dm_value = 0x1;
-		dm_digtable.rx_gain_range_min = (u8)dm_value;
-		break;
-
-	case DIG_TYPE_RX_GAIN_MAX:
-		if (dm_value > 0x50)
-			dm_value = 0x50;
-		dm_digtable.rx_gain_range_max = (u8)dm_value;
-		break;
-
-	default:
-		break;
-	}
-
-}	/* DM_ChangeDynamicInitGainThresh */
-
 /*-----------------------------------------------------------------------------
  * Function:	dm_dig_init()
  *
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index d7bd257a7e93..471609819e08 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -105,24 +105,6 @@ struct dig {
 	long		rssi_val;
 };
 
-/* 2007/10/11 MH Define DIG operation type. */
-typedef enum tag_dynamic_init_gain_operation_type_definition {
-	DIG_TYPE_THRESH_HIGH	= 0,
-	DIG_TYPE_THRESH_LOW	= 1,
-	DIG_TYPE_THRESH_HIGHPWR_HIGH	= 2,
-	DIG_TYPE_THRESH_HIGHPWR_LOW	= 3,
-	DIG_TYPE_DBG_MODE				= 4,
-	DIG_TYPE_RSSI						= 5,
-	DIG_TYPE_ALGORITHM				= 6,
-	DIG_TYPE_BACKOFF					= 7,
-	DIG_TYPE_PWDB_FACTOR			= 8,
-	DIG_TYPE_RX_GAIN_MIN				= 9,
-	DIG_TYPE_RX_GAIN_MAX				= 10,
-	DIG_TYPE_ENABLE			= 20,
-	DIG_TYPE_DISABLE		= 30,
-	DIG_OP_TYPE_MAX
-} dm_dig_op_e;
-
 typedef enum tag_dig_algorithm_definition {
 	DIG_ALGO_BY_FALSE_ALARM = 0,
 	DIG_ALGO_BY_RSSI	= 1,
@@ -209,8 +191,6 @@ void init_rate_adaptive(struct net_device *dev);
 void dm_txpower_trackingcallback(struct work_struct *work);
 void dm_restore_dynamic_mechanism_state(struct net_device *dev);
 void dm_backup_dynamic_mechanism_state(struct net_device *dev);
-void dm_change_dynamic_initgain_thresh(struct net_device *dev,
-				       u32 dm_type, u32 dm_value);
 void dm_force_tx_fw_info(struct net_device *dev,
 			 u32 force_type, u32 force_value);
 void dm_init_edca_turbo(struct net_device *dev);
-- 
2.18.0

