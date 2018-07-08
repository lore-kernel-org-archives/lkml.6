Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC802C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730D2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFaHsmXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeGHL63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:58:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40394 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeGHL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:58:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so11708436edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GszbxB3261ChNu5ctSeCs4j/Q/+sTwvuD2r65xmhPpE=;
        b=kFaHsmXdjyi2D7W5ehazon2sUJyDzSiDHgYfAtM21JSU24q2FPCLLf8iiCN8xRtVJg
         42KX6Z4II9TMxJk/ynjSD/toSCly+zWYBn9xPJcEOxz7fg1p2nxTNDQYJQaAeUyu5Yov
         IXRfH+IyINV7Q/5/vsQ607P+wtwptNaZGHY3tmbc4nngDTYigRt6VTt+ZFQLL3vMgEpl
         FhxpCb43aGq4M6tpFayWUoXQPK+dF3Zf3OZF87PpQiTSv4T2SUtzSKOeEKqhQob27NYh
         JxEel87X5IuN+Ak83QDkRCYPPvrtr3Ps0HYsGuWlb34T0fSwRTXFplnk/xPUJ8NTV56j
         vIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GszbxB3261ChNu5ctSeCs4j/Q/+sTwvuD2r65xmhPpE=;
        b=dGosKSTVlQMFCd2DsxuZrXQNwbQYvqLmb8XFMam4IPl4T59P2tk8wqzDelNcmUt8n3
         D1PTi/zyFlVLuUnIxYme5wtF/F1dD/5U5KpQUgrDrEV2w4m1iKnEzMNSbwknp6JBPwme
         oFF1vHlmpCFNbq7VNSt6PIzhbaXj25R71rcxw8Kqi0IXjgRa47DCbY8TDRHc1NZGLohO
         2wH2OzR2gifo+qH7ogDYd7Mw3u4dTAokB0A4+AReo6RGS0RUPwVquGblnb0EXyu9jhTZ
         dpHzzwng80WmXFob6RGSyfsi6K6sBCtrGS7h+MJGI9pbtjI1NHoHpTEhjhMalSsfuWSD
         7ULw==
X-Gm-Message-State: APt69E3S0v2NEaLicvym10u0O8Y8REKm98Ra47tulGL6hFPKcxFsE98U
        HygMDo+NPVY9wkVzppI9NeM=
X-Google-Smtp-Source: AAOMgpfpK0MmDAvxsMu8NgHF2N+MUBUXHfzuyGMRKLYU0xbGHajEWJ72vPXZQEupKOQCKs6DV5kphg==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr18502183edz.79.1531051105649;
        Sun, 08 Jul 2018 04:58:25 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id k15-v6sm5355134edr.3.2018.07.08.04.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 04:58:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: replace tabs with spaces
Date:   Sun,  8 Jul 2018 13:58:12 +0200
Message-Id: <20180708115812.22769-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708115812.22769-1-straube.linux@gmail.com>
References: <20180708115812.22769-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in some function definitions and variable
declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index e6dff44e00fd..fed33d9acf60 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -73,9 +73,9 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+uint rtw_is_cckrates_included(u8 *rate)
 {
-	u32	i = 0;
+	u32 i = 0;
 
 	while (rate[i] != 0) {
 		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
@@ -86,7 +86,7 @@ uint	rtw_is_cckrates_included(u8 *rate)
 	return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+uint rtw_is_cckratesonly_included(u8 *rate)
 {
 	u32 i = 0;
 
@@ -212,9 +212,9 @@ uint rtw_get_rateset_len(u8 *rateset)
 
 int rtw_generate_ie(struct registry_priv *pregistrypriv)
 {
-	u8	wireless_mode;
-	int	rateLen;
-	uint    sz = 0;
+	u8 wireless_mode;
+	int rateLen;
+	uint sz = 0;
 	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
 	u8 *ie = pdev_network->ies;
 
-- 
2.18.0

