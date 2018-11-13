Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42561C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CD9208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbeKMV7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:59:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730946AbeKMV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:59:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so10585646lji.3;
        Tue, 13 Nov 2018 04:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eg2ufM9FdHFhTVDmxheR3tr+ip3I7Xl4uZ2RuWzUJVA=;
        b=hD643M5KtdBUw0TD/5+unU+/spW+g2ArQQH34uryOqdHDSN8+IVLVXLkBpaiPvmm6c
         uv9Y3Yj39nEck5cHRkvqucOp+6tgPSQHazDqy1lA6L4d9XhiUpxJbn6FuDsIRe1UoE/Q
         WH+aBRdsJc0cFRFTv2b3xOfDSnbOtVfyk7XkSA+WvucQQeEIzTQ0lQhbe9w9H2nGYRF7
         4d5rgbCb15OQHjpp4ygcEvVBmbdmDD5jMmuganUnFUxup2dRcphutVrfsLDAnR6ZsAFF
         kEnmK6ga32aQLkASG5VNaJw2nFdsuKPTbN0gFzf7LnEv0cqsxl8ZJ9VWl0w9rx2DY0o3
         MnvQ==
X-Gm-Message-State: AGRZ1gKfvkD/axNeDkoRJF2ViWu7tHDorh+Jh8qS5nzpqAft2OV+k1xE
        /ZQ6ybavYCJsRhhmHkZSUEU=
X-Google-Smtp-Source: AJdET5eiZpJm78DDRAbNNrgPNoDh/5Ee9eTpHn/cx6mX1G4R3MmmTqs07oz3ukMBdLA0oRfOmCYlCA==
X-Received: by 2002:a2e:4819:: with SMTP id v25-v6mr3261176lja.2.1542110509761;
        Tue, 13 Nov 2018 04:01:49 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x24-v6sm3844320ljc.54.2018.11.13.04.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 04:01:49 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:01:36 +0200
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
Subject: [PATCH v4 6/8] clk: clk-twl6040: Free of_provider at remove
Message-ID: <c7d4076e0786e233d0aec41e8d14702267688d1b.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
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

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 25dfe050ae9f..e9da09453eb2 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+			of_clk_hw_simple_get, &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
