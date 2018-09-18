Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDA221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="znjkq8uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDA221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeIRNEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:04:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45348 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeIRNEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:04:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so873201wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sKgGJauRyU8Im/O3ZfgwWmGgncQeTpVlTQQ6DAwFVNo=;
        b=znjkq8uFQG77DstG7hfrxyH0RcaGAXDm7Ep2XyAl59aJRuI0Ua1T77jeWo6TpqlEB9
         IsZrcs3P9mw4f0JOFQWh35tDK4hrqMi03T81i5xzltnlEHrORNxonwZ2f4yiK9K2MWeW
         axYmL6yXsKsUgzNXMIHUhzp1cf6h8bMF3sSF3oJB/BJKvHtCpUJ63Xwq2kZOL9YtaDQ1
         vxF1p82s1XuvGodumxh9eMgwHfTEJy7B7L3k55OGWduxNs95eSZ9CtMYP/+z7tWdMgrl
         cN/mDNYDyv3pD1NVgM79n7jbNfbvItU/AJfx3OajMVfQvQJXhlobIdLf5kvRK0an8sZH
         Jyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sKgGJauRyU8Im/O3ZfgwWmGgncQeTpVlTQQ6DAwFVNo=;
        b=IoOnI9l4hvGa9ScunA9wdVqRRS8RUzdbGh/jlb2JNsi5FLDKaa29B+hjz6S25FiLAs
         B5kzHF6BQY6jqi9g+sJE++5v+BlhJfqVokGhyeeSnncKAhGbheVtsL1DyH0EhG065Eb1
         rhPepWS4Qdp2pguK5Xk06Kf2+vj5PFsTQYusr4a15cUU6qh8EgS7ZOelB4JkQotxPfH6
         8RbSwZOJSXV7Ctu1LtKMyD1/e3PFXiD8b2+ZVHUZENFJSKiG9rToQCJwYTJScN7Uf6MV
         6PKKJDCJlIzQnxH1dn55BF32EHm7M3hSx1K7WvMDbWyUfIO/Hmyeet/lOqgXB3XIYm2s
         D5Zg==
X-Gm-Message-State: APzg51A+C1JcEFUPSB50ue7Jrt9sQWATt/1dkN7Lu1U5AXklInsOHUSe
        jl02Lu+GwTV12sf2WiwPVGTIfA==
X-Google-Smtp-Source: ANB0VdZl5UhBvW6polcK3U3XISx9Nh/On/D/FD2nINlbs2wyEO+ZgVpoSqrSRegJHfib5zmIT9txhw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr22514376wra.120.1537256009693;
        Tue, 18 Sep 2018 00:33:29 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm1138842wmf.35.2018.09.18.00.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 00:33:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 1/2] net: neterion: s2io: Use linux/io-64-nonatomic-lo-hi.h
Date:   Tue, 18 Sep 2018 07:33:13 +0000
Message-Id: <1537255994-39517-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537255994-39517-1-git-send-email-clabbe@baylibre.com>
References: <1537255994-39517-1-git-send-email-clabbe@baylibre.com>
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
index f980f10..6266032 100644
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

