Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCDAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3C920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3C920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJaRaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:30:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41687 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:30:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id c16so10964146lfj.8;
        Wed, 31 Oct 2018 01:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJKi78f3BmTlbgbFoV5YXjiBkX7wj5R8W+WOr3C0zec=;
        b=cSz9NgfKvJhEWagNJosO++Jz5b724QZgf/Tx21wOhXYCMIj35dClSiRbjdVivO1du1
         gA4BPk4jPiQTdL4GvOb2Jn4d9Zj1yJtau6em56jil1n2/MXFEuXkscLj1NlUw3atSNzH
         siYuugJQ/MxJ4rJR39/Niep3jCCvXdYrsd1eauXaY2yUcOIQ8VNUjNTMWFU12PCxUz6d
         CtaxOjOePI3yOHTvEZ19vXacYB9cNAMXDwy0FRI9NbyEgfKh8C/mIgMk6SieODjmn5Lz
         xlvIXEhP0CndcvqU2dchbwCqbmtQ/2MgIwXSDyuS0RokOdsQc6/DTZCCz7KBs+HIJMRI
         VG7w==
X-Gm-Message-State: AGRZ1gLP5zqiVCHpmNHJw/Ciy+ICByE2jvPznp+1By2M+Mn5GxsNRif1
        1mwQ1PSipZIeQLlqaA8pSQY=
X-Google-Smtp-Source: AJdET5dHivoOLmVKefTpysoQURcCgOEhVWg1eeqESIZmDlGxkWhU0I+qiaE5vSusHGnwfZ/HweN1rA==
X-Received: by 2002:a19:cec8:: with SMTP id e191mr1196583lfg.13.1540974789281;
        Wed, 31 Oct 2018 01:33:09 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p134-v6sm4397709lfd.80.2018.10.31.01.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 01:33:08 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:32:56 +0200
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
Subject: [PATCH 5/8] clk: clk-hi655x: Free of_provider at remove
Message-ID: <6705a681118488ea905a5d3c29266683bf1a8a6c.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
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


