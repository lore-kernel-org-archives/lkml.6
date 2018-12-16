Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C38C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E6B217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vdpltc/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeLPOKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:10:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40058 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:10:50 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mfd: ingenic-tcu: Fix bit field description in header
Date:   Sun, 16 Dec 2018 15:10:44 +0100
Message-Id: <20181216141044.14465-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544969448; bh=jNOxF6znZLe6o/cQ2cphCdvkWJIUYhyObOtgNMxyCgk=; h=From:To:Cc:Subject:Date:Message-Id; b=vdpltc/cjzZfeFLsBj0NsdAK1dNI9ROozakuKhqZc6+I/y8NtoPCfnxYvuqPPJDBBvnEDNRInnUzkA6gnQfc5sSAG1LuPVK5kKBJwr9rpDaRBsotSyoUKCAdLlungIFO/eBS5lxjppXka5tJsWpl7wwIVLkdB/A4yBoUfY1/csU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of the bit was inverted.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/mfd/ingenic-tcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/ingenic-tcu.h b/include/linux/mfd/ingenic-tcu.h
index ab16ad283def..2083fa20821d 100644
--- a/include/linux/mfd/ingenic-tcu.h
+++ b/include/linux/mfd/ingenic-tcu.h
@@ -41,7 +41,7 @@
 #define TCU_TCSR_PRESCALE_LSB		3
 #define TCU_TCSR_PRESCALE_MASK		0x38
 
-#define TCU_TCSR_PWM_SD		BIT(9)	/* 0: Shutdown abruptly 1: gracefully */
+#define TCU_TCSR_PWM_SD		BIT(9)	/* 0: Shutdown gracefully 1: abruptly */
 #define TCU_TCSR_PWM_INITL_HIGH	BIT(8)	/* Sets the initial output level */
 #define TCU_TCSR_PWM_EN		BIT(7)	/* PWM pin output enable */
 
-- 
2.11.0

