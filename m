Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A825BECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6735220858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9GJIdrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6735220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeGUTvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34368 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeGUTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so6616494wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QvfMCMYoAagGCxMdaJGnRMG8z8eJJLlF+y+bfCmX1w=;
        b=u9GJIdrTUy+0joKxtGT8Wr9mK3z6t5mU+OWVNCVc0rWReQxYyoFAVPrXXPcaRbJBfq
         gfFlWSOoksLY7tHvdcZPhF412saV/J/lhN2kdi0hVzIgMLQfhLx674jGnqmMsTZIDyBl
         BCCZUxe31d6yZPFMLXtVr5GNlG/nM/SzJCQr2KvPqT/ggSblv9OLPKyhltZxNTRDzPaB
         +3gSzOT3VztMz/5DxwBKl4nTi79o6RZ4L6pERL6xA6Ly6VFBzxW043e9BFURR879V+yE
         dsrZz8020Vo1GbyKr5Xb5yitolyA3cUgNnMRffxw8ox6fVxBaR1R0O23H4wxRPMn66OR
         nzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QvfMCMYoAagGCxMdaJGnRMG8z8eJJLlF+y+bfCmX1w=;
        b=UVsIinD8O9NhOGB7xQRNz38EuH/BGrQBdcVMN2lq+FJ/DnRMuqY1wHgbaZoZ833qFm
         qVdO32N7eMpmak+eYGad5UxCEQwD1x7IpwlIZd6AQieGLho5Z7J6vRNh6u6Cv7w04EJv
         UkzZTZbxcPQBBUXAqOYuklWYz+WhD7/2aGkUyulqey2mE93ZLCBi0uuqeT9JQs+06FI3
         ZQMSJMVnkD8LwqBxVuq6Y+A98VVS/7j74xFpeNLEF/xLtls9Cu+c8fHLPIie4DAAy0nn
         GcOrVRNgU89ym+cnMF2vAaPe0pxJgGkxHinko6LU4ml95tTUMhOcB4W5caB2QyxbAttZ
         eC9A==
X-Gm-Message-State: AOUpUlGcOaAIkwxL836J/clGA7a5+Bee6rBGxYXIH9ve9qwBi76asI3D
        9WhjnkUtHf/VbQurOou+2GQ=
X-Google-Smtp-Source: AAOMgpdFNFOkQY5/TyjMq3nG2Wp4Sm5Fx6MJnAocnuf5WciNem8rzt/33saBnnrmJxfsXsmXy+0vCQ==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr3995314wmd.77.1532199488981;
        Sat, 21 Jul 2018 11:58:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: replace tabs with spaces
Date:   Sat, 21 Jul 2018 20:57:41 +0200
Message-Id: <20180721185742.7496-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces or just remove tabs where appropriate.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 1259cfd8098d..7d5cbaf50f1c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -39,14 +39,14 @@ u8 RSN_CIPHER_SUITE_WEP104[] = { 0x00, 0x0f, 0xac, 5 };
 /*  for adhoc-master to generate ie and provide supported-rate to fw */
 /*  */
 
-static u8	WIFI_CCKRATES[] = {
+static u8 WIFI_CCKRATES[] = {
 	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
-	};
+};
 
-static u8	WIFI_OFDMRATES[] = {
+static u8 WIFI_OFDMRATES[] = {
 	 IEEE80211_OFDM_RATE_6MB,
 	 IEEE80211_OFDM_RATE_9MB,
 	 IEEE80211_OFDM_RATE_12MB,
@@ -55,7 +55,7 @@ static u8	WIFI_OFDMRATES[] = {
 	 IEEE80211_OFDM_RATE_36MB,
 	 IEEE80211_OFDM_RATE_48MB,
 	 IEEE80211_OFDM_RATE_54MB
-	};
+};
 
 int rtw_get_bit_value_from_ieee_value(u8 val)
 {
@@ -492,7 +492,7 @@ int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie,
 {
 	u8 authmode, sec_idx, i;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
-	uint	cnt;
+	uint cnt;
 
 	/* Search required WPA or WPA2 IE and copy to sec_ie[] */
 
@@ -970,7 +970,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	u16 wpa_len = 0, rsn_len = 0;
 	struct HT_info_element *pht_info = NULL;
 	uint len;
-	unsigned char		*p;
+	unsigned char *p;
 
 	memcpy(&le_tmp, rtw_get_capability_from_ie(pnetwork->network.ies), 2);
 	cap = le16_to_cpu(le_tmp);
-- 
2.18.0

