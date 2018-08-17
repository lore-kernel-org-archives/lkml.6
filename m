Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B4FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27321A38
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2ovy9vP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B27321A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHQVje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40794 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so7841592wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ApNAZDGYiqlURIizintFb8Elra+Rgg25DvUe3hu8wfY=;
        b=b2ovy9vPJ0DU7dvqxeFUdoh912CQZ3V7o9UeHgtZLYQM3dHzwlkhVuxo4zIhT1cUmy
         QIRdeCjk50A6Z7cbHJo2pdJbucDWf7rQt1ArEwNMZ08RuySKaxGTD76tWzhjOW9RML7e
         SK+N/4FOTmfMZUEbqOkYC60ZePVZyWLzcXi4eYjVjRGr8RYe4V+ysFLsZWFTF3SskvPi
         o72EIxo/eDuuWBl3TGrMpO+pOUowcFry9LYCDMve6uTqMJY5xlP+csFEj3TlivtLv5AO
         qe3dC9Cn/FI27EqniAH5kkmfOvYYTW/ltA9O09kgJAyD6OA9+IFhDzU3V21fOwWdhvCl
         ZGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ApNAZDGYiqlURIizintFb8Elra+Rgg25DvUe3hu8wfY=;
        b=HxoJuAd1QX1ygKYV5zo6PPBYQ3vF7YxVGpPCoWVdzX7dX3teMSonYyMz9XzwNn/WAW
         MlDdgsJboMmmo6hFJ/pgSlxrTaiSLYsPa/IB4mgwWfg/MBwN5dvR2cIJlNWFFtcbgPy0
         wmaG9OHy0qPV5Fa98ipTmPZupbFVCNUFBKs6SAJk5cR/LGV72sVOhC9Qr3+c71Xc/e2D
         ZVB0XjvYtldgfDLNgjp/VXZ9+tMFL0ZDroiXZARKTaI16Dy7v4fXMbCSmQuKRAYYUtmi
         KX6okd2dDnjw7AqjZqXhYWN2tprNyp5Op0nnN+AYYY7TJgIXXf3hZUaanWB8hmp3axhp
         99Iw==
X-Gm-Message-State: AOUpUlFA6vk4aQvXbueuuD8pb6N8eUx2bP1pEHibpeYLBf2jz0L9s+zw
        TB07eA2WIHipSZEAZl7TXaPZGPH5eP8=
X-Google-Smtp-Source: AA+uWPxgkkaLRmisCTb9G3+KI3E4pt/c6voWJHC0A/GPCyiKC/wJTX6M/44XRPsIi/fc/XarV3EbRw==
X-Received: by 2002:adf:e648:: with SMTP id b8-v6mr5773515wrn.254.1534530905299;
        Fri, 17 Aug 2018 11:35:05 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/10] staging:rtl8192u: Correct block comments - Style
Date:   Fri, 17 Aug 2018 19:34:43 +0100
Message-Id: <20180817183447.15993-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the block comments so they conform to coding standard.

This is a coding style change which should not impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 73 +++++++++----------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 947c381bce79..5ead032735a6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -2,14 +2,14 @@
 #ifndef _RTL819XU_HTTYPE_H_
 #define _RTL819XU_HTTYPE_H_
 
-//------------------------------------------------------------
-// The HT Capability element is present in beacons, association request,
-//	reassociation request and probe response frames
-//------------------------------------------------------------
-
-//
-// MIMO Power Save Settings
-//
+/*
+ * The HT Capability element is present in beacons, association request,
+ * reassociation request and probe response frames
+ */
+
+/*
+ * MIMO Power Save Settings
+ */
 #define MIMO_PS_STATIC				0
 
 /*
@@ -18,18 +18,18 @@
  */
 #define HTCLNG	4
 
-//
-// Represent Channel Width in HT Capabilities
-//
+/*
+ * Represent Channel Width in HT Capabilities
+ */
 enum ht_channel_width {
 	HT_CHANNEL_WIDTH_20 = 0,
 	HT_CHANNEL_WIDTH_20_40 = 1,
 };
 
-//
-// Represent Extension Channel Offset in HT Capabilities
-// This is available only in 40Mhz mode.
-//
+/*
+ * Represent Extension Channel Offset in HT Capabilities
+ * This is available only in 40Mhz mode.
+ */
 enum ht_extension_chan_offset {
 	HT_EXTCHNL_OFFSET_NO_EXT = 0,
 	HT_EXTCHNL_OFFSET_UPPER = 1,
@@ -118,11 +118,10 @@ typedef	struct _HT_CAPABILITY_ELE {
 
 } __attribute__ ((packed)) HT_CAPABILITY_ELE, *PHT_CAPABILITY_ELE;
 
-//------------------------------------------------------------
-// The HT Information element is present in beacons
-// Only AP is required to include this element
-//------------------------------------------------------------
-
+/*
+ * The HT Information element is present in beacons
+ * Only AP is required to include this element
+ */
 typedef struct _HT_INFORMATION_ELE {
 	u8	ControlChl;
 
@@ -161,12 +160,11 @@ typedef enum _HT_AGGRE_MODE_E {
 	HT_AGG_FORCE_DISABLE = 2,
 }HT_AGGRE_MODE_E, *PHT_AGGRE_MODE_E;
 
-//------------------------------------------------------------
-//  The Data structure is used to keep HT related variables when card is
-//  configured as non-AP STA mode.  **Note**  Current_xxx should be set
-//	to default value in HTInitializeHTInfo()
-//------------------------------------------------------------
-
+/*
+ *  The Data structure is used to keep HT related variables when card is
+ *  configured as non-AP STA mode.  **Note**  Current_xxx should be set
+ *  to default value in HTInitializeHTInfo()
+ */
 typedef struct _RT_HIGH_THROUGHPUT {
 	u8				bEnableHT;
 	u8				bCurrentHTSupport;
@@ -267,11 +265,10 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u32				IOTAction;
 } __attribute__ ((packed)) RT_HIGH_THROUGHPUT, *PRT_HIGH_THROUGHPUT;
 
-//------------------------------------------------------------
-// The Data structure is used to keep HT related variable for "each AP"
-// when card is configured as "STA mode"
-//------------------------------------------------------------
-
+/*
+ * The Data structure is used to keep HT related variable for "each AP"
+ * when card is configured as "STA mode"
+ */
 typedef struct _BSS_HT {
 	u8				bdSupportHT;
 
@@ -292,9 +289,11 @@ typedef struct _BSS_HT {
 extern u8 MCS_FILTER_ALL[16];
 extern u8 MCS_FILTER_1SS[16];
 
-/* 2007/07/11 MH Modify the macro. Becaus STA may link with a N-AP. If we set
-   STA in A/B/G mode and AP is still in N mode. The macro will be wrong. We have
-   to add a macro to judge wireless mode. */
+/*
+ * 2007/07/11 MH Modify the macro. Becaus STA may link with a N-AP. If we set
+ * STA in A/B/G mode and AP is still in N mode. The macro will be wrong. We have
+ * to add a macro to judge wireless mode.
+ */
 #define PICK_RATE(_nLegacyRate, _nMcsRate)	\
 		(_nMcsRate == 0) ? (_nLegacyRate & 0x7f) : (_nMcsRate)
 /* 2007/07/12 MH We only define legacy and HT wireless mode now. */
@@ -331,9 +330,9 @@ typedef enum _HT_IOT_PEER
 	HT_IOT_PEER_MAX = 6
 }HT_IOT_PEER_E, *PHTIOT_PEER_E;
 
-//
-// IOT Action for different AP
-//
+/*
+ * IOT Action for different AP
+ */
 typedef enum _HT_IOT_ACTION {
 	HT_IOT_ACT_TX_USE_AMSDU_4K = 0x00000001,
 	HT_IOT_ACT_TX_USE_AMSDU_8K = 0x00000002,
-- 
2.18.0

