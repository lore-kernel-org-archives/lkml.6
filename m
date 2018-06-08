Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WsQaJYU9GlscdgAAmS7hNA
	; Fri, 08 Jun 2018 08:25:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0ADE96089E; Fri,  8 Jun 2018 08:25:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKieoiP+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E430606FA;
	Fri,  8 Jun 2018 08:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E430606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeFHIZn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:25:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46057 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeFHITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:18 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so6030970pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2y/xY2dusr5GMTlLcs29f19Nju3/wuuxjplM+exAbo=;
        b=FKieoiP+oTs39Jw8HxQ3lxOLeBs5f6t7CE83ff/85RIfHalbD8s+wfshp/M8iV4tbI
         I1r33vk+lPq7y6XD3ZVaO8Fh6nIg6wFXcDFUNOrKdsTKnDpXZsMJyl9eo8ZphQ+Z5LFb
         J6x6a2dFhQjM7Y1pZdermG1QvPPODua+nlxqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y2y/xY2dusr5GMTlLcs29f19Nju3/wuuxjplM+exAbo=;
        b=nECMdiFDmNyI1wCI+iPx0WbTZ8QsW2Hp2DMZ7GXQRJMaLiHbzFyBdm/DVfYY642C98
         vdZJ88kdmtCW0Cyyfr0X9YCBJRPmutuDl+6H9UstiJjR6EZDixHAxIE8F964+FH5YFFa
         OnUuZqIOrzX324BT0Etzk+4Fm+YnvrNzdA1NI3x24FrkQP28RrOcfBYZ9u/+3hRZbyrr
         FHQoCXPLHVLKX4TEwMdX03z9SUxQABJE4qh8/uKyBi18nd/5EtxJ+0cBk3KQxHjyZPkE
         +ZWhkuQyoAmCruQDHoGv2f8dmEXKJkkTOFZc7vEHXLpBOUkeZVP+3ZrRLICzCkdO90TQ
         jYow==
X-Gm-Message-State: APt69E2c3QVJTPY/SastqmAYkIRwKuJvt1iEkT34lCQYzmXuigyD6tg6
        wzjwttawQ2bSPCzmAbvk5oImTA==
X-Google-Smtp-Source: ADUXVKLtVQTj9L/QmmEDUBBLNhSQFL/lAJhAPS+hMHV1N7gVjxJJHH0CCLtSt4hlw6Y0tiqRSTQsGQ==
X-Received: by 2002:a62:e816:: with SMTP id c22-v6mr5006819pfi.124.1528445958137;
        Fri, 08 Jun 2018 01:19:18 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:19:17 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 5/6] mmc: sdhci: add CMD23 support for v4 mode
Date: Fri,  8 Jun 2018 16:18:12 +0800
Message-Id: <1528445893-14530-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
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
