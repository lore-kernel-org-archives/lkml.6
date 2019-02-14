Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1B222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="A9+1L2Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbfBNBg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:36:56 -0500
Received: from onstation.org ([52.200.56.107]:37232 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfBNBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:36:56 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EC99415F;
        Thu, 14 Feb 2019 01:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1550108215;
        bh=OmyX0O7C0YwnE8JoeLBdhGsLjaxW2/FAIuO2K4XSPe8=;
        h=From:To:Cc:Subject:Date:From;
        b=A9+1L2LjOZMAAmiuBwPk7OZftQ+zYVD0hmsexpOP3iFeTZduKLOwStlM4YE7FHddq
         mPk7TTxjBaLT4UDROFNHD0LLvC4tNrgg8N4EJnFgvNncHIivEZbZg5Cba+7Xuns6K/
         ePiEk8bbD04vclJ82org4iY2NCx/p4tb+fTXuMl8=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org
Cc:     sboyd@kernel.org, lee.jones@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH -next 1/3] spmi: pmic-arb: select IRQ_DOMAIN_HIERARCHY in Kconfig
Date:   Wed, 13 Feb 2019 20:36:39 -0500
Message-Id: <20190214013641.9740-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IRQ_DOMAIN_HIERARCHY for pmic-arb in Kconfig since this driver
uses the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects
IRQ_DOMAIN, so it can be removed from here.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This addresses a build failure found by make randconfig in linux-next:
https://lore.kernel.org/lkml/fb0508f1-131d-ff17-9b5d-123ec75275dd@infradead.org/

 drivers/spmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 0d3b70b3bda8..d48ed7c2c6c4 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -12,7 +12,7 @@ if SPMI
 
 config SPMI_MSM_PMIC_ARB
 	tristate "Qualcomm MSM SPMI Controller (PMIC Arbiter)"
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
 	default ARCH_QCOM
-- 
2.17.2

