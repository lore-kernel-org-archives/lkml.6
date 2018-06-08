Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JPyaDaw9GlsIQwAAmS7hNA
	; Fri, 08 Jun 2018 08:26:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 329F0607E4; Fri,  8 Jun 2018 08:26:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7A11XC9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C07B4601C3;
	Fri,  8 Jun 2018 08:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C07B4601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeFHI0n (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:26:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39593 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeFHITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so7865979plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FkQjw0tnznQzkqhNl9915wjCXW19DdBddES+/u0pdI=;
        b=D7A11XC9NRb0A18pNGJQ+MUULMWZ24DD87PMtK1ouKTtEaJlz5CzywJQni4Xxm2vIS
         uwCkhELfoXJm29QE7Z3ZpglaARof5Vj4hGciCM/MY1teWI+as2nPpms2bkyrOc2hAT1y
         njLfAxMsQ90LE+oE64Gghv8Nf1B47XSxJn7AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FkQjw0tnznQzkqhNl9915wjCXW19DdBddES+/u0pdI=;
        b=NRbhH2zZ1KPCmzjusietB8Css/um8CRrxi3hYCkPI4/CcZnNuCprrIlJRTOokN+mIk
         ubKdkbjQPrs0c4Jo/ePxJHj/CdgRoTrLa1+4Ttre4Qj7KiyaF8qr4plbCbF6/BeD8Mk+
         bnH7UW7nOZNOX4Wy0/4ZY4GzRs7QFQJJCc31osOpXBVzjIcZv7MsVOW0r8jMlaTpXGw0
         hXp8Trqx1CPF0Wf54Y4U+Q+Jf8gA/y+itaqD8traywHVi4R01dObt4fQP5TnyqIkHOew
         kcimQdK9bsyN/KqSdmzFCfUJm4Th75XthN5uJC1MnlzDYUX7G3sITFMWytA0UGpjcrsQ
         euLg==
X-Gm-Message-State: APt69E3WpnZXKbiy9KdSyQzrSOpuZuLmb+tq5sTCU5uqggE25lBEWls2
        dnqjqQ+D53dyeV7ELj34D9wBvg==
X-Google-Smtp-Source: ADUXVKI99syxtAJwXcZFCSY3fTAlvL/yV4bhYCf+Q/uvMwvLmApHsCbWxIQZDMQaIOR1npSEk0h0LQ==
X-Received: by 2002:a17:902:6e4:: with SMTP id 91-v6mr5528041plh.63.1528445944162;
        Fri, 08 Jun 2018 01:19:04 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:19:03 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 1/6] mmc: sdhci: add sd host v4 mode
Date: Fri,  8 Jun 2018 16:18:08 +0800
Message-Id: <1528445893-14530-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduces a flag to record this.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 drivers/mmc/host/sdhci.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7f..cf5695f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
+	if (host->version >= SDHCI_SPEC_400) {
+		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+			SDHCI_CTRL_V4_MODE)
+			host->v4_mode = true;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c95b0a4..128b0ba 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -270,6 +271,8 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
 
 /*
  * End of controller registers.
@@ -551,6 +554,9 @@ struct sdhci_host {
 	u32			sdma_boundary;
 
 	unsigned long private[0] ____cacheline_aligned;
+
+	/* Host Version 4 Enable */
+	bool			v4_mode;
 };
 
 struct sdhci_ops {
-- 
2.7.4
