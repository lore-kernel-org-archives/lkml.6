Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tqBKCZs7GlsUKQAAmS7hNA
	; Fri, 08 Jun 2018 08:19:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01A36607DC; Fri,  8 Jun 2018 08:19:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpYah+g6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6FB12606FA;
	Fri,  8 Jun 2018 08:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FB12606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeFHITN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:19:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40511 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeFHITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so6259557pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HweywlkV3W7hX6j4jAziXnB8202QrrYYO0FfXOW5ydM=;
        b=jpYah+g6bV7iiyUJ0nYKHVkiO4s11rtRN+TAWmZTzk2YGsyugFV8fqtax2Fgkg6wsw
         kOKCCg4mKNdC0gmZeD+igEMjcmEKJqt2eKn9OCxysFMOl5zZxTVoGp4r03/q/uImtGRO
         2VxdFL2wnOwn66W3nOPx15Xb0q+GWFqXYg9X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HweywlkV3W7hX6j4jAziXnB8202QrrYYO0FfXOW5ydM=;
        b=h41OZY2fGnn0HKCRbaKB9gVAMR/sK10TOtpb64cJRbccwz04Uwnxtlspumfi5SN4ur
         2XGqWP5BtbwypITenTkhnJ8rGMyV/Zbgk2DVWlpk4dziV9uc9n15ylXLk6pqVSg5vaN4
         IV7+jmznowVIdem3KxR8k3Ib76sMi1b2Yhn+6EeLeh59125CeydQddZIrh2+XN5xilQW
         MEYmTQ6tZ3HmSCIFPUs5ZeS9HWM+u/z+iEl1ilWfesJZjeALa++8W5lHh9EQGJBy8uZx
         XuZx1RfUUDeUVLvBoBzez4VhLCv6mhpLZu0zGt54RImDmnRBswodUUY/xZV0BAd9zbx0
         xFqA==
X-Gm-Message-State: APt69E19OekY2XHCOQi3PiiZVBBfKWbo5miUYklYCzNOaDdZcrF6gKok
        jpzqWurTQO0pSY4BBFapiehTNw==
X-Google-Smtp-Source: ADUXVKIZ/l24gzIvah47m4Tcp3KS+Wrp9ImDSKC1yRNRWipnImeZEUMmlerZOkZS1pyO+n6AsmLkFA==
X-Received: by 2002:a63:6d0:: with SMTP id 199-v6mr4348329pgg.338.1528445947598;
        Fri, 08 Jun 2018 01:19:07 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:19:06 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 2/6] mmc: sdhci: made changes for System Address register of SDMA
Date: Fri,  8 Jun 2018 16:18:09 +0800
Message-Id: <1528445893-14530-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cf5695f..f57201f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
+	u32 reg;
 	struct mmc_data *data = cmd->data;
 
 	if (sdhci_data_line_cmd(cmd))
@@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
 			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+				     reg);
 		}
 	}
 
@@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
 			u32 dmastart, dmanow;
+			u32 reg;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->data->bytes_xfered = dmanow - dmastart;
 			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
 			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
+			sdhci_writel(host, dmanow, reg);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-- 
2.7.4
