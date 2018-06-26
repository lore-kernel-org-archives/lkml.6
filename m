Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A8AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3542679A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GFs2c/xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3542679A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeFZJZ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:25:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52548 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbeFZJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1052847wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pofyQ6FgMsDD6pm9jY/9qPsZRPAHxS5ZCh6KlS8j4r0=;
        b=GFs2c/xAysy1Tp1JCMI+A2ITv9zFBFOAhoONz5pE8v/xz4JjZtWhthe3drKDktp5KZ
         K29ZInK+gwjhDB2qFuny/afQdi4Tuds+tU1URL22xGe27zL2HGcruggjARbmc9UKwduo
         DC0+Kwz0IaPi79uxbXQVLFmoFq9znp+RVC67r7kUFwJ1rKf7k5zZf5Jsm/126qsLJNb2
         qfaiqRmDNwPbp4Yy6h9J2L/JU03ZOVoh16mB6hyXFaHiVaexVw3qFtLLb8NcQ/uPkcka
         SOvelFtJAHuegwCj08FEbu9wW2Y6freftCasvYchPQVgKvpVTNWP5giVAf+3baK3qJyJ
         Zo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pofyQ6FgMsDD6pm9jY/9qPsZRPAHxS5ZCh6KlS8j4r0=;
        b=DA/wzSTsaEhPs7eIIxOGQ78rG8OGB0i1fh2NZucAqdG6N2UBCnEMJf0z2dQG4TL24F
         LBN5vXIpfMVdyjNPBf2z7I0bwbDuuU50fersuguEHanzhV+o51lA8y6AN7AQ4jG8aFxz
         emFmQdSN0pgShxC11mYrKAgx0GBELKjj7yF7zeFrRHV1Ix1patgAZrAjl24B2nnAt/fo
         lOLh41u4yG7T53vPT4SYcpWBvY7JR3O8c3o3SbYIIALacgHl0X1tKGBt6J/VSMtBRTEG
         2FECkHLmO/lwxpK/Q8u24hh7jlFORtr2aU//LaD4K8TzCkGHckgqEmCba5DJovYk8y2H
         Yt3g==
X-Gm-Message-State: APt69E0U/Imm5w0Dudyjub0buG5UQzThwBXaXav66IywbN80hT9LqkC7
        lq+hCrHAQe3tv7uA3h7784IH5Q==
X-Google-Smtp-Source: AAOMgpfjTyQGjhNYeyZ15Kq4OOfGXEbGc0Bwo1AZJ1vqqrnD1D8gf89R6Wjos0rJbkBmYwSXRFBXSg==
X-Received: by 2002:a1c:d7c3:: with SMTP id o186-v6mr914858wmg.67.1530005147382;
        Tue, 26 Jun 2018 02:25:47 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/13] clk: davinci: psc-da830: add a lookup entry for aemif clock
Date:   Tue, 26 Jun 2018 11:25:29 +0200
Message-Id: <20180626092537.6737-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use the ti-aemif platform driver for da830-evm. To make it
work we need a lookup entry for the aemif clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da830.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-da830.c b/drivers/clk/davinci/psc-da830.c
index 081b039fcb02..6481337382a6 100644
--- a/drivers/clk/davinci/psc-da830.c
+++ b/drivers/clk/davinci/psc-da830.c
@@ -14,6 +14,7 @@
 
 #include "psc.h"
 
+LPSC_CLKDEV1(aemif_clkdev,	NULL,	"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,	"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd_clkdev,	NULL,	"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,	"serial8250.0");
@@ -22,7 +23,7 @@ static const struct davinci_lpsc_clk_info da830_psc0_info[] = {
 	LPSC(0,  0, tpcc,     pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(1,  0, tptc0,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
 	LPSC(2,  0, tptc1,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
-	LPSC(3,  0, aemif,    pll0_sysclk3, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, aemif,    pll0_sysclk3, aemif_clkdev, LPSC_ALWAYS_ENABLED),
 	LPSC(4,  0, spi0,     pll0_sysclk2, spi0_clkdev,  0),
 	LPSC(5,  0, mmcsd,    pll0_sysclk2, mmcsd_clkdev, 0),
 	LPSC(6,  0, aintc,    pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
-- 
2.17.1

