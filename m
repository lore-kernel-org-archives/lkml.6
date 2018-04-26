Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888943-1524763360-2-13698044936985908555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524763359; b=bn/BVELrBTFofLijfSEPZ87c5t9GTpS3XFAgIfb/y+o4sdwHDg
    PRQMPkLPyMkAV/q5mhgvmg7w8zVZtIeQEe0KkCgdM4/K+XO/cndrQBHybi3VWPdb
    wGt7FGVZc9MpGsTh4ADOlyxOLS/Be2m9jVYdSfJjjqSBdibn/IhmYz3wpYmkrHrx
    s+QPQeKhnFy55rHouaLiN0LIOaADpQ2bQhH9GC+USgsTT213/GJPIbwIvS1uFsmo
    0lwCQJPOpc/8pPW9kn3KzU33f/VeuqGg6ZJXJ7SN01LVJ6ezNZa9UMk72szDUP16
    IvpC8iVGa5Etg9ruJMb990rCw91QBCpkeRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524763359; bh=L2ySq/cXPYkHqOV77TJRDYh5rOrKc4
    VXf1EAweBOddg=; b=ldlpGErD/XO1xKYIhwEpO2iWFG9O/OsFfM8E0SbAO+YjAK
    O3wIslKYjFqxDponlkgyyuvG261JUaEr9tMoEBDRiF84k8ByJNjx22W1M8APu0C2
    2uhtCLm5BIBDRNt52eaMmw/WKvmQMKcwR5EOKSv7Xc2Fx2v9MtShTXJVXIsUKYzG
    2WY6qU9BsMXk3aru5KaiJOCXI27GvpBAU6iSZ6VqybJh7olp4dC3tg5A6tyoaj6A
    xaxfUzA+5+Fi2hUozmTxSCsK+HFHB6a9ID1SoX7u7yaLBgEAcX2oL1RdHxMHSwXt
    zZIYgQyHwT+8xYoqYac6F9D8XO5CO4zdB6OrSOPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvWiZklZZtYYxhygxemy+2ykVZpE1+0UlQisKLl2XRpqUgvKCzqLWOgYPU43nGfyDleDKQ7WrQwVWhS4rRi8dDD4jJnkd0G8uvdbOuzyoV8ozOh+mc2
    bhJRRfryzQX7fCc/keBZeShAFLUyNUYBokoq8cdycbzx05e6ZNc43RatoWe80+aeJm8h7XJStpxpbsD9y5MHGtTWzu/O6lzHUj/UNj2e5btXhgq2DpxyKh+R
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=w_Cx_DjtcGcFuUi5bA0A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756732AbeDZRWg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 13:22:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:32942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbeDZRWf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 13:22:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,331,1520924400";
   d="scan'208";a="46296694"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
Date: Thu, 26 Apr 2018 10:22:32 -0700
Message-Id: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit fixes incorrect setting of reset bits for PCI/VGA and
PECI modules.

1. Reset bit for PCI/VGA is 8.
2. PECI reset bit is missing so added bit 10 as its reset bit.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
Cc: stable <stable@vger.kernel.org>
---
 drivers/clk/clk-aspeed.c                 | 4 ++--
 include/dt-bindings/clock/aspeed-clock.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5eb50c31e455..2c23e7d7ba28 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -88,7 +88,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
 	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
-	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
+	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
 	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
 	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
@@ -297,7 +297,7 @@ static const u8 aspeed_resets[] = {
 	[ASPEED_RESET_JTAG_MASTER] = 22,
 	[ASPEED_RESET_MIC]	= 18,
 	[ASPEED_RESET_PWM]	=  9,
-	[ASPEED_RESET_PCIVGA]	=  8,
+	[ASPEED_RESET_PECI]	= 10,
 	[ASPEED_RESET_I2C]	=  2,
 	[ASPEED_RESET_AHB]	=  1,
 };
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index d3558d897a4d..8d69b9134bef 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -45,7 +45,7 @@
 #define ASPEED_RESET_JTAG_MASTER	3
 #define ASPEED_RESET_MIC		4
 #define ASPEED_RESET_PWM		5
-#define ASPEED_RESET_PCIVGA		6
+#define ASPEED_RESET_PECI		6
 #define ASPEED_RESET_I2C		7
 #define ASPEED_RESET_AHB		8
 
-- 
2.17.0
