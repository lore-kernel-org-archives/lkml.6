Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26806C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF542082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6ReI4x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF542082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeH3MXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36634 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeH3MXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so3567739pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ML8nLjCbNbISUG+Te8iXuKkkqfqMMtZy3g4F+HUTCY=;
        b=W6ReI4x1Bc/JmVCF489DBl573vArOUp3cJURvJx9EXcspdw1VS15ynJVuAHRR1exLj
         x1PjZQ87eAHftm6Wv/LTZk1KuUzvimrJ4PNbshzliEbuMSZg9ESuN57vAAc7G3iLJ4Jz
         CYvAr9lGj8h1xuaJO2bIJ1CHUu9Cr1+Jp9WkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ML8nLjCbNbISUG+Te8iXuKkkqfqMMtZy3g4F+HUTCY=;
        b=NKSCvXiHu6tHve35jkAKNz55zc+ICDMDqsSFpv+9rzY2NOa1LHdXEj+BYa9ZMi7D6q
         IJCEaBDKJVvIwPrg+ivpUj7gE02yP6bCpkN8i1bB3xN61QYsQP4acPm/+Joi3+24LhcW
         Fkr8Yizm0cIjjxzjOCm0AlbqlEUWqsO7dMO6bVYXxQ2eaZilPjWimsgq5oIi3ii2wdjV
         bqld1LyJkPahSwA5ZQiLj3au9vPlM+lIlvZyeWDEmB0TLPs2rWPhmsab9XKkismrGd62
         qXnhCuV+bWo4TcgNqhditCkK571xkybcTXVHsK6RDmRKZ3NW9vtUPbK6dOIb0DbrfFek
         TDuA==
X-Gm-Message-State: APzg51AxpZbJzN6Vg48kyet2STLITZC2pYobJsDTYDI7vuQNE2K7Qs04
        hDNdrpla4y1HWE/+sWRMK3s8ig==
X-Google-Smtp-Source: ANB0VdYBCoLBFd/djSUyL8vhmwff4LDw2imhqvGfKmtHUobEqkY19rpLtRbAkGba8SeBdt2LLoDJgA==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr9585423pfd.194.1535617340445;
        Thu, 30 Aug 2018 01:22:20 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:19 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V8 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
Date:   Thu, 30 Aug 2018 16:21:41 +0800
Message-Id: <1535617305-16952-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host Controller Version 4.10 re-defines SDMA System Address register
as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
Address register (05Fh-058h) instead if v4 mode is enabled. Also
when using 32-bit block count, 16-bit block count register need
to be set to zero.

Since using 32-bit Block Count would cause problems for auto-cmd23,
it can be chosen via host->quirk2.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 14 +++++++++++++-
 drivers/mmc/host/sdhci.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 17345b6..604bf4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,7 +1073,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
+	 * can be supported, in that case 16-bit block count register must be 0.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c5cc513..f7a1079 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
@@ -462,6 +463,13 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/*
+ * 32-bit block count may not support eMMC where upper bits of CMD23 are used
+ * for other purposes.  Consequently we support 16-bit block count by default.
+ * Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
+ * block count.
+ */
+#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

