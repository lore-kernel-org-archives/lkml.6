Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36454ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12F020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFJDOtVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12F020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeGWLJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:09:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45184 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbeGWLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:09:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so37839pgq.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6U0oFcYatVgQm3/eP8KlsQEUgCN13nFxxwM/5+0rxN4=;
        b=DFJDOtVXyhlEZdjc+WhJtSMgDZYQ+etpTgSIkgvz7Iy9gCFUxFT8ZKbLv6yWnnVG7g
         OwO7zp+PVVwv6iiP/m+2f7U3U4b2tYQEEp2VsYDueahuhtBjiSwjXCOy21Sp3ONGtc4X
         Dgd/8sOiW4a3S+9338g3StHq1WZ87dvBhzrJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6U0oFcYatVgQm3/eP8KlsQEUgCN13nFxxwM/5+0rxN4=;
        b=H3t/EduVE4mqBYN49WZzjvku+Om497TnIDYmzdS3IBj2fdPklYOsZS1Wi2neiBUn6g
         iFXqRus0fVH5pWEB7QcD8pHdCIyVimo7Igcfga3usuG47wZy3gRg7bct5q29WsYvOjs2
         vwRXpV8qGtNxw1/lAkl2UWsqX4F8kZrsnNJYcgEoHXbty9nE08lj/Vc0GYZwJ1ph5uji
         8D8j6MEV+plAPAeJVvfC9VmpBKtXsM84VxpMCeDzh8YTVP9tRS4CwfbBnMuXh5pm02ub
         CO4ZB2xZ8kVtri11sB57n6btoqQ5Ctjv0XcSPLpPcFokod8/gpQmkmlCrd3b8PSQHdpM
         w37g==
X-Gm-Message-State: AOUpUlHlqQ27VXahx8uO2UfaWjk6ELFHalYHkR0bHGsklsSIT5Hd8i2Q
        DiUM+rx/fp90xYhVbn0twdRviA==
X-Google-Smtp-Source: AAOMgpclEpfd9s9y07bjDPDl40N/DoFGBoJBQV6CeXkfdpyonE9dCKoYG741pBEEmclpf1jgIHpoaw==
X-Received: by 2002:a63:5350:: with SMTP id t16-v6mr11450113pgl.196.1532340558854;
        Mon, 23 Jul 2018 03:09:18 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13470698pfk.87.2018.07.23.03.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 03:09:18 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 2/7] mmc: sdhci: Change SDMA address register for v4 mode
Date:   Mon, 23 Jul 2018 18:08:23 +0800
Message-Id: <1532340508-8749-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cab5350..9cb17c0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -729,7 +729,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
-static u32 sdhci_sdma_address(struct sdhci_host *host)
+static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
 	if (host->bounce_buffer)
 		return host->bounce_addr;
@@ -737,6 +737,18 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
+{
+	if (host->v4_mode) {
+		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
+	} else {
+		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
+	}
+
+}
+
 static unsigned int sdhci_target_timeout(struct sdhci_host *host,
 					 struct mmc_command *cmd,
 					 struct mmc_data *data)
@@ -996,8 +1008,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
 		}
 	}
 
@@ -2824,7 +2835,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * some controllers are faulty, don't trust them.
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
-			u32 dmastart, dmanow;
+			dma_addr_t dmastart, dmanow;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2832,12 +2843,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			 * Force update to the next DMA block boundary.
 			 */
 			dmanow = (dmanow &
-				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+				~((dma_addr_t)SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 				SDHCI_DEFAULT_BOUNDARY_SIZE;
 			host->data->bytes_xfered = dmanow - dmastart;
-			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
+			DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
 			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			sdhci_set_sdma_addr(host, dmanow);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
@@ -3581,8 +3592,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
-	/* SDMA does not support 64-bit DMA */
-	if (host->flags & SDHCI_USE_64_BIT_DMA)
+	/* SDMA does not support 64-bit DMA if v4 mode not set */
+	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode)
 		host->flags &= ~SDHCI_USE_SDMA;
 
 	if (host->flags & SDHCI_USE_ADMA) {
-- 
2.7.4

