Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8EC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5775B20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEuju2+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5775B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG2AbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39872 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbeG2AbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so8692842wre.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zic9By+GlvZKw2S7FiYXuD9kxh4GjhuJ8CuhOKq9TGs=;
        b=gEuju2+JWIIOcZYhqN6dlOOTioM84A0iqJ7egP9fyTq0r8q2vQPdLO8pr9DKAQGRw/
         LeBQWvddCZVk3Ro1noy8/411miWqMUuKjjR3oyGH9BKZcxJgfnb2HI1uSa5PxRcLSy72
         yC34+xiKnZ24rUVvCMVfHOtUNkuJhrbPFcBnHbmSCCVXDtvjxbxoE/rEFv1ecKY1V+jL
         bHUEtdYui4IfKqrPAV65PuqTRIuL1qAePHxkZDWC+L4y6RxQV2WvUS0BLH+R0aOHZ8/p
         jwhIJsqSocMBFilI6Z6EaRJgCx1rF3q0a7lz8VKbnSEJtAFpvZdgsdwcdEIgak8BAoyd
         5G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zic9By+GlvZKw2S7FiYXuD9kxh4GjhuJ8CuhOKq9TGs=;
        b=P2Q08p7vlApIfTnByQ9e0wFYz898ccjfpmxuUyHkEc012Mbe5DNmVNnPbNvoBd5o/y
         lJQOIYB8+IEYZwXpiuvLWjp9y70nBW4yAVZOoYF6QvBP/Od4dXWwTRuxYQenL8c9Ks+y
         uVjl2wwWweZye5s2vrHdoTS6DyzZEVNPS6mp8teXL8cKYSG1oEO0L8NVXGXI727aHx7C
         nY1QhyZpReMZSM9nWTuXR7oK0Q7UBzojoeY4gg1fmuAdYu77DFocTlNJOFrXxzuGvLt5
         Qzdy5utPE/LSARgyVDrz5qC5mtIB3Qj8JERHFn7utS2WmgUeTV4W08dWpC2mtkoQxZYw
         JY1g==
X-Gm-Message-State: AOUpUlHmkmlisQ8DABtrDdxQdC5ZWz0tU74YQ57IbP+1vfBM4htJ9ihi
        Fk+Nu4p3B9G2O5nU8wYhb/Y2mtiU
X-Google-Smtp-Source: AAOMgpdU5OTQ+2jJzPNPumAD8pR9zNJQeZ1+WBhcdLn7Fjiu3VK5cWoH0DpvayXCzlUvH/BJaqFnsA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr10370116wrm.226.1532818992708;
        Sat, 28 Jul 2018 16:03:12 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/12] staging:rtl8192u: Remove unused union ECW -Style
Date:   Sun, 29 Jul 2018 00:02:57 +0100
Message-Id: <20180728230300.19732-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union ECW is never used in code so has simply been removed.
This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 43edb830ad5d..65d7c9f4d840 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -24,18 +24,6 @@ union aci_aifsn {
 	} f;	// Field
 };
 
-//
-// ECWmin/ECWmax field.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.13.
-//
-typedef	union _ECW {
-	u8	charData;
-	struct {
-		u8	ECWmin:4;
-		u8	ECWmax:4;
-	} f;	// Field
-} ECW, *PECW;
-
 //
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
-- 
2.18.0

