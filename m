Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C51208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxUCUeYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C51208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeGaWnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:43:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41651 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeGaWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so5849380edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1yh2jetdP0r9KmyPTmhJJIuNTHgeV9AukaqW6y3nHr0=;
        b=HxUCUeYeY1bb5yaSdF9iBPaFntZ5Zkr4RWcisyrEyeO6Nh/f/hnJbOyZfB3c9rdiVO
         PjwNNpJl08DhIt1Gb5LpNb+JkPYzvP+ky2u0tlKX0tZSm0zy7SjyFbk+J86E7Hk0aCZ7
         Xq3UBQCLhlMjWoObCx/SAUpsblCkA9NqZ2wWEa5LKrq7TokgaPpEoOCVDP6Di31CU+Xy
         ANDEn6Pl6iRiwOQJfgNNxzJirSYb1xk0vYsJwO2sK7QpPzskasKXtwaZQCOh0i3Gen9E
         VEO1nO9JeMTy1O0n7tnOU2OadLkWQXa6RJ2O7rsKAq49fnE0RmFYFVudvZC9U8lFJN9g
         IvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1yh2jetdP0r9KmyPTmhJJIuNTHgeV9AukaqW6y3nHr0=;
        b=DLzSVvsE74i8oShHsu1NMbR17wom8rObXBTmNatG4E875C1MquhDduhJMFV5OU+TBk
         zVJbql0vqpoGDGguIkFdZ6Nd6fWzMbpsFFKHSiTI4LOKX6k+DQL49cFsYe3KGBm0lYRi
         ScgH9BMRkQGAS/sDvpHjN7J+li82YMg/l2vwpiZ3YWiOTFzSkdxZ3CAq6h6feAT0kxFH
         LbmOmcgP8TpFjLthvc1W0m4PoBuwZk+jwuPvqkwoUOGAEJS8tVlM30U4P8DhONdaix99
         V32/HYrM7MJnPU6DDbJrZqw6zb6JVBka+1EqZDdBVSpMlZn+eq6P3ZLMnRIX8fS88gdu
         0HAg==
X-Gm-Message-State: AOUpUlGsaYOeJPvSeRDXAqISr5wJ/mJSGEkO7i8j9pYBsOS34beWEHcG
        z4ZsSAajHPVU3hFNh0NhJ8/RB68x
X-Google-Smtp-Source: AAOMgpeXWW5aKrSFcgV0DIeMkPUC7u5s8YwNQUqFSZV2vwgL4Uz+lHxjTrYOKXVCuwUQ8pn/OHsHIQ==
X-Received: by 2002:a50:89d3:: with SMTP id h19-v6mr1115492edh.140.1533070847691;
        Tue, 31 Jul 2018 14:00:47 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/14] staging:rtl8192u: Rename IsACValid and add parenthesis - Style
Date:   Tue, 31 Jul 2018 22:00:04 +0100
Message-Id: <20180731210005.17452-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro IsACValid is renamed to resolve the checkpatch issue with
CamelCase naming. In addition the parameter has parenthesis added to
clear the checkpatch issue with precedence issues.

These changes are coding style changes and as such should have not
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h    | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 59a60f86607c..77f0e26f5d2d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -77,6 +77,6 @@ struct octet_string {
 	u16             length;
 };
 
-#define IsACValid(ac)			((ac <= 7) ? true : false)
+#define is_ac_valid(ac)			(((ac) <= 7) ? true : false)
 
 #endif // #ifndef __INC_QOS_TYPE_H
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e0ccabadec22..de06cd11ab65 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -309,7 +309,7 @@ bool GetTs(
 		UP = 0;
 	} else {
 		// In WMM case: we use 4 TID only
-		if (!IsACValid(TID)) {
+		if (!is_ac_valid(TID)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, " in %s(), TID(%d) is not valid\n", __func__, TID);
 			return false;
 		}
-- 
2.18.0

