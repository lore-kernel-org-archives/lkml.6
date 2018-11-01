Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC005C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F92064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7F92064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeKAQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:21:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeKAQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:21:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4-v6so17165406lja.4;
        Thu, 01 Nov 2018 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yodtWAaw5BTk3hbCqBw9o101omzQN2QDRD/joFnNkiA=;
        b=GV61w+fX4F0AYAYu4/LmO29b/vTkWYlx1op5fvEe77g8hrijTxtBvcAaVO3XDXOQV2
         0n85XwGf5vKqdzgNzhV+bcQjl0m4/JmrYe+7mw+zVvxc4fmsK5LGBYRvyIpyqtNsoRnh
         Er8bYk75rvFPr+UVHdqPfbR3nil/Km7ohvl+xscpjdyA8zhmCUpCIey1TifQb83/bjDj
         633XYpqhh7Wv3gk8OeE0ftMVictcrJocW7bL+gy2PJ4Q+qqe7WW/hwsjX2wdx/jr0hjm
         RHTKFD04Xm80Q7N2XS5zXaNq7/znVpkwlDphDdKEr3hjDAQer2glCAPkkn9ePe2iNauB
         9EHg==
X-Gm-Message-State: AGRZ1gLjCY4jmKyYMK/1TA1enTOpLYVtw0VqjZ0X7gJjsUP6pimvahSu
        xHOvTsOf1RfkQCHtsNf1glk=
X-Google-Smtp-Source: AJdET5eUuISbkUGNn72cxrLKDqXMAfSvg/3aJ2eYCd4be5+L8XJkHeHpMYROEMUbhtnFkEkjQBnxJw==
X-Received: by 2002:a2e:4408:: with SMTP id r8-v6mr4407134lja.21.1541056775260;
        Thu, 01 Nov 2018 00:19:35 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3340046lfc.61.2018.11.01.00.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 00:19:34 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:19:22 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v2 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
Message-ID: <8e396e22b328f35538a01193797fbd0d001f885d.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm variant of clkdev lookup registration in order to avoid
clkdev lookup leak at device remove.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 0d92f3e5e3d9..07798debfec4 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -309,16 +309,17 @@ static int s3c24xx_dclk_probe(struct platform_device *pdev)
 			goto err_clk_register;
 		}
 
-	ret = clk_hw_register_clkdev(clk_table[MUX_DCLK0], "dclk0", NULL);
+	ret = devm_clk_hw_register_clkdev(&pdev->dev, clk_table[MUX_DCLK0],
+					  "dclk0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_DCLK1], "dclk1",
-					     NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_DCLK1], "dclk1", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT0],
-					     "clkout0", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT0], "clkout0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT1],
-					     "clkout1", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT1], "clkout1", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register aliases, %d\n", ret);
 		goto err_clk_register;
-- 
2.14.3


