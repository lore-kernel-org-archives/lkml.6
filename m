Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCABFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EC22084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EC22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKBVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:43:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43544 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:43:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id u18so1206337lff.10;
        Fri, 02 Nov 2018 05:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5x+Ok5Ed4t9w7g5J7qXI1OurGBp0O2MAJGG1HebFLU=;
        b=KGzoUCvm5/2b6dA7Lmnls17L74Q6oNK3aZbWxXuPgMPbPdCgXogibv51WoUiOvdP30
         NxJN9bOQt8tNHNMwuo40R9CkrRdxondpNgGENWWNfsnnlJ6YkLPgIjW+eeNRbIf7lbDD
         oiK9RuSWwh1oqsLHbAbbn1heirMVt8NLcz+NcGPclXX9q1hgwInlc8R+LkoKNUvhd8uI
         hZI6kJmcR1I56pxDTcZMmucSlbEr3vMy38JNRGH7yZSUtqag6SDmhb9CqjO9BdfQEtNd
         lckhYUdtbfQTpqLt0zX1FwOWgtrlNI9wbIZ2wt/RTDIrb01T16mNGFh9x1rC/oQNekha
         JsRw==
X-Gm-Message-State: AGRZ1gLaQhs1eNBGH9WDbFz5BmPuh9N1z1mSQis5VL0eTaoFh+ztCjvh
        UoIK46AFknMmgb1aHtO5KPc=
X-Google-Smtp-Source: AJdET5dlM7Gl67fYKCTdLIuaFdbAX7CuFNVR37Z6KObOdFlosdpkknsAqp9MQje21OG0cpsW28nYRQ==
X-Received: by 2002:a19:48d0:: with SMTP id v199mr6949047lfa.104.1541162163233;
        Fri, 02 Nov 2018 05:36:03 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a63-v6sm5537119ljf.54.2018.11.02.05.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:36:02 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:35:49 +0200
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
Subject: [PATCH v3 2/7] clk: clk-max77686: Clean clkdev lookup leak and use
 devm
Message-ID: <0be8b4ce5554e8539a458cc6152facc88a3e1804.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-max77686 never clean clkdev lookup at remove. This can cause
oops if clk-max77686 is removed and inserted again. Fix leak by
using new devm clkdev lookup registration. Simplify also error
path by using new devm_of_clk_add_parent_hw_provider.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-max77686.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 02551fe4b87c..51a46179f6f8 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -235,8 +235,9 @@ static int max77686_clk_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = clk_hw_register_clkdev(&max_clk_data->hw,
-					     max_clk_data->clk_idata.name, NULL);
+		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
+						  max_clk_data->clk_idata.name,
+						  NULL);
 		if (ret < 0) {
 			dev_err(dev, "Failed to clkdev register: %d\n", ret);
 			return ret;
@@ -244,8 +245,9 @@ static int max77686_clk_probe(struct platform_device *pdev)
 	}
 
 	if (parent->of_node) {
-		ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
-					     drv_data);
+		ret = devm_of_clk_add_parent_hw_provider(dev,
+							 of_clk_max77686_get,
+							 drv_data);
 
 		if (ret < 0) {
 			dev_err(dev, "Failed to register OF clock provider: %d\n",
@@ -261,27 +263,11 @@ static int max77686_clk_probe(struct platform_device *pdev)
 					 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT);
 		if (ret < 0) {
 			dev_err(dev, "Failed to config low-jitter: %d\n", ret);
-			goto remove_of_clk_provider;
+			return ret;
 		}
 	}
 
 	return 0;
-
-remove_of_clk_provider:
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return ret;
-}
-
-static int max77686_clk_remove(struct platform_device *pdev)
-{
-	struct device *parent = pdev->dev.parent;
-
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return 0;
 }
 
 static const struct platform_device_id max77686_clk_id[] = {
@@ -297,7 +283,6 @@ static struct platform_driver max77686_clk_driver = {
 		.name  = "max77686-clk",
 	},
 	.probe = max77686_clk_probe,
-	.remove = max77686_clk_remove,
 	.id_table = max77686_clk_id,
 };
 
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
