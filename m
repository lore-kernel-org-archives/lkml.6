Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724743;
	bh=cZvSfRG/8/v1+hbVZi8v2vUxMsGFlRIdhgVQ3yZ2lLs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gu7Djy5Nyf0aIGeOl0e+8MNxYifvTs71BHFYNsvSukqLuXXn8dAfPKZXrlMNIoeDP
	 RNhQBmqtiNCH/Q2MbIx1q7qTCtWpg9AIVSuBoZ0RzWgl6XYG1Xe6+UJ4KGHJTwX6ZH
	 r0Q3kSrNRQt/Ndc/+Yth+DxymFjiq8wfzTL7L1f8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeLMSMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:12:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbeLMSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3IFeZCz8gv/scnrupK+s9h/aSMdWS/wRWB7/Pip0l7U=; b=ldoKWHPYY/az
        gvGuUpBdeuXCQkKnGbdMeUGLLaJ2H0ZNwrAq9TcEvX+l5sNEBS5wT9G12vxowI1MWlrkQnY4c7S+n
        63Zb1zQtpcfuXM1aESrSN1NJvDUkagaP4gHR4a1C75hDIWJf6ZQzwOOV4hvwL4pPKsZ7jImTSrM77
        PIRF0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSQ-0002Qw-NL; Thu, 13 Dec 2018 18:11:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 63D8411254D1; Thu, 13 Dec 2018 18:11:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "mfd: axp20x: Clean up included headers" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181134.63D8411254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mfd: axp20x: Clean up included headers

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From dcea4d5c0a349034686ef9f8ba8a9910e0a1c14b Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:11 +0200
Subject: [PATCH] mfd: axp20x: Clean up included headers

Add the bitops.h header as we need it, alphabetize header order.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/axp20x.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 0be511dd93d0..da54399dc7b3 100644
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
2.19.0.rc2

