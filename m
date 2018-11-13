Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A313D20815
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A313D20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeKMVzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:55:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43965 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbeKMVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:55:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id g26-v6so10539801lja.10;
        Tue, 13 Nov 2018 03:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJ06/MEsQS8wIywHorlvQqUqrYoodnmIZrcXjxSdJq0=;
        b=JAlNJUxw7dZuzyCnLK0SNN04kvc3ETj/705MU21SoeLVRr1rCcvmKJ8iYYLzrTcsuy
         35Q7lAScOVkLZq+2nYqcze+P9LJS0f8OHxk0QFvRtJeWlPDnNr610P3FkeBAAxbivI57
         lbpwxFZBg+CSP7UGH+Gkwf7LeIxiTi4MxrRz2P2ETjiXeKOYYZfJSXOsbwtmlISIyy29
         8NA2SqUzg/NvJaNJU8nTBfqamh7kj/uJFcCWFJRTy8zAJmFfsVPZJnbx9Zua7hm7mPMR
         JcQ+KkYh+duOBLRiqWCSMZ+ujUxfO1XvrSFIRhQJjuOHBeQgkhTeUzHXZwm0AD4WW9Ri
         audg==
X-Gm-Message-State: AGRZ1gJ0v0p0zmARQZ6vmW7J6Arj6U+4Ad8h8ER7/oPTqHLHkT7uzY7o
        Kp5sb01siYeWg8f0Mk2p0SM=
X-Google-Smtp-Source: AJdET5dPbccSJIhU4ykGo/7sZ/6SWA6kO+vJeerN5LGWL5sFshLw+a7sE+sfVQzxYkAhfiqGWuVZ6Q==
X-Received: by 2002:a2e:8099:: with SMTP id i25-v6mr3224659ljg.174.1542110253613;
        Tue, 13 Nov 2018 03:57:33 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f18-v6sm3745263ljf.36.2018.11.13.03.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:57:33 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:57:17 +0200
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
Subject: [PATCH v4 2/8] clk: clk-max77686: Clean clkdev lookup leak and use
 devm
Message-ID: <cf0e38cddcb5643f3a796cf7e73332c12e3c250e.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
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
index 22c937644c93..e65925d5e412 100644
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
