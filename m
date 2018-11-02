Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF66C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06D92082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06D92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKBVoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:44:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40690 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:44:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so1599323lji.7;
        Fri, 02 Nov 2018 05:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkHc1XDfS2zAEG1O6tNrzFVGgOycf/0Y3wU3cQalzu0=;
        b=uEVtIclc9yPI9UN+2HdS/esRZuomnYUtKhs1beNz8zp6WKt/f1JmK7UDEkleIQnfe0
         dM+Wa68DPL6AelGh8/FOUOJD6InDLQoTeAEdFgT8JB/aFOMV+gqPDn3rgJdEtLu+0pGc
         70cSe+fYpn+X60o9jiHzultwAKsQJFDGYq9z3k4i22xGdVyu2+lIe1aI4SqmADmnyoJ3
         Xz6h6bnDTs2UgEWHHOu3qSzU0o3Pth/Wmg7jdV0N+xs36bxPruwPIGQN4gIKtNVSpfyH
         NC8Q27mzZ8McEM4hH+kvG6EnPFjBk7GwwePOPwv5EWXj7QSiSPVPjUBltTnlI8JJQcET
         QFEg==
X-Gm-Message-State: AGRZ1gLo4c/jBD89v7GN4C94AfF/LGRgundZjwb1tlWTUMguTBngfWmP
        uAGJFpIK5vgku5A/6RsncaI=
X-Google-Smtp-Source: AJdET5dhkQJ4jFduLKkaHHDNMMXHLuYY6WY03oYUynBUpLEg/UFwtz/6PJeLj3M6DtVoCDXnQnipaQ==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr8148863ljj.102.1541162215626;
        Fri, 02 Nov 2018 05:36:55 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j66-v6sm5641477ljb.45.2018.11.02.05.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:36:55 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:36:42 +0200
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
Subject: [PATCH v3 4/7] clk: clk-hi655x: Free of_provider at remove
Message-ID: <0f66b67315e67192ada302304e2d133fff4989f9.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
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

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..394d0109104d 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+				of_clk_hw_simple_get, &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
