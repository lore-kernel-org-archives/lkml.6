Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C78ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B8120858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4BqUJxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B8120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeGUTvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeGUTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so14081998wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8yMKYgqa4dnn4LXX3gofDT8G7dbJh6H2EtFfUwPSSk=;
        b=U4BqUJxaEKzOm0e6/SvLcsqPwZ2Uu//TRDfvsAeF/suDjg25iBAuSjgL48n6tFpsev
         4jQXt0VM39z1WqlogUs0co3OdNDJ2msfYxojTllDkMJBYX81LhzpSY+tNXp0rd0X9u79
         vRTQXPEIpAFRy1NqfJWzbTG+FKpSYPAjM3Ny0gBUut6ZSQEjTpwUt6GRGmbzCOXdLkaq
         uJyFAK+iInHn4e8wZ0wtLxuP9AzkEFj2Uzp2XBRncOBZH1aK4++y+VlrDi2aFP4hYLXG
         gOdRcm7zwUti8VfFeIGd5PVeMwpCyXbOsREYQndXXZJkobzQ4KIjPp6NdUpYPjE1E4zU
         d//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8yMKYgqa4dnn4LXX3gofDT8G7dbJh6H2EtFfUwPSSk=;
        b=K9LMOx/0Hvj7gtA9A9//Pc6Nx+5W33PvHajJXuPOr+kmUoaxxswcu9yt/cQuwQ3bZa
         acLnk4Seu9ofp5ppLrewusGbddgJ+I1azUYJiAsF/E4OiijnhPemSQprwBA/ya/Hn7vG
         fKwEIgxgrt9U25uItZZc/wh8gJzNA4taYpWhwB97lMiTq93dkV98kBIHeO1+IRkY9q4b
         QHhnrRsJccCy6328fjSHe1h4FdOAI2RDaOoodGStbwQNIiq6GAcL0RpYBQDHPm1mdoec
         imS3+wNkxDqe+F2zMIJ6Xp3pLkB0PliJPztBYXLhzVe8VZa0bnBEXPj7tLhXlzyEmFd1
         IkZA==
X-Gm-Message-State: AOUpUlE8dKI8RQEIzIqNIWXrH8vUfh4BfyS5hd8YGmoB0RNQBl8kSbm+
        26+WaqnD6/acjie7+705FfbehC6N
X-Google-Smtp-Source: AAOMgpeEjxoEEcCLeudhWtwzB84Am4Yt0loCghdQJrkhwUGUo3XAdsrPf50+ErLXnst+NNDWnRbFSg==
X-Received: by 2002:adf:f585:: with SMTP id f5-v6mr4330627wro.59.1532199482807;
        Sat, 21 Jul 2018 11:58:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: refactor rtw_is_cckratesonly_included()
Date:   Sat, 21 Jul 2018 20:57:37 +0200
Message-Id: <20180721185742.7496-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtw_is_cckratesonly_included() to improve readability and
slightly reduce object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index b695f47be073..77eca07c92aa 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -87,13 +87,12 @@ uint rtw_is_cckrates_included(u8 *rate)
 
 uint rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	while (*rate) {
+		u8 r = *rate & 0x7f;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
-		i++;
+		rate++;
 	}
 
 	return true;
-- 
2.18.0

