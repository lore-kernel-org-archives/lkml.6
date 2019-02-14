Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B821902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="GAa3GYES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbfBNBhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:37:05 -0500
Received: from onstation.org ([52.200.56.107]:37240 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389052AbfBNBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:36:56 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 5570A1AE;
        Thu, 14 Feb 2019 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1550108215;
        bh=7NoAGXdf0Vh7lWFtukQFACbBzh8lRU7cykhaKJSJLnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAa3GYESaLq1YkqhpzAj0fTGmDuwBrWUq9dDrA/MANyE37tGB4pE+eZto6deM3mZ+
         BBoUvhvfeQK5tHUsAfKMTZeblnudFJqkTa3qXIsEuiJkFOR0hSDDQT30BoNw183WIl
         +HS93abQ0uH8K+tefRrowDZ+lQBTO2MajCQMtDYk=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org
Cc:     sboyd@kernel.org, lee.jones@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH -next 2/3] mfd: pm8xxx: select IRQ_DOMAIN_HIERARCHY in Kconfig
Date:   Wed, 13 Feb 2019 20:36:40 -0500
Message-Id: <20190214013641.9740-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214013641.9740-1-masneyb@onstation.org>
References: <20190214013641.9740-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IRQ_DOMAIN_HIERARCHY for pm8xxx in Kconfig since this driver uses
the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN,
so it can be removed from here.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Linus: For your ib-qcom-ssbi branch.

 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c9ffe8efcbb6..8f316a820b38 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -927,7 +927,7 @@ config UCB1400_CORE
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
 	depends on (ARM || HEXAGON || COMPILE_TEST)
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 	select MFD_CORE
 	select REGMAP
 	help
-- 
2.17.2

