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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29800ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D069D21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1H8vUWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D069D21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbeIUQOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390422AbeIUQOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so2507787wme.3;
        Fri, 21 Sep 2018 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSs5Q2DC8kHvOkkfmRY6o4j+dxlAtNorZ2w89xOGL0M=;
        b=u1H8vUWBiS9RHPvzqSvc0FOwMIw28n1qg6CW68hmltnFhuRhHRDolMaGRll/7WagOO
         pc/E68TbTyxhQQ00si0nsbxh6YRp8DCh6EGAV+s3dFc/bB1OTXpDeGJljJrRMWayMXEX
         G59eMpuJiv2fKOMqnD4abblkANwfcJcUhLwWnLP8tbJa5IPPs4coIO55Q0gi14+42T+i
         OGGM5dVLdLIaiAOM21viM71n72lsIOXXQHyeZNZuLrRoP5WheTR40Swbx2JRP7rN1W98
         DRRzxhSNaoAJlxwXb+vMUcAk+Yw4OOB/z56aPb46+wXiYmyCmHMktIf4h4Dex0xbcgBh
         DBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSs5Q2DC8kHvOkkfmRY6o4j+dxlAtNorZ2w89xOGL0M=;
        b=WCPilplo1v1B3IxpP3x8M6yWzeTo0cXOON7nxk0L53yc5hG+wjPU2wTRio4TJ6Bhkh
         2eBm/BCBqERMU9QuEwQEWIstCbb2uJAdQJqjgkbSY4YHN6S3pEuVqoWpPQEJwnkcjNUs
         S6sYiqCv67Y2WCR0IA+alZBaEzefG2jJKbwFJec4OaavAtkURg4xCcQK+L3eNuzmNysU
         +s7i3d5ORFNzMvfuXOfQwc/M7/VUTWK7XdtQ+OvdXc3sDA28Lzp51cQdXzioTq4n21G8
         PO+jSk+H/GwqfcABvOH+OV5iu8dYMohgDA5kToQI8/I4aQ2ngWy7Se6ZYYGM0ZSWJdIR
         9rcg==
X-Gm-Message-State: APzg51CzsEOzGGkRaIzBMud2OOxxO9v41quLYJc8ZA7gyBc4QfegFMbV
        FYgm1FhbG3XnmqMtCzSRs0s=
X-Google-Smtp-Source: ACcGV60+2GAsREjlGlnO1ySlsS+k0ZrsNFzafwCD2eNH7yM2qLm+ZEuQnn+kC20/nM70u688mVkSyw==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr6717345wmt.94.1537525560296;
        Fri, 21 Sep 2018 03:26:00 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id u127-v6sm3432035wmf.48.2018.09.21.03.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:59 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] gpio: tegra186: Rename flow variable to type
Date:   Fri, 21 Sep 2018 12:25:45 +0200
Message-Id: <20180921102546.12745-9-thierry.reding@gmail.com>
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

The IRQ core code refers to the interrupt type by that name, whereas the
term flow is almost never used. Some GPIO controllers use the term
flow_type, but it is most consistent to just go with the IRQ core
terminology.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 9d0292c8a199..66ec38bb7954 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -279,7 +279,7 @@ static void tegra186_irq_unmask(struct irq_data *data)
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
 }
 
-static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
+static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
 	void __iomem *base;
@@ -293,7 +293,7 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
 	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_MASK;
 	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL;
 
-	switch (flow & IRQ_TYPE_SENSE_MASK) {
+	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_NONE:
 		break;
 
@@ -325,7 +325,7 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
 
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
 
-	if ((flow & IRQ_TYPE_EDGE_BOTH) == 0)
+	if ((type & IRQ_TYPE_EDGE_BOTH) == 0)
 		irq_set_handler_locked(data, handle_level_irq);
 	else
 		irq_set_handler_locked(data, handle_edge_irq);
-- 
2.19.0

