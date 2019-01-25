Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AA5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0997621872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfAYUaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:30:21 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39426 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548448219; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2GB/9omsfAEJyxvwqR9Fp/FkRyq3uxmoYeckV+aQibQ=;
        b=JhRR6ouOHPn3mJD/ms9WPtt1JppWnhQCHDlRWQmArUva1qk+6c2NlTrpsu2NVSUYWoj//e
        CZ5xPp/F3ZJbAfX0+/6VTsuolqpY2A7siLhk7724tmYHe6CqHbYAlyga53P8LEklQy3ZxC
        Zif3mwgAZ97+D0rB4u737Dle5jHoYAg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] sound: soc: JZ4740: Fix divider written at incorrect offset in register
Date:   Fri, 25 Jan 2019 17:30:08 -0300
Message-Id: <20190125203009.24301-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4-bit divider value was written at offset 8, while the jz4740
programming manual locates it at offset 0.

Fixes: 26b0aad80a86

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 99394c036998..e099c0505b76 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -92,7 +92,7 @@
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
 #define JZ_AIC_CLK_DIV_MASK 0xf
-#define I2SDIV_DV_SHIFT 8
+#define I2SDIV_DV_SHIFT 0
 #define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
 #define I2SDIV_IDV_SHIFT 8
 #define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
-- 
2.11.0

