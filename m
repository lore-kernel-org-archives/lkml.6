Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56ED20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVZfwTtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeLQJr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53882 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbeLQJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so11589338wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
        b=EVZfwTtjI2HPaEOPFzP9moBBmXkSxInAAJ7BRRRXudV7/1vL8+cD2S4QekPouJEyZd
         RBe8E8EGJqcoOEh4t41puF2VEVELP1NptHRYarXHNAFkq2dE+DA9q6nGla51q7MoKXhV
         o5EDvdvD/akneA9Cnt3ExIuUMLAwIwUl7oktA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
        b=cR80XJsguYIYuvVLdlAJCxZIW4OQrdAdsm9zEvgdxkAJnXN967qSstoa//LCbDFLhO
         HYCNJyeYTTm5fXNEziSIGAUnKsI48860Sq22WM1+vVRtEg3CyjVFYLCwiOLfyMET7g8T
         1UhNTHfg8RC+5mNDNGlB8EI05++fZq2cBevOZb6df31xI5BZQAbw4AMkNrRKCgThstwp
         sP8pBONWLUh9PQFcLiOFKDTTWlejysmxsH5HHYzDno0vyAEiPKx4BlCijx4Cb2QL4FDY
         RynYIBSXNXJ+qUsRlcy4flKLmcLkH4OKt+61M9ery+2BZuj0Osm8e33Vqdg3wYB6Ouxh
         DgSw==
X-Gm-Message-State: AA+aEWZcNAS5nvMcOVC5hlZdeuCO6hm5Bljwjgs7eSZYoJygv5M2G0eH
        lFzVzksNH9sl+d/Dgygawxl3fw==
X-Google-Smtp-Source: AFSGD/XqSAH8rmyhruv49gM4d71mRU3ObdmMPG4wlaMGiX45bzT98SLCa9pJwKg/2IRNJRtrPt2KnA==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr11600933wmd.66.1545040011090;
        Mon, 17 Dec 2018 01:46:51 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:50 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Date:   Mon, 17 Dec 2018 10:46:25 +0100
Message-Id: <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
to keep the software model of the clock in line with reality, the
framework transverses the clock tree and disables those clocks that
were enabled by the firmware but have not been enabled by any device
driver.

If CPUFREQ is enabled, early during the system boot, it might attempt
to change the CPU frequency ("set_rate"). If the HFPLL is selected as
a provider, it will then change the rate for this clock.

As boot continues, clk_disable_unused_subtree will run. Since it wont
find a valid counter (enable_count) for a clock that is actually
enabled it will attempt to disable it which will cause the CPU to
stop. Notice that in this driver, calls to check whether the clock is
enabled are routed via the is_enabled callback which queries the
hardware.

The following commit, rather than marking the clock critical and
forcing the clock to be always enabled, addresses the above scenario
making sure the clock is not disabled but it continues to rely on the
firmware to enable the clock.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 0ffed0d..9d92f5d 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
 	};
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
-- 
2.7.4

