Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VM1mJbrvGFv6BgAAmS7hNA
	; Thu, 07 Jun 2018 08:41:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 00EF0607F7; Thu,  7 Jun 2018 08:41:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BE0160452;
	Thu,  7 Jun 2018 08:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BE0160452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeFGIlk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:41:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932671AbeFGIlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:41:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7C615207FA; Thu,  7 Jun 2018 10:41:35 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4988E20E1C;
        Thu,  7 Jun 2018 10:41:12 +0200 (CEST)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] ARM: at91: fix USB clock detection handling
Date: Thu,  7 Jun 2018 10:41:06 +0200
Message-Id: <20180607084107.4461-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more compatibles to be able to correct the USB clock detection.

at91sam9261 and at91sam9263 have the same PMC_SCSR layout as at91sam9260.
at91sam9rl doesn't have any USB clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 849014c01cf4..563f34d01ce4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -559,15 +559,20 @@ static const struct pmc_info pmc_infos[] __initconst = {
 	{ .uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP },
 	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP },
 	{ .uhp_udp_mask = AT91SAM926x_PMC_UHP },
+	{ .uhp_udp_mask = 0 },
 };
 
 static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-pmc", .data = &pmc_infos[0] },
 	{ .compatible = "atmel,at91sam9260-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9261-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9263-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-pmc", .data = &pmc_infos[2] },
 	{ .compatible = "atmel,at91sam9n12-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,at91sam9rl-pmc", .data = &pmc_infos[3] },
 	{ .compatible = "atmel,at91sam9x5-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d3-pmc", .data = &pmc_infos[1] },
+	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ /* sentinel */ },
 };
-- 
2.17.1
