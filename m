Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9FAECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F6C20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwZBZ39k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F6C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeGUTvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeGUTvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1257778wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5R3yVBHLMT3fAeREpweUC4g0rJRSCT474DZnOgKO7U=;
        b=PwZBZ39kqJB/xjJCF2gRLUivqHM1lr1CxD8fLegvZwjualmsloed01L7PZrIR1gmsL
         HatNk99+6I8VRHZh3PDtaCYnTC5uoZToKiyfHznHCtvk83NqfhNE10HL+gS+87efKz13
         8uF0F4BwrqMaS9wsGqY20oOb9YqCMKFbsqu6JC0bflrjfG/Awpn3p8RChCQa6Cthy3hh
         akbx+nncPQNZRZVHKJttao/BWcIX+5AEw3wc/xfpX11QeW0YbTrLwYA4RwDnKPg8Kr3u
         KYXAtAbFxtfHj0f4Wo43afemTHw3/EURP2HKEUmnNEKYJksNZeY9cIPC8aOC//bW+olf
         KdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5R3yVBHLMT3fAeREpweUC4g0rJRSCT474DZnOgKO7U=;
        b=B48HYxUf+wTz6cqW72c2pDcnSQXGc+YLZDBFesIaJrxbGoaKzANHiGq33mNAY8Tx9Z
         EiTdYebElDuHM8SrPso+G2fGJXexs+/O5gM31ic719eawMGMHXNfZbZcdJrhGGA/3FWw
         KfhZCsuP/V1Ojo8/nJ0K8hkD0rsxKoOZ8XqqHxfo43gWbIJKXV+GJj0GMRktOJrTFmZW
         qfglkPNlnBqn0MGj7cic+PdcYregSBfnZUqFiJsvYPRL/lxCQZpWX604/pbvTiLOXYDZ
         Ni6NCFq+XB6lvZkHjz8uRGMi5WEk4LdisEW85mW4PeIe1qS4Sk0cInsfPkB9z4vaqE6g
         /b5g==
X-Gm-Message-State: AOUpUlGVzaQnCkqHWV2urXtEKplfOuEHht9fLiqG+tizDrXw4knKRnYO
        rfAPkgbeyWh7kBChlpA3ezo4QXpa
X-Google-Smtp-Source: AAOMgpfUqk1MisNgNmCTZrz4FEbiz5j3W+aXd6QRg2pb8IRc+PeLR4L0p4YqymGq3mjr/3Cao/+cBA==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr4047634wmf.148.1532199487450;
        Sat, 21 Jul 2018 11:58:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: rtl8188eu: remove unnecessary parentheses
Date:   Sat, 21 Jul 2018 20:57:40 +0200
Message-Id: <20180721185742.7496-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 9db19724f168..1259cfd8098d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -40,18 +40,18 @@ u8 RSN_CIPHER_SUITE_WEP104[] = { 0x00, 0x0f, 0xac, 5 };
 /*  */
 
 static u8	WIFI_CCKRATES[] = {
-	(IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK),
-	(IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK),
-	(IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK),
-	(IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK)
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 	};
 
 static u8	WIFI_OFDMRATES[] = {
-	 (IEEE80211_OFDM_RATE_6MB),
-	 (IEEE80211_OFDM_RATE_9MB),
-	 (IEEE80211_OFDM_RATE_12MB),
-	 (IEEE80211_OFDM_RATE_18MB),
-	 (IEEE80211_OFDM_RATE_24MB),
+	 IEEE80211_OFDM_RATE_6MB,
+	 IEEE80211_OFDM_RATE_9MB,
+	 IEEE80211_OFDM_RATE_12MB,
+	 IEEE80211_OFDM_RATE_18MB,
+	 IEEE80211_OFDM_RATE_24MB,
 	 IEEE80211_OFDM_RATE_36MB,
 	 IEEE80211_OFDM_RATE_48MB,
 	 IEEE80211_OFDM_RATE_54MB
@@ -919,7 +919,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
 	}
 
-	DBG_88E("%s MAC Address  = %pM\n", __func__, (mac_addr));
+	DBG_88E("%s MAC Address  = %pM\n", __func__, mac_addr);
 }
 
 static int rtw_get_cipher_info(struct wlan_network *pnetwork)
-- 
2.18.0

