Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A09C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnLMqzqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeLQJrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732162AbeLQJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so11542074wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrsB9vDQWUxmYDFtafFb8lMIaGmRCz/1Apw6ozfisK4=;
        b=AnLMqzqwXsU3Rh56Mw8RlaefGcFHGPMQFybrCvfMQAM0x7joM8gy5RZbA/REs6gSFs
         sFjAZ0C9BsOKSSnbxXXoD+VmQ35THbPnF4oapNOqnox/HFRUZJj3FUv25uiQ3Q7Ij/r8
         Dr60uQr75h1UvYt4KqZB6KwXyLooOeFnR3uZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrsB9vDQWUxmYDFtafFb8lMIaGmRCz/1Apw6ozfisK4=;
        b=g2ld5wVlz8P3d94Dpx55CjFjZpq9/2Zwr2HQGedfDAJ9/ICeR5aWuodmpaNo2qJy/U
         8nLBl0Aw3sWLTchMZpNTZEeXSQldJV1f29DFSzseHIfO6c2GFQvmB1u6tNwlTDUJew9L
         JuZfk5lCikNJkffnEN4ZUbpuhJPwBLOBQ0xQF/LSmcY7ShcuTtYyrqQT4mvfLYL6u3HT
         7g/vqgpCzL/88Apl+wxPilaFJFYKuqU/Z1VQWSZ7ApLoEbnSCQL+yvdbXvbKxn/UQCBU
         VJ4ng4u12W0mNM2VvV24ZX0ljeWhsEAPaqMUjo9j9Jt+81zX5rLRoFjyvrXv9EAAfBnf
         9USg==
X-Gm-Message-State: AA+aEWb35SSo4I9rjAjGFL+Q/CE5SW4OVpaS78dDTQf//e79T9ejzmry
        avZCiC8W++j4FZmMEapmDJXHuw==
X-Google-Smtp-Source: AFSGD/XJ7Wwie14n0gvFJE1BP09wzskI9QWh3ZBKXMDWsG30w6b4VE7zrHrinRfEvKyaXI/An6PA2w==
X-Received: by 2002:adf:c38e:: with SMTP id p14mr9926632wrf.68.1545040007133;
        Mon, 17 Dec 2018 01:46:47 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:46 -0800 (PST)
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
Subject: [PATCH 06/13] clk: qcom: hfpll: get parent clock names from DT
Date:   Mon, 17 Dec 2018 10:46:23 +0100
Message-Id: <1545039990-19984-7-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow accessing the parent clock name required for the driver
operation using the device tree node.

This permits extending the driver to other platforms without having to
modify its source code.

For backwards compatibility leave the previous value as default.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index a6de7101..87b7f46 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -52,6 +52,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct regmap *regmap;
 	struct clk_hfpll *h;
+	struct clk *pclk;
 	struct clk_init_data init = {
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
@@ -75,6 +76,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 					  0, &init.name))
 		return -ENODEV;
 
+	/* get parent clock from device tree (optional) */
+	pclk = devm_clk_get(dev, "xo");
+	if (!IS_ERR(pclk))
+		init.parent_names = (const char *[]){ __clk_get_name(pclk) };
+	else if (PTR_ERR(pclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	h->d = &hdata;
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
-- 
2.7.4

