Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF811C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829542081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="VGaryfFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829542081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLJSnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:43:14 -0500
Received: from plaes.org ([188.166.43.21]:55080 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeLJSm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:42:27 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 43DE44126E;
        Mon, 10 Dec 2018 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544467345; bh=DNxG4QIovujeB65kr1xY5el00nrx7k3udwttY/HTPZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGaryfFNV8xozeb60Rm/7qOjwYb6gmCJWGq8Cd7nxq9t9XCpL+pNRT7bgqit37AYt
         OXwWFOVmIObrzD2+lDTY2dql8MHvW87roLS7tCbFsjbpgDF1cBnqvPlFkolVCVqaJC
         NBog6RXKOMt/Xt+60O1Tg4JYbkP9MkfoO7ft5YKDRREakbtwWbr2Pu/RmIw0LmL/Eh
         TDrW/h/j0Kymk51bt7orI5oJHpvsyH1m2ZDVWBr1BcfOrJ/CK7J7SLjJeEoAVx9NAO
         7SalzfgTfPW56vrQFa598+kViB/L/HYnIWHw1tZBw/+tchFeXp3FQR/5GHz8MFVKAX
         RL1oB4IrRw3gg==
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
Subject: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Date:   Mon, 10 Dec 2018 20:42:12 +0200
Message-Id: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
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
