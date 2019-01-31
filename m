Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831FC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B370E20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCUUO0PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfAaIZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:25:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40556 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfAaIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:25:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so1151378pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZHVFmOzJU25u9HkbvP1Fa/F6wYGwLMXnctx3Yz3nHM=;
        b=iCUUO0PIyoJk5/cvtqGv+Fd5sv2pVJYL0+e52+knivjq+Iuvz/uGWErpsZWgF/E/ap
         uThiGmiTXiStQuF0xCLw54QgTqMfT0IEJ/2p5ZHk1gG5v33YttwWAsY+qZsRIK6JmwDF
         cjmdapDO/XGYUWEiTdumO4GsN5tgamZzp2HuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZHVFmOzJU25u9HkbvP1Fa/F6wYGwLMXnctx3Yz3nHM=;
        b=bH4DEnKxyyuPJDHWvEsoecZ3ts+UKBzW0aEDMadMfrBogGsOZTY9/HGlbnCdvrKQVZ
         2Dpz3qEanQOvUNZoZ04/Ls0lS+SgeCPv7YesOqem8xyZTf6K1sn+J/pz7uGXvCNpi9RX
         GCqCmOGpYc5cqt6TqfbdfWmn644Jk2N917KWBIs+fRTwCq2AaM/nlLjl5pdhPU0k9ADp
         R230xOLhBtqErXSJuvIFLbPQD+uNfq1gQC89qozCYvXHsQUrUCMKMcIJTKqynG/rN/Lw
         Bkk8FMBveIamSULzHOpWAsgUUAdFnhikGOkIYl7r0yq+4TLXpaAzB/k4+ZrWHUvaLJ9N
         uqsA==
X-Gm-Message-State: AJcUuker9C50KoF63w2WUL7QpE/KtUJDl7HdSYV2HKWYXgLHzSNWkQH2
        /JAhJmK/WknQWKejDNKsvigOVg==
X-Google-Smtp-Source: ALg8bN5CPVF1hoE2m5jYOIrmHZdzYV6fTyIc3y3+TBziqdt4RqSflvxhdqBh9HybtBb7Zm34xfWamw==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr33560188pfg.98.1548923127645;
        Thu, 31 Jan 2019 00:25:27 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id s37sm8923021pgm.19.2019.01.31.00.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 00:25:26 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
Date:   Thu, 31 Jan 2019 13:55:13 +0530
Message-Id: <e2e83f314120f078f7e24fbd5393decb9940a067.1548923105.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous frequency value isn't getting used in the routine
_generic_set_opp_clk_only(), drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d455b84cce5a..fa15aa8e00b0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -533,9 +533,8 @@ static int _set_opp_voltage(struct device *dev, struct regulator *reg,
 	return ret;
 }
 
-static inline int
-_generic_set_opp_clk_only(struct device *dev, struct clk *clk,
-			  unsigned long old_freq, unsigned long freq)
+static inline int _generic_set_opp_clk_only(struct device *dev, struct clk *clk,
+					    unsigned long freq)
 {
 	int ret;
 
@@ -572,7 +571,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	}
 
 	/* Change frequency */
-	ret = _generic_set_opp_clk_only(dev, opp_table->clk, old_freq, freq);
+	ret = _generic_set_opp_clk_only(dev, opp_table->clk, freq);
 	if (ret)
 		goto restore_voltage;
 
@@ -586,7 +585,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	return 0;
 
 restore_freq:
-	if (_generic_set_opp_clk_only(dev, opp_table->clk, freq, old_freq))
+	if (_generic_set_opp_clk_only(dev, opp_table->clk, old_freq))
 		dev_err(dev, "%s: failed to restore old-freq (%lu Hz)\n",
 			__func__, old_freq);
 restore_voltage:
@@ -759,7 +758,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						 opp->supplies);
 	} else {
 		/* Only frequency scaling */
-		ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
+		ret = _generic_set_opp_clk_only(dev, clk, freq);
 	}
 
 	/* Scaling down? Configure required OPPs after frequency */
-- 
2.20.1.321.g9e740568ce00

