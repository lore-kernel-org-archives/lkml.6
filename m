Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C35208DF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3hsvKmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C35208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGIDVw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:21:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35852 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeGIDVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:21:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so12590139pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phQAPKjHuXaJ49E6Z2SoJBvzQ21pOgO1IGo0W1Ifx3w=;
        b=T3hsvKmA5wT9bOLw8EqwK6etiLU05GuEo3vZ+YpAYSKfjW3csF+1Q7pdLYJ6/v4ED8
         l8RXa8EkfE9ekym5jHnM529DFGgmIEMxk+NDm+nwli0yrfKXZsK55gdGbig7U1pVB3bu
         MhtgToBx7tvnqDlbu7IYsjqm+HoU079p3BgdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phQAPKjHuXaJ49E6Z2SoJBvzQ21pOgO1IGo0W1Ifx3w=;
        b=D41Vsgo7/t3qh8sZweckgDdSGZeeaNXb/lWWgZZiJPVOAeSjL335vJixUuEBUabJtE
         kzif6q6/U3+Dmto1/NyT9gb6Rdc65S8Ax44oMU2SyFYJt2zqX7N0F8ISlBz0MxOW4DB7
         ZrFWh7jq11Os+fvTdnqMD4oS3v3jxCmamc9OmiT2cQJHqZltu3lPUCgw6UiLwVSKucv7
         3F19ZB6Jkjsl38DP68VWgUMSO6aWPVZbUIlibmByXmh1ZZ+TrM45L1tmAKtPeyOVAHXk
         A5KeSdJxNVQw0p25lfy7/Gh3pZLomVVa/YSP+Ujebo2+ob/lwVqYVlBpwx07cHcifo1I
         Zwug==
X-Gm-Message-State: APt69E04of/yOAANv1MBk2xZb8+8DmGZb1cRZwRoNtuVt+Fzuoj9frM6
        xruufTWFIEqPTXO+mw+Ujptrew==
X-Google-Smtp-Source: AAOMgpf4ySqkz8KT0cIQJhNg9F4IpGb8pAOtd9hZ1h6wWlZQqW+1W2EDPhCO2RvGZMCFqx0ww3plLQ==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr11351335pgg.357.1531106510392;
        Sun, 08 Jul 2018 20:21:50 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:21:49 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date:   Mon,  9 Jul 2018 11:19:55 +0800
Message-Id: <1531106398-14062-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Host Version 4 is enabled, SDMA System Address register is
re-defined as 32-bit Block Count, and SDMA uses ADMA System
Address register (05Fh-058h) instead.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7871ae2..f64e766 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -889,6 +889,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
+	u32 reg;
 	struct mmc_data *data = cmd->data;
 
 	host->data_timeout = 0;
@@ -1021,7 +1022,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
+	sdhci_writew(host, data->blocks, reg);
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 24fa58a..889e48b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
-- 
2.7.4

