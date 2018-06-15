Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B06A9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680F520891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L48YsjaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680F520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965507AbeFOCFS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:05:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44886 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965475AbeFOCFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:05:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so4118805pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2y/xY2dusr5GMTlLcs29f19Nju3/wuuxjplM+exAbo=;
        b=L48YsjaHSCvYqD74kW04H+9/aYUtXBSXZLec/VHg9XfYHeAjirdoDVUlw3e/3FHRNM
         cO8yeY1/D1nhjSeYtJ/DBC1EEmqb45dbTuGXsY8WzdqRuQ0Gwu99jhOAAXSMcW3sQnuC
         WJclfoErmkMO6rPwelFZDEW8ykNJoLvuIIMo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y2y/xY2dusr5GMTlLcs29f19Nju3/wuuxjplM+exAbo=;
        b=t8jxxFOXZ/IL6Qukwcfc5L2e1crCBQ2BWJ9Tjl7j6R1w9uBP9wy3XPZrYlknybO2aM
         6DdprWcwjq7v+XHGezUL3KFa5waOzl7UjifZH8g9MIqcSxOCyFaDDgYXW0fUqZ+X86pg
         5qMRUFcJ2eeXkL9ickn5Aecbeb898Au+1NzG7rFDlcY+zjxO6RsypyPCnpqk6benjd4V
         EwD1xeKhN9JdJpN5Z7l15EyJkeR//3MTmOuAZhi/+116MAtxTbC6rvRJcA9VL5l7H6Uq
         NHkfsuhesosdKcXapXDKivkQVVZsZPE64rG7oTsPP57aSgfnZ+QHBPzHjH+8XrDjbgjp
         3N8w==
X-Gm-Message-State: APt69E0xPtv94tH5dcR9i/OYMaFz7RweQZX68umpJAlycmjJCauYF9fH
        U/WLvOQaCcN3+ca4uSY0fiVeKw==
X-Google-Smtp-Source: ADUXVKJlgz/IFYDx4RfxjdumBHLYS10xb2vsTHvoDz7IY93cgf46UPvR8ajPYwKYkJUcJNvMjFPCnQ==
X-Received: by 2002:a63:b34e:: with SMTP id x14-v6mr4395991pgt.243.1529028314036;
        Thu, 14 Jun 2018 19:05:14 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:05:13 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 5/7] mmc: sdhci: add CMD23 support for v4 mode
Date:   Fri, 15 Jun 2018 10:04:13 +0800
Message-Id: <1529028255-6022-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host Driver Version 4.10 adds a new bit in Host Control 2 Register
for selecting Auto CMD23 or Auto CMD12 for ADMA3 data transfer.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b8ee124..3b2af7e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -954,6 +954,20 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_set_auto_cmd23(struct sdhci_host *host,
+					struct mmc_command *cmd)
+{
+	u16 ctrl2;
+
+	if (host->v4_mode) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl2 |= SDHCI_CMD23_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	} else {
+		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+	}
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -989,7 +1003,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 			mode |= SDHCI_TRNS_AUTO_CMD12;
 		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+			sdhci_set_auto_cmd23(host, cmd);
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1e84539..d5e1c10 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -185,6 +185,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
-- 
2.7.4

