Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69143256C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K83F4lvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69143256C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeF3PAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:00:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35425 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF3PAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:00:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so4711232wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZaafUXewnbCDMD81TkYsPLaBltTtJ0jYN5jWPtT6bHQ=;
        b=K83F4lvXNz/BbBOh1uEwEl01JDiKzp8+lkVHWik6vvy2RiL8fuGw7GoH1mf8ITWM5R
         atULVvgOWLhXu328naY7Fmq91k59Qr5+KGmnRrC/lY8krIxTObZFdYCpBSE1R5h0MmTm
         9uXn5Op63G6/gxjoW3JXQFoBssZpqUWUPcJLgFuK+eoIZHba0YTQF40TIBUj9hFvyrTX
         GyTcTjnK3D25UOJ58vMj/6T3TutNSe2q1m7fescaODaCay1qzZF0Glqg3lgvuZpSL0Hp
         PuwWy6//GSea98TL13D5/iwJ0TlcauYArj+SJB9cQVvPXpvpOMAkTLmb72rnVmzz6dsk
         hQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZaafUXewnbCDMD81TkYsPLaBltTtJ0jYN5jWPtT6bHQ=;
        b=dQscaWbUF28fKHVpsh4asItcXHZqOx23h13vwKj+cykQOlrIPfvV/Q/RAtG2NjiTJj
         1Ghi7z9rCu8gYjwJH2eCg1vrhl5Ms3GXWUMZqvmVbVTF+qSPBXlZWWQbmJ8KBeFcVKsQ
         FB0wd6kw/vnEXj+yFkbtt1TMoTXE8BRHjMG36usNfkoB37mg8Efh8UTGyx8N/BNvSioY
         pABxBdAiothAhsw3Ni398MFn1IRFupmq0owOxaiHrHfZVfxUvycAry1mlsG9zdnjX0GD
         RR/LCM3eCgo2B9vB2/iCE7QKJAayCDw7dzl/JX6+f/LB+gxbPUWjd+d8G2Q3LIYM8RQJ
         FXmw==
X-Gm-Message-State: APt69E3/S2JMn4Zy1TShzl0WpZGVjJ+cmMMosh8nnnC20zbDfWZKQgNw
        l4cmLPU5D6nWIoGNWShzf2o=
X-Google-Smtp-Source: AAOMgpc2PQrJxm4QCPEeEun35z1ArCwWrDy6fYcW5wik3A+Llx+Wpyx8pH0En7SatI8ZSvtrAaZklA==
X-Received: by 2002:a1c:cf81:: with SMTP id f123-v6mr4582007wmg.3.1530370802780;
        Sat, 30 Jun 2018 08:00:02 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm2621785wmo.26.2018.06.30.08.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 08:00:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove rtw_ioctl_rtl.h
Date:   Sat, 30 Jun 2018 16:59:41 +0200
Message-Id: <20180630145941.13118-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header rtw_ioctl_rtl.h is not used anywhere.
Running 'grep -r rtw_ioctl_rtl *' from kernel root
directory returns nothing, remove the file.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/include/rtw_ioctl_rtl.h | 66 -------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h

diff --git a/drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h b/drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h
deleted file mode 100644
index e29ebfd40a58..000000000000
--- a/drivers/staging/rtl8188eu/include/rtw_ioctl_rtl.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef _RTW_IOCTL_RTL_H_
-#define _RTW_IOCTL_RTL_H_
-
-#include <osdep_service.h>
-#include <drv_types.h>
-
-/*  oid_rtl_seg_01_01 ************** */
-int oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv);/* 84 */
-int oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv);
-
-int oid_rt_pro_set_fw_dig_state_hdl(struct oid_par_priv *poid_par_priv);/* 8a */
-int oid_rt_pro_set_fw_ra_state_hdl(struct oid_par_priv *poid_par_priv);	/* 8b */
-
-int oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv);/* 93 */
-int oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv);
-
-/*   oid_rtl_seg_01_03 section start ************** */
-int oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv *priv);
-int oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv);
-
-/*  oid_rtl_seg_01_11 */
-int oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv);
-
-/*   oid_rtl_seg_03_00 section start ************** */
-int oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv);
-int oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv);
-
-#endif
-- 
2.18.0

