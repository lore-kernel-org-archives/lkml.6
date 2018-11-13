Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A871FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CE420818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CE420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbeKMV6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:58:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40384 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeKMV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:58:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so10556915lji.7;
        Tue, 13 Nov 2018 04:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4b7mWWvbRMSl/BrY6BXSv/3823MeAc6TDJ2DxbTG2QU=;
        b=eH4NnTYhinneWPuVs9we5HwjvGLKMlazlOpZj4+qsNAgFN5my78xHP5SiyCl7Ab7hn
         9ovsI3n7faSYj5S515lg7Y0XZ1fieryNDnFQso2hW8tMFtQcHntrrMV5yBmegYx7DiC0
         1p6buUWPPeG+roR49c0CoKLiztU4XkiEICuwUWSdyRucf6LfXaN4glflhvJuXGLOfcLS
         MHTKDBl7miX3cJAyHOBMvgwOEpU+FbNwC1kuoEQvhVcdo7zVrZPlwFeweRctWQzzgw2+
         Cgy4WD8uY8uy15MpVUUAQUnSPDzScOjDo8LzYic7l9Km1hKzs2BpdvzTpmC3rAOxAS9A
         imfQ==
X-Gm-Message-State: AGRZ1gKb1APQ1k6zM3iOfLkmVGBUVRnytulozJBHDqFF8VwZSua+GENO
        lPMf0KBhI9ahkdeqwTK3W7g=
X-Google-Smtp-Source: AJdET5ffbiuIZOU9/qFylZpeIpZWfVwNaAtJyzaMhL4O3x6I/l/Phk1LIDh0Gl929CUhQS1HCZMXLw==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr3022060ljc.172.1542110462379;
        Tue, 13 Nov 2018 04:01:02 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id m77sm1777280lfg.3.2018.11.13.04.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 04:01:01 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:00:53 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v4 5/8] clk: rk808: use managed version of of_provider
 registration
Message-ID: <b737f3ee039b8fb25be358a00d0adac7c4fec6d0.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify clean-up for rk808 by using managed version of of_provider
registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-rk808.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 6461f2820a5b..177340edaae5 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -138,23 +138,12 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(node, of_clk_rk808_get, rk808_clkout);
-}
-
-static int rk808_clkout_remove(struct platform_device *pdev)
-{
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
-	struct device_node *node = client->dev.of_node;
-
-	of_clk_del_provider(node);
-
-	return 0;
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+					of_clk_rk808_get, rk808_clkout);
 }
 
 static struct platform_driver rk808_clkout_driver = {
 	.probe = rk808_clkout_probe,
-	.remove = rk808_clkout_remove,
 	.driver		= {
 		.name	= "rk808-clkout",
 	},
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
