Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA9B2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PSwY1M3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA9B2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeITAqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:46:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52118 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeITAqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:46:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2-v6so7422271wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JsR2AbIidYMWzaG1THAzt1IEb2vjdO5cWL+rwbq1p0Q=;
        b=PSwY1M3O/7eUr8occ+umnogXW4RdRRfgVnEBGk2PgiT2qtWSCBojv+dIZzj84MHRr6
         hdrxQ7oenTme/Iu0QQya7D1BqpyliZwSUVHT2VNXUHGrUiWwJX8E9tgRfQzAE7GYPhii
         +J3J35mWhbRSr65F3oWnSM97Ma3lVJr6VbqXBWOh3GuS5t7G45sVF3jM5+t8+k/CWIaR
         A5msMHSMsXb4AMIh0wGSw48y7jjhvtDXE2orpqeeFghlDZ6rezW4+tlXO7176Z04+fM4
         P8udLhHlqH4wHz1LN0h1PWuHBLrm38Cdy2rYTTGXG5R1mF+kdLbuRLSxzRgyKo/tj81Q
         oG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JsR2AbIidYMWzaG1THAzt1IEb2vjdO5cWL+rwbq1p0Q=;
        b=EXaicejSVWnuOY7bScpFrdkmE4gy8YzveDhfIgX1EBpqpaOMva0UHWrfPIwY82nRMO
         J0cevuhzt1ZXmR7y3Qi6m3gznIXV+seR8gwFvxD8lE/8dgUPyasQFd7U9ZU+gezCx5wJ
         SXrOxpSopvVZElmz7aczMQHQ92cLtM/swsSHXZSLV32+sIFR2vUwlIaLnwuOVYUlzKMf
         6HpOD/7xSJBo4eJDFb/bBH28l6cxczbhTRuxUZrk4WWeEMkxSukX1CA+qfcR3wqcp4Mv
         SLr1fBx10a2+xJxTLi2M5n2HCe2LA0l9yWENbQGN5YaDcrvVQuawgkvAShB/WbXZlWI9
         Xixg==
X-Gm-Message-State: APzg51D3R8QkegmfqyU/S9XAADN/x6dqa46033ExkPkrbMoM9blkQwbd
        9trIa4UJ7Da4DrEFUnclKOFgv9TVTi0=
X-Google-Smtp-Source: ANB0VdbVLhl0MT34Wlt82Hz7MqjnoAiaiN978P4NOwNLA7odRHnf50y0RB1bM7wlaV43PEjrenqq+A==
X-Received: by 2002:a1c:bb85:: with SMTP id l127-v6mr21304426wmf.156.1537384021743;
        Wed, 19 Sep 2018 12:07:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 139-v6sm8892721wmp.4.2018.09.19.12.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 12:07:01 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] net-next: mscc: remove unused ocelot_dev_gmii.h
Date:   Wed, 19 Sep 2018 19:06:53 +0000
Message-Id: <1537384013-2353-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header ocelot_dev_gmii.h is unused since the inclusion of the driver.
It is unused, lets just remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/mscc/ocelot_dev_gmii.h | 154 ----------------------------
 1 file changed, 154 deletions(-)
 delete mode 100644 drivers/net/ethernet/mscc/ocelot_dev_gmii.h

diff --git a/drivers/net/ethernet/mscc/ocelot_dev_gmii.h b/drivers/net/ethernet/mscc/ocelot_dev_gmii.h
deleted file mode 100644
index 6aa40ea..0000000
--- a/drivers/net/ethernet/mscc/ocelot_dev_gmii.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- * Microsemi Ocelot Switch driver
- *
- * Copyright (c) 2017 Microsemi Corporation
- */
-
-#ifndef _MSCC_OCELOT_DEV_GMII_H_
-#define _MSCC_OCELOT_DEV_GMII_H_
-
-#define DEV_GMII_PORT_MODE_CLOCK_CFG                      0x0
-
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_MAC_TX_RST           BIT(5)
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_MAC_RX_RST           BIT(4)
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_PORT_RST             BIT(3)
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_PHY_RST              BIT(2)
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_LINK_SPEED(x)        ((x) & GENMASK(1, 0))
-#define DEV_GMII_PORT_MODE_CLOCK_CFG_LINK_SPEED_M         GENMASK(1, 0)
-
-#define DEV_GMII_PORT_MODE_PORT_MISC                      0x4
-
-#define DEV_GMII_PORT_MODE_PORT_MISC_MPLS_RX_ENA          BIT(5)
-#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_ERROR_ENA        BIT(4)
-#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_PAUSE_ENA        BIT(3)
-#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_CTRL_ENA         BIT(2)
-#define DEV_GMII_PORT_MODE_PORT_MISC_GMII_LOOP_ENA        BIT(1)
-#define DEV_GMII_PORT_MODE_PORT_MISC_DEV_LOOP_ENA         BIT(0)
-
-#define DEV_GMII_PORT_MODE_EVENTS                         0x8
-
-#define DEV_GMII_PORT_MODE_EEE_CFG                        0xc
-
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_ENA                BIT(22)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE(x)       (((x) << 15) & GENMASK(21, 15))
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE_M        GENMASK(21, 15)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE_X(x)     (((x) & GENMASK(21, 15)) >> 15)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP(x)    (((x) << 8) & GENMASK(14, 8))
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP_M     GENMASK(14, 8)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP_X(x)  (((x) & GENMASK(14, 8)) >> 8)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF(x)   (((x) << 1) & GENMASK(7, 1))
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF_M    GENMASK(7, 1)
-#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF_X(x) (((x) & GENMASK(7, 1)) >> 1)
-#define DEV_GMII_PORT_MODE_EEE_CFG_PORT_LPI               BIT(0)
-
-#define DEV_GMII_PORT_MODE_RX_PATH_DELAY                  0x10
-
-#define DEV_GMII_PORT_MODE_TX_PATH_DELAY                  0x14
-
-#define DEV_GMII_PORT_MODE_PTP_PREDICT_CFG                0x18
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG               0x1c
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG_RX_ENA        BIT(4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG_TX_ENA        BIT(0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG              0x20
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_FC_WORD_SYNC_ENA BIT(8)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_GIGA_MODE_ENA BIT(4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_FDX_ENA      BIT(0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_MAXLEN_CFG            0x24
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG              0x28
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID(x)    (((x) << 16) & GENMASK(31, 16))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID_M     GENMASK(31, 16)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID_X(x)  (((x) & GENMASK(31, 16)) >> 16)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_PB_ENA       BIT(1)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_VLAN_AWR_ENA BIT(0)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA BIT(2)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_ADV_CHK_CFG           0x2c
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_ADV_CHK_CFG_LEN_DROP_ENA BIT(0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG               0x30
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RESTORE_OLD_IPG_CHECK BIT(17)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_REDUCED_TX_IFG BIT(16)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG(x)     (((x) << 8) & GENMASK(12, 8))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG_M      GENMASK(12, 8)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG_X(x)   (((x) & GENMASK(12, 8)) >> 8)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2(x)    (((x) << 4) & GENMASK(7, 4))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2_M     GENMASK(7, 4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2_X(x)  (((x) & GENMASK(7, 4)) >> 4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG1(x)    ((x) & GENMASK(3, 0))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG1_M     GENMASK(3, 0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG               0x34
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_BYPASS_COL_SYNC BIT(26)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_OB_ENA        BIT(25)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_WEXC_DIS      BIT(24)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED(x)       (((x) << 16) & GENMASK(23, 16))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_M        GENMASK(23, 16)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_X(x)     (((x) & GENMASK(23, 16)) >> 16)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_LOAD     BIT(12)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_RETRY_AFTER_EXC_COL_ENA BIT(8)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_LATE_COL_POS(x) ((x) & GENMASK(6, 0))
-#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_LATE_COL_POS_M GENMASK(6, 0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG               0x38
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG_TBI_MODE      BIT(4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG_IFG_CRS_EXT_CHK_ENA BIT(0)
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_FC_MAC_LOW_CFG        0x3c
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_FC_MAC_HIGH_CFG       0x40
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY                0x44
-
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_IPG_SHRINK_STICKY BIT(9)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_PREAM_SHRINK_STICKY BIT(8)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_CARRIER_EXT_STICKY BIT(7)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_CARRIER_EXT_ERR_STICKY BIT(6)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_JUNK_STICKY BIT(5)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_RETRANSMIT_STICKY BIT(4)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_JAM_STICKY  BIT(3)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_FIFO_OFLW_STICKY BIT(2)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_FRM_LEN_OVR_STICKY BIT(1)
-#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_ABORT_STICKY BIT(0)
-
-#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG                  0x48
-
-#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_MM_RX_ENA        BIT(0)
-#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_MM_TX_ENA        BIT(4)
-#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_KEEP_S_AFTER_D   BIT(8)
-
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG                   0x4c
-
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_DIS    BIT(0)
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME(x) (((x) << 4) & GENMASK(11, 4))
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME_M GENMASK(11, 4)
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME_X(x) (((x) & GENMASK(11, 4)) >> 4)
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS(x) (((x) << 12) & GENMASK(13, 12))
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS_M GENMASK(13, 12)
-#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS_X(x) (((x) & GENMASK(13, 12)) >> 12)
-
-#define DEV_GMII_MM_STATISTICS_MM_STATUS                  0x50
-
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_ACTIVE_STATUS BIT(0)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_ACTIVE_STICKY BIT(4)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE(x) (((x) << 8) & GENMASK(10, 8))
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE_M GENMASK(10, 8)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE_X(x) (((x) & GENMASK(10, 8)) >> 8)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_UNEXP_RX_PFRM_STICKY BIT(12)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_UNEXP_TX_PFRM_STICKY BIT(16)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_RX_FRAME_STATUS BIT(20)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_TX_FRAME_STATUS BIT(24)
-#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_TX_PRMPT_STATUS BIT(28)
-
-#endif
-- 
2.7.4

