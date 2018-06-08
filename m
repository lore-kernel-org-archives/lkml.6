Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OWMxLPI7GluNKwAAmS7hNA
	; Fri, 08 Jun 2018 08:19:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49B17608BA; Fri,  8 Jun 2018 08:19:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMu3uV+F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B581760590;
	Fri,  8 Jun 2018 08:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B581760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeFHITV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:19:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44239 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbeFHITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so7854833plk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2kKdK2qZqm7YxqxQreraVLLw0s8TN4UgsB3k/YpdPQI=;
        b=eMu3uV+FIFUH5dBfHJQiTcF0H8MCPRxIB+C1Z8BezzykBY/c9VijVF7D+18wXIupGp
         9aY28w3zMYMd9f4wZZWE//C9ccivy+hltm8SjDk5jBnJGI5a+lUBK1LuAlkY6UTSbi+2
         lt+JsJqsQ9mWalp1GrUydWKAmewnFKaXj9XeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2kKdK2qZqm7YxqxQreraVLLw0s8TN4UgsB3k/YpdPQI=;
        b=c4zpc+GFUNIe6tBlQNg/q0Qku/FJe2oS73AVap+aWE53uKPq9Ug5Y51oUOsHh6SgAr
         9bZLZOtkNKyCj4++w/VrURnXKb0oUz7U7jeRFFsDVVMATSMKTmNxWiSmEWzdVXp9ee5B
         26tQdfQ7/thZ/9PbAKDvNPl/NlD4ZwTgWMMxO95zB3C/PPbn3DgYFictaxnNsN50Wt9i
         9DTRQfiDrbn2TvQwb/rGni2vxG2wc1kzCmI+QDFTZwWlZnTabeU1tu2TivS3baENv7MN
         MAG8Qmk8f497A3wxuChK50Ebbz0Op9ba8GmtYUVP9mX7m+7ga72U+dBpMeRqVk6KvJ1z
         Lcrw==
X-Gm-Message-State: APt69E3CBhpRDd2xaI7uV0Uwff7MP9Mqp12HhGgjBJLJuU5E/Yw7Ym9E
        RK2BjpAsqAxNIVeyQZn6W/JDwQ==
X-Google-Smtp-Source: ADUXVKIUuLi1glU/e8hqbQE0DObSJSYswciFEi/IT+z1kGiHRXqdrtgswWoPT4Q7+dU+qS46Y13jBA==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11-v6mr5516405plo.203.1528445954765;
        Fri, 08 Jun 2018 01:19:14 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:19:13 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 4/6] mmc: sdhci: add 32-bit block count support for v4 mode
Date: Fri,  8 Jun 2018 16:18:11 +0800
Message-Id: <1528445893-14530-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Host Version 4 is enabled, SDMA System Address register is
re-defined as 32-bit Block Count, and SDMA uses ADMA System
Address register (05Fh-058h) instead.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5d3b0d8..b8ee124 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -943,7 +943,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
+	sdhci_writew(host, data->blocks, reg);
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 820a863..1e84539 100644
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
