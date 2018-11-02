Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D82BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70B2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC70B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKBVpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:45:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33757 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:45:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id i26so1246438lfc.0;
        Fri, 02 Nov 2018 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWFrztTGBGBvTlJ4yv0DEf/05EQvWoHnl+hl24Atexs=;
        b=GkCzko3mQGts1eCHOnCyqHmgCmljKhybShTtJASOCr+IDAj5BGt0fDgqMe+eGrXyIy
         9TzgX00JI2PtEg1bfoJGHtz/TyiGPe4J5QZGhhs72/Pd7XZ9ESyN9dhV3rrhndnDd2Dj
         FR5f0/wVmfuiD36Lj5eQ7iw1/kDQhAOy/FFKqjhWZhECPHq8OaAYuGqiVug8CueIWQOL
         Fr+sj7UwbIp0UHOX4bAl4tlcRq7c/v8j0A12dhF5QjBPsBFgFq54XEa0S9Z4GRE8MOUt
         EfjFIzW64RmQDLmC2XgpHtY+1AYK1U0tnst2ZCm33fAZp4jaesk4AbTV8xaBUxjTNRAu
         CuDw==
X-Gm-Message-State: AGRZ1gKbdaXSHiuBYM2bU70LyYtz3BtBTO9Uir4q8tz2sv+FYI98/NQm
        WkT/dQg3TMkfiNaX/BcBL70=
X-Google-Smtp-Source: AJdET5f59gj3giKEcfA7HmG//zPzEs+DCu7u8ul4wUV+I0FfLYxpMxxOuqZLix2NlyPzlXp1uIUySQ==
X-Received: by 2002:a19:d04f:: with SMTP id h76mr6545138lfg.52.1541162320578;
        Fri, 02 Nov 2018 05:38:40 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t5-v6sm5605393lfg.90.2018.11.02.05.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:38:40 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:38:27 +0200
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
Subject: [PATCH v3 7/7] clk: apcs-msm8916: simplify probe cleanup by using
 devm
Message-ID: <fa3bfb55703033b39dd7454cb49706fd3a3d43ee.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
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

use devm variant for of_provider registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/qcom/apcs-msm8916.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index b1cc8dbcd327..f4e0c136ab1a 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -96,8 +96,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &a53cc->clkr.hw);
+	ret = devm_of_clk_add_parent_hw_provider(dev, of_clk_hw_simple_get,
+						 &a53cc->clkr.hw);
 	if (ret) {
 		dev_err(dev, "failed to add clock provider: %d\n", ret);
 		goto err;
@@ -118,7 +118,6 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 	struct device *parent = pdev->dev.parent;
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
-	of_clk_del_provider(parent->of_node);
 
 	return 0;
 }
-- 
2.14.3


