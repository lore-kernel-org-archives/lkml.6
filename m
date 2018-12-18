Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B8FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF625218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7MQXph2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeLRSgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:36:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53800 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeLRSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so3673986wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dDmqtbs6PlvYjsSdKjp2UMPDl11lpofyKBJXWSQ6EQ=;
        b=E7MQXph2LhUSm8GwOVeZKqSWQSdYdzvbj3zVh6aJ2xHBepJQqx+bOufQf5zCQtX6pM
         hwMlGg4VxwW9938KtY9lD29nG/1HdAOsaxWI7d+U2pB6LR5PZE89PgVrNt6tppt+2ILf
         5LvfPoInVwPXreIbpi8vJJC7RNBSLv/csYSxVwncYJBcGLbJEo8C5tYNiw8VO90GKwpQ
         R683GO9TvyiIeWgC2TtpJRDxNEUQzcWxq8SQIa0sb5txq9kepVjxmE1tzAoSm0tKcC9M
         oUmI1KwJFioCe1XNYUqOdH7SOcC9otD0EFT/SlUoajLGWfQ4bed7DqpuQr4pP/p3u2jS
         ImDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dDmqtbs6PlvYjsSdKjp2UMPDl11lpofyKBJXWSQ6EQ=;
        b=IqMcgYY3gPuMIqXi+234GB0h3WUW9n9fdMbokH42LdmLQgMn28gD/rM82DIMDADbah
         q6D4Ajne7C1pzDd62QHD0HnzHmjCYCdNYx+/xIM+Ge+dEY6NTGEQivUaIwNPcx35TGk8
         AYO4QeCKbiPESX9ulqhF0fIYCr6JEYpegXnt5OyDRYBhITDskbTVtXIsBazNIpBOJcaj
         49HvyYONOMaIQYUd77UofQzlTCWwiCCUxsC5YjgofGNTNM/BYfu1Atu1j3t3wsv1wsEq
         i84zsCfubBMsyyn93UUslxsw9t1c8I1Cvy9AyWg5I7P/7ddIzJz9N2CH7P6m+lmWnkIM
         Kb3Q==
X-Gm-Message-State: AA+aEWZXSwplXPyVW7FITEJ0Ipqiy20VeKEO9tYMxtPTKspozP8AmAJ5
        S+RzmeOyWUCkugr7dJ7c36Y=
X-Google-Smtp-Source: AFSGD/XtO2rsU/knTz8lLvh97URv1w8exbxsmerHafSAuI9Hhyyj9e3R06LFZW0wi1wYI0C2fB9a3w==
X-Received: by 2002:a1c:47:: with SMTP id 68mr4049592wma.89.1545158118284;
        Tue, 18 Dec 2018 10:35:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 11/17] staging: rtl8188eu: constify some arrays
Date:   Tue, 18 Dec 2018 19:34:45 +0100
Message-Id: <20181218183451.18692-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values of these arrays in rtw_mlme_ext.c and rtw_wlan_util.c
are never changed, so make them const.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 14 +++++-----
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 26 +++++++++----------
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  4 +--
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  | 10 +++----
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index dd1280eb3355..ade4045bab45 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -22,15 +22,15 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 /**************************************************
 OUI definitions for the vendor specific IE
 ***************************************************/
-u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
-u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
-u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
-u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
+const u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
+const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
+const u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
+const u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
 
-u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
+const u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
-u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
-u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
+const u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
+const u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 
 /********************************************************
 MCS rate definitions
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 484bb41b25cc..d18ce3a76c95 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -12,18 +12,18 @@
 #include <drv_types.h>
 #include <wifi.h>
 
-static u8 ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
-static u8 ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
+static const u8 ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
+static const u8 ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
 
-static u8 BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
-static u8 BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
+static const u8 BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
+static const u8 BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
 
-static u8 CISCO_OUI[] = {0x00, 0x40, 0x96};
-static u8 MARVELL_OUI[] = {0x00, 0x50, 0x43};
-static u8 RALINK_OUI[] = {0x00, 0x0c, 0x43};
-static u8 REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
-static u8 AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
-static u8 EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
+static const u8 CISCO_OUI[] = {0x00, 0x40, 0x96};
+static const u8 MARVELL_OUI[] = {0x00, 0x50, 0x43};
+static const u8 RALINK_OUI[] = {0x00, 0x0c, 0x43};
+static const u8 REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
+static const u8 AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
+static const u8 EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
 
 u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 
@@ -33,20 +33,20 @@ u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 #define WAIT_FOR_BCN_TO_MIN	(6000)
 #define WAIT_FOR_BCN_TO_MAX	(20000)
 
-static u8 rtw_basic_rate_cck[4] = {
+static const u8 rtw_basic_rate_cck[4] = {
 	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 };
 
-static u8 rtw_basic_rate_ofdm[3] = {
+static const u8 rtw_basic_rate_ofdm[3] = {
 	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-static u8 rtw_basic_rate_mix[7] = {
+static const u8 rtw_basic_rate_mix[7] = {
 	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 090191fcae0a..bfef66525944 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -211,8 +211,8 @@ int hostapd_mode_init(struct adapter *padapter);
 void hostapd_mode_unload(struct adapter *padapter);
 #endif
 
-extern u8 WPA_TKIP_CIPHER[4];
-extern u8 RSN_TKIP_CIPHER[4];
+extern const u8 WPA_TKIP_CIPHER[4];
+extern const u8 RSN_TKIP_CIPHER[4];
 extern u8 REALTEK_96B_IE[];
 extern const u8 MCS_rate_1R[16];
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index a2d9d5307179..08151a175d6e 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -81,12 +81,12 @@
 #define		_54M_RATE_	11
 
 
-extern u8 RTW_WPA_OUI[];
-extern u8 WMM_OUI[];
-extern u8 WPS_OUI[];
-extern u8 P2P_OUI[];
+extern const u8 RTW_WPA_OUI[];
+extern const u8 WMM_OUI[];
+extern const u8 WPS_OUI[];
+extern const u8 P2P_OUI[];
 
-extern u8 WMM_PARA_OUI[];
+extern const u8 WMM_PARA_OUI[];
 
 /*  Channel Plan Type. */
 /*  Note: */
-- 
2.20.1

