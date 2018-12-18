Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29046C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23CF218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHKmJ5iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeLRSgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:36:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50642 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeLRSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so3683844wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQ2c4wk0lI4ceSmnIJBQ/Z0bYcscg7IsqaQ3eViqN4=;
        b=aHKmJ5ivAHJTF+whJSXSfvUUklr7J+J0omuwnfbz7CwsQe5Wey4dQbo3Hyq4Npskkr
         CONMNooqdXmSaOgJ5XGPUcOR7mK+G5fwni+WTjSXTeBRKOc3eU/k+5Sd/2oJJtethvJm
         TfNugko5diaXkIeZDyh6NwoDCBmujROtkoVGqctq197c50sBoe2wSm5tK0wDyJqdpLtu
         ZK0NO+Hf8mgJbhyUKuJdflh5KX3+msdUEGtB6GYMjWtqqxw5Da4M3oabwPnhaHpVIdZ8
         BkXyazeVkx9D4iLog/bZtYv0u13kA+4+aGRMhbYbnW2I/OHyoatJZmPtQEGvOudv7tzY
         1awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQ2c4wk0lI4ceSmnIJBQ/Z0bYcscg7IsqaQ3eViqN4=;
        b=k653iL+Jm/eGUghEQr8lZoB95LCFxrydgZYPz5QwPz4tcQ2EixoAoIGTRhI+9O49Fy
         bGerNHm/zaDlOX/WjQo7W8hU1I4Gk2p8zCWHc7eJ/DF95hR+n1Ri/KMDB5yBsA5BZ5ti
         UtRi4QAtYXZ2mX1uRU1l+azAty7GPwRPEPSC4z9vjGxEuNLoftTii7/XvR5wB9gF1G1b
         6iCD7T0iEBiP9cm6zYPD4xdfAVF0Xus7d9IkTkLrGwLXGP1SE5MF5Ebs3Fpjk+GZWMUS
         6OrtB2zixpR9HV/QhSSL1UCFFS4gqTONgHSOIR2WQBkv4rejYr3nszkGDeHmTWsNwkm1
         XqMQ==
X-Gm-Message-State: AA+aEWYoHdHB6Zz71UZkLcOJsDzfy2x6/0B0zGA7SBHJPIQ9ViMNm+bc
        IOjkDr8s3Ba+E/vCEPkOs4g=
X-Google-Smtp-Source: AFSGD/WCrJo6f1cTx5+73zd16S7VBSBNvK1PMSJ7e5+5WkYWSSkxlkhaeoCYwdN2S4lnzzrCIP3MfA==
X-Received: by 2002:a1c:ae88:: with SMTP id x130mr4040163wme.91.1545158117419;
        Tue, 18 Dec 2018 10:35:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:16 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 10/17] staging: rtl8188eu: convert unsigned char arrays to u8
Date:   Tue, 18 Dec 2018 19:34:44 +0100
Message-Id: <20181218183451.18692-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of some arrays from unsigned char to u8.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 16 +++++++-------
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 22 +++++++++----------
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  6 ++---
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  | 10 ++++-----
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 30ebec6c32be..dd1280eb3355 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -22,15 +22,15 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 /**************************************************
 OUI definitions for the vendor specific IE
 ***************************************************/
-unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
-unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
-unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
-unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
+u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
+u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
+u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
+u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
 
-unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
+u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
-unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
-unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
+u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
+u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 
 /********************************************************
 MCS rate definitions
@@ -5207,7 +5207,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	/* main tx key for wep. */
 	if (pparm->set_tx)
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 9a20faad96c9..484bb41b25cc 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -12,20 +12,20 @@
 #include <drv_types.h>
 #include <wifi.h>
 
-static unsigned char ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
-static unsigned char ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
+static u8 ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
+static u8 ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
 
-static unsigned char BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
-static unsigned char BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
+static u8 BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
+static u8 BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
 
-static unsigned char CISCO_OUI[] = {0x00, 0x40, 0x96};
-static unsigned char MARVELL_OUI[] = {0x00, 0x50, 0x43};
-static unsigned char RALINK_OUI[] = {0x00, 0x0c, 0x43};
-static unsigned char REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
-static unsigned char AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
-static unsigned char EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
+static u8 CISCO_OUI[] = {0x00, 0x40, 0x96};
+static u8 MARVELL_OUI[] = {0x00, 0x50, 0x43};
+static u8 RALINK_OUI[] = {0x00, 0x0c, 0x43};
+static u8 REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
+static u8 AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
+static u8 EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
 
-unsigned char REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
+u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 
 #define R2T_PHY_DELAY	(0)
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 126b96906171..090191fcae0a 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -211,9 +211,9 @@ int hostapd_mode_init(struct adapter *padapter);
 void hostapd_mode_unload(struct adapter *padapter);
 #endif
 
-extern unsigned char WPA_TKIP_CIPHER[4];
-extern unsigned char RSN_TKIP_CIPHER[4];
-extern unsigned char REALTEK_96B_IE[];
+extern u8 WPA_TKIP_CIPHER[4];
+extern u8 RSN_TKIP_CIPHER[4];
+extern u8 REALTEK_96B_IE[];
 extern const u8 MCS_rate_1R[16];
 
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 62999bc06de5..a2d9d5307179 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -81,12 +81,12 @@
 #define		_54M_RATE_	11
 
 
-extern unsigned char RTW_WPA_OUI[];
-extern unsigned char WMM_OUI[];
-extern unsigned char WPS_OUI[];
-extern unsigned char P2P_OUI[];
+extern u8 RTW_WPA_OUI[];
+extern u8 WMM_OUI[];
+extern u8 WPS_OUI[];
+extern u8 P2P_OUI[];
 
-extern unsigned char WMM_PARA_OUI[];
+extern u8 WMM_PARA_OUI[];
 
 /*  Channel Plan Type. */
 /*  Note: */
-- 
2.20.1

