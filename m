Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BFFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974672080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOCpRnDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbeLOQrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:47:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52132 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so8468796wmh.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XKdYbnr4tfyKwElzFhvDPqEUXNKaRI44IkBSTa87LA=;
        b=KOCpRnDNXzXNsYOMgvpW6rE+pkfc0OBDRGiP0BsXnOvjqx0erU/BwlS3mjEcenVkUX
         tMAJzSIayEjdng2bmKjNuTDX4m64ikAV68Rka1MedasXqeOZap1RXJnOEmTfQDJhXLIf
         H1t1xsuV5Gin1noGb/AhbYP2mwpV2TEhgS8faJv4kBe/rDQ5iAJcy74NCfyZG6vhk3RO
         HSU8AfhGGhP7uLdNDH/fWpyqnbCMMCaWIwEJ5oDEmbHrCa5gDNaRv6w1uNM/Wf50FHK8
         9LbfWOyIpFZrULRkPJAk9t3tCZfUv6Goj38r2bzKCT2wQQS4UyTV9hL+mcv0se8dIv0t
         xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XKdYbnr4tfyKwElzFhvDPqEUXNKaRI44IkBSTa87LA=;
        b=ro7d2DgKdH8/0f/KpScRkzK9JjLkuVPWUMKGt1xbsaQoQZRKEbTE16WBtVgjgi//2g
         DpiyhWOELz/zsc+PD4TAcoWUBsT1OkT5Ccasoxy4VBxWE94L+cEfkjkdRV3hJ6US2c+9
         XktRa/Whdb4G0HeXHjB5lqrRTtkFBHMatQX6JBGtIa0Yj36j7NlNnkeXav7hGwIfN9sk
         UJZ4y1f02Xu9ZY1Rjd0SjK99wmKK3D4B1DxU1v2hX6UKBRmeunekGqUTNRXfLfFNgHgN
         bT4R5FyO9tWpREpSr4FJBOSBhZKIdoiBJ2D8QN+pYwfyokNUqqScf0nrJA8unspX0mHN
         nrIw==
X-Gm-Message-State: AA+aEWaKadvDI6ywrnUdO+UQYrhFsMSvJPiuLVoHtmsA04AzizEDE26X
        R8u/c5IMD2SZfwTr+YQkVMZbP/9p
X-Google-Smtp-Source: AFSGD/VYOm4NoKnvyymuPBXjItWwjI1Uf+oLAiPcnf+oFYDmn5qtP+9hQh5MSAaNWuBpqp5nbrLIpQ==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr6480153wmg.122.1544892390930;
        Sat, 15 Dec 2018 08:46:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/9] staging: rtl8188eu: convert unsigned char arrays to u8
Date:   Sat, 15 Dec 2018 17:46:11 +0100
Message-Id: <20181215164616.2643-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert unsigned char arrays to u8 and make them static and/or const
where possible.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 18 ++++++-------
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 26 +++++++++----------
 drivers/staging/rtl8188eu/include/rtw_mlme.h  |  6 ++---
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  9 ++-----
 4 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index eda11eff5051..b5cd9f6c4e30 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -22,17 +22,15 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 /**************************************************
 OUI definitions for the vendor specific IE
 ***************************************************/
-unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
-unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
-unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
-unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
+const u8 RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
+const u8 WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
+static const u8 WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
+static const u8 P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
 
-unsigned char WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
+static const u8 WMM_PARA_OUI[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 
-unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
-unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
-
-extern unsigned char REALTEK_96B_IE[];
+const u8 WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
+const u8 RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 
 /********************************************************
 MCS rate definitions
@@ -5210,7 +5208,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	unsigned char null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 	/* main tx key for wep. */
 	if (pparm->set_tx)
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 9a20faad96c9..f01a50e8ba51 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -12,20 +12,18 @@
 #include <drv_types.h>
 #include <wifi.h>
 
-static unsigned char ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
-static unsigned char ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
-
-static unsigned char BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
-static unsigned char BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
-
-static unsigned char CISCO_OUI[] = {0x00, 0x40, 0x96};
-static unsigned char MARVELL_OUI[] = {0x00, 0x50, 0x43};
-static unsigned char RALINK_OUI[] = {0x00, 0x0c, 0x43};
-static unsigned char REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
-static unsigned char AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
-static unsigned char EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
-
-unsigned char REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
+static const u8 ARTHEROS_OUI1[] = {0x00, 0x03, 0x7f};
+static const u8 ARTHEROS_OUI2[] = {0x00, 0x13, 0x74};
+static const u8 BROADCOM_OUI1[] = {0x00, 0x10, 0x18};
+static const u8 BROADCOM_OUI2[] = {0x00, 0x0a, 0xf7};
+static const u8 CISCO_OUI[] = {0x00, 0x40, 0x96};
+static const u8 MARVELL_OUI[] = {0x00, 0x50, 0x43};
+static const u8 RALINK_OUI[] = {0x00, 0x0c, 0x43};
+static const u8 REALTEK_OUI[] = {0x00, 0xe0, 0x4c};
+static const u8 AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
+static const u8 EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
+
+u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 
 #define R2T_PHY_DELAY	(0)
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 126b96906171..bfef66525944 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -211,9 +211,9 @@ int hostapd_mode_init(struct adapter *padapter);
 void hostapd_mode_unload(struct adapter *padapter);
 #endif
 
-extern unsigned char WPA_TKIP_CIPHER[4];
-extern unsigned char RSN_TKIP_CIPHER[4];
-extern unsigned char REALTEK_96B_IE[];
+extern const u8 WPA_TKIP_CIPHER[4];
+extern const u8 RSN_TKIP_CIPHER[4];
+extern u8 REALTEK_96B_IE[];
 extern const u8 MCS_rate_1R[16];
 
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 62999bc06de5..1fb2349bd0a0 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -80,13 +80,8 @@
 #define		_48M_RATE_	10
 #define		_54M_RATE_	11
 
-
-extern unsigned char RTW_WPA_OUI[];
-extern unsigned char WMM_OUI[];
-extern unsigned char WPS_OUI[];
-extern unsigned char P2P_OUI[];
-
-extern unsigned char WMM_PARA_OUI[];
+extern const u8 RTW_WPA_OUI[];
+extern const u8 WPS_OUI[];
 
 /*  Channel Plan Type. */
 /*  Note: */
-- 
2.20.0

