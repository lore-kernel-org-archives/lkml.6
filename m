Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05178ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85A420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wSjQ5MbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85A420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeINPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:47:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:47:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so10015819wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3DZ+oX6KvCfED1/kBUM71B/YCmo6RLhrUP2ubiTmXII=;
        b=wSjQ5MbXa9ZOYqx5InCpzdrrWtHWsxrj777Zowa6NoElvqGUz65c+VnEnJAYoY7ok0
         TDtzeniwIIDGGp66/ZCXY+dnZt6efF7yDfr+tsOo6mHk2tDcA1mbCuslYCbXSXif2y7Z
         iOAerr2GxH4x4K0m9cZu4H4HT+ce83EjrUypa4WBjVDStSDrtB4172E0fzKrRKdmJ1Xh
         5ERii/mErTPzP1P11dhDbHD+uW1uJnMbu3TNuj7Ugx7KrllZETicAa+i1wMVLxKAhP/V
         Il6E7rYYkXe95Ouj3X7bCWjzn56p5jUQHbnCkycJHHFDLjL1xEI4MU/Rh1CkHcSJnrXu
         tdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3DZ+oX6KvCfED1/kBUM71B/YCmo6RLhrUP2ubiTmXII=;
        b=mVeK+Ea9oFGVX9hQEit+MnjRm/QrElUwaov5UzrwvRspfao1jprQWStodNLfoLETiQ
         aSVn3eUcW0OxviSqg1CILdVXQtJAoAusf8e+GOlSU36viCJ3uX85383K70Y+uE+8bYdF
         HthyuIUUZLJfMjOFVZwSpLw7RbvRDRqPz5a/ZiPxL8ve6ZQX6fWyoiBNMEZdk4FcLxRO
         Tl4+JSc89b8RmXM5IgdgaAvrhGW2JhN3JZBxF5OGPhIh93XtmIi9JRSVU32lQzvxoJHA
         HEXor9Jr2V7mykEuyQuHzoWuRcQw0LmP6/yIPx57pUmKq332jjxSdS/6c+t6pZHoYDLW
         8AfA==
X-Gm-Message-State: APzg51Bjkzhd1ghvFYVF1zV5OJLs7yOh2eBC+oEk0B5h4V6YhEP/sws2
        a/mRv3puUQ1rloyusJbeySw3sg==
X-Google-Smtp-Source: ANB0VdafD7edC/jrLEOJBPUrfA1r/7Iopumaj5ykWSYJnVwkpKCAttwMyZAOL7D6JTk+1fZcmR+Zcw==
X-Received: by 2002:a5d:404a:: with SMTP id w10-v6mr8591465wrp.147.1536921201064;
        Fri, 14 Sep 2018 03:33:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r6-v6sm6376790wrt.92.2018.09.14.03.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 03:33:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] net: neterion: s2io: Use linux/io-64-nonatomic-lo-hi.h
Date:   Fri, 14 Sep 2018 10:33:10 +0000
Message-Id: <1536921190-38619-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536921190-38619-1-git-send-email-clabbe@baylibre.com>
References: <1536921190-38619-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace the custom definition of writeq/read and use ones
defined in linux/io-64-nonatomic-lo-hi.h.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/neterion/s2io.c |  1 +
 drivers/net/ethernet/neterion/s2io.h | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index b8983e7..44acc63 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -75,6 +75,7 @@
 #include <linux/tcp.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <net/tcp.h>
diff --git a/drivers/net/ethernet/neterion/s2io.h b/drivers/net/ethernet/neterion/s2io.h
index 1a24a72..0a921f3 100644
--- a/drivers/net/ethernet/neterion/s2io.h
+++ b/drivers/net/ethernet/neterion/s2io.h
@@ -10,6 +10,7 @@
  * system is licensed under the GPL.
  * See the file COPYING in this distribution for more information.
  ************************************************************************/
+#include <linux/io-64-nonatomic-lo-hi.h>
 #ifndef _S2IO_H
 #define _S2IO_H
 
@@ -970,27 +971,6 @@ struct s2io_nic {
 #define RESET_ERROR 1
 #define CMD_ERROR   2
 
-/*  OS related system calls */
-#ifndef readq
-static inline u64 readq(void __iomem *addr)
-{
-	u64 ret = 0;
-	ret = readl(addr + 4);
-	ret <<= 32;
-	ret |= readl(addr);
-
-	return ret;
-}
-#endif
-
-#ifndef writeq
-static inline void writeq(u64 val, void __iomem *addr)
-{
-	writel((u32) (val), addr);
-	writel((u32) (val >> 32), (addr + 4));
-}
-#endif
-
 /*
  * Some registers have to be written in a particular order to
  * expect correct hardware operation. The macro SPECIAL_REG_WRITE
-- 
2.7.4

