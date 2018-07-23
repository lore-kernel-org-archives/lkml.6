Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC6EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683EC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzGfZSyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683EC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbeGWLJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:09:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44944 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbeGWLJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:09:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so24959pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7vCwreaGTb+OgwtgSaE5FF7B3FBPIGjJoxy7kBg1p8=;
        b=GzGfZSyDMO7pnTpQYplG/G3gF4dCd7uTJK/VLknFdGTrdXP+mJpzqfCpRHgonVzvQh
         lJTAxiO2nVHdbSB6RZZLwlbkINaaeP/FgS0xue+QX2mnBpQ2mEaGAh7b+LQ2GHy0JAuF
         DVRCCAohrNKYpT5+7fAi0GNaJGyne2QbJmul8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7vCwreaGTb+OgwtgSaE5FF7B3FBPIGjJoxy7kBg1p8=;
        b=qVDLwLJZnca/+mqUiaDBqb4/v47pXJ6Zn9SymPeV6ysjTuMedao0SVUlWcLxfo3Rst
         l7MX4FeczE7LJkrg5ZZ07zwX52Ex+I0mUk+yWMR6Ds9rLndupuarAZatpOylsAlEQNPt
         RgqgsNUGjolblouS3IlD823aIasIgIcftCRht6DDIRmuiLQAvTzJui3zxp9n48spktMk
         3xtCh9X2KckhgYwy+hRMIA9Va2xLUTBEyjZhrYfF6L+PYmYUy8DrXcOs2DUyTQegPVE9
         1q13OBKMIIU42VG3MyojAoLlDVHmTQcoT5+u+MZ4mioN1ippAJ8GQGNz7H1VwAYarLG0
         SmLg==
X-Gm-Message-State: AOUpUlF9E32jZUCRABd68fHW29FIFUByP3+2BcUMCYrrBTg0p9IJuqYF
        1bRsUnuwAelcj8qJ47Xiw0C3Xg==
X-Google-Smtp-Source: AAOMgpfrAfD7lZeTuKB78hCoxgMCgWirLXEC01kW8jmdGfBrEtzmZlkV8b+3SpSDbBuwtk+ojD/srw==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr12347410plp.143.1532340554034;
        Mon, 23 Jul 2018 03:09:14 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13470698pfk.87.2018.07.23.03.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 03:09:13 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 1/7] mmc: sdhci: add sd host v4 mode
Date:   Mon, 23 Jul 2018 18:08:22 +0800
Message-Id: <1532340508-8749-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduced an interface to enable
v4 mode.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..cab5350 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -123,6 +123,30 @@ EXPORT_SYMBOL_GPL(sdhci_dumpregs);
  *                                                                           *
 \*****************************************************************************/
 
+static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
+{
+	u16 ctrl2;
+
+	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
+	if (ctrl2 & SDHCI_CTRL_V4_MODE)
+		return;
+
+	ctrl2 |= SDHCI_CTRL_V4_MODE;
+	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
+}
+
+/*
+ * Vendor's Host Controller which supports v4 mode can call
+ * this function to enable v4 mode before calling
+ * __sdhci_add_host().
+ */
+void sdhci_enable_v4_mode(struct sdhci_host *host)
+{
+	host->v4_mode = true;
+	sdhci_do_enable_v4_mode(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
+
 static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
 {
 	return cmd->data || cmd->flags & MMC_RSP_BUSY;
@@ -224,6 +248,10 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 		/* Resetting the controller clears many */
 		host->preset_enabled = false;
+
+		if (host->v4_mode)
+			sdhci_do_enable_v4_mode(host);
+
 	}
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..519d939 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -565,6 +566,9 @@ struct sdhci_host {
 
 	u64			data_timeout;
 
+	/* Host Version 4 Enable */
+	bool			v4_mode;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
@@ -747,5 +751,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

