Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B2ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B997920867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ina5VuRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B997920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeIRNEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:04:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45348 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbeIRNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:04:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so873245wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7HMFROr3A0ntDJOkROIsUs2dkKSokmnYBihQmG4E4c=;
        b=ina5VuRBZQ1V4Fep20cZEkJk0b5Awrxp/D8hjppfEyWc/0CH/bx5011gU4gou+hVxK
         nfOYxhl01dQdiCSNyjSm77No8h10pYyt4jT2V/k0nPOMZ9WnQ15jZfMsNusuVsTDFSJo
         r+bSImJkBWB5iZfoM8nDUA9izLuo1cqPDmL0YB3KvGVuq3CC9IcZc/7iBkp6/edLTwdw
         zGCxdRLDXpnZHYFDm8gX2CNW7ZYGxnlhyYh8SFTiMZXHQAJwsbPzUpwNostyGkIQ32mb
         rOcyx4AhExC2Ovt0uRUp79MSNzgfSll/aMmozDb6Ubvy0VZoLUH5IXZ+UVIsTi1Cs6BA
         B6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7HMFROr3A0ntDJOkROIsUs2dkKSokmnYBihQmG4E4c=;
        b=SXf0BjUqev6AlL76I603+DQbkf1PkXXKwxpVe2a3OBZMab2Q73p0ehKYy8dSCaW3zU
         AcLtF2517MOeOoS+Wou5g6Zq4WWgCRU/U3IlJBhXPbnTFUwbXK6UnMXu24Pdxq25auux
         Owvn28t+3wCvgmSO9He3XoLaRqYH2LMfCAHxX42X0s8iDjSs+RiqsCWQE6e9++/yTza4
         RObJsdd1EVWLJAaNJAofripx5HOXE2fV4Jz63XFNsdcWq7O6JCYZLHR4A6FvbnOS5OLS
         Ie8Oo1GtawlIo47ChXj01jGoKO0+xce5H3KT+MdCsScvE+t9UPlehWDcw7C5clrQ9Q4j
         wC5Q==
X-Gm-Message-State: APzg51AmQSvG0l7T8fyI3mM0w/0pxhIxZoHdlIXH0l6c0W56FfCCMQpN
        3Akzi4sf6jB69yac7zX9ZbUXpw==
X-Google-Smtp-Source: ANB0VdaLDMr2M9VWhKPKVRudk0pfxB5iyziJtvSHiAa13BilQxvoE1EYEfmP1TIc34jDKG8uLVyR9Q==
X-Received: by 2002:adf:ad47:: with SMTP id p65-v6mr22152772wrc.222.1537256010578;
        Tue, 18 Sep 2018 00:33:30 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r13-v6sm1138842wmf.35.2018.09.18.00.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 00:33:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/2] net: neterion: vxge: Use linux/io-64-nonatomic-lo-hi.h
Date:   Tue, 18 Sep 2018 07:33:14 +0000
Message-Id: <1537255994-39517-3-git-send-email-clabbe@baylibre.com>
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
 drivers/net/ethernet/neterion/vxge/vxge-config.c  |  1 +
 drivers/net/ethernet/neterion/vxge/vxge-config.h  | 20 --------------------
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c |  1 +
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 398011c..4c1fb7e 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -13,6 +13,7 @@
  ******************************************************************************/
 #include <linux/vmalloc.h>
 #include <linux/etherdevice.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/pci.h>
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

