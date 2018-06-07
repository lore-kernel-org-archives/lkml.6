Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QTlFIFrdGFtedAAAmS7hNA
	; Thu, 07 Jun 2018 07:24:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CCD44607E7; Thu,  7 Jun 2018 07:24:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfz1jU2+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49947602FC;
	Thu,  7 Jun 2018 07:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49947602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeFGHYJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:24:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41402 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeFGHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:24:06 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so5525513plb.8;
        Thu, 07 Jun 2018 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cfir5d9nY+kHtjjYX58OJl7xlw1mcjEAzGYTWy2Emm4=;
        b=gfz1jU2+bKH2qmaF3CETlfmz/x+LqlVtdjSVaohFR0210pNjPNSpIyAEnXftwgEuun
         iTWOvdQdbTOjMJYg5YvyBkEU67bjc4mLo1n8NCcLagesZ0bYalRuyd5xo0z265EIzQOt
         1p+yrTqWpmZbAmAuBLbRvW3cmefZRKJbYfxfz3SHU+P1jzM4+9RvIGMRas+E3FVF3KWD
         9JTFPcWfVJuJuMZHqGiukaZWOIxdXsbrocGv3jKBtDDri520SXb/FwsMrvvLiiWO40An
         HHEqWFKLqsNvOd+Cjd3RRWkQINIFEzan2RHBaK+iZpNaP7WftxC5m7EZlhfBq+lP4TDV
         zh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cfir5d9nY+kHtjjYX58OJl7xlw1mcjEAzGYTWy2Emm4=;
        b=Y9CWFGwdTlxRHJuF5BUhX6jSkNPsWLihgwarlBjhdY4UZ2GwQRmQCiIiJZB3bZ604s
         5EG85sH+cClJQXMe8+5+0ESkvxeOA0q+RwlmET3g+GRsPI5OnqHLRcz8qPsXHVVe0/9N
         ubRz33pvLfqyP91p1ouAS0PVk3L4AENuwEyH5NN54JJ0JDj3u0I0xOb5lcgDSFeljNoX
         68wkXB1/SWuwKIA+yAJHLJs4qS9Hj7tgeO9JduN/leL551TeLLGK9KPI9a38jN58j+bz
         +YDmP/dsVrO0Z0zDT374g/yjuChgprCPrlFVSFqCz5ysSN6z4WEURfNX1YfR0UHc9ixe
         jOFA==
X-Gm-Message-State: APt69E0issfham3pRSJyfPRWvRWWjJ6aUCNP7N4LPXtzc3Fk4OBKwmQx
        mmYjfOjNtfnqKfPJq5ordos=
X-Google-Smtp-Source: ADUXVKInovR5/DhQAx3m/OKH5DK9289f4J7SSY3t+CdCvNS79yHErV1v3DY9txWL2upAvAfQylWPug==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr851851pls.18.1528356246254;
        Thu, 07 Jun 2018 00:24:06 -0700 (PDT)
Received: from aurora.jms.id.au ([203.0.153.9])
        by smtp.gmail.com with ESMTPSA id c74-v6sm23195091pfd.19.2018.06.07.00.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:24:04 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Thu, 07 Jun 2018 16:53:57 +0930
From: Joel Stanley <joel@jms.id.au>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
Date: Thu,  7 Jun 2018 16:39:59 +0930
Message-Id: <20180607070959.31995-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the host to talk to the BMC's PCIe slave device. The BMC
is not involved, but the clock needs to be enabled so the host can use
the device.

Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
Cc: stable@vger.kernel.org # 4.15
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Tested-by: Lei YU <mine260309@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 4d425594999d..c17032bc853a 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -91,8 +91,8 @@ static const struct aspeed_gate_data aspeed_gates[] = {
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
-	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
-	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
+	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
+	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	CLK_IS_CRITICAL }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
 	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
 	[ASPEED_CLK_GATE_LCLK] =	{  8,  5, "lclk-gate",		NULL,	0 }, /* LPC */
-- 
2.17.1
