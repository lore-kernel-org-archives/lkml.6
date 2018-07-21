Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C52ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8082720863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLQZopQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8082720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeGUTvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeGUTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so14101370wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cX2aCTsVZ4vBSdd5zPtHnKwlK9Wc9VIz156r8mT5yzg=;
        b=HLQZopQU8x+hbwvWw1ltRhHRslbB+tZ+8Bjf3SyqftEarHdpHuSk+SbxJQvts3NCIb
         MLaVly8WXKfqZiUYXEwappmirqetryzz4xSvmY5a/VklaBuoQMQxSqZhgJhnikZbblAw
         8s17oh+h7sG9IlpgiY9vBPLwsMwDYt4PfPOIZY4FX3ZURVVSDLJ+gFRUuGSkyh41RbzZ
         ZrWwcmI+OT/SYJ3WBnoBIs7jhwKL+hQDH3HRtTvSsaRsDQM27QLQvJqsZa7OYp0IwFfi
         /WgcFRRd1mUEn3DGmX+nD49XhQpRxBgy5tRCxAaEDYWUQW/Q7/EYTs4dE6kJ9SM+vf0/
         JFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cX2aCTsVZ4vBSdd5zPtHnKwlK9Wc9VIz156r8mT5yzg=;
        b=mWJFQtLurT/gATHBfjuLHg6AuNPq1B8AJG/5ppjIrY0j8Oryly3QA5e6QEALswF064
         KVkj9gDwtuZQGLaKThoQdjq9+vHIdZx3O0UyrZUiBIQtzexLpi+0RBbH9yzw92wIjfq8
         rbaO2ioC18NVh0AnXXDW/Kezkynw6zy3nvu5atL2yGg+skaofIf5+Xu+TfOJL92344zK
         3vykv+0tDLd9cVyzF9XVdSG6rPTWoXKV6uF27l4T/9qlUfLr7YFRHxJJ0R9ISuiae7+7
         e0M4pBXxLRV/51rGTTX7aXxrK/VGUZ4Aq5iLucTcSNPw6fLJ5bqs6P9wf8cvnCwXeuUq
         Jd3g==
X-Gm-Message-State: AOUpUlHZi4zi8oMtZEyZ5dh0uE7QQLWxADMAO/Mq7U5Ef5skOziKxET8
        P1CHwzOgXkhlM8SKsHhGqfc=
X-Google-Smtp-Source: AAOMgpcdJ982I16ZDPvoeLuiOEvZv4HliIFe1oEL08pxxV/Qs1oqyD8k4a1emefEoKjCb/zv54IFjQ==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr4482756wru.261.1532199480930;
        Sat, 21 Jul 2018 11:58:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: refactor rtw_is_cckrates_included()
Date:   Sat, 21 Jul 2018 20:57:36 +0200
Message-Id: <20180721185742.7496-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtw_is_cckrates_included() to improve readability and
slightly reduce object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index b7188fa5364a..b695f47be073 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -74,14 +74,14 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 
 uint rtw_is_cckrates_included(u8 *rate)
 {
-	u32 i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
-		i++;
+		rate++;
 	}
+
 	return false;
 }
 
-- 
2.18.0

