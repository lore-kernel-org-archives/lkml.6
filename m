Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7ADC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F120881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuLKGXTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfA1SeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:34:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfA1Sda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so19239163wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVpmDAqKxQ/sn4lpMw47fV7HcMyJcxjw7jbklh3qbPU=;
        b=AuLKGXTEF/zJmA5NsI2ZU/MrY8PjDijYbEC7ayTof56dDleGQHTG8AdDA26ctjQtFa
         H9vffH4TsWwAOXxxxd05+mUnTuz6FxQttOEvnrvbsi+ho4z7s4/hiM7CyWgAvuJUThDt
         o1WXVLwa8xB2zcnkoJhZfw3cjiaNoa1Da+AD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVpmDAqKxQ/sn4lpMw47fV7HcMyJcxjw7jbklh3qbPU=;
        b=QIfpsrCZ0KVa2jDgjJ/OZw1XTFEtsDUleiG44M1blCb72elNoBap1isrLDqQ3H9xc2
         BfS/T1gtNUEso5WRqFaZZWvgxFaSLt0MCLMvurmYz65chmixIGzKEJExxA6Ej7INdvVD
         Uvs1+B4Tb4x1ZvTAolpSftvOtUgZUx/PIzPG/u/AOJ+UozKZvIsg/hSj9Sl7oyP4qf83
         qlTavukaG0OVciZkTgKGmPRMFvo1a2CX20W6U7+JJa69fEKRIHPeeTzJhtNbiW/fj2Za
         1nqYxiNC/cpaM3OIAJPjxikAdlJcNpU0g3uGJWYUd7hCLh4netMmQfx4ZUMmXUvNSFb7
         ThPA==
X-Gm-Message-State: AJcUukcC1XSMtRmciFw5t3XF4p0/1lDmuMt/Ubr+WvxvKBnS01NKac6N
        XDDkuqBYCQEQB/oCX4MvWZ6Q3A==
X-Google-Smtp-Source: ALg8bN4DPSWSntfVf4nxRbsKw8kQvIawgC5fRMRsITJxa8keGe+bq96fbP/BtZDbVmU0kxACokb9wA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr23059241wrc.168.1548700408757;
        Mon, 28 Jan 2019 10:33:28 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:28 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 07/14] clk: qcom: hfpll: register as clock provider
Date:   Mon, 28 Jan 2019 19:32:54 +0100
Message-Id: <1548700381-22376-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the output of the high frequency pll a clock provider.
On the QCS404 this PLL controls cpu frequency scaling.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 87b7f46..0ffed0d 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -53,6 +53,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_hfpll *h;
 	struct clk *pclk;
+	int ret;
 	struct clk_init_data init = {
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
@@ -87,7 +88,14 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
 
-	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
+	ret = devm_clk_register_regmap(dev, &h->clkr);
+	if (ret) {
+		dev_err(dev, "failed to register regmap clock: %d\n", ret);
+		return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &h->clkr.hw);
 }
 
 static struct platform_driver qcom_hfpll_driver = {
-- 
2.7.4

