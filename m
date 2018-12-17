Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34536C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C1720675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4fmN2UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeLQJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbeLQJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so11513777wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVpmDAqKxQ/sn4lpMw47fV7HcMyJcxjw7jbklh3qbPU=;
        b=M4fmN2UPFDBuCsA/l/cfcC1hAR2jDhREULfaMwREXj9jde/LxvV5oqmtitq/xTFGoK
         JcghxbB0VRELV28L1XuXo8UNv6/qfU5zrtZrWbBEUQN4HBKc+hdqh7Kus5kWW177TwD/
         VAKgPKG+lBoxikNDrD45+8T0MbSLbmTWCrvS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVpmDAqKxQ/sn4lpMw47fV7HcMyJcxjw7jbklh3qbPU=;
        b=maHJkl8avhYmiXwyL697cH0S2pUQMMt3/e9X9PjjdndoykSaWvhO7Cve1Oe7hs1Xfj
         0J3pzzPEiZwMasWafuXiHhahHa+xc+OvtkFVrFny34gB5ulc3SyKgqAJ2DRg2HNhuhtl
         dzJnOHgASHEdxiVtjra1QszX5A8dfQ03WyNknelXkUGKnvUtOWR8zDUGOSKPR4N/KIOM
         6LXrbV5hcy1QpH5Au5Y4JguOUxFHkPG32oEfkUMNwwhVG5LwviR7SXY8U2D0TWSKBfro
         zmML+W/5wDX9SObrvlLiuG03peU4zz9J2xG/b+ZWl8Duc8hHRm/oMY4kWSSPd54+j+xc
         /kRQ==
X-Gm-Message-State: AA+aEWY3YPa/TXU5P8WK7ZRTYjb2TAarfxp78Q2c9O+pABYcM0XxRICW
        X0aNcNVzKmjwQgIrYZGuWOp1Eg==
X-Google-Smtp-Source: AFSGD/VTupLcbMqZPhg1oCeeYfC/f3CgT6s4do11VgP7Qhki/qWB+BpHpXcMxaMUDN5phIvMK1Zfwg==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr9561514wrp.242.1545040009055;
        Mon, 17 Dec 2018 01:46:49 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:48 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 07/13] clk: qcom: hfpll: register as clock provider
Date:   Mon, 17 Dec 2018 10:46:24 +0100
Message-Id: <1545039990-19984-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
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

