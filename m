Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E4C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBA42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeKBVni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:43:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39518 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:43:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id n18so1215628lfh.6;
        Fri, 02 Nov 2018 05:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XHBuXIz+/k/o9sHwadx6Xj4e5igjCAket6IT5Fa5bu0=;
        b=F2C8pG9shyle2xQWJdlcVNYU8Ry0BME+nJgb4y11H6UlAaItLV+MqxVVOgxKDZ86bI
         3ULMxNX1WRBtUSfKu/VhMpf/UXf+tu4uteErgkx4PZLqHYPscQfRLyWzjVpsjV8V6+B1
         +y35Nfw+K9+iqroWZ/YdHH/5PGnvdjDnrvlCZH2h6Sx7/sUM4MzlBfY528yUBE+8Cde/
         uUyce7uTUtT9RV1foeyt6iwqKeeZC95qY+BqHZ98oYbFFfn2DhHyomg5XdQdLn6KjUoi
         RPxOCKYDpAcH1iOQ5o7hw2RhgUot5ARw/MXnnT+dAsX85hpw8e812ioFBqsjhgB+V9OS
         nKNw==
X-Gm-Message-State: AGRZ1gI3WjZ4F51BO7w6tU6nQjJkKpEnBm5KSePI8tce7Mz0WZjgfE11
        OBl2LaLRk++je/ZA2MMaIUI=
X-Google-Smtp-Source: AJdET5f98WmhOgjNCCnLbQqOo8CLgXCsjGIuZLUhIOODJZO3xhN5eWHpj2rx7Fh8LSIu5G+mG87uzw==
X-Received: by 2002:a19:d04f:: with SMTP id h76mr6541421lfg.52.1541162193044;
        Fri, 02 Nov 2018 05:36:33 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t77-v6sm5708146lfi.63.2018.11.02.05.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:36:32 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:36:20 +0200
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
Subject: [PATCH v3 3/7] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <5f79250d8055016b3a3c815e478ece889b8f80d2.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
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

Use devm based clkdev lookup registration to avoid leaking lookup
structures.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/x86/clk-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index fb62f3938008..32d8df9bd853 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -52,7 +52,8 @@ static int st_clk_probe(struct platform_device *pdev)
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
-	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
+				    NULL);
 
 	return 0;
 }
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
