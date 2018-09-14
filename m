Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59720ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1639020881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MuDqghx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1639020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeINPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:47:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeINPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:47:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so1424526wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQFRBcVxGnjSdeu6N94/HshPWKAGC1ok14ILiV35zX0=;
        b=MuDqghx0afcYIZZssfvk45iFUCYB/BDdjBZCYlnXjuRUFjJruYasCKbNMqOvvvacY/
         913DYZtZ7fvuXXTo3L46pyGZV+hfHfUn0/luVHAZJroixDRSbziV8tpUHQE1qAFezZLu
         T2mwh24C5kqLI4pf8A06uTtFuN//PO+5+tBKgEId3o5vkXyFGdzIiAV0AF8JYvNYJqkl
         dJDvq/TUp5d94kdpAUWEH9Lcm1Kt3SSOnmyqFsXzwbbwch5nSrD15PeEQa5Lfmmq8VFL
         diWcYZ4yepT8Q8F1Vyj6uFGe+iGp+/UmMfbGouL+mcaLl2ICFXKZ0y4XJEz71f3kKaly
         niVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQFRBcVxGnjSdeu6N94/HshPWKAGC1ok14ILiV35zX0=;
        b=k6mOhNVECPHeTQHmSpmXAVhuxuMYcLjTgOWEFN0H9nTjmr7MVp3yPmPc3rlTTRyH/i
         hyZPa3iglDjQHk+19uPfHxbk4K44qT9zlPgZMmSogSBlUQNGsS+7y0eSho+1A03SZblT
         t7NsDu7L4ku8D+uSsTBrVE+ndBwa9Fg8kguX+Z8PnsfbDShx4KEtllVAuiaeqs3L6/wc
         Y/i337XVOq6qQ4ymorbvMdVR/jBqkRlIY7bvuspr6eQp2aPlzft/vH0/AsWoprXoQtV2
         +btkiF5wkNavF8uTZ6Gltw9PE6hCwwjUBaekB8NUKbKsXvQuGxY+Y/02WKwVC4Pc5MMP
         7UPA==
X-Gm-Message-State: APzg51DWs2oFq+ZhxZnElCOhu2wmDZ5TTsMYBj9pfXGgs3HaGbQUcD9f
        sHr8HNzZgz43sJVNPn329e/IyQ==
X-Google-Smtp-Source: ANB0VdZbzK2lXVcAakPs/Rh8sNDvOsBV8cGti4MvKpqbMuoL2tCce7yB9AbI222PfeGjXYQJ9xCwaA==
X-Received: by 2002:a1c:1eca:: with SMTP id e193-v6mr1591536wme.99.1536921200071;
        Fri, 14 Sep 2018 03:33:20 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r6-v6sm6376790wrt.92.2018.09.14.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 03:33:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] net: neterion: vxge: use linux/io-64-nonatomic-lo-hi.h
Date:   Fri, 14 Sep 2018 10:33:09 +0000
Message-Id: <1536921190-38619-2-git-send-email-clabbe@baylibre.com>
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
 drivers/net/ethernet/neterion/vxge/vxge-config.c  |  1 +
 drivers/net/ethernet/neterion/vxge/vxge-config.h  | 20 --------------------
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c |  1 +
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 358ed61..2b422c5 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -13,6 +13,7 @@
  ******************************************************************************/
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.h b/drivers/net/ethernet/neterion/vxge/vxge-config.h
index d743a37..e678ba3 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.h
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.h
@@ -2011,26 +2011,6 @@ enum vxge_hw_status vxge_hw_vpath_mtu_set(
 void
 vxge_hw_vpath_rx_doorbell_init(struct __vxge_hw_vpath_handle *vp);
 
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
 static inline void __vxge_hw_pio_mem_write32_upper(u32 val, void __iomem *addr)
 {
 	writel(val, addr + 4);
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
index 0c3b5de..30e5cdc 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-traffic.c
@@ -12,6 +12,7 @@
  * Copyright(c) 2002-2010 Exar Corp.
  ******************************************************************************/
 #include <linux/etherdevice.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/prefetch.h>
 
 #include "vxge-traffic.h"
-- 
2.7.4

