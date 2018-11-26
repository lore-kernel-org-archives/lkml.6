Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6844C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00102086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="TnCPnVVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00102086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeK0CXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:23:12 -0500
Received: from plaes.org ([188.166.43.21]:50100 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbeK0CWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:44 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 4789541C94;
        Mon, 26 Nov 2018 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246096; bh=6POH4HWf8Q038kfDzLV0JnZ89Ha7A34mVLpZirOp0+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnCPnVVGns5fk4DFCTxNu2pI7wK52XAVta4lEPdm7x0zoJPE3L1PN9J5w5ctjAOtb
         fkSB/D1sSzpIYaUzmA42ZgpPIi//G56DT/2oROYH4mync7YI4116az9rQAL1Z2Rcly
         OC4KMDYuTkTx9+EII5+KYY2VFt+ngOL3Z8pGbXzOJl3RIszw4sXrM9suyrH4Acx/f/
         XoY9QfJp0te3Tz+XMMExLmxsp8w0DnxkCLWKv31GeR6tnH6gaHd0KIXqho0ZneO6GJ
         TS9ArPb5Kuw1msh7RLie+E7XPiSZ/6Lj5wXho8MPkq5QNnXSZp6ikGsEXu7MsMtGDQ
         kBtoQgq1stAdQ==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 11/14] mfd: axp20x: Clean up included headers
Date:   Mon, 26 Nov 2018 17:27:52 +0200
Message-Id: <1567a4f47e802c592a3f109c7b5e0656528e2a5c.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
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
---
 drivers/mfd/axp20x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511d..da54399 100644
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
