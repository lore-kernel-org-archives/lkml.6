Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BFC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670E12087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="I9dbTZ9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfASUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:45:04 -0500
Received: from onstation.org ([52.200.56.107]:35174 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfASUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:43:32 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 129B63C9;
        Sat, 19 Jan 2019 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547930611;
        bh=DFgHa3haznYjy+rYPiuxbY7sR7Wg5p7utmT6YLE2+Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9dbTZ9B4lN5xqjhHu/LVjyLKk5wmKm0H0eAZcIRi4ZCuM+SzHajslYtagXk8mJDU
         NYRjtm7KSESM5pVpP/W9pbz/B1Cac0UQ2YywtuztrhU07HoUhqnYoF/Y+UgPFPcFUY
         pwEvr4uR9B9RY9A+30j3rPKsMjccN7P/bDH/joOA=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com
Cc:     shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 02/15] pinctrl: qcom: spmi-gpio: add support for three new variants
Date:   Sat, 19 Jan 2019 15:42:39 -0500
Message-Id: <20190119204252.18370-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190119204252.18370-1-masneyb@onstation.org>
References: <20190119204252.18370-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for qcom,pm8005-gpio, qcom,pm8998-gpio, and
qcom,pmi8998-gpio. These three variants are already in use in some
arm64 dtsi files. Those boards work since the generic binding
qcom,spmi-gpio is also specified.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v5:
- None

Changes since v4:
- None

Patch introduced in v4.

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4458d44dfcf6..5f2977982ef1 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1063,10 +1063,13 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id pmic_gpio_of_match[] = {
+	{ .compatible = "qcom,pm8005-gpio" },	/* 4 GPIO's */
 	{ .compatible = "qcom,pm8916-gpio" },	/* 4 GPIO's */
 	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pmi8994-gpio" },  /* 10 GPIO's */
+	{ .compatible = "qcom,pm8998-gpio" },	/* 26 GPIO's */
+	{ .compatible = "qcom,pmi8998-gpio" },	/* 14 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pms405-gpio" },	/* 12 GPIO's, holes on 1 9 10 */
 	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
-- 
2.17.2

