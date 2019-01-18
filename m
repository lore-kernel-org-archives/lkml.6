Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C042086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Gqetm3TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfARPN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:13:56 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57878 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfARPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547824432; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6zNY/a+A66q1szoSq2HpWsby0AjFKHoudpnJtUju4HA=;
        b=Gqetm3TA4BwIdIopeV4PeodGiwMQUd9l3Uuazb38LPKoIqZHf/PP+ys4nBsuZd7xfdyki0
        DUldXYdJWcSqBp13JpR6aSS4AuzBMmF/SOhYDXTzXev3cd+mG+/cAyj7tF8ZrC3xKBC1os
        CMvTvNXdnbdxe2wygWi4uhHmLU/LYYg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/4] memory: Kconfig: Drop dependency on MACH_JZ4780 for jz4780
Date:   Fri, 18 Jan 2019 12:13:27 -0300
Message-Id: <20190118151329.8040-2-paul@crapouillou.net>
In-Reply-To: <20190118151329.8040-1-paul@crapouillou.net>
References: <20190118151329.8040-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4780 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---

v2: No change

 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 2d91b00e3591..3d411575fcb6 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -122,7 +122,7 @@ config FSL_IFC
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
 	default y
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
-- 
2.11.0

