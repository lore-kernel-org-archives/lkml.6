Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E86F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJaR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:28:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40923 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJaR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:28:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so13996789lji.7;
        Wed, 31 Oct 2018 01:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5tCTzkMuA5kwQPkvyBXAPtmNWoajWA+W8o5G1slWkE=;
        b=Iwaopz2hPLplSn/arsljDs+Doq9rsy05Ul4HRK9nP48suA4B4glClVTOT4aMCJgbtu
         bDqTwahEjbfP2FZb/MwQR0UwhTJK7tHHF6+HLkCwhoKWATs+XykQfVIAfb3iP4jAkYz3
         UN9KpnlcXnZluNiW10Whhup0NRmJGRY2g5Y82l2OzQBqLtyJBTRejutBUvLTzD+hNP3W
         oQyPj/kNhSrK7y9JMuERUtSAGsCuqzlQoVLdeh3NC5p5ME3K1jreybHK9AWodmx4OWe1
         wP8G1ZXGhV6ve8W9wfNKx02+rRcFj3I77P4fN/r7+IBRAN5KjMGiP4VfvtviAOKfEwVP
         /Mpw==
X-Gm-Message-State: AGRZ1gISto6TlX65DK/U+xMWhaKqalETfhMhFCOHl6HiT6Q+HeIgDKfz
        2yras+tMbp1Z9lIbLi3yky3Y1SXsj00=
X-Google-Smtp-Source: AJdET5eDktTFvolBr6I/NEsHTLr6WgtMZwfLejf/cwFGoGKltQejpiRNJcirb1rZ96+HFB6Y5ErfJg==
X-Received: by 2002:a2e:9445:: with SMTP id o5-v6mr1475349ljh.7.1540974686887;
        Wed, 31 Oct 2018 01:31:26 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a4-v6sm4098629lfa.91.2018.10.31.01.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 01:31:26 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:31:19 +0200
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
Subject: [PATCH 2/8] clk: clk-max77686: Clean clkdev lookup leak and use devm
Message-ID: <db05ac6d6721872b891aa72f9e2e82b664dca8a9.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
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
---
 drivers/clk/clk-max77686.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 02551fe4b87c..b1920c1d9b76 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -235,7 +235,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = clk_hw_register_clkdev(&max_clk_data->hw,
+		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
 					     max_clk_data->clk_idata.name, NULL);
 		if (ret < 0) {
 			dev_err(dev, "Failed to clkdev register: %d\n", ret);
@@ -244,8 +244,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
 	}
 
 	if (parent->of_node) {
-		ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
-					     drv_data);
+		ret = devm_of_clk_add_parent_hw_provider(dev,
+						of_clk_max77686_get, drv_data);
 
 		if (ret < 0) {
 			dev_err(dev, "Failed to register OF clock provider: %d\n",
@@ -261,27 +261,11 @@ static int max77686_clk_probe(struct platform_device *pdev)
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
@@ -297,7 +281,6 @@ static struct platform_driver max77686_clk_driver = {
 		.name  = "max77686-clk",
 	},
 	.probe = max77686_clk_probe,
-	.remove = max77686_clk_remove,
 	.id_table = max77686_clk_id,
 };
 
-- 
2.14.3


