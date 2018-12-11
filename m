Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ADC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D132084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="WJjikUPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D132084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeLKPRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:17:54 -0500
Received: from plaes.org ([188.166.43.21]:59660 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbeLKPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:17:24 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 6DAB441A4E;
        Tue, 11 Dec 2018 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544541442; bh=ByCwPrun3zomohIabXCqr8/YD09wa8MnYdpb1VM3gbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJjikUPXjiZpwh4MmzOuGASuEzhle9mUab5gMvGtWV9YSGkmVXb+Emdr7gFJVeiqZ
         DEz2edKvggmJ+CPkAoz+xI+hpZArlDniQnsxZMvYZwH87iyUNkr/R9VR2eUsGr3KOD
         ilw0i9SAG8nJirW+tKbxbnaZ3h7xndNg5FtW3xUosjaJViZEXPRKZuYMZTeiE8ol0E
         7o80wQIBOkPhQwYnDqhLwpX17vEtgsLSsj5ASjUD/PM7chIYqAlOyeLUDgVksCGsIL
         EMcjr5rtJgrX5tphIWKX5LASpMBpU2J//kDvIAPpkDJVyLYzHrmU798odELJSyWmKP
         l/N1IAixOZsEw==
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
Subject: [PATCH v2 7/8] mfd: axp20x: Clean up included headers
Date:   Tue, 11 Dec 2018 17:17:11 +0200
Message-Id: <0cd6a4f334a84bfcbbdd805ccabe132611517ba3.1544512919.git-series.plaes@plaes.org>
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

Add the bitops.h header as we need it, alphabetize header order.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dfc3cff..c3f3dbd 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -16,18 +16,19 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/err.h>
+#include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/mfd/axp20x.h>
-#include <linux/mfd/core.h>
-#include <linux/of_device.h>
-#include <linux/acpi.h>
 
 #define AXP20X_OFF	0x80
 
-- 
git-series 0.9.1
