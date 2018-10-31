Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6224C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BF920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BF920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJaRax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:30:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36275 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:30:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so14018597lji.3;
        Wed, 31 Oct 2018 01:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JJ40AdSZPMkqm7Da3QKXJd/JQH4MrVzdTvQwG7toy0o=;
        b=uPqf0xPxrrnTFJe+76jNOvr5y6+A7EJfO8Z3GiEWgEl2C8+zNcrthd7q0PFDGIEv19
         aAYYuz6rYNGA1Tkh64vpdw+rS/R/9niKwUR8BtLBZQPWR1Q/0t4TsTQwHDU9WkwSdY9k
         q5DIPsAP4R9i418oWFz0ZVwG8oEXHwE5aaNW4pbu+W5bP8PauXwNBKCFdtc2qHX9AV1q
         nmNWyDQvOfM0w13tzpAyvuUPrWSY4Ms0Jbl1LLBe+Jt1kA3NYdItZ5M+S2AcjHWw+ebV
         hDhZJPQb16WaePIYMc4SxoT/fpCombkCZa7aLOfO2qv/zonRwv17tZzW/bi5ofXjyQ6w
         wNgA==
X-Gm-Message-State: AGRZ1gKP3fmrvm+BLIymPY2OJROn30Au4FhbP96++oaV1v36HWu0lRHi
        Y16R3fcgYtrMUbHC2A5s7ZI=
X-Google-Smtp-Source: AJdET5cjdgLBrCJqgFZ2mzt6ED/HOT3OWL2hbdn1z1omeguTTDhoP10SZv8fOZFL0V7HG0nmTYiGdw==
X-Received: by 2002:a2e:9445:: with SMTP id o5-v6mr1480858ljh.7.1540974822030;
        Wed, 31 Oct 2018 01:33:42 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j20sm1313575lfg.69.2018.10.31.01.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 01:33:41 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:33:23 +0200
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
Subject: [PATCH 6/8] clk: rk808: use managed version of of_provider
 registration
Message-ID: <e90180fb30d5e47603ab8ccebb6dba45e73a9eef.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
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


