Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1D320700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c+bM7IaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1D320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLFPSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:18:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40950 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLFPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:18:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so1412690wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7CGHPuU0cKd8uxanXCkssfy7HoOVVH2fzqpoBO3MJk=;
        b=c+bM7IaWZi1H/3FYMQILbAyq3SkhW7Uih01O/P0gAfzhOuiZ5bnjA7L7I8NlwiHI/h
         H3OzC5LtUaJ3Tt+AqTqgP6zvsv3H3STi6sCHOoc3iiUkw9VJrjD4nw/ljk7rlFdYfZPZ
         n9lPPlK5rN0Rt2KtNVt7DMayET1i97tQKB+A5OnowPY5mN2MIKF5C1RarI4cDEb+fwkb
         IkTZ+bGtP7E5G0DsA5fVu/lPbzIQ+6aL4I1rL7Nn9MWo8aAK30cScv/o+rlOFACB4wVa
         8Gbqh2mm58L1zsQhs1IgVCxGbY17DH2CUdB7UUG5H4rwVYbzRKmnjuPV8alx7YokJN9m
         wi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7CGHPuU0cKd8uxanXCkssfy7HoOVVH2fzqpoBO3MJk=;
        b=Wc2eG/vTsMT/ye1QIwZm1T2uFH90OGRsF8GxSMSlVHSAWw8reS7DWhDIYx0aggCWdK
         iEoxlFkgyhpGnGB6d2EGFoiiQj5jpqBfjy6j2mYSh5sy/prn1l1mmyteEwJ7AhGZYccJ
         c4DjzBYltf5KLbvEK1XaNXLt3D2SEq3Zrr/U7/do29XdQIgIbIXQQU96fIl40bGTS+1R
         TcmmElM5Z9iWeMYuoEEXqvVi3fSB5m5cYuRWRBWR5KQirAdS5xnhCdGfELRKiPv9bXg5
         pmDSRIwLwriwf4wZf0mobbOifhe5zSgPCrdU5qB84zWgmnCzkOAqaysmMMRm14EvauMD
         SOFQ==
X-Gm-Message-State: AA+aEWb6+Iasws1ThTakpU1NkR83zZNGyJKdITxWIARTFdwuEO6ytLgI
        Hx2HGBTIsuEwL056KfAF1/p4uw==
X-Google-Smtp-Source: AFSGD/Xv9y5Gp69PrLbFCQosYzPu0t940Sru5qC/QjA70Z1iyheNfOgkmA5JlbjaAS+UP/JrjTlFjw==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr19076799wmj.48.1544109519103;
        Thu, 06 Dec 2018 07:18:39 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j33sm939652wre.91.2018.12.06.07.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:18:38 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mmc: meson-gx: remove useless lock
Date:   Thu,  6 Dec 2018 16:18:26 +0100
Message-Id: <20181206151828.24417-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock is only used within the irq handler so it does not
seem very useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index fcb5d693c897..5cc31e434ca1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
-#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -159,7 +158,6 @@ struct meson_host {
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
-	spinlock_t lock;
 	void __iomem *regs;
 	struct clk *core_clk;
 	struct clk *mmc_clk;
@@ -1040,8 +1038,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
-	spin_lock(&host->lock);
-
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -1091,7 +1087,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	spin_unlock(&host->lock);
 	return ret;
 }
 
@@ -1244,8 +1239,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
-	spin_lock_init(&host->lock);
-
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
-- 
2.19.2

