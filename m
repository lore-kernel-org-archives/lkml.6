Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD13ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AE6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPtt6AzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AE6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbeIUQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32841 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbeIUQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so1103818wro.0;
        Fri, 21 Sep 2018 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbGBYnIeoST/0zQWTWLQzJlAfoD9M3FE2inu0eq3szg=;
        b=bPtt6AzThbkO/B3qvA/OaTVMF7mLY1P5wsGqKTMcYhLVMn3t+YfNfGPmTthvHZ+rbG
         RL8xkEUVVefHRvmhwY+nI860PJ5rwzk15Nd35f/jBUSF2ZlQVVLw1O8+r3iQZMKFM9Xs
         fHGSZicy71ynKWAip/xXAHYRYmqC04qa5zvmzIb6/RCWEFc08H90HxmUAG606kHzxm6N
         PITDwpKKDsHRrzSrr8Y8qElNNq5qYZwdLnyZyLTqmYvmma5acTzkTlt8TpV7ASrTz2+I
         UuJLrhlgWzyXQKs/BIowtkuS2J8X7B+SgCNSx4/fzPfnAfTSnJ7gDkpSXvTVAVJYaOO2
         jTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbGBYnIeoST/0zQWTWLQzJlAfoD9M3FE2inu0eq3szg=;
        b=JFJhjCq+mO4CO+KSI+w+R0GhNiMcbO83+dF9fT2tbxBmIe9Xrht2nv69WPD67ZBRdD
         le28075X43DzEyV+X8QdCkXVUVQ7KaR67G5XLn75tzalRryRLhoiZemVuVcaTZvT+bKm
         aiKmJSBzkx8cDjohWQLtiontYDLwA2KCmPwkMph0G65AlhN+WxMtr0Nypvh6jMggZChS
         t8OsMxBuUgFFtzE/LjpB0WTI0TNFO6OclKTcO8ujJ/uW+daMZsqe0lqTCjavN3Hsg4o5
         1vvw1TcUoCfzr4yIPPmSNsycpZY1m2IGRmDZAzfKWfldbN6dSidNRT7SKIfABAi32nVB
         3BIw==
X-Gm-Message-State: APzg51CqeT37J0FQ6D853PlH5ikpFEh+oxcmIE1nBce1TuM4dJI62HFJ
        duZHWwmxbMx0Vax1SCc0PJQ=
X-Google-Smtp-Source: ANB0VdZfczZEiR2Nj/SVzRziaE+HkkCPEq1I48vLdIM6Lw6ZQhuv4YRhg/qZxJnR6/wjxLXh3yjL2w==
X-Received: by 2002:a5d:610b:: with SMTP id v11-v6mr12643586wrt.265.1537525554820;
        Fri, 21 Sep 2018 03:25:54 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id h17-v6sm23242580wrq.73.2018.09.21.03.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] soc/tegra: pmc: Add initial Tegra186 wake events
Date:   Fri, 21 Sep 2018 12:25:41 +0200
Message-Id: <20180921102546.12745-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 support 96 wake events in total. Many of them are never used,
so only the most common ones (RTC alarm and power key) are currently
defined.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index eeef5a1f2837..42e7deb6de74 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -53,6 +53,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
+#include <dt-bindings/gpio/tegra186-gpio.h>
 
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
@@ -2351,6 +2352,11 @@ static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 	iounmap(wake);
 }
 
+static const struct tegra_wake_event tegra186_wake_events[] = {
+	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA_AON_GPIO(FF, 0)),
+	TEGRA_WAKE_IRQ("rtc", 73, 10),
+};
+
 static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_powergates = 0,
 	.powergates = NULL,
@@ -2366,6 +2372,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.num_wake_events = ARRAY_SIZE(tegra186_wake_events),
+	.wake_events = tegra186_wake_events,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
-- 
2.19.0

