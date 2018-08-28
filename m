Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A6820856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS/l6slx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A6820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeH1Wsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:48:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40830 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1Wst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:48:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so2132778edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/9KyDkWw/UevIrWG1PjWY5YJUHkIawCXkIPoAOmBFk=;
        b=eS/l6slxBidHshZroc3jMq7zxwvmxQeMV+17o+czSbs9nS9dK5L3nzTEXAKWz46+Tq
         oBb51SFHG1uKgrblRL+BJQbczOzA4zcFN+heqp8btA5UGepNCEyr/UBbdzagpeC+/Gkk
         VXBeqi6m/Bc5FhMPMuJ6aTQdJ9ZghrA8kGwD8jIxtdlQ8HT91oOvUfmxuR2LaYQNj0CS
         GF3KJo4GYv3KIZciKsaAkhupNqIWWFGsNg+0gStIdUGeaDN+bRC7HudsZWxcTxmnYz3g
         0cxeqtNIDiIH/mxK2fyLrLKnGCyhJowkU1r7r6TMhPMDmVBYzNk9IXCee3fvU1srYFcW
         tugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/9KyDkWw/UevIrWG1PjWY5YJUHkIawCXkIPoAOmBFk=;
        b=KpFSy7iVhk4DLlmkeCNbDhF+7uWVtfyAv+a9FNTSCJbPpxdCz+GF6zPRQtjVcXr7M2
         oyPzgo0/FC1lj5Up5dVo/tcmnrCHuXN/SgU2UvRH4kBzjt4piO0J6LJuEaCM7Lqflo92
         w3KvgoANNc7gdnquXwptBIyq1Jk7afdPDqBxt997Bmw5GqaN3FwA7STPh/HceZeIK+ko
         fAydxEtZEBosGOO1veBqauJF4rEfpOePfdOFzKHq7F4z7a7nvk+aQNpsroWnw3DJ3ZYe
         wW+G+7j2BCXDdgI1XKKVQH9BGwpKyBCYjXDfFPmeOD8kNTFbYqLwlMy5EYFGKsmnuXaS
         Cccw==
X-Gm-Message-State: APzg51AdxACfjt1vZDEbAK5aBgpcpzWmdO/ATRR2K/1ZmtZcNO7ZcBBs
        XyUYgBKAv88RMNL6w2LA18e6N0uh
X-Google-Smtp-Source: ANB0VdYAHgd3aeMde86h4AmwEEe/ibQkFmbHv/tZ/JbmHvmAdNanNNzOXuIKmQ/J1UvMOEcwGy6Wjg==
X-Received: by 2002:a50:fc90:: with SMTP id f16-v6mr3948643edq.149.1535482550030;
        Tue, 28 Aug 2018 11:55:50 -0700 (PDT)
Received: from localhost.localdomain ([109.79.175.209])
        by smtp.gmail.com with ESMTPSA id o24-v6sm742975edr.64.2018.08.28.11.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:55:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/4] staging:rtl8192u: Remove unused definitions - Style
Date:   Tue, 28 Aug 2018 19:55:32 +0100
Message-Id: <20180828185535.28808-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828185535.28808-1-johnfwhitmore@gmail.com>
References: <20180828185535.28808-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused definitions from the file r8180_93cx6.h.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8180_93cx6.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8180_93cx6.h b/drivers/staging/rtl8192u/r8180_93cx6.h
index 643d465e7105..bfbef1a16159 100644
--- a/drivers/staging/rtl8192u/r8180_93cx6.h
+++ b/drivers/staging/rtl8192u/r8180_93cx6.h
@@ -21,22 +21,4 @@
 
 #define EPROM_DELAY 10
 
-#define EPROM_ANAPARAM_ADDRLWORD 0xd
-#define EPROM_ANAPARAM_ADDRHWORD 0xe
-
-#define EPROM_RFCHIPID 0x6
-#define EPROM_TXPW_BASE 0x05
-#define EPROM_RFCHIPID_RTL8225U 5
-#define EPROM_RF_PARAM 0x4
-#define EPROM_CONFIG2 0xc
-
-#define EPROM_VERSION 0x1E
-#define MAC_ADR 0x7
-
-#define CIS 0x18
-
-#define EPROM_TXPW0 0x16
-#define EPROM_TXPW2 0x1b
-#define EPROM_TXPW1 0x3d
-
 int eprom_read(struct net_device *dev, u32 addr); /* reads a 16 bits word */
-- 
2.18.0

