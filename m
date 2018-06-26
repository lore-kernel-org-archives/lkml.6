Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA5C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814D02679D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QpU2yQAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814D02679D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934465AbeFZJ0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:26:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38452 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934393AbeFZJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so16475713wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u4tKrqOBdXJ23Vx4TJ9XThLndhjqxmxnoJ7uc13SY2M=;
        b=QpU2yQAt6d0UI8gVxjxOYHIpjkl2tLzcKAzrQjKptL+CP2DXAQcoooojW8lK0jRa5y
         jo5sEM+v5dF4l93MP/rF41/B9jGTPGclvAEf1vpuzXeJakgGcAmXci8kChQq78Ohncc0
         jrCKAab8Ow+z5vB3iPOYaydYUS4qwXk9lNkAV0qlOg4YVX5yQXsWfO530Fe+NcbGnPk3
         SlL89LYUCyHRpvlflhZALeDr9RRocRf3/9Mr4+kwc3Ttk5b/7/tf+NDtXCBHld4Slr+3
         MbGyw4CEIJtg2xWYvn/KBBfcOjotHQXmKmAcgLIdJgL4WYEhExBYsEpL/Gnlct0RYKKZ
         +lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u4tKrqOBdXJ23Vx4TJ9XThLndhjqxmxnoJ7uc13SY2M=;
        b=CQKvuiLwumCN0Ow565gyR8SjjdcP6yEgR41alRpZQx9IZ8f0BkkVcJC+2wSqjNcIhW
         Sbwn2MGOXN29CFgYdaqlbcnVdC+aRM6noQCjzKwCaZX9fVHXpmD53NV6rj8pJgKll5Uz
         kiBD4v8esRry4Xb/VoD4JsYPVM70dmWwA8V+Ee4V5HhASaGh/9KKYyQ6BMW0bGI9OjtE
         9/RNDLoSr5r91B9xvSLNjihtX9P6SrCGj3V5I8vdzPrNOTJQoyWZAurqyiiEi4YVHC6Y
         BEu76jiorbEXulWntkUWCVsREvYFGxXUhIJ/RaGpwAdAe5zV9LWYLzGp7TA8J6IJ8hMq
         Q3eQ==
X-Gm-Message-State: APt69E0wAB+xZBSXOj1+3JlIsgs9VBntb1QBZvxSoZPayaPieO74CASi
        qc+PCawuPUJje3C8aufYP3PuXA==
X-Google-Smtp-Source: AAOMgpea1xgnclCenPhi/nnYCxJc2//722BqfLRJykUoXNMZCiu2bx6cuiPCluqz1Zxx0N9FupcvbQ==
X-Received: by 2002:adf:9345:: with SMTP id 63-v6mr791939wro.60.1530005156174;
        Tue, 26 Jun 2018 02:25:56 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/13] ARM: davinci: unduplicate aemif support
Date:   Tue, 26 Jun 2018 11:25:37 +0200
Message-Id: <20180626092537.6737-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users now register platform devices using the ti-aemif driver.
Remove the handcrafted aemif API.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/aemif.c                 | 218 ------------------
 .../linux/platform_data/mtd-davinci-aemif.h   |   1 -
 3 files changed, 1 insertion(+), 220 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 8725d8bea567..93d271b4d84b 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -6,7 +6,7 @@
 
 # Common objects
 obj-y 					:= time.o serial.o usb.o \
-					   common.o sram.o aemif.o
+					   common.o sram.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
deleted file mode 100644
index e4ab3f3a2a1f..000000000000
--- a/arch/arm/mach-davinci/aemif.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * AEMIF support for DaVinci SoCs
- *
- * Copyright (C) 2010 Texas Instruments Incorporated. http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/time.h>
-
-#include <linux/platform_data/mtd-davinci-aemif.h>
-#include <linux/platform_data/mtd-davinci.h>
-
-/* Timing value configuration */
-
-#define TA(x)		((x) << 2)
-#define RHOLD(x)	((x) << 4)
-#define RSTROBE(x)	((x) << 7)
-#define RSETUP(x)	((x) << 13)
-#define WHOLD(x)	((x) << 17)
-#define WSTROBE(x)	((x) << 20)
-#define WSETUP(x)	((x) << 26)
-
-#define TA_MAX		0x3
-#define RHOLD_MAX	0x7
-#define RSTROBE_MAX	0x3f
-#define RSETUP_MAX	0xf
-#define WHOLD_MAX	0x7
-#define WSTROBE_MAX	0x3f
-#define WSETUP_MAX	0xf
-
-#define TIMING_MASK	(TA(TA_MAX) | \
-				RHOLD(RHOLD_MAX) | \
-				RSTROBE(RSTROBE_MAX) |	\
-				RSETUP(RSETUP_MAX) | \
-				WHOLD(WHOLD_MAX) | \
-				WSTROBE(WSTROBE_MAX) | \
-				WSETUP(WSETUP_MAX))
-
-static inline unsigned int davinci_aemif_readl(void __iomem *base, int offset)
-{
-	return readl_relaxed(base + offset);
-}
-
-static inline void davinci_aemif_writel(void __iomem *base,
-					int offset, unsigned long value)
-{
-	writel_relaxed(value, base + offset);
-}
-
-/*
- * aemif_calc_rate - calculate timing data.
- * @wanted: The cycle time needed in nanoseconds.
- * @clk: The input clock rate in kHz.
- * @max: The maximum divider value that can be programmed.
- *
- * On success, returns the calculated timing value minus 1 for easy
- * programming into AEMIF timing registers, else negative errno.
- */
-static int aemif_calc_rate(int wanted, unsigned long clk, int max)
-{
-	int result;
-
-	result = DIV_ROUND_UP((wanted * clk), NSEC_PER_MSEC) - 1;
-
-	pr_debug("%s: result %d from %ld, %d\n", __func__, result, clk, wanted);
-
-	/* It is generally OK to have a more relaxed timing than requested... */
-	if (result < 0)
-		result = 0;
-
-	/* ... But configuring tighter timings is not an option. */
-	else if (result > max)
-		result = -EINVAL;
-
-	return result;
-}
-
-/**
- * davinci_aemif_setup_timing - setup timing values for a given AEMIF interface
- * @t: timing values to be progammed
- * @base: The virtual base address of the AEMIF interface
- * @cs: chip-select to program the timing values for
- * @clkrate: the AEMIF clkrate
- *
- * This function programs the given timing values (in real clock) into the
- * AEMIF registers taking the AEMIF clock into account.
- *
- * This function does not use any locking while programming the AEMIF
- * because it is expected that there is only one user of a given
- * chip-select.
- *
- * Returns 0 on success, else negative errno.
- */
-static int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
-					void __iomem *base, unsigned cs,
-					unsigned long clkrate)
-{
-	unsigned set, val;
-	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
-	unsigned offset = A1CR_OFFSET + cs * 4;
-
-	if (!t)
-		return 0;	/* Nothing to do */
-
-	clkrate /= 1000;	/* turn clock into kHz for ease of use */
-
-	ta	= aemif_calc_rate(t->ta, clkrate, TA_MAX);
-	rhold	= aemif_calc_rate(t->rhold, clkrate, RHOLD_MAX);
-	rstrobe	= aemif_calc_rate(t->rstrobe, clkrate, RSTROBE_MAX);
-	rsetup	= aemif_calc_rate(t->rsetup, clkrate, RSETUP_MAX);
-	whold	= aemif_calc_rate(t->whold, clkrate, WHOLD_MAX);
-	wstrobe	= aemif_calc_rate(t->wstrobe, clkrate, WSTROBE_MAX);
-	wsetup	= aemif_calc_rate(t->wsetup, clkrate, WSETUP_MAX);
-
-	if (ta < 0 || rhold < 0 || rstrobe < 0 || rsetup < 0 ||
-			whold < 0 || wstrobe < 0 || wsetup < 0) {
-		pr_err("%s: cannot get suitable timings\n", __func__);
-		return -EINVAL;
-	}
-
-	set = TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
-		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
-
-	val = __raw_readl(base + offset);
-	val &= ~TIMING_MASK;
-	val |= set;
-	__raw_writel(val, base + offset);
-
-	return 0;
-}
-
-/**
- * davinci_aemif_setup - setup AEMIF interface by davinci_nand_pdata
- * @pdev - link to platform device to setup settings for
- *
- * This function does not use any locking while programming the AEMIF
- * because it is expected that there is only one user of a given
- * chip-select.
- *
- * Returns 0 on success, else negative errno.
- */
-int davinci_aemif_setup(struct platform_device *pdev)
-{
-	struct davinci_nand_pdata *pdata = dev_get_platdata(&pdev->dev);
-	uint32_t val;
-	unsigned long clkrate;
-	struct resource	*res;
-	void __iomem *base;
-	struct clk *clk;
-	int ret = 0;
-
-	clk = clk_get(&pdev->dev, "aemif");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret < 0) {
-		dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
-			ret);
-		goto err_put;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "cannot get IORESOURCE_MEM\n");
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	base = ioremap(res->start, resource_size(res));
-	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res);
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	/*
-	 * Setup Async configuration register in case we did not boot
-	 * from NAND and so bootloader did not bother to set it up.
-	 */
-	val = davinci_aemif_readl(base, A1CR_OFFSET + pdata->core_chipsel * 4);
-	/*
-	 * Extended Wait is not valid and Select Strobe mode is not
-	 * used
-	 */
-	val &= ~(ACR_ASIZE_MASK | ACR_EW_MASK | ACR_SS_MASK);
-	if (pdata->options & NAND_BUSWIDTH_16)
-		val |= 0x1;
-
-	davinci_aemif_writel(base, A1CR_OFFSET + pdata->core_chipsel * 4, val);
-
-	clkrate = clk_get_rate(clk);
-
-	if (pdata->timing)
-		ret = davinci_aemif_setup_timing(pdata->timing, base,
-						 pdata->core_chipsel, clkrate);
-
-	if (ret < 0)
-		dev_dbg(&pdev->dev, "NAND timing values setup fail\n");
-
-	iounmap(base);
-err:
-	clk_disable_unprepare(clk);
-err_put:
-	clk_put(clk);
-	return ret;
-}
diff --git a/include/linux/platform_data/mtd-davinci-aemif.h b/include/linux/platform_data/mtd-davinci-aemif.h
index 97948ac2bb9b..a403dd51dacc 100644
--- a/include/linux/platform_data/mtd-davinci-aemif.h
+++ b/include/linux/platform_data/mtd-davinci-aemif.h
@@ -33,5 +33,4 @@ struct davinci_aemif_timing {
 	u8	ta;
 };
 
-int davinci_aemif_setup(struct platform_device *pdev);
 #endif
-- 
2.17.1

