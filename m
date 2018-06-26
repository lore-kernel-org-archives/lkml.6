Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F187C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39167267BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fXkrD4io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39167267BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934244AbeFZJ27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:28:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53833 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933730AbeFZJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:25:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so1036778wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=guAFZVNu53f/LUonRamWSVSShsa/vjmer8idGdqo8SM=;
        b=fXkrD4ioR421yhrHm2Wd8XK/8oJQm6VV9ULIszAy9RrQipTVyraqRMCL9lKFpOgn7H
         dFpbzhXdDNRFK/bsEzBjwUxDC3pAC9WjwjFzviJJyBgqYAPq++7kfi2S/hPMCc0Dv5kn
         PTnpUQo1gJq6XocvQJ9u9W31C7Zr8UVL4cGZ6A1JtQP5l1clBgPOwyk45iUYjTDUIrRr
         N0EntSmu0hRbAt4P3io8HTW8HvNuifuYwjlLa7bsrDPnb1IJkOBDmKX+szDj5waL/TQ2
         O8LtZvnVUuqnxZ21xJwtDIYzqEDtHyKbaJX8uUBha7FAOIg3zsWPN5p6EhzbJO60GZs1
         8UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=guAFZVNu53f/LUonRamWSVSShsa/vjmer8idGdqo8SM=;
        b=Uku5OYJ7UjytISv5bOzgNNeuX8XXTQNjU873Uyb7BWWcPUpU+xpI2nT221Eogf9ksi
         LpDCwREex/s0jQiJ2eZO+zPTg9uxNG5AMYLVOuXppbal6FwcwHDXUHGE7sQRl0G6a6hv
         tzkegzI0mGZ9IMSoTxnr4Rq9Zm3lQoe+XNiCjXLFiEe5F36qUtbS6miLoXPd5r7iwfLA
         eJoDwXeA9o9nkszWzIrcO6b0h3GBGPVOYdg7oDEB993wzE7VnI1yW8RsKVdeffyelKdg
         pRs24bu+84EwX2zlmqfG85Bl8FpAhJyBSPHjGPhBxUH9ZsboKDU8GvDUTEzqj5QaARjn
         FUqA==
X-Gm-Message-State: APt69E38xqae17h+HmBhbOvChVem3ZnjZwup7iLpvUxDpwitZtvd/5LT
        Ark7+JmFHULC1BYWOn0YnKeNQw==
X-Google-Smtp-Source: AAOMgpc2idEnFJyh00ufYdYQxSbjMpppEg3ku7IqWAZVm6lg3P+6KqjJtaiYDz0Ye6+4bRm2cCV3pw==
X-Received: by 2002:a1c:3307:: with SMTP id z7-v6mr1018263wmz.114.1530005142899;
        Tue, 26 Jun 2018 02:25:42 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1528791wrn.50.2018.06.26.02.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 02:25:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/13] clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
Date:   Tue, 26 Jun 2018 11:25:25 +0200
Message-Id: <20180626092537.6737-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626092537.6737-1-brgl@bgdev.pl>
References: <20180626092537.6737-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit a8e3923ab571 ("mtd: rawnand: davinci: don't acquire and
enable clock") we no longer acquire the aemif clock from the davinci
nand driver - we only do it from the ti-aemif driver. Remove the nand
entry from the psc lookup table.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da850.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index d196dcbed560..5a18bca464cd 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -16,8 +16,7 @@
 
 #include "psc.h"
 
-LPSC_CLKDEV2(emifa_clkdev,	NULL,		"ti-aemif",
-				"aemif",	"davinci_nand.0");
+LPSC_CLKDEV1(emifa_clkdev,	NULL,		"ti-aemif");
 LPSC_CLKDEV1(spi0_clkdev,	NULL,		"spi_davinci.0");
 LPSC_CLKDEV1(mmcsd0_clkdev,	NULL,		"da830-mmc.0");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1

