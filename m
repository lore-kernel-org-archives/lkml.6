Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821DDECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EAF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uibjJbG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EAF20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeGUTvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeGUTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so14127880wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cetfgD6NYY1JM5xAg9RA3v8FHreuHzAPGO+X1IMABng=;
        b=uibjJbG37ZZDrc9gkBLqm6+af386hr+Td5g1P7CAO0gH7DZvEdrjoCNakHxkHxz/SD
         6mpDLXTMmEh2+uZvBTQ1iWQfE9LYCjk6jQ58FXoxK6g8RFgHzt7dsboscGGUyWQ9E8WV
         a3QhYBPBfCg9gwDxzlCHJuxF3Nj6kFzzWxINId2VHlpZHoH3aPC3ukv3RSokYv3alhBs
         WPPRCxUhm4HjwWZ+kUlMPRF/k0mmUF4GIQxSswsbPO7/9v4s5Of4iGu7mJgfFu3mIgbA
         R0hGexev3XkeZO+ArBWI3PCWYh5Y6ICTICM9jej5Y86G1ot293z2kFELxrbyDYUtziuA
         tjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cetfgD6NYY1JM5xAg9RA3v8FHreuHzAPGO+X1IMABng=;
        b=nWyv61mT0xZJmPlprF3+fK37fxHiEv0WX1Fhp8ACUqM4Im9CRA1sTTQmDB9WAZl7qw
         tzL9nlp1p6Evzk5iKIK0t1F2Td0Il0UpwcKcQfz9vx+wvx4KPSlOCPYTYzIoD+cdLqjB
         pvZcd0idxk0QX5qjEEpKgVhCEyMVy2jHAexJhlsFZoSLOMejauC5gpi27iYoR6fvL1FZ
         mUdVCMOkGS+1BHGDHz9+a3nmp6USQeW9/sqdmTms193bnMVXnsZeY+dYfCe3yt+RswfS
         aEFMPiet4LYJUofq2JyiiFZph8eIIpLiDQDK9SQkPf8tZoLdT3As0RqcZ1yXZU+4weSe
         jR3w==
X-Gm-Message-State: AOUpUlHb1MMzazuw2LvzZ5oPSn61SN0FZCbb961mGHxZT5AiYX3wut+5
        RAV0rThzLJ3WbmZTo8uEFms=
X-Google-Smtp-Source: AAOMgpeOC3rnG78+MaUZBGDiLYnp2ChKioq91MZng3WqK4DlrtJQnEseUx1x5nvGe6ly3cNhwbX2eQ==
X-Received: by 2002:adf:f64c:: with SMTP id x12-v6mr4198815wrp.97.1532199484316;
        Sat, 21 Jul 2018 11:58:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: change return type to bool
Date:   Sat, 21 Jul 2018 20:57:38 +0200
Message-Id: <20180721185742.7496-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both rtw_is_cckrates_included() and rtw_is_cckratesonly_included()
return true or false. Change the return type from uint to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 4 ++--
 drivers/staging/rtl8188eu/include/ieee80211.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 77eca07c92aa..d48840869307 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -72,7 +72,7 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint rtw_is_cckrates_included(u8 *rate)
+bool rtw_is_cckrates_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
@@ -85,7 +85,7 @@ uint rtw_is_cckrates_included(u8 *rate)
 	return false;
 }
 
-uint rtw_is_cckratesonly_included(u8 *rate)
+bool rtw_is_cckratesonly_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index 3fbd92a95b17..c60b833ca110 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -767,9 +767,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
+bool rtw_is_cckrates_included(u8 *rate);
 
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
-- 
2.18.0

