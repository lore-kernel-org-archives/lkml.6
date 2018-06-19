Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB592C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74339204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rTXOBJcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74339204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937743AbeFSNlL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:41:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35020 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937695AbeFSNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:41:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so566225wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9CgGsxjPmXSJzKHBcIzvkjp9vRQY5ar1a5/jpyGPWw=;
        b=rTXOBJcCwtd7UV0iGy1AhM0DKWC1S733yQT8EFg3NbCXowIDQ8d3pR6vB8XkYmOz8e
         Jo9n5WnYwSQ9p9zSuKRGDP5v4FHLzYncskdRvkK8uA8wTVxUPWvph+vI9vuZwTTpjPDG
         6XSSjW1g+cEAErn3J9Lihbq7k/+RUIHVaGEX1TSf0P1AQV+TWFC3PVQr/rPkGHud3Z3X
         yHqAn+mqEHgapkekpKH+t8dRobSpswHJHazWP96IVQNHO68URpVMENopk0v4/yQSzoUb
         uUYiVSvxZB5Jhb6uQJCcvFKsjV2ts2s+rlL1TQm9Osm2L3kgsZDaIXfb5W6uibKwrRXd
         qPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9CgGsxjPmXSJzKHBcIzvkjp9vRQY5ar1a5/jpyGPWw=;
        b=sItRIUyIvxqokV4OUZZ0arMNYKqVh6ANkMvFykBwhs0kIo7RehQoEe4IsQkQjD9Fni
         MUJIXVVob6beW/0Pj1BHEQ1sI1niqY4mmsjqlvU95GUH8e+CBVGmQWIeDetLLx4YUgkz
         zMUPIs/cXMOirUOQEJfOhVE/VkBYElBYX3Ub5Ss57ToyioYaEwtLDxMubsBceu6NPokv
         XZW8iK6gTeVokFWs4ExllcVAy8ewORfeFXUfzdp3jQaT4kzBi3sIEfCGgRlxAkK1OLgj
         Z5NZ+ySQ+TEtoXzdot1Z21+EsT8uh/+OJOMZs093iNk/zLlcooqDCGqzVp9ruBGtmDIL
         ndxA==
X-Gm-Message-State: APt69E0YBcf+hR2NxGG4ZuAwWDexd/XzXt+YcM/7zDxKlNbnkCwUZeW4
        lwP1i+ESLXC7vRipnOPcCJt0WRoh
X-Google-Smtp-Source: ADUXVKLHjePjXdNrnjjYHL7uKRjr0rOJ2r7VnYuNndCSTMwbHLVC1RkEujVoPCmU34G9dkPbTb+/sg==
X-Received: by 2002:a1c:470b:: with SMTP id u11-v6mr11499989wma.49.1529415665755;
        Tue, 19 Jun 2018 06:41:05 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm17196154wrq.74.2018.06.19.06.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 06:41:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] clk: fix CLK_SET_RATE_GATE with clock rate protection
Date:   Tue, 19 Jun 2018 15:40:51 +0200
Message-Id: <20180619134051.16726-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180619134051.16726-1-jbrunet@baylibre.com>
References: <20180619134051.16726-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_SET_RATE_GATE should prevent any operation which may result in a rate
change or glitch while the clock is prepared/enabled.

IOW, the following sequence is not allowed anymore with CLK_SET_RATE_GATE:
* clk_get()
* clk_prepare_enable()
* clk_get_rate()
* clk_set_rate()

At the moment this is enforced on the leaf clock of the operation, not
along the tree. This problematic because, if a PLL has the CLK_RATE_GATE,
it won't be enforced if the clk_set_rate() is called on its child clocks.

Using clock rate protection, we can now enforce CLK_SET_RATE_GATE along the
clock tree

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9760b526ca31..97c09243fb21 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -691,6 +691,9 @@ static void clk_core_unprepare(struct clk_core *core)
 	    "Unpreparing critical %s\n", core->name))
 		return;
 
+	if (core->flags & CLK_SET_RATE_GATE)
+		clk_core_rate_unprotect(core);
+
 	if (--core->prepare_count > 0)
 		return;
 
@@ -765,6 +768,16 @@ static int clk_core_prepare(struct clk_core *core)
 
 	core->prepare_count++;
 
+	/*
+	 * CLK_SET_RATE_GATE is a special case of clock protection
+	 * Instead of a consumer claiming exclusive rate control, it is
+	 * actually the provider which prevents any consumer from making any
+	 * operation which could result in a rate change or rate glitch while
+	 * the clock is prepared.
+	 */
+	if (core->flags & CLK_SET_RATE_GATE)
+		clk_core_rate_protect(core);
+
 	return 0;
 unprepare:
 	clk_core_unprepare(core->parent);
@@ -1888,9 +1901,6 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (clk_core_rate_is_protected(core))
 		return -EBUSY;
 
-	if ((core->flags & CLK_SET_RATE_GATE) && core->prepare_count)
-		return -EBUSY;
-
 	/* calculate new rates and get the topmost changed clock */
 	top = clk_calc_new_rates(core, req_rate);
 	if (!top)
-- 
2.14.3

