Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736B121738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPNU7CdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfBTCPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:15:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36260 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfBTCPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:15:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so11127891pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqagvOGzM+1NbNVkTuVd8N0ntUQuQbmaSYvM2+e2Zg8=;
        b=OPNU7CdHUnvsrHQP1WsVmpt3YtGi9dkv6hlltMDg/aWk3Ynbgzi5mV8Pmxbn7vfMhT
         CV1eKKTuSN2Z9218FzZmc8tbrRRgYUZlzzKoUGFKHnbecRi2M+CwShNKgnvAwEEE27BV
         Na7oJ0FSQF4Cgg8flRXk2LhZlK+wfwDsqyjq9nPpo/qYYJrRQO3gaXUXXp62a9DSt6IX
         R+aUI3fmsC+GrRGWerZG0z6F8FFebBPgx270RTT9IZ9+zEj+QPl5FZHsovrUQIgbkRQK
         soUviez9qgwTNGH38rQXqWLtxzk0Z5FcidyAdNaoVPLiqIoR5CcGhWpSliMw+ID1/Tcg
         TVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqagvOGzM+1NbNVkTuVd8N0ntUQuQbmaSYvM2+e2Zg8=;
        b=ansAvKgHzsw+MZaH4RptH9rHMru/14i71bSq3n57hTYONJww6fUrkmeX6/dWK05/Pd
         VEPEwP0U+9ZOdp2Cj0mAODFGwoy0Mv9kMY5MsnDOkuv1b7/1wtbHNMh0G2vYW8Ow3Rt6
         1bp0lwajv9MeKxRwZ0vmUrGx9RmX0cYoNxIV6zEiz+H1MQOlkw+q3YxfkCDu40Wgt4oW
         bs1kyQSRgyA+TgoFOK6eMohg6IPVqOUIE6nl0uNQRyd9nobuAYCILMDCD2tyBGMcrm7d
         9lZ6l0v7mMOFMwUJtR0/n9eylgKfcZNyPup9lQWq/+ybUD7IurPP1A6mU9rESglxlja3
         3QJg==
X-Gm-Message-State: AHQUAuZNpvJ2nsJjo0BObjppUMR6OjO6La/sbcNvbiCjcVbRCPUQwZd8
        SKQM/tQ34lInh0+GesEfwiM=
X-Google-Smtp-Source: AHgI3IYwYyP9Qs8ZBGutbuEyX7IMDi/EN/z8BV0g1GY/Knjyz7SMhhVUhgVtIrJiis5U7vwGLKrSbw==
X-Received: by 2002:a62:f517:: with SMTP id n23mr32599145pfh.209.1550628900315;
        Tue, 19 Feb 2019 18:15:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e5sm6130957pfd.73.2019.02.19.18.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 18:14:59 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpcv2: Make use of regmap_read_poll_timeout()
Date:   Tue, 19 Feb 2019 18:14:29 -0800
Message-Id: <20190220021429.4910-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling loop with a call to
regmap_read_poll_timeout() to avoid code repetition. Also fix
misspelled "failed" while at it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/imx/gpcv2.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 176f473127b6..e06bf12a1e4b 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -136,8 +136,8 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
 	const bool enable_power_control = !on;
 	const bool has_regulator = !IS_ERR(domain->regulator);
-	unsigned long deadline;
 	int i, ret = 0;
+	u32 pxx_req;
 
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
@@ -169,30 +169,19 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 	 * for PUP_REQ/PDN_REQ bit to be cleared
 	 */
-	deadline = jiffies + msecs_to_jiffies(1);
-	while (true) {
-		u32 pxx_req;
-
-		regmap_read(domain->regmap, offset, &pxx_req);
-
-		if (!(pxx_req & domain->bits.pxx))
-			break;
-
-		if (time_after(jiffies, deadline)) {
-			dev_err(domain->dev, "falied to command PGC\n");
-			ret = -ETIMEDOUT;
-			/*
-			 * If we were in a process of enabling a
-			 * domain and failed we might as well disable
-			 * the regulator we just enabled. And if it
-			 * was the opposite situation and we failed to
-			 * power down -- keep the regulator on
-			 */
-			on = !on;
-			break;
-		}
-
-		cpu_relax();
+	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
+				       !(pxx_req & domain->bits.pxx),
+				       0, USEC_PER_MSEC);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		/*
+		 * If we were in a process of enabling a
+		 * domain and failed we might as well disable
+		 * the regulator we just enabled. And if it
+		 * was the opposite situation and we failed to
+		 * power down -- keep the regulator on
+		 */
+		on = !on;
 	}
 
 	if (enable_power_control)
-- 
2.20.1

