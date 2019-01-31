Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A50218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfAaMDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:03:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41275 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfAaMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:03:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so2432515ljc.8;
        Thu, 31 Jan 2019 04:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhIIaawKxXGdGw9tURA71dsUwy7rC8b83r901j6v9IA=;
        b=isq4djzK42Zi61cnIwyDQzLs8OZenMA0aFgPDpX1gLwuH5EktqQVD2DXeO8zbZE4oG
         Qj2qv2ENubBO67bX739neejCcLIqdZrQkxxGKdGP/qq8P4ZVRb6ZIXopTlY0IZ2QO1f0
         XETID1TgiQWsxmwZwhFIJDKhzWe3VBGIlcBNvo4T/K5jpIfQJyCZY6ZJyHggpcOjWoCM
         gx3qoaniYp3y5maFil6hrEf01zs2wq4JW0qqqtguXCP83ehJ1G/v7JZHp8pkLzTRdOo1
         uQfl2ZfH+Rv7Ge9m1Y3Bg65NVGXJpu3hO8geEBrYnoDJi5i2jT/ivy7Nk07MKZCqHsLE
         jFgw==
X-Gm-Message-State: AJcUukdznd0ZbUZHtXMf1r0zme+g+BTRJk7f4rycsPMdROQRQ1KJIlrR
        eaiDAjhGGETmBBAOARk2Yhc=
X-Google-Smtp-Source: ALg8bN4wm6IZZxKzMIUBmBaMrNW3kGHT3R3tgzH0TtJiFcLMIyz2PztYy86YWLUfRRf/l0hmlfoK9A==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr28184294ljg.50.1548936211077;
        Thu, 31 Jan 2019 04:03:31 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d5sm779370lfi.65.2019.01.31.04.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:03:30 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:03:18 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v4 03/10] clk: bd718x7: use chip specific and generic
 data structs
Message-ID: <6003ef36e7aa8a55c58a3328af106d2955280a95.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the clk driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-bd718x7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 60422c72d142..461228ebf703 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -17,7 +17,7 @@ struct bd718xx_clk {
 	u8 reg;
 	u8 mask;
 	struct platform_device *pdev;
-	struct bd718xx *mfd;
+	struct rohm_regmap_dev *mfd;
 };
 
 static int bd71837_clk_set(struct clk_hw *hw, int status)
@@ -68,7 +68,7 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	int rval = -ENOMEM;
 	const char *parent_clk;
 	struct device *parent = pdev->dev.parent;
-	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct rohm_regmap_dev *mfd = dev_get_drvdata(parent);
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
@@ -119,5 +119,5 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_DESCRIPTION("BD71837/BD71847 chip clk driver");
 MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
