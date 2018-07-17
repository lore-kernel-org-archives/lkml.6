Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B42ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFC9206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFC9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGQXDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbeGQXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 29B0E206F6; Wed, 18 Jul 2018 00:28:17 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id F27F7207AB;
        Wed, 18 Jul 2018 00:28:06 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 02/16] clk: at91: generated: SSCs don't have a gclk
Date:   Wed, 18 Jul 2018 00:27:43 +0200
Message-Id: <20180717222757.10253-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the SSCs don't have gclk, don't check for their ID to allow them to set
the audio pll rate.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/clk-generated.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 33481368740e..e709a12269c0 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -26,8 +26,6 @@
 #define GENERATED_SOURCE_MAX	6
 #define GENERATED_MAX_DIV	255
 
-#define GCK_ID_SSC0		43
-#define GCK_ID_SSC1		44
 #define GCK_ID_I2S0		54
 #define GCK_ID_I2S1		55
 #define GCK_ID_CLASSD		59
@@ -368,8 +366,7 @@ static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
 
 		if (of_device_is_compatible(np,
 					    "atmel,sama5d2-clk-generated")) {
-			if (gck->id == GCK_ID_SSC0 || gck->id == GCK_ID_SSC1 ||
-			    gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
+			if (gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
 			    gck->id == GCK_ID_CLASSD)
 				gck->audio_pll_allowed = true;
 			else
-- 
2.18.0

