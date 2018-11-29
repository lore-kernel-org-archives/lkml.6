Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E409D21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkMMcb2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E409D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeK2RFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:05:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeK2RFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:05:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so913339wmj.1;
        Wed, 28 Nov 2018 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8bVnxML0RIBSqe2xfgatL1DZGkhzzv9tKm9bU+tLZo=;
        b=SkMMcb2akedNX6rVcDKZD7okC/jsOIYlXY5XNksqCo+CnHl8nUR9/kbXLLaJbjx8DV
         ZSppw+ZJf4LtRBT+J6LtkW6gDi9882wbXa57Qob5e/3IU3zFiJnc1/z5igGPsW0qnaDy
         v9zEG+sWKCVfBljD0fwTV6i2D4kIW/FhUAJlNxZy8R7rYVVhqeZsb/kJa8z10SEF5qSE
         hm1u+l4lTJdHH/aQCtderMPWoiGCQVFmclv3DXLfB6K8Zz2+v74vXpMWI87A54jomVzh
         e4O1JwZVwIqx3Yb95Xd4/doJnmWyjWhUuCjmwyQi9bd7Ie4PBPHfKfzR6AI3TJvhIg6B
         +6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8bVnxML0RIBSqe2xfgatL1DZGkhzzv9tKm9bU+tLZo=;
        b=M9ViwZDW7+jPMFfQvCCFujsmqI8zmbg88qj4bggDUkjOnGe0PsHeZpNVVssqNjWMh2
         MLcjBCOgzbixjlzBH6IqtrdmtJLUHzi+VpIU14Imu5JbyGAw2s12yG0l++KyGGyWz5q5
         todqYm2GzfnqYvnUqS8Mh77nLF0KMhioYb8jXXWAMOw/Z/Ks2wFVeGcE2uGe1Q5CD4Li
         a3hjzz3QeJr84BDqfXdMfpyHjk1YN17UQBuQE+xthLCUY3mbwZAIyTI/vLbhytOIhm8H
         Vp9aC2QKwIos67yRFVuWs7T6ANirVuznfpe5xotgVzUhzKefv74enC6xzYQ7D8GHHcwi
         RF0Q==
X-Gm-Message-State: AA+aEWZflBKMM/TtVVyQrc7Et+0heiwSRyfUcJl2X+8V9tueur0jqAua
        mqMnZeJ+7WzQ0BbzFFa2IXQ=
X-Google-Smtp-Source: AFSGD/Ui4lmkdixhimPM3NMeYlqOug2hDHAZ54WCs/+CVuPBCETCiY3cMiG7dY9f4uu1b5YRSWA/+w==
X-Received: by 2002:a1c:1849:: with SMTP id 70-v6mr435716wmy.110.1543471296934;
        Wed, 28 Nov 2018 22:01:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e9sm629421wro.16.2018.11.28.22.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 22:01:36 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] net: usb: aqc111: Initialize wol_cfg with memset in aqc111_suspend
Date:   Wed, 28 Nov 2018 23:01:05 -0700
Message-Id: <20181129060104.13966-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181129051808.30015-1-natechancellor@gmail.com>
References: <20181129051808.30015-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/usb/aqc111.c:1326:37: warning: suggest braces around
initialization of subobject [-Wmissing-braces]
                struct aqc111_wol_cfg wol_cfg = { 0 };
                                                  ^
                                                  {}
1 warning generated.

Use memset to initialize the object to take compiler instrumentation out
of the equation.

Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use memset instead of braces.

 drivers/net/usb/aqc111.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index f69d566bd523..57f1c94fca0b 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1323,7 +1323,9 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 			      1, 1, &reg8);
 
 	if (aqc111_data->wol_flags) {
-		struct aqc111_wol_cfg wol_cfg = { 0 };
+		struct aqc111_wol_cfg wol_cfg;
+
+		memset(&wol_cfg, 0, sizeof(struct aqc111_wol_cfg));
 
 		aqc111_data->phy_cfg |= AQ_WOL;
 		ether_addr_copy(wol_cfg.hw_addr, dev->net->dev_addr);
-- 
2.20.0.rc1

