Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D7420851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="iRdN6gA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D7420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLKPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:17:24 -0500
Received: from plaes.org ([188.166.43.21]:59552 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeLKPRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:17:21 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 23183409A6;
        Tue, 11 Dec 2018 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544541439; bh=DNxG4QIovujeB65kr1xY5el00nrx7k3udwttY/HTPZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRdN6gA1aWsbOokJIFQyHUIS1TkGG9rwoQkAT9AxOiwfNGZxD+GNOO9r9EYKKcglj
         a6YcN7n3EoZhvhY3T4ri6hweIduI05vtP6NdjFu8IzzlwvDazrbS2ZTCdLRtB2KDyt
         rWxj0aMzHvAB8kiuVXX0Aq8pdLZrbQiprfKWQ4WTpCLhGr7uvs4vvJFT6N+YdhWIX3
         CtMF16x/bZfHY3aRQjNAEXP0NXdHdtFTvSqBCrXpmaAnrmCyBcPh8SKs7uLywgAaiC
         OzCNm7r23Ax2iKhsvOQv+b0wNolGX71xy7jrPAQHUP0PEUtUG312zQpsM6xqsf88xZ
         rWnUy5l8OIZPg==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 1/8] mfd: axp20x: name voltage ramping define properly
Date:   Tue, 11 Dec 2018 17:17:05 +0200
Message-Id: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The current axp20x names the ramping register 'scal' which probably
means scaling. Since the register really has nothing to do with
scaling, but really is the voltage ramp we rename it appropriately.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/axp20x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 2302b62..a353cd2 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -35,7 +35,7 @@ enum axp20x_variants {
 #define AXP152_ALDO_OP_MODE		0x13
 #define AXP152_LDO0_CTRL		0x15
 #define AXP152_DCDC2_V_OUT		0x23
-#define AXP152_DCDC2_V_SCAL		0x25
+#define AXP152_DCDC2_V_RAMP		0x25
 #define AXP152_DCDC1_V_OUT		0x26
 #define AXP152_DCDC3_V_OUT		0x27
 #define AXP152_ALDO12_V_OUT		0x28
@@ -53,7 +53,7 @@ enum axp20x_variants {
 #define AXP20X_USB_OTG_STATUS		0x02
 #define AXP20X_PWR_OUT_CTRL		0x12
 #define AXP20X_DCDC2_V_OUT		0x23
-#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
+#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
 #define AXP20X_DCDC3_V_OUT		0x27
 #define AXP20X_LDO24_V_OUT		0x28
 #define AXP20X_LDO3_V_OUT		0x29
-- 
git-series 0.9.1
