Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0EEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F3120657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="U46EbLUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfAMPro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:47:44 -0500
Received: from onstation.org ([52.200.56.107]:42676 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfAMPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B0718794;
        Sun, 13 Jan 2019 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394461;
        bh=2YgscNyhUtCB9+XJurbhJ1isjq9wZM8MacKxIpKAS7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U46EbLUAU0Lg4kCitMDM2NX1ZxWGtS4/BK+RaaW9mPsGjftWA1xt7mwkZ5kCmbxNH
         +6Z3UFtqSCFP97CC7q7LDgWyFXy9HxtDD5yuHDG0p5Ko2zsKt+MAcw9uN4Vx1vs0Xm
         zfS1mHg8t5XQHdogboeeqgIV+7EjJVtVUYjEA39E=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 02/14] pinctrl: qcom: spmi-gpio: add support for three new variants
Date:   Sun, 13 Jan 2019 10:47:04 -0500
Message-Id: <20190113154716.5145-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for qcom,pm8005-gpio, qcom,pm8998-gpio, and
qcom,pmi8998-gpio. These three variants are already in use in some
arm64 dtsi files. Those boards work since the generic binding
qcom,spmi-gpio is also specified.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is a new patch introduced in V4.

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

